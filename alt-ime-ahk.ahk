#Include IME.ahk

#MaxHotkeysPerInterval 350

; 各種キーのパススルー処理（略）
; ...（ここはそのまま）

; フラグ定義
LAltPressed := false
RAltPressed := false

; 左 Alt キーが押された
*LAlt::
    LAltPressed := true
    SetTimer, CheckLAlt, -150  ; 150ms以内に他のキーが押されなければIME切替とみなす
    Return

; 左 Alt キーが離された
LAlt up::
    if (LAltPressed) {
        IME_SET(0)
        LAltPressed := false
        Return
    }
    Return

CheckLAlt:
    if (GetKeyState("LAlt", "P")) {
        ; Alt押しっぱなし → 組み合わせの可能性 → IME切替しない
        LAltPressed := false
    }
Return

; 右 Alt キーが押された
*RAlt::
    RAltPressed := true
    SetTimer, CheckRAlt, -150
    Return

; 右 Alt キーが離された
RAlt up::
    if (RAltPressed) {
        IME_SET(1)
        RAltPressed := false
        Return
    }
    Return

CheckRAlt:
    if (GetKeyState("RAlt", "P")) {
        RAltPressed := false
    }
Return
