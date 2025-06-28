#Requires AutoHotkey v2.0

ListLines(false)
ProcessSetPriority("R")
SetKeyDelay(-1, -1)
SetMouseDelay(-1)
SetDefaultMouseSpeed(0)
SetWinDelay(-1)

#Include %A_ScriptDir%\lib\utility.ahk

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
class CriticalAvailability
{
    static IsLunarSlashCrit() {
        coords := [
            {x: 256, y: 952},
            {x: 255, y: 955},
            {x: 255, y: 956},
            {x: 255, y: 957},
            {x: 255, y: 958},
            {x: 256, y: 960},
            {x: 258, y: 962},
            {x: 259, y: 962},
            {x: 261, y: 962},
            {x: 263, y: 961},
        ]

        ; Iterate through the coordinates
        for coord in coords {
            color := Utility.GetColor(coord.x, coord.y)
            if (color != 0xFF9700) {
                Utility.Log("tab crit false, color: " color . " at coords: " coord.x ", " coord.y, "`n")
                return false  ; Return false if any color doesn't match
            }
        }

        Utility.Log("tab crit true", "`n")
        return true  ; Return true if all colors match
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

    static Tab() {
        if(!Utility.IsXButton2OnHold())
            return

        ; Utility.Log("r")
        Send "{Tab}"
    }

}

; everything rotation related
class Rotations
{
    ; default rotation without any logic for max counts
    static Default() {
        Skills.LMB()
        Sleep 270

        Skills.Tab()
        Sleep 270

        if(CriticalAvailability.IsLunarSlashCrit()) {
            Skills.RMB()
            Sleep 250
        }
    }

    ; full rotation with situational checks
    static FullRotation() {
        Rotations.Default()
    }
}