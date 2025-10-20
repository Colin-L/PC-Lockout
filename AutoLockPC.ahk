; LockPC.ahk
; Puts PC to sleep for an hour at a specified time
; Gives a warning a few minute before locking

#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

global LOCK_START_HOUR := 19 ; 7 PM
global LOCK_END_HOUR := 20 ; 8 PM
global WARNING_MINUTES_BEFORE_LOCK = 5

Loop
    {
       LockPC()
        Sleep, WARNING_MINUTES_BEFORE_LOCK * 60 * 1000
    }

WarnUser(){
    SoundPlay, warning-sound-6686.wav
    TrayTip, Warning, PC will lock in %WARNING_MINUTES_BEFORE_LOCK% minutes
Return
}

LockPC(){
    FormatTime, CurrentHour,, HH
    FormatTime, CurrentMinutes,, mm
    WarningTime := (LOCK_START_HOUR * 60) - WARNING_MINUTES_BEFORE_LOCK
    CurrentTime :=CurrentHour * 60 + CurrentMinutes
    LockStartTime := LOCK_START_HOUR * 60

    If (CurrentTime >= WarningTime and CurrentTime < LockStartTime)
    {
        WarnUser()
    }
    ; Check if the current time is between 7 PM and 8 PM
    Else If (CurrentHour >= LOCK_START_HOUR and CurrentHour < LOCK_END_HOUR)
    {
        SoundPlay, warning-sound-6686.wav
        Sleep, 2 * 1000
        SoundPlay, warning-sound-6686.wav

        TrayTip, Warning, PC will go to sleep in 10 seconds
        Sleep, 10 * 1000

        ; Put the PC to sleep
        DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)
    }
Return
}