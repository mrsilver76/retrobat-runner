# RetroBat-Runner
*Automatically launch RetroBat when a specific button combination is pressed on any connected controller*

This simple script runs in the system tray and automatically launches RetroBat when a specific button combination is pressed. This is useful for people who don't want to run RetroBat perminantly on a computer and want an easy way to start it when they are sitting on the sofa and/or don't have easy access to a keyboard and mouse.

The script is heavily documented and can be easily modified to suit your preferences. That said, the default settings should be more than enough for most people and comes pre-compiled and working out of the box.

## Download

1. Get the latest version from https://github.com/mrsilver76/retrobat-runner/releases.
2. Decompress the file by double-clicking on the zip file.
3. Launch the program by double-clicking on the exe file.

## Running RetroBat Runner

* Once RetroBat Runner is launched, it will appear in your System Tray with the RetroBat icon.
* The default launch combination is **SELECT** followed by **START**. It does not matter which controller you use.
* You must press the second button within 1 second of pressing the first. If you do not, then you will need to start the combination from the beginning again.
* If you press the combination correctly, your controller will vibrate (if your controller supports this) and RetroBat will start.
* Pressing the combination whilst you are running RetroBat will do nothing.

## Configuration instructions

To configure the script, open it up in your preferred text editor.

For Windows, I recommend [Notepad++](https://notepad-plus-plus.org/) but Notepad will do. For Linux, I recommend [nano](https://www.nano-editor.org/) which usually comes preinstalled with most distributions.

You will also need AutoHotkey v2 installed to run the script and compile it into an executable.

There are a couple of things you can easily configure:

### buttonCombo

This is the combination of buttons you need to press in order to launch RetroBat. Each button has a number associated with it and a constant which is easier to read and understand (for example, `0x002` = `DPAD_BUTTON_DOWN`). You can find these constants in `XInput.ahk`.

### buttonTimer

This is the maximum number of milliseconds between each button press. If you take longer than that, then the button combination needs to be started from the beginning.

### rumbleConfirm

If you want the controller to rumble when you complete the combo, then set this to `1`. You will need a controller that supports rumble.

It's worth noting that only the controller that executes the last button press of the combo will rumble.

## Installation instructions

The easiest approach is to store the executable in the 


