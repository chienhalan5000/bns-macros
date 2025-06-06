#Requires AutoHotkey v2.0

SendMode "Input"
SetWorkingDir A_ScriptDir

; everything utility related
class Utility
{
    ; return the color at the passed position
    static GetColor(x, y)
    {
        color := PixelGetColor(x, y)
        ; Tooltip('Red: 0x' SubStr(color, 3, 2)
        ; '`nGreen: 0x' SubStr(color, 5, 2)
        ; '`nBlue: 0x' SubStr(color, 7, 2))
        return color
    }

    ; check if BnS is the current active window
    static GameActive()
    {
        return true
    }

    static IsRButtonOnHold()
    {
        return GetKeyState("RButton", "P")
    }

    static LogKey(key, seperator := ">") {
        FileAppend(key " " seperator " ", logFile)  ; Append key and delay to the log file
    }
}