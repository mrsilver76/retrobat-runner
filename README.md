# RetroBat Runner

This program runs in the system tray and automatically launches [RetroBat](https://www.retrobat.org/) when a specific button combination is pressed on any connected controller. This is useful for people who don't want to run RetroBat permanently and want an easy way to start it without using  keyboard or mouse.

* 🎮 Support for all XInput controllers.
* 🚀 Menu option to automatically start with Windows.
* 📳 All controllers vibrate (where supported) when the combination is correctly pressed.
* 📢 Computer will play a sound when the combination is correctly pressed.
* 💿 Works wherever RetroBat is installed.
* 🖥️ Low CPU and memory usage.
* 🖊️ Source code is fully documented.

Controllers using DirectInput mode (such as the Sony DualShock) require [DS4Windows](https://ds4-windows.com/) for RetroBat Runner to work.

## Download

* Get the latest version from [here](https://github.com/mrsilver76/retrobat-runner/releases).
* Most people will want the file called `RetroBat_Runner.exe`.

## Running RetroBat Runner

* Once RetroBat Runner is launched, it will appear in your System Tray with the RetroBat icon.
* The launch combination is **SELECT/BACK** followed by **START**. It does not matter which controller you use and you can even use different controllers to complete the combination.
* You must press the **START** button within 1 second of pressing the **SELECT/BACK** button. If you do not, then you will need to start the combination from the beginning again.
* If you press the combination correctly, all controllers will vibrate (if the controller supports this), a sound will be played and RetroBat will start.
* Pressing the combination whilst you are running RetroBat will do nothing.

## Installation instructions

The easiest approach is to store the executable somewhere on your computer (for example, "My Documents"), run the executable, right click on the icon in your system tray and click on "Start with Windows" so that it is checked.

The next time the current user logs into Windows (which will normally be when the computer powers on), RetroBat Runner will automatically start and sit in the System Tray.

To stop it starting with Windows, repeat the process again so that "Start with Windows" is unchecked.

## Configuration instructions

If you want to configure the program then you need to edit the source code in your preferred text editor. I recommend [Notepad++](https://notepad-plus-plus.org/) but Notepad will do. You will also need [AutoHotkey v2](https://www.autohotkey.com/) installed.

The code is fully documented and you can easily configure the button combination (`comboButton`), how quickly you have to tap the buttons (`buttonTimer`) and whether the controllers rumble and the computer plays a sound when the combination is executed correctly (`confirmRumble`).

## Attribution

The Trail running icon was created by [Freepik - Flaticon](https://www.flaticon.com/free-icons/trail-running)

RetroBat is &copy; Adrien Chalard and the RetroBat Team. For more details visit the [website](https://www.retrobat.org/) or the [GitHub repository](https://github.com/RetroBat-Official). 

## Questions/problems?

Please raise an issue at https://github.com/mrsilver76/retrobat-runner/issues.

## Future improvements

Possible future improvements can be found at https://github.com/mrsilver76/retrobat-runner/labels/enhancement. Unless there is significant interest, it's doubtful I'll implement many of them as the program in its current form suits me just fine.

## Version history

### 1.1.0 (22nd December 2024)
 - Added option to automatically start with Windows from the system tray.
 - Cleaned up the "About" tray menu item
 - Tidied up the documentation to focus more on people who just want to use the executable.

### 1.0.1 (1st December 2024)
- Implemented workaround to resolve an issue where EmulationStation isn't the active window after starting up
- Implemented workaround to resolve a strange issue where the controllers may continue to rumble longer than 1/4 of a second.
- When rumbling is enabled, a sound will also be played.
- README tidied up and now includes specific warning about lack of support for DirectInput controllers.

### 1.0 (2nd November 2024)
- Initial release.
