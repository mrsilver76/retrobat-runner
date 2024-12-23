#Requires AutoHotkey v2.0
#Include XInput.ahk
#SingleInstance Force
#Warn

;
; RetroBat Runner v1.1.0 (22nd December 2024)
; Automatically launch RetroBat when a specific button combination is
; pressed on any connected controller
; https://github.com/silver76/retrobat-runner/
;
; This program runs in the system tray and automatically launches RetroBat
; when a specific button combination is pressed. This is useful for people
; who don't want to run RetroBat perminantly on a computer and want an
; easy way to start it when they are sitting on the sofa and/or don't have
; easy access to a keyboard and mouse.
;
; Trail running icon created by Freepik - Flaticon
; https://www.flaticon.com/free-icons/trail-running
;
; This program is free software; you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation; either version 2 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License along
; with this program; if not, write to the Free Software Foundation, Inc.,
; 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
;
; ----- Configuration starts here ----------------------------------------

; comboButton
; An array containing the button combinations that need to be entered
; before RetroBat will start. The default and recommended list is
; XINPUT_GAMEPAD_BACK (the "Select" button) followed by
; XINPUT_GAMEPAD_START (the "Start" button). A shorter combination
; is easier to press, but increases the chance that it's accidentally
; pressed.
;
; Possible values can be found by looking at XInput.ahk

XInput_Init()  ; Required for values to work in line below
comboButton := [ XINPUT_GAMEPAD_BACK, XINPUT_GAMEPAD_START ]

; buttonTimer
; The time (in milliseconds) allowed between each button press. If
; the next button is not pressed within this time then the user
; must start the combination again. A longer timer makes it easier
; for someone to press the combination, but increases the chance that
; it's accidentally pressed. The defaut is 1000ms = 1 second.

buttonTimer := 1000

; confirmRumble
; If set to 1, the controller that correctly presses the last button of
; the combo will rumble and a sound will be played. If set to 0, then
; there will be no haptic or audio feedback.
;
; Note: This will not work if the controller doesn't support rumble!

confirmRumble := 1

; ----- End of configuration --------------------------------------------- 

version := "1.1.0"
comboPos := 1
lastButtonPress := 0
lastButtonPressTimer := 0
buttonPress := 0
startWithWindows := false

Initialise()

Loop
{
	buttonPress := 0
	
	; Poll all four controllers looking for a button
	; press. 
	
	Loop 4 {
		state := XInput_GetState(A_Index-1)
		Try
		{
			If (state.wButtons != 0)
			{
				buttonPress := state.wButtons
			}
		}
	}
	
	; Has a button been pressed?
	
	if (buttonPress > 0)
	{
		Handle_Button_Press()
	}
	
	; Sleep to avoid high CPU usage
	Sleep(100)
}

; Handle_Button_Press
; Called when a button on a controller has been pressed.

Handle_Button_Press()
{
	Global

	; Are we midway through a combo and timed out?

	If (lastButtonPressTimer != 0 && A_TickCount - lastButtonPressTimer > buttonTimer)
	{
		Reset_Everything()
		; Don't return here, carry on handling the button press...
	}

	; If buttonPress == lastPress then we've not yet taken our
	; finger off the button, so update the timestamp to allow
	; for people who press the button thoroughly
	
	If (buttonPress == lastButtonPress)
	{
		lastButtonPressTimer := A_TickCount
		Return
	}
	
	; Have we pressed the wrong next button?
	
	If (buttonPress != comboButton[comboPos])
	{
		Reset_Everything()
		Return
	}
	
	; We've pressed the right button, within the right amount of time
	; so we need to move onto the next button
	
	comboPos++	
	lastButtonPressTimer := A_TickCount
	lastButtonPress := buttonPress

	; If we're at the end of the list then the combo has been successfully
	; executed

	If (comboPos > comboButton.Length)
	{
		Combo_Executed()
		Reset_Everything()
	}
}

