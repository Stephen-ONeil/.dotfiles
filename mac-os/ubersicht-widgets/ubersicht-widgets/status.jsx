import { css } from "uebersicht";

export const refreshFrequency = 10000;
export const command = "./status.sh";
export const className = css`
  right: 18px;
  top: 8px;
  height: 13px;
`;


const is_wifi_off = (wifi_info) => /AirPort:off/.test(wifi_info);
const is_wifi_disconnected = (wifi_info) => /state:init/.test(wifi_info);
const get_wifi_quality = (wifi_info) => {
  const received_signal_strength = +(/agrCtlRSSI:([^;]+)/.exec(wifi_info)[1]);

  // Rules from the original widgets I used, https://github.com/noperator/dotfiles/tree/master/widgets
  // This stuff doesn't seem to be an exact science, could get fancier and base it on more than just agrCtlRSSI too
  if (received_signal_strength <= -100){
    return 0;
  } else if (received_signal_strength >= -50){
    return 100;
  } else {
    return 2*(received_signal_strength + 100);
  }
};
const get_wifi_status_class = (quality) => {
  if (quality >= 60 ){
    return "good";
  } else if (quality >= 30){
    return "degraded";
  } else {
    return "bad";
  }
};
const get_wifi_ssid = (wifi_info) => /[^B]SSID:([^;]+)/.exec(wifi_info)[1];

const WifiStatus = ({wifi_info}) => {
  if ( is_wifi_off(wifi_info) ){
    return <span className="bad">( off )</span>;
  } else if( is_wifi_disconnected(wifi_info) ){
    return <span className="bad">( disconnected )</span>;
  } else {
    const quality = +( get_wifi_quality(wifi_info) );
    const status_class = get_wifi_status_class(quality);
    const ssid = get_wifi_ssid(wifi_info);

    return <span className={status_class}>{`( ${quality}% at ${ssid} )`}</span>;
  }
};


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
  const reported_time_remaining = (/; ([^ ]*) remaining;/.exec(battery_info) || ["",""])[1];
  if (reported_time_remaining === "" || $time_remaining == "0:00") {
    return "no estimate";
  } else {
    return reported_time_remaining;
  }
};
const BatteryStatus = ({battery_info}) => {
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


const StatusSeparator = () => <span className='status-seperator'>|</span>;

export const render = ({ output }) => {
  const {
    battery_info,
    wifi_info,
    date,
  } = JSON.parse(output);

  return (
    <div>
      <link rel="stylesheet" type="text/css" href="status.css" />
      <div class="statuses">
        <BatteryStatus battery_info={battery_info} />
        <StatusSeparator />
        <WifiStatus wifi_info={wifi_info} />
        <StatusSeparator />
        {date}
      </div>
    </div>
  );
};