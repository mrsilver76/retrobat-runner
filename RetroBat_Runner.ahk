#Requires AutoHotkey v2.0
#Include XInput.ahk
#SingleInstance Force
#Warn

;
; RetroBat Runner v1.2.0 (1st May 2025)
; Automatically launch RetroBat when a specific button combination is
; pressed on any connected controller
; https://github.com/silver76/retrobat-runner/
;
; A program that runs in the system tray and automatically launches RetroBat
; when a specific button combination is pressed. This is useful for people
; who don't want to run RetroBat perminantly on a computer and want an
; easy way to start it without using the keyboard and mouse.
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

; buttonTimer
; The time (in milliseconds) allowed between each button press. If
; the next button is not pressed within this time then the user
; must start the combination again. A longer timer makes it easier
; for someone to press the combination, but increases the chance that
; it's accidentally pressed. The defaut is 1000ms = 1 second.

buttonTimer := 2000

; confirmRumble
; If set to 1, the controller that correctly presses the last button of
; the combo will rumble and a sound will be played. If set to 0, then
; there will be no haptic or audio feedback.
;
; Note: This will only work for XInput controllers that support rumble.

confirmRumble := 1

; ----- End of configuration ---------------------------------------------

version := "1.2.0"
startWithWindows := false
debugOutput := 0
retrobatPath := ""
emulationStationPID := 0
testMode := 0

class INPUT_MODE {
	static DirectInput := 1
	static XInput := 2
}

XInput_Init()
Initialise()
Logger("main", "Starting RetroBat Runner " version)

lastCheck := 0
loop {

	if (emulationStationPID == 0)
		Detect_First_Input()

	if (emulationStationPID > 0) {
		; Check if 2 seconds have passed since last call
    	if (A_TickCount - lastCheck >= 2000) {
        	Check_ES_Status()
        	lastCheck := A_TickCount
		}
    }
	Sleep(100)
}
Exit

; Check_ES_Status
; Called every couple of seconds to determine if EmulationStation is still running. If it is
; not then we will start checking for controller input and execute any shutdown commands
Check_ES_Status() {
	global buttonTimer, confirmRumble, testMode, version, startWithWindows, debugOutput, retrobatPath, emulationStationPID

	; Do we have a PID and that PID still exists? If so, then it's running

	if (emulationStationPID > 0 && ProcessExist(emulationStationPID)) {
		return
	}

	; EmulationStation was running, but now isn't

	Logger("Check_ES_Status", "EmulationStation (PID " emulationStationPID ") no longer exists")
	emulationStationPID := 0

	; Future development: configure a command that can be run when EmulationStation exists
}

; Detect_First_Input
; Main loop that identifies when a user presses the back/select button on their controller.
Detect_First_Input() {
	global buttonTimer, confirmRumble, testMode, version, startWithWindows, debugOutput, retrobatPath, emulationStationPID

	loop 16 {
		controllerID := A_Index

		; Check Direct Input or Bluetooth controllers
		for button in [7, 9, 11] {
			if GetKeyState(controllerID "Joy" button) {
				Logger("Detect_First_Input", "Detected DirectInput: " controllerId "Joy" button)
				Detect_Second_Input(controllerID, button, INPUT_MODE.DirectInput)
				return
			}
		}

		; Check XInput controllers
		if (controllerID <= 4) {
			state := XInput_GetState(controllerID - 1)
			if (state && state.wButtons == XINPUT_GAMEPAD_BACK) {
				Logger("Detect_First_Input", "Detected XInput: joy " controllerId " with state " state.wButtons)
				Detect_Second_Input(controllerID - 1, XINPUT_GAMEPAD_BACK, INPUT_MODE.XInput)
				return
			}
		}
	}
}

; Detect_Second_Input
; Second loop that identifies if the same controller then follows up with the start button within
; one second of releasing the first button.
Detect_Second_Input(controllerID, firstButton, inputMode) {
	global buttonTimer, confirmRumble, testMode, version, startWithWindows, debugOutput, retrobatPath, emulationStationPID

	; Wait for the button to be released
	Wait_For_Release(controllerID, firstButton, inputMode)

	Logger("Detect_Second_Input", "Entering function")

	if (inputMode == INPUT_MODE.DirectInput)
		expectedButton := firstButton + 1
	else
		expectedButton := XINPUT_GAMEPAD_START

	startTime := A_TickCount  ; Get the current time

	; Now wait for the configured amount of time waiting for the second
	; button in the combo to be pressed

	while (A_TickCount - startTime <= buttonTimer) {
		if (inputMode = INPUT_MODE.DirectInput && GetKeyState(controllerID "Joy" expectedButton)) {
			Combo_Executed(controllerID, expectedButton, INPUT_MODE.DirectInput)
			return
		}
		else if (inputMode = INPUT_MODE.XInput) {
			secondState := XInput_GetState(controllerID)
			if (secondState && secondState.wButtons == expectedButton) {
				Combo_Executed(controllerID, expectedButton, INPUT_MODE.XInput)
				return
			}
		}
		Sleep(25)  ; Keep checking until timeout
	}
	; Did not press the start bitton within buttonTimer milliseconds
	Logger("Detect_Second_Input", "Timout waiting for second button in combo")
	Sleep(500)
}

