#Requires AutoHotkey v2.0

^!z::  ; Control+Alt+Z hotkey.
{
    color := 0xfcf3eb
    if(color >= 0xf2e9e1 && color <= 0xfffdf5)
        MsgBox "Pulverize is available"
    else
        MsgBox "Pulverize is not available"
}