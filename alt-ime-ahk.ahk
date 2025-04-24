#Include IME.ahk

#MaxHotkeysPerInterval 350

; グローバルフラグ
global LAltPressed := false
global RAltPressed := false

; 左 Alt キーが押された
*LAlt::
{
    LAltPressed := true
    SetTimer(CheckLAlt, -150)
}

; 左 Alt キーが離された
LAlt up::
{
    if (LAltPressed)
    {
        IME_SET(0)
        LAltPressed := false
    }
}

CheckLAlt()
{
    if GetKeyState("LAlt", "P")
        LAltPressed := false
}

; 右 Alt キーが押された
*RAlt::
{
    RAltPressed := true
    SetTimer(CheckRAlt, -150)
}

; 右 Alt キーが離された
RAlt up::
{
    if (RAltPressed)
    {
        IME_SET(1)
        RAltPressed := false
    }
}

CheckRAlt()
{
    if GetKeyState("RAlt", "P")
        RAltPressed := false
}
