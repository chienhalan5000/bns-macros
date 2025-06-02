#Requires AutoHotkey v2.0

ListLines(false)
ProcessSetPriority("A")
SetKeyDelay(-1, -1)
SetMouseDelay(-1)
SetDefaultMouseSpeed(0)
SetWinDelay(-1)

#Include %A_ScriptDir%\lib\utilityv2.ahk

logFile := A_ScriptDir "\key_log.txt"  ; Define the log file path

^F10::Reload()
^F11::Pause()
^F12::ExitApp()

; #HotIf WinActive("ahk_class UnrealWindow")
$RButton::{
    while (Utility.GameActive() && GetKeyState("RButton", "P")) {
        Rotations.FullRotation()
    }
}

; everything related to checking availability of skills or procs
class Availability
{
    static IsPulverizeAvailable() {
        color := Utility.GetColor(1458, 413)
        return (color >= 0xf2e9e1 && color <= 0xfffdf5) ; check if color is within the range of Pulverize available +/- 10 base color 0xfcf3eb
    }
}

; skill bindings
class Skills {
    static LogKey(key, seperator := ">") {
        FileAppend(key " " seperator " ", logFile)  ; Append key and delay to the log file
    }

    static RMB() {
        Skills.LogKey("t")
        Send "t"
    }

    static LMB() {
        Skills.LogKey("r")
        Send "r"
    }

    static SwiftStrike() {
        Skills.LogKey("2")
        Send "2"
    }

    static CycloneKick() {
        Skills.LogKey("f")
        Send "f"
    }

    static Pulverize() {
        Skills.LogKey("f")
        Send "f"
    }
}

; everything rotation related
class Rotations
{
    ; default rotation without any logic for max counts
    static Default() {
        Skills.SwiftStrike()
        Sleep 280
        Skills.LMB()
        Sleep 280
        Skills.CycloneKick()
        Sleep 280

        return
    }

    ; full rotation with situational checks
    static FullRotation() {
        if (Availability.IsPulverizeAvailable()) {
            Skills.LMB()
            Sleep 280
            Skills.Pulverize()
            Sleep 280
        }

        Rotations.Default()
    }
}