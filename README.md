# RetroBat Runner

This program runs in the system tray and automatically launches [RetroBat](https://www.retrobat.org/) when a specific button combination is pressed on any connected controller. This is useful for people who don't want to run RetroBat permanently and want an easy way to start it without using  keyboard or mouse.

* 🎮 Supports both XInput and DirectInput controllers.
* 🕹️ Supports [8bitdo controllers](https://www.8bitdo.com/) using the "Switch" input mode.
* 🚀 Menu option to automatically start with Windows.
* 📳 All controllers vibrate (where supported) when the combination is correctly pressed.
* 📢 Computer will play a sound when the combination is correctly pressed.
* 💿 Works wherever RetroBat is installed - even if it's on an external drive.
* 🖥️ Low CPU and memory usage.
* 🖊️ Source code is fully documented.
* 🪵 Debug logging to help diagnose problems.

## Download

* Get the latest version from [here](https://github.com/mrsilver76/retrobat-runner/releases).
* Most people will want the file called `RetroBat_Runner.exe`.

## Running RetroBat Runner

* Launch RetroBat Runner by double-clicking on it. The location of your installation of RetroBat will be automatically detected.
* RetroBat Runner will appear in your System Tray with the RetroBat icon.
* The launch combination is **SELECT/BACK** followed by **START** on any connected controller.
* You must press the **START** button within 1 second of pressing the **SELECT/BACK** button.
* If you press the combination correctly, all controllers will vibrate (if the controller supports this), a sound will be played and RetroBat will start.
* If you do not press the combination correctly or you are too slow, then you will need to start the combination from the beginning again.
* Pressing the combination whilst you are running RetroBat will do nothing.

> [!TIP]
> You must use the same controller to complete the combination. You cannot press **SELECT/BACK** on one controller and **START** on a different controller.

## Installation instructions

The easiest approach is to store the executable somewhere on your computer (for example, "My Documents"), run the executable, right click on the icon in your system tray and click on "Start with Windows" so that it is checked.

The next time the current user logs into Windows (which will normally be when the computer powers on), RetroBat Runner will automatically start and sit in the System Tray.

To stop it starting with Windows, repeat the process again so that "Start with Windows" is unchecked.

To uninstall, delete the executable. There are no other files.

> [!TIP]
> If RetroBat Runner is not working for you then you can run the program with the command line argument `/debug` to generate a log file. If you raise any issues then you may be asked to provide this file.

## Source code

If you want to view or edit the source code (`RetroBat_Runner.ahk`) then you can use any text editor. I recommend [Notepad++](https://notepad-plus-plus.org/) or [Visual Studio Code](https://code.visualstudio.com/), but the built-in Notepad will do. The code needs the XInput library (`XInput.ahk`) to run, so don't delete this file.

To run or compile the code, you will need [AutoHotkey v2](https://www.autohotkey.com/) installed.

The code is reasonably well documented and there are two variables that are easily configurable - how quickly you have to tap the buttons (`buttonTimer`) and whether the controllers rumble and the computer plays a sound when the combination is executed correctly (`confirmRumble`).

If you want to work on the code and not keep running RetroBat all the time then call the program with the `/test` command line argument and Notepad will be launched instead.

## Attribution

The Trail running icon was created by [Freepik - Flaticon](https://www.flaticon.com/free-icons/trail-running).

RetroBat is copyright &copy; Adrien Chalard and the RetroBat Team. For more details visit the [website](https://www.retrobat.org/) or the [GitHub repository](https://github.com/RetroBat-Official). 

## Questions/problems?

Please raise an issue at https://github.com/mrsilver76/retrobat-runner/issues.

## Future improvements

Possible future improvements can be found at https://github.com/mrsilver76/retrobat-runner/labels/enhancement. Unless there is significant interest, it's doubtful I'll implement many of them as the program in its current form suits me just fine.

## Version history

### 1.2.0 (xx)
- Added support for DirectInput and Bluetooth controllers.
- Added support for Switch input mode with 8bitdo controllers.
- Fixed bug where sometimes EmulationStation isn't correctly in focus after being launched.
- After EmulationStation is running, the mouse cursor is now moved away to the top-right and is no longer visible.
- Improved responsiveness to account for any Bluetooth controllers with sluggish input.
- To support DirectInput controllers, the ability to define custom combination buttons and the ability to complete a combination on different controllers was removed.
- Significantly improved the quality of the code and applied consistent code formatting.
- Reduced the CPU usage when EmulationStation is running.
- Added the ability to enable debugging mode from the command line using `/debug`.
- Added the ability to enable test mode from the command line using `/test` (this opens Notepad instead of RetroBat).

### 1.1.0 (22nd December 2024)
 - Added option to automatically start with Windows from the system tray.
 - Cleaned up the "About" tray menu item.
 - Tidied up the documentation to focus more on people who just want to use the executable.

### 1.0.1 (1st December 2024)
- Implemented workaround to resolve an issue where EmulationStation isn't the active window after starting up.
- Implemented workaround to resolve a strange issue where the controllers may continue to rumble longer than 1/4 of a second.
- When rumbling is enabled, a sound will also be played.
- README tidied up and now includes specific warning about lack of support for DirectInput controllers.

### 1.0 (2nd November 2024)
- Initial release.
