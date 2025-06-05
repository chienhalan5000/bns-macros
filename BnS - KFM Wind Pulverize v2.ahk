#Requires AutoHotkey v2.0

ListLines(false)
ProcessSetPriority("A")
SetKeyDelay(-1, -1)
SetMouseDelay(-1)
SetDefaultMouseSpeed(0)
SetWinDelay(-1)

#Include %A_ScriptDir%\lib\utilityv2.ahk

logFile := A_ScriptDir "\key_log.txt"  ; Define the log file path

global pulverizeCooldown := 0  ; Timestamp when Pulverize will be available
global lastCycloneKick := 0    ; Timestamp of the last CycloneKick
global lastComboStop := 0      ; Timestamp when the combo stopped

^F10::Reload()
^F11::Pause()
^F12::ExitApp()

; #HotIf WinActive("ahk_class UnrealWindow")
$RButton::{
    global lastComboStop, pulverizeCooldown  ; Declare global variables

    ; Adjust cooldown based on downtime when resuming
    if (lastComboStop > 0) {
        downtime := A_TickCount - lastComboStop
        pulverizeCooldown := Max(0, pulverizeCooldown - downtime)
        lastComboStop := 0  ; Reset downtime tracker
    }

    ; Start the combo loop
    while (Utility.GameActive() && GetKeyState("RButton", "P")) {
        Rotations.FullRotation()
    }

    ; Record the time when the combo stops
    lastComboStop := A_TickCount
}

; everything related to checking availability of skills or procs
class Availability
{
    static IsPulverizeAvailable() {
        ; Check if Pulverize is off cooldown and CycloneKick was used recently
        return (A_TickCount >= pulverizeCooldown && A_TickCount - lastCycloneKick <= 2000)  ; CycloneKick must be used within 2 seconds
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
        global pulverizeCooldown
        
        Skills.LogKey("2")
        Send "2"
        ; Reduce Pulverize cooldown by 3 seconds
        pulverizeCooldown := Max(0, pulverizeCooldown - 3000)
    }

    static CycloneKick() {
        global lastCycloneKick

        Skills.LogKey("f")
        Send "f"
        ; Update the last CycloneKick timestamp
        lastCycloneKick := A_TickCount
    }

    static Pulverize() {
        global pulverizeCooldown

        Skills.LogKey("f")
        Send "f"
        ; Set Pulverize cooldown to 12 seconds
        pulverizeCooldown := A_TickCount + 12000
    }
}

; everything rotation related
class Rotations
{
    ; default rotation without any logic for max counts
    static Default() {
        totalSleep := 0  ; Track total sleep time

        Skills.SwiftStrike()
        Sleep 280
        totalSleep += 280  ; Add sleep time

        Skills.LMB()
        Sleep 280
        totalSleep += 280  ; Add sleep time

        Skills.CycloneKick()
        Sleep 280
        totalSleep += 280  ; Add sleep time

        ; Subtract total sleep time from Pulverize cooldown
        global pulverizeCooldown
        pulverizeCooldown := Max(0, pulverizeCooldown - totalSleep)
    }

    ; full rotation with situational checks
    static FullRotation() {
        ; Check if Pulverize is available
        if (Availability.IsPulverizeAvailable()) {
            Skills.LMB()
            Sleep 280
            Skills.Pulverize()
            Sleep 280
        }

        ; Execute the main combo
        Rotations.Default()
    }
}