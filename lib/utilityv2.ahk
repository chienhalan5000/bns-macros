#Requires AutoHotkey v2.0

SendMode "Input"
SetWorkingDir A_ScriptDir

; everything utility related
class Utility
{
    ; return the color at the passed position
    static GetColor(x, y, &red?, &green?, &blue?)
    {
        color := PixelGetColor(x, y, "RGB")
        if IsSet(red) {
            red := (color & 0xFF0000) >> 16
        }
        if IsSet(green) {
            green := (color & 0xFF00) >> 8
        }
        if IsSet(blue) {
            blue := color & 0xFF
        }
        return color
    }

    ; check if BnS is the current active window
    static GameActive()
    {
        return true
    }
}