; Reset_Everything
; Sets the position of the combo back to the beginning and clears
; the details of the last button press and when it was pressed.

Reset_Everything()
{
	Global
	comboPos := 1
	lastButtonPress := 0
	lastButtonPressTimer := 0
}
					
; Initialise
; Works out where RetroBat is installed and configures the system
; tray icon and menu

Initialise()
{
	Global

	; Get the path from the registry
	Global retrobatPath := RegRead("HKEY_CURRENT_USER\Software\RetroBat", "LatestKnownInstallPath", "")
	if (!retrobatPath)
	{
		; No registry key, so assume the default install location
		retrobatPath := "C:\Retrobat\"
	}
	; Append trailing slash if it is missing
	if (!SubStr(retrobatPath, -1) == "\")
	{
		retrobatPath .= "\"
	}
	; Append the executable name
	retrobatPath .= "retrobat.exe"

	; Check if this exists
	If (!FileExist(retrobatPath))
	{
		Msgbox("Unable to find RetroBat at " retrobatPath, "RetroBat Runner", 16)
		ExitApp 1
	}
		
	; Configure system tray menu and set icon to RetroBat
	
	A_IconTip := "RetroBat Runner v" version
	A_TrayMenu.Add()
	A_TrayMenu.Add("Start with Windows", ToggleStartWithWindows)
	A_TrayMenu.Add("About RetroBat Runner", About)
	TraySetIcon(retrobatPath, 1, false)

	; Work out if we're configured to run at startup
	
	startupExe := RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "RetroBat Runner", "")
	if (startupExe && startupExe == '"' A_ScriptFullPath '"')
	{
		A_TrayMenu.Check("Start with Windows")
		startWithWindows := true
	}
}

; ToggleStartWithWindows
; Called when the "Start with Windows" menu option is clicked on.