; Wait_For_Release
; Waits for the specific controller (defined by controllerID) to be no longer pressing any buttons
Wait_For_Release(controllerID, buttonID, inputMode) {
	global buttonTimer, confirmRumble, testMode, version, startWithWindows, debugOutput, retrobatPath, emulationStationPID

	Logger("Wait_For_Release", "Entering function")

	loop {
		Sleep(10)

		if (inputMode = INPUT_MODE.DirectInput) {
			if GetKeyState(controllerID "Joy" buttonID) == false {
				break
			}
		}
		else if (inputMode = INPUT_MODE.XInput) {
			state := XInput_GetState(controllerID)
			if (state && state.wButtons != buttonID)
				break
		}
	}

	; Button has been released
	Logger("Wait_For_Release", "Button released")
}

; ComboExecuted
; Called when the combination has been successfully executed.
Combo_Executed(controllerID, firstButton, inputMode) {
	global buttonTimer, confirmRumble, testMode, version, startWithWindows, debugOutput, retrobatPath, emulationStationPID

	; Wait for the button to be released
	Wait_For_Release(controllerID, firstButton, inputMode)

	Logger("Combo_Executed", "Entering function")

	; If EmulationStation is already running then we shouldn't
	; do anything
	if (emulationStationPID > 0 && ProcessExist(emulationStationPID)) {
		Logger("Combo_Executed", "EmulationStation still running (PID " emulationStationPID ") so returning")
		return
	}

	; If configured, rumble all controllers (where supported)
	; Try is used to avoid errors being thrown for controllers that
	; either don't exist or don't support rumble.

	if (confirmRumble == 1) {
		Logger("Combo_Executed", "Playing sound and rumbling controllers")
		SoundPlay("*-1")
		futureTick := A_TickCount + 250 ; 1/4 of a second in the future
		while (futureTick > A_TickCount) {
			loop 4 {
				try
				{
					XInput_SetState(A_Index - 1, 65534, 65534)
				}
			}
		}

		; Turn rumble back off again. This avoids a strange bug where
		; rumble continues forever.

		loop 4 {
			try
			{
				XInput_SetState(A_Index - 1, 0, 0)
			}
		}
	}

	; Are we running in test mode? If so, then open Notepad instead

	if (testMode == 1) {
		Logger("Combo_Executed", "Test mode: Notepad launched instead")
		Run("notepad.exe", , , &emulationStationPID)
		return
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

	SendInput("#m")
	WinActivate("ahk_class Progman")
	WinWaitActive("ahk_class Progman",,2)

	; Now we launch RetroBat

	try {
		Logger("Combo_Executed", "Executing " retrobatPath)
		Run(retrobatPath, , "Max", &retroBatPID)
		Logger("Combo_Executed", "RetroBat PID = " retroBatPID)
	}
	catch as e {
		MsgBox("Unable to launch " retrobatPath "`n`n" e.Message, "RetroBat Runner", 48)
		Logger("Combo_Executed", "Unable to launch: " e.Message)
		return
	}

	; We've launched RetroBat and it will then launch EmulationStation - so we need to
	; monitor the child processes that RetroBat spawns and identify the one that
	; is EmulationStation

	Loop 50 {
		Sleep(100)
		childPIDs := GetChildPIDs(retroBatPID)
		for pid in childPIDs {
			name := ProcessGetName(pid)
			if name ~= "i)emulationstation" {
				emulationStationPID := pid
				break 2  ; exit both loops
			}
		}
	}

	; If we don't have the EmulationStation PID then there isn't much we can do
	if (emulationStationPID == 0) {
		Logger("Combo_Executed", "Unable to get EmulationStation PID from parent process " retroBatPID)
		MsgBox("EmulationStation does not appear to be launching!", "RetroBat Runner", 48)
		return
	}
	Logger("Combo_Executed", "EmulationStation PID = " emulationStationPID)

	; We are going to  move the mouse cursor to the centre of the screen and wait for
	; EmulationStation to be detected under the mouse cursor (using
	; `MouseGetPos`). Once we have this, we'll simulate a left mouse click.

	CoordMode("Mouse", "Screen")
	MouseMove(A_ScreenWidth / 2, A_ScreenHeight / 2)

	; Now loop 50 times, waiting until the PID under the mouse matches that of EmulatonStation
	loop 50 {
		MouseGetPos(, , &winID)
	    mousePID := WinGetPID("ahk_id " winID)

		if (mousePID == emulationStationPID) {
			break
		}
		Sleep(100)
	}

	if (mousePID != emulationStationPID) {
		; We couldn't find EmulationStation, so give up
		Logger("Combo_Executed", "Unable to find EmulationStation under mouse pointer")
		return
	}

	; EmulationStation is running, so send a left click

	Logger("Combo_Executed", "Found EmulationStation under mouse pointer")
	MouseClick("left")

	; Sleep for 1 second, put the mouse in the centre and then click again
	Sleep(1000)
	MouseMove(A_ScreenWidth / 2, A_ScreenHeight / 2)
	MouseClick("left")

	; Now move mouse to top-left corner
	MouseMove(A_ScreenWidth, 0)

	Logger("Combo_Executed", "All mouse clicks sent to EmulationStation")
}

; Logger
; Write output to a log file, but only if debugging is enabled
Logger(funcName, msg) {
	if (debugOutput == 0)
		return

	timeStamp := FormatTime(, "yyyy-MM-dd HH:mm:ss")
	prefix := "[" timeStamp "] [" funcName "]"

	logPath := A_ScriptFullPath ".log"

	FileAppend(prefix " " msg "`n", logPath)
}

; Initialise
; Works out where RetroBat is installed and configures the system
; tray icon and menu
Initialise() {
	global buttonTimer, confirmRumble, testMode, version, startWithWindows, debugOutput, retrobatPath, emulationStationPID

	; Check if called with /debug or /test
	for index, arg in A_Args {
		if (StrLower(arg) = "/debug") {
			debugOutput := 1
			try FileDelete(A_ScriptFullPath ".log")
		}
		if (StrLower(arg) = "/test") {
			testMode := 1
		}
	}

	; Change version number if running in test mode
	if (testMode) {
		version .= " [test mode]"
	}

	; Get the path from the registry
	retrobatPath := RegRead("HKEY_CURRENT_USER\Software\RetroBat", "LatestKnownInstallPath", "")
	if (!retrobatPath) {
		; No registry key, so assume the default install location
		retrobatPath := "C:\Retrobat\"
	}
	; Append trailing slash if it is missing
	if (!SubStr(retrobatPath, -1) == "\") {
		retrobatPath .= "\"
	}
	; Append the executable name
	retrobatPath .= "retrobat.exe"

	; Check if this exists
	if (!FileExist(retrobatPath)) {
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
	if (startupExe && startupExe == '"' A_ScriptFullPath '"') {
		A_TrayMenu.Check("Start with Windows")
		startWithWindows := true
	}
}

; ToggleStartWithWindows
; Called when the "Start with Windows" menu option is clicked on.
ToggleStartWithWindows(*) {
	global buttonTimer, confirmRumble, testMode, version, startWithWindows, debugOutput, retrobatPath, emulationStationPID

	; Toggle the menu item

	A_TrayMenu.ToggleCheck("Start with Windows")
	startWithWindows := !startWithWindows

	; Write or delete the registry key for this current user

	if (startWithWindows == true) {
		RegWrite('"' A_ScriptFullPath '"', "REG_SZ", "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "RetroBat Runner")
	}
	else {
		RegDelete("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "RetroBat Runner")
	}
}

; About
; Message pop-up with an about screen
About(*) {
	global buttonTimer, confirmRumble, testMode, version, startWithWindows, debugOutput, retrobatPath, emulationStationPID

	msg := "RetroBat Runner v" version "`n"
	msg .= "https://github.com/mrsilver76/retrobat-runner/`n"
	msg .= "Automatically launch RetroBat after a specific combination has been pressed on any attached controller`n`n"

	msg .=
		"This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.`n`n"

	msg .= "RetroBat locaton: " retrobatPath "`n"
	msg .= "Start with Windows: " (startWithWindows = 1 ? "yes" : "no") "`n"
	msg .= "Button combo: BACK/SELECT then START`n"
	msg .= "Button timer: " buttonTimer " milliseconds`n"
	msg .= "Sound & rumble confirm: " (confirmRumble = 1 ? "yes`n" : "no`n")

	if (testMode)
		msg .= "Test mode: enabled`n"
	if (debugOutput)
		msg .= "Debug output: " A_ScriptName ".log`n"

	; Remove training newline
	msg := RegExReplace(msg, "`n$", "")

	MsgBox msg, "About Retrobat Runner", 64
}

; GetChildPIDs
; Given a process ID, get a list of all the child processes that it has called
GetChildPIDs(parentPID) {
	children := []
	query := "SELECT ProcessId FROM Win32_Process WHERE ParentProcessId = " parentPID

	for process in ComObject("WbemScripting.SWbemLocator").ConnectServer().ExecQuery(query) {
		children.Push(process.ProcessId)
	}
	return children
}