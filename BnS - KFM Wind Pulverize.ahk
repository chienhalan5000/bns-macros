#Requires AutoHotkey v2.0

ListLines(false)
ProcessSetPriority("R")
SetKeyDelay(-1, -1)
SetMouseDelay(-1)
SetDefaultMouseSpeed(0)
SetWinDelay(-1)

#Include %A_ScriptDir%\lib\utility.ahk

logFile := A_ScriptDir "\log.txt"  ; Define the log file path

^F10::Reload()
^F11::Pause()
^F12::ExitApp()

; #HotIf WinActive("ahk_class UnrealWindow")
$XButton2::{
    while (Utility.GameActive() && Utility.IsXButton2OnHold()) {
        Rotations.FullRotation()
    }
}

; everything related to checking availability of skills or procs
class Availability
{
    static IsPulverizeAvailable() {
        color := Utility.GetColor(1615, 795)
        return (color == 0xDC8B7E)
    }
}

; skill bindings
class Skills {
    static RMB() {
        if(!Utility.IsXButton2OnHold())
            return

        ; Utility.Log("t")
        Send "t"
    }

    static LMB() {
        if(!Utility.IsXButton2OnHold())
            return

        ; Utility.Log("r")
        Send "r"
    }

    static SwiftStrike() {
        if(!Utility.IsXButton2OnHold())
            return

        ; Utility.Log("2")
        Send "2"
    }

    static CycloneKick() {
        if(!Utility.IsXButton2OnHold())
            return

        ; Utility.Log("f")
        Send "f"
    }

    static Pulverize() {
        if(!Utility.IsXButton2OnHold())
            return

        Utility.Log("f (pul)")
        Send "f"
    }
}

; everything rotation related
class Rotations
{
    ; default rotation without any logic for max counts
    static Default() {
        Skills.SwiftStrike()
        Sleep 290

        Skills.LMB()
        Sleep 290
            
        Skills.CycloneKick()

        Sleep 330

        if (Availability.IsPulverizeAvailable()) {
                
            Skills.Pulverize()
            Sleep 330
            ; Skills.LMB()2
            ; Sleep 300

        }
    }

    ; full rotation with situational checks
    static FullRotation() {
        Rotations.Default()
    }
}