ToggleStartWithWindows(*)
{	
	Global
	
	; Toggle the menu item
	
	A_TrayMenu.ToggleCheck("Start with Windows")
	startWithWindows := !startWithWindows
	
	; Write or delete the registry key for this current user
	
	if (startWithWindows == true)
	{
		RegWrite('"' A_ScriptFullPath '"', "REG_SZ", "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "RetroBat Runner")
	}
	else
	{
		RegDelete("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "RetroBat Runner")
	}
}

; ComboExecuted
; Called when the combination has been successfully executed. 

Combo_Executed()
{
	Global
	
	; If EmulationStation is already running then we shouldn't
	; do anything
	PID := ProcessExist("emulationstation.exe")	
	If (PID != 0)
	{
		Return
	}
	
	; If configured, rumble all controllers (where supported)
	; Try is used to avoid errors being thrown for controllers that
	; either don't exist or don't support rumble.
	
	If (confirmRumble == 1)
	{
		SoundPlay("*-1")
		futureTick := A_TickCount + 250 ; 1/4 of a second in the future
		while (futureTick > A_TickCount)
		{
			Loop 4
			{
				Try
				{
					XInput_SetState(A_Index-1, 65534, 65534)
				}
			}
		}
		
		; Turn rumble back off again. This avoids a strange bug where
		; rumble continues forever.
		
		Loop 4
		{
			Try
			{
				XInput_SetState(A_Index-1, 0, 0)
			}
		}
	}	

	; Now we need to launch RetroBat ... but ... there is a problem.
	;
	; Sometimes EmulationStation (ES) doesn't properly activate. When this happens,
	; you see ES almost full screen, but the Windows taskbar is visible (and maybe the odd
	; window) and controller input isn't detected. 
	;
	; The obvious solution is to wait until ES starts and then just do:
	;
	;     WinActivate "ahk_class SDL_app"
	; 
	; but that causes a new problem - as when you launch a game from ES
	; that uses RetroArch, RetroArch runs behind ES and you cannot control it. Even
	; swapping out ahk_class to ahk_id doesn't work.
	;
	; This workaround mimics pretty much what someone sitting at their computer
	; would do - which is to launch ES, wait until it appears and then click on it
	; to bring it to the foreground.
	;
	; Firstly we need to minimise everything on the desktop and ensure
	; that no window is active (by making the desktop active). This is so that
	; when we position the pointer later on, it's not on top of any windows.
	
	SendInput "#m"
	WinActivate "ahk_class Progman"
	WinWaitActive "ahk_class Progman"

	; Now we launch RetroBat

	Try
	{
		Run(retrobatPath,,"Max")
	}
	Catch as e
	{
		MsgBox("Unable to launch " retrobatPath "`n`n" e.Message, "RetroBat Runner", 48)
		Return
	}

	; Now we wait until ES is running and then we move the mouse cursor to the centre of
	; the screen and wait for ES to be detected under the mouse cursor (using `MouseGetPos`).
	; Once we have this, we'll simulate a left mouse click.
	
	ESPid := ProcessWait("emulationstation.exe", 5)
	If (ESPid)
	{
		; ES is running. Move the mouse to the centre of the screen.
		CoordMode "Mouse", "Screen"
		MouseMove A_ScreenWidth/2, A_ScreenHeight/2
		
		; Now loop 50 times, waiting until the PID under the mouse matches that of ES
		Loop 50
		{
			MousePID := -1
			Try
			{
				MouseGetPos ,,&ahkid
				MousePid := WinGetPID(ahkid)  ; Convert ahk_id to pid
			}
			; If the mouse pid is the ES pid, then we know that ES is running under
			; the mouse pointer ... so send a left-click.
			If (MousePid == ESPid)
			{
				MouseClick "left"
				Break
			}
			Sleep 100
		}
	}

	; Wait for 5 seconds before accepting any input again
	Sleep(5 * 1000)	
}

; About
; Message pop-up with an about screen

About(*)
{	
	; Generate button combination
	buttons := ""
	for buttonCode in comboButton
	{
		buttons .= (buttons ? " then " : "") GetButtonName(buttonCode)
	}

	msg := "RetroBat Runner v" version "`n"
	msg .= "https://github.com/mrsilver76/retrobat-runner/`n"
	msg .= "Automatically launch RetroBat after a specific combination has been pressed on any attached controller`n`n"
	
	msg .= "This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.`n`n"
	
	msg .= "RetroBat locaton: " retrobatPath "`n"
	msg .= "Start with Windows: " (startWithWindows = 1 ? "yes" : "no") "`n"
	msg .= "Button combo: " buttons "`n"
	msg .= "Button timer: " buttonTimer " milliseconds`n"
	msg .= "Rumble confirm: " (confirmRumble = 1 ? "yes" : "no")
	
	MsgBox msg, "About Retrobat Runner", 64
}

; GetButtonName
; A horrible function to get the name of the button from its hex value.
; We do this because dictionaries cannot use numbers as the key and I'm
; unable to get an array to work properly.

GetButtonName(hexCode)
{
    switch hexCode
	{
        case 0x0001:
            return "DPAD_UP"
        case 0x0002:
            return "DPAD_DOWN"
        case 0x0004:
            return "DPAD_LEFT"
        case 0x0008:
            return "DPAD_RIGHT"
        case 0x0010:
            return "START"
        case 0x0020:
            return "BACK/SELECT"
        case 0x0040:
            return "LEFT_THUMB"
        case 0x0080:
            return "RIGHT_THUMB"
        case 0x0100:
            return "LEFT_SHOULDER"
        case 0x0200:
            return "RIGHT_SHOULDER"
        case 0x0400:
            return "GUIDE"
        case 0x1000:
            return "A"
        case 0x2000:
            return "B"
        case 0x4000:
            return "X"
        case 0x8000:
            return "Y"
        default:
            return "Unknown"
    }
}