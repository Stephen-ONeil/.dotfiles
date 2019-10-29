import { css } from "uebersicht";


export const refreshFrequency = 500;

export const command = "/usr/local/bin/yabai -m query --spaces";

export const className = css`
  font-family: menlo;
  font-size: 14px;
  font-weight: 600;
  -webkit-font-smoothing: antialiased;
  
  position: relative;
  margin-top: 7px;
  
  color: #9c9c9c;
`;
const yabaiSpaceList = css`
  list-style: none;
  margin: 0 0 0 1em;
  padding: 0;
`;
const yabaiSpace = css`
  display: inline-block;
  text-align: center;
  width: 1em;
  margin: 0 0.5em;
`;
const yabaiSpaceVisible = css`
  color: #fff;
`;
const yabaiSpaceFocused = css`
  border-bottom: 3px solid #1a73e8
`;

export const render = ({ output }) => {
  const spaces = JSON.parse(output);

  return (
    <ul className={yabaiSpaceList}>
      { spaces.map(
        ({id, index: yabai_index, display, visible, focused}, ix) => [
          ix > 0 && display !== spaces[ix-1].display && ( // indicate display change with marker placed before first space on new display
            <li key={`display-${display}-separator`} className={yabaiSpace}>
              -
            </li>
          ),
          <li key={id} className={`${yabaiSpace} ${visible && yabaiSpaceVisible} ${focused && yabaiSpaceFocused}`}>
            {yabai_index}
          </li>,
        ]
      )}
    </ul>
  );
};