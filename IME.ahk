; IME.ahk - AHK v2対応 IME制御用ユーティリティ

GetImeStatus(hwnd) {
    hIMC := DllCall("imm32\ImmGetContext", "Ptr", hwnd, "Ptr")
    if !hIMC
        return false

    status := DllCall("imm32\ImmGetOpenStatus", "Ptr", hIMC)
    DllCall("imm32\ImmReleaseContext", "Ptr", hwnd, "Ptr", hIMC)
    return status != 0
}

SetImeStatus(hwnd, turnOn := true) {
    hIMC := DllCall("imm32\ImmGetContext", "Ptr", hwnd, "Ptr")
    if !hIMC
        return

    if turnOn {
        DllCall("imm32\ImmSetOpenStatus", "Ptr", hIMC, "Int", 1)
    } else {
        DllCall("imm32\ImmSetOpenStatus", "Ptr", hIMC, "Int", 0)
    }

    DllCall("imm32\ImmReleaseContext", "Ptr", hwnd, "Ptr", hIMC)
}
