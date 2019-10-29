const is_battery_charging = (battery_info) => /'AC Power'/.test(battery_info);

const get_battery_charge_percent = (battery_info) => /(\d*)%/.exec(battery_info)[1];

const get_battery_status_class = (charge_percent, charging) => {
  if ( charging && charge_percent >= 85 ){
    return "good";
  } else if ( !charging && charge_percent <= 20 ){
    return "bad";
  } else if ( !charging && charge_percent <= 30 ){
    return "degraded";
  } else {
    return "";
  }
};

const get_battery_time_remaining = (battery_info) => {
  const time_remaining_match = /; ([^ ]*) remaining/.exec(battery_info);

  // Before time remaining is calculated, `pmset -g batt` returns "no estimate" instead of "N:NN remaining", in which case the above regex returns null
  // ... except sometimes it reports "0:00 remaining" for a couple seconds, which is also a "no estimate" case
  const no_estimate = !time_remaining_match || time_remaining_match[1] === "0:00";

  if ( no_estimate) {
    return "no estimate";
  } else {
    return time_remaining_match[1];
  }
};

export const BatteryStatus = ({battery_info}) => {
  const battery_is_charging = is_battery_charging(battery_info);

  const charge_percent = get_battery_charge_percent(battery_info);

  const status_class = get_battery_status_class(charge_percent, battery_is_charging);

  const time_remaining = get_battery_time_remaining(battery_info);
  
  return (
    <span className={status_class}>
      {`[ ${battery_is_charging ? '+' : '-'}${charge_percent}%, ${time_remaining} ]`}
    </span>
  );
};