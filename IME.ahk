#Requires AutoHotkey v2.0
#SingleInstance Force
#Include %A_ScriptDir%\IMEv2.ahk

global Hotkeys := Map()

OnExit(HandleExit)
SetTimer(CheckIMEState, 500)

; IME 状態表示用のツールチップ
CheckIMEState() {
    hwnd := WinActive("A")
    if hwnd {
        imeStatus := GetImeStatus(hwnd)
        ToolTip("IME: " . (imeStatus ? "ON" : "OFF"))
    }
}

; ホットキーの登録
RegisterHotkeys() {
    Hotkeys["^!i"] := ToggleIME
    for hotkey, fn in Hotkeys
        Hotkey(hotkey, fn)
}

; IMEのON/OFFトグル
ToggleIME(*) {
    hwnd := WinActive("A")
    if hwnd {
        ToggleIme(hwnd)
    }
}

; IMEをトグルする関数
ToggleIme(hwnd) {
    if GetImeStatus(hwnd)
        SetImeStatus(hwnd, false)
    else
        SetImeStatus(hwnd, true)
}

; IMEステータス取得
GetImeStatus(hwnd) {
    himc := DllCall("imm32\ImmGetContext", "ptr", hwnd, "ptr")
    result := DllCall("imm32\ImmGetOpenStatus", "ptr", himc, "int")
    DllCall("imm32\ImmReleaseContext", "ptr", hwnd, "ptr", himc)
    return result
}

; IMEステータス設定
SetImeStatus(hwnd, status) {
    himc := DllCall("imm32\ImmGetContext", "ptr", hwnd, "ptr")
    if status
        DllCall("imm32\ImmSetOpenStatus", "ptr", himc, "int", 1)
    else
        DllCall("imm32\ImmSetOpenStatus", "ptr", himc, "int", 0)
    DllCall("imm32\ImmReleaseContext", "ptr", hwnd, "ptr", himc)
}

; 終了時処理
HandleExit(ExitReason, ExitCode) {
    ToolTip() ; ToolTipを非表示にする
}

RegisterHotkeys()
