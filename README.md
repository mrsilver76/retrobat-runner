# RetroBat Runner
*Automatically launch RetroBat when a specific button combination is pressed on any connected controller*

This program runs in the system tray and automatically launches [RetroBat](https://www.retrobat.org/) when a specific button combination is pressed. This is useful for people who don't want to run RetroBat perminantly on a computer and want an easy way to start it.

The source code is heavily documented and can be easily modified to suit your preferences. There is also an executable which comes with sensible default settings and should work for most people without the need to do anything further.

## Download

1. Get the latest version from https://github.com/mrsilver76/retrobat-runner/releases.
2. Decompress the file by double-clicking on the zip file.
3. Launch the program by double-clicking on the exe file.

## Running RetroBat Runner

* Once RetroBat Runner is launched, it will appear in your System Tray with the RetroBat icon.
* The default launch combination is **SELECT/BACK** followed by **START**. It does not matter which controller you use and you can even use different controllers to complete the combination.
* You must press the **START** button within 1 second of pressing the **SELECT/BACK** button. If you do not, then you will need to start the combination from the beginning again.
* If you press the combination correctly, all controllers will vibrate (if the controller supports this) and RetroBat will start.
* Pressing the combination whilst you are running RetroBat will do nothing.

> [!TIP]
> The program automatically works out the location of RetroBat by querying the registry (`HKCU\Software\RetroBat\LatestKnownInstallPath`). If this does not work then it will assume the location is `C:\RetroBat\`.

## Configuration instructions

If you want to configure the program then you need to edit the source code in your preferred text editor. I recommend [Notepad++](https://notepad-plus-plus.org/) but Notepad will do. You will also need [AutoHotkey v2](https://www.autohotkey.com/) installed.

Make your changes (the code is documented to help you), save the file and then double-click on it to run. If you want to run it on a machine that doesn't have AutoHotkey installed then I recommend compiling it. 

There are a couple of things you can easily configure at the top of the code:

### comboButton

This is the combination of buttons you need to press in order to launch RetroBat. Each button has a number associated with it and a constant which is easier to read and understand (for example, `XINPUT_GAMEPAD_DPAD_DOWN` has the value `0x0002`). You can use either the number or the constant in this line of code. You can find the constants in `XInput.ahk` or at [this Microsoft page](https://learn.microsoft.com/en-us/windows/win32/api/xinput/ns-xinput-xinput_gamepad).

> [!TIP]
> Controllers usually have either a "back" or "select" button and `XINPUT_GAMEPAD_BACK` is used for both.

You can have as many button combinations as you like however, the more you have, the harder it will be for someone to execute. You shouldn't have the combination too simple, otherwise you run the risk of accidentally triggering it.

The default setting is **SELECT/BACK** followed by **START**.

### buttonTimer

This is the maximum number of milliseconds between each button press. If you take longer than that, then the button combination needs to be started from the beginning.

The longer the time, the easier it is for someone to execute the combination but the more likely that they will trigger it during general usage.

The default setting is 1000ms, which is 1 second.

### confirmRumble

If you want all the connected controllers to rumble when you complete the combo, then set this to `1`. This will only work on controllers that have a rumble motor in them.

The default setting is `1` which means rumble is on.

## Installation instructions

The easiest approach is to store the executable in the start up folder in Windows. To locate this, right-click on the Windows icon, select "Run", type `shell:startup` and press Enter. If you put the executable (or code) in this folder then RetroBat Runner will start whenever that user logs in.

The executable uses very little CPU and memory.

## Attribution

The Trail running icon was created by [Freepik - Flaticon](https://www.flaticon.com/free-icons/trail-running)

## Questions/problems?

Please raise an issue at https://github.com/mrsilver76/retrobat-runner/issues.

## Version history

### 1.0 (xxth xxxxx 2024)
- Initial release.


