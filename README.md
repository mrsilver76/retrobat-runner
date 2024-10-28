# RetroBat Runner
*Automatically launch RetroBat when a specific button combination is pressed on any connected controller*

This simple script runs in the system tray and automatically launches RetroBat when a specific button combination is pressed. This is useful for people who don't want to run RetroBat perminantly on a computer and want an easy way to start it when they are sitting on the sofa and/or don't have easy access to a keyboard and mouse.

The script is heavily documented and can be easily modified to suit your preferences. That said, the default settings should be more than enough for most people and comes pre-compiled and working out of the box.

## Download

1. Get the latest version from https://github.com/mrsilver76/retrobat-runner/releases.
2. Decompress the file by double-clicking on the zip file.
3. Launch the program by double-clicking on the exe file.

## Running RetroBat Runner

* Once RetroBat Runner is launched, it will appear in your System Tray with the RetroBat icon.
* The default launch combination is **SELECT** followed by **START**. It does not matter which controller you use and you can even use different controllers to complete the combination.
* You must press the **START** button within 1 second of pressing the **SELECT** button. If you do not, then you will need to start the combination from the beginning again.
* If you press the combination correctly, your controller will vibrate (if your controller supports this) and RetroBat will start.
* Pressing the combination whilst you are running RetroBat will do nothing.

## Configuration instructions

To configure the script, open it up in your preferred text editor. I recommend [Notepad++](https://notepad-plus-plus.org/) but Notepad will do. You will also need [AutoHotkey v2](https://www.autohotkey.com/) installed.

Make your changes (the code is documented to help you), save the file and then double-click on it to run. If you want to run it on a machine that doesn't have AutoHotkey installed then I recommend compiling it. 

There are a couple of things you can easily configure at the top of the code:

### buttonCombo

This is the combination of buttons you need to press in order to launch RetroBat. Each button has a number associated with it and a constant which is easier to read and understand (for example, `XINPUT_GAMEPAD_DPAD_DOWN` has the value `0x0002`). You can use either the number or the constant in this line of code. You can find the constants in `XInput.ahk` or at [this Microsoft page](https://learn.microsoft.com/en-us/windows/win32/api/xinput/ns-xinput-xinput_gamepad).

> :warning: Despite the name, `XINPUT_GAMEPAD_BACK` is used for the "select" button.

You can have as many button combinations as you like however, the more you have, the harder it will be for someone to execute. You shouldn't have the combination too simple, otherwise you run the risk of accidentally triggering it.

The default setting is **SELECT** followed by **START**.

### buttonTimer

This is the maximum number of milliseconds between each button press. If you take longer than that, then the button combination needs to be started from the beginning.

The longer the time, the easier it is for someone to execute the combination but the more likely that they will trigger it during general usage.

The default setting is 1000ms, which is 1 second.

### rumbleConfirm

If you want the controller to rumble when you complete the combo, then set this to `1`. You will need a controller that supports rumble. It's worth noting that only the controller that executes the last button press of the combo will rumble.

The default setting is `1` which means rumble is on.

## Installation instructions

The easiest approach is to store the executable in the start up folder in Windows. To locate this, right-click on the Windows icon, select "Run", type `shell:startup` and press Enter. Put the executable in this folder. Whenever your PC boots, this will run.

The executable uses very little CPU and memory.

## Questions/problems?

Please raise an issue at https://github.com/mrsilver76/retrobat-runner/issues.

## Version history

### 1.0 (xxth xxxxx 2024)
- Initial release.


