#SingleInstance force ; Only one copy of this script should run at a time.
SendMode("Input")  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir(A_ScriptDir)  ; Ensures a consistent starting directory.

init()

; Press Ctrl+Alt+Shift+D to switch toggle between Light and Dark Mode
^!+D::
{
  global DarkMode := !DarkMode
  global SystemThemeEnum := DarkMode ? "Dark Mode" : "Light Mode"
  UpdateTooltipAndAlert()
}

init() {
  global high := 85
  global low := 15
  global critic := 10
  global DarkMode := false
  global SystemThemeEnum := DarkMode ? "Dark Mode" : "Light Mode"
  delta := 5000
  global alert := true

  UpdateTooltipAndAlert()
  SetTimer(UpdateTooltipAndAlert, delta)
}

UpdateTooltipAndAlert() {
  static skip := 0
  if GetSystemPowerStatus() && alert {
    A_IconTip := GetFormattedBatteryStatusLevel()

    if BatteryLevel > high && ChargingStatus {
      if !skip
        TrayTip "Charge limit of " high "% reached.`nCurrent battery level: " BatteryLevel "%", "Unplug the Charger", "iconi"
      skip += 2
    }
    else if BatteryLevel <= critic && !ChargingStatus {
      if !skip
        TrayTip "Crital battery limit of " critic "% limit reached.`nCurrent battery level: " BatteryLevel "%", "Plug in the charger NOW", "iconx"
      skip := 6
    }
    else if BatteryLevel <= low && !ChargingStatus {
      if !skip
        TrayTip "Battery low. " low "% limit reached.`nCurrent battery level: " BatteryLevel "%", "Plug in the charger", "icon!"
      skip += 3
    }
    else
      skip := 0
    skip := Mod(skip, 6)
  }
  else
    A_IconTip := Format("Charging status: Unknown`nBattery level: -.-`nPower Saving Mode: U{1}", SystemThemeEnum)

  TraySetIcon Format("icons/{1}{2}{3}{4}.ico", BatteryLevel, (ChargingStatus ? "c" : ""), (BatterySaver ? "e" : ""), (DarkMode ? "i" : "")), , true
}

GetSystemPowerStatus() {
  global
  System_Power_Status := Buffer(12, 0)
  if !DllCall("kernel32.dll\GetSystemPowerStatus", "Ptr", System_Power_Status)
    return false
  ChargingStatus := NumGet(System_Power_Status, 0, "UChar") ; _ACLineStatus
  ChargeStatus := NumGet(System_Power_Status, 1, "UChar") ; _BatteryFlag
  BatteryLevel := NumGet(System_Power_Status, 2, "UChar") ; _BatteryLifePercent
  BatterySaver := NumGet(System_Power_Status, 3, "Uchar") ; _SystemStatusFlag
  BatteryLifeTime := NumGet(System_Power_Status, 4, "Int") ; _BatteryLifeTime
  BatteryFullLifeTime := NumGet(System_Power_Status, 8, "Int") ; _BatteryFullLifeTime
  return true
}

GetFormattedBatteryStatusLevel() {
  global
  Switch ChargingStatus {
    case 0: ChargingEnum := "Unplugged"
    case 1: ChargingEnum := "Charging"
    default: ChargingEnum := "Unknown"
  }

  Switch ChargeStatus {
    case 0: ChargeEnum := "(GOOD)"
    case 1: ChargeEnum := "(HIGH)"
    case 2: ChargeEnum := "(LOW)"
    case 4: ChargeEnum := "(CRITICAL)"
    default: ChargeEnum := ""
  }

  Switch BatterySaver {
    case 0: BatterySaverEnum := "Off"
    case 1: BatterySaverEnum := "On"
    default: BatterySaverEnum := "Unknown"
  }

  return Format("{1}`nBattery level: {3}.0% {2}`nPower Saving Mode: {4}`n{5}", ChargingEnum, ChargeEnum, BatteryLevel, BatterySaverEnum, SystemThemeEnum)
}
