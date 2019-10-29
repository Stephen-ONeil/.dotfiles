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
        ({index, visible, focused}) => (
        <li className={`${yabaiSpace} ${visible && yabaiSpaceVisible} ${focused && yabaiSpaceFocused}`}>
          {index}
        </li>
        )
      )}
    </ul>
  );
};