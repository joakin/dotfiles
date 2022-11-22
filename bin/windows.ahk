#SingleInstance Force

#InstallKeybdHook
#UseHook

; SendMode Input
; SetKeyDelay 0

#Persistent
SetCapsLockState, AlwaysOff

; Send Capslock to Right control. Following mappings go to right control
~*Capslock::
    StartTime := A_TickCount
    Send {RCtrl DownR}
    KeyWait, Capslock
    Send {RCtrl Up}
    if (A_PriorKey = "Capslock" and A_TickCount - StartTime < 400) {
        Send {Esc}
        ; MsgBox, % A_TickCount - StartTime " millis"
    }
return

SendCommand(keys)
{
    shift := GetKeyState("Shift") ? "+" : ""
    ctrl := GetKeyState("LCtrl") ? "^" : ""
    allkeys := ctrl . shift . keys
    Send, %allkeys%
    Return
}

; Readline shortcuts
; #IfWinNotActive doesn't work with regex mode, or with multiple windows, even with groups
#If !WinActive("ahk_exe nvim-qt.exe") and !WinActive("ahk_exe WindowsTerminal.exe")

; Ctrl+A	Beginning of line
Capslock & a::SendCommand("{Home}")

; Ctrl+E	End of line
Capslock & e::SendCommand("{End}")

; Ctrl+B / ←	Backward one character
Capslock & b::SendCommand("{Left}")

; Ctrl+F / →	Forward one character
Capslock & f::SendCommand("{Right}")

; Meta+B	Backward one word
*!b::SendCommand("^{Left}")

; Meta+F	Forward one word
*!f::SendCommand("^{Right}")

; Ctrl+N / ↓	Next line (in history)
Capslock & n::SendCommand("{Down}")

; Ctrl+P / ↑	Prev line (in history)
Capslock & p::SendCommand("{Up}")

; Meta+P	Backward one page (not readline, but follows logic)
*!p::SendCommand("{PgUp}")

; Meta+N	Forward one page (not readline, but follows logic)
*!n::SendCommand("{PgDn}")

; Ctrl+D	Delete one character
Capslock & d::SendCommand("{Del}")

; Ctrl+H	Delete previous character
Capslock & h::SendCommand("{Backspace}")

; Meta+D	Delete one word
!d::SendCommand("^{Del}")

; Ctrl+G	Cancel

; Ctrl+I / Tab	Command line completion
Capslock & i::SendCommand("{Tab}")

; Ctrl+J	Line feed
Capslock & j::
SendCommand("{End}")
SendCommand("{Enter}")
Return

; Ctrl+K	Cut text to the end of line
Capslock & k::
SendCommand("+{End}")
SendCommand("{Backspace}")
Return

; Ctrl+M	Same as Enter key
; UNUSED
; Capslock & m::Send {Enter}

; Ctrl+R	Search backwards in history
; UNIMPLEMENTED

; Ctrl+S	Search forwards in history
; UNIMPLEMENTED

; Ctrl+T	Transpose characters
; UNIMPLEMENTED

; Meta+T	Transpose words (TODO)
; UNIMPLEMENTED

; Ctrl+U	Cut text to the beginning of line
Capslock & u::
SendCommand("+{Home}")
SendCommand("{Backspace}")
Return

; Ctrl+W	Cut previous word
Capslock & w::Send ^{Backspace}

#If
