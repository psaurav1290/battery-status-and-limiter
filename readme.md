###### *Author- [Saurav Priyadarshi](https://github.com/psaurav1290/)*
# Battery Status & Limiter
This is a simple battery utility script written in [AutoHotkey v2.0](https://www.autohotkey.com/).

_Docs- [AutoHotkey v2 documentation](https://www.autohotkey.com/docs/v2/)._

## Key Features-
1. Displays current battery percentage right in the tray icon unlike the inaccurate representation battery level in default windows battery icon. The default icon usually gives wrong impression of the battery charge level.![Battery utility tray icon](https://raw.githubusercontent.com/psaurav1290/battery-status-and-limiter/main/screenshots/tray.png)
2. Hovering on the tray icon displays tooltip containing- plugged in status, battery level, power saving mode, theme of the tray icon.
	![Battery utility tray tooltip](https://raw.githubusercontent.com/psaurav1290/battery-status-and-limiter/main/screenshots/tray-tooltip.png)
3. The hotkey `Ctrl + Alt + Shift + D` toggles dark mode, i.e.- switches between the light and dark theme of the tray icon. Light mode is the default mode.
4. Sends battery level alerts to prevent over charging and deep discharges and thus increase battery life. There are following three levels of alert-
	- Error (every *`delta`* sec)- When the battery level is critically low, i.e. <= 10%
	- Warning (every 2 *`delta`* sec)- When the battery level is low, i.e. <= 15%
	- Info (every 3 *`delta`* sec)- When the battery is charged up to upper limit, i.e. >=85
	
	By default - `delta = 5sec`
5. Charging and battery saving icons included in icon pack.	![Charging made tray icon](https://raw.githubusercontent.com/psaurav1290/battery-status-and-limiter/main/screenshots/charging-mode.png)
![Battery saving mode tray icon](https://raw.githubusercontent.com/psaurav1290/battery-status-and-limiter/main/screenshots/eco-mode.png)

## Setting up-
1. Download and install [AutoHotkey v2.0](https://www.autohotkey.com/).
2. Clone this repository.
	OR
	Alternatively click [here](https://github.com/psaurav1290/battery-status-and-limiter/archive/refs/heads/main.zip) to download the repository as zip. Extract the zip.
3. Run the `BatteryUtility.ahk`.

## Running the script on startup-
1. Copy the `BatteryUtility.ahk`.
2. Open Run using Ctrl+R, type `shell:startup` and press enter to open the user startup folder.
3. Paste here the shortcut of the file copied in step 3.

## Customization-
1.  **Change alert levels-**
	Alter the alert levels according to your needs in line 12, 13 and 14.
	```
	12 | global high := 85
	13 | global low := 15
	14 | global critic := 10
	```

2. **Change alert frequency (`delta`)-**
	To change the frequency of alerts, change the `delta` value in line 17.
	e.g.-
	To change the alert frequency of error, warning and info to 10sec, 20sec, 30sec respectively, change the delta to 10000 *(10000ms = 10sec)* in line 17-
	```
	17 | delta := 10000
	```
	
	***Note-** This will also cause to change the refresh rate of battery percentage in tray icon to once every 10sec.*

3. **To disable  alert-**
	Change the `delta` value in line 18 to `0`.
	```
	18 | global alert := false
	```

4. **Change default theme-**
	To switch to dark mode as default mode change the Boolean to `true` on line 15-
	```
	15 | global DarkMode := true
	```

5. **To change the hotkey to toggle the theme-**
	Change the hotkey in line 5.
	e.g.- To change the hotkey to `Ctlr + D` write the following code in line 5-
	```
	5 | ^D::
	```
