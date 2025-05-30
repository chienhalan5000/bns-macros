#Requires AutoHotkey v2.0

ListLines(false)
ProcessSetPriority("A")
SetKeyDelay(-1, -1)
SetMouseDelay(-1)
SetDefaultMouseSpeed(0)
SetWinDelay(-1)

#Include %A_ScriptDir%\lib\utilityv2.ahk

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
        return Utility.GetColor(1458, 413) == 0xfcf3eb
    }
}

; skill bindings
class Skills {
    static RMB() {
        Send "t"
    }

    static LMB() {
        Send "r"
    }

    static SwiftStrike() {
        Send "2"
    }

    static CycloneKick() {
        Send "f"
    }

    static Pulverize() {
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
            while (Availability.IsPulverizeAvailable() && Utility.GameActive() && (GetKeyState("RButton", "P") || GetKeyState("XButton2", "P"))) {
                Skills.LMB()
                Sleep 280
                Skills.Pulverize()
                Sleep 280
            }
        }

        Rotations.Default()
    }
}