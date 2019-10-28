import { css } from "uebersicht";

import { BatteryStatus } from './status/BatteryStatus.jsx';
import { WifiStatus } from './status/WifiStatus.jsx';
const StatusSeparator = () => <span className='status-seperator'>|</span>;


export const refreshFrequency = 5000;
export const command = "./status/status.sh";
export const className = css`
  right: 18px;
  top: 8px;
  height: 13px;
`;

export const render = ({ output }) => {
  const {
    battery_info,
    wifi_info,
    date,
  } = JSON.parse(output);

  return (
    <div>
      <link rel="stylesheet" type="text/css" href="status/status.css" />
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