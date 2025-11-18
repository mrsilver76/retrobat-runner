# RetroBat Runner

_A program that runs in the system tray and automatically launches [RetroBat](https://www.retrobat.org/) when a specific button combination is pressed on any connected controller. This is useful for people who don't want to run RetroBat permanently on a computer and want an easy way to start it without using the keyboard or mouse._

## 🧰 Features

* 🎮 Supports both XInput and DirectInput controllers.
* 🕹️ Supports [8bitdo controllers](https://www.8bitdo.com/) using the "Switch" input mode.
* 📳 All controllers vibrate (where supported) when the combination is correctly pressed.
* 📢 Computer will play a sound when the combination is correctly pressed.
* 🔄 Can automatically launch another program before RetroBat starts.
* 🚀 Menu option to automatically start with Windows.
* 🔚 Can automatically launch another program after EmulationStation closes.
* 💿 Works wherever RetroBat is installed - even if it's on an external drive.
* 🖥️ Low CPU and memory usage.
* 🪵 Debug logging to help diagnose problems.
* 🖊️ Source code is fully documented.

## 📦 Download

* Get the latest version from [here](https://github.com/mrsilver76/retrobat-runner/releases).
* Most people will want the file called `RetroBat_Runner.exe`.

>[!WARNING]
>RetroBat v7.3 to v7.5 renamed the main executable to `RetroBat-new.exe`. If you wish to using any of those versions,
>you must download and use the older RetroBat Runner [v1.3.2](https://github.com/mrsilver76/retrobat-runner/releases/tag/1.3.2).

## 🚀 Quick start guide

* Launch RetroBat Runner by double-clicking on it. The location of your installation of RetroBat will be automatically detected.
* RetroBat Runner will appear in your System Tray with the RetroBat icon.
* The launch combination is **SELECT/BACK** followed by **START** on any connected controller.
* You must press the **START** button within 2 seconds of pressing the **SELECT/BACK** button.
* If you press the combination correctly, all controllers will vibrate (if the controller supports this), a sound will be played and RetroBat will start.
* If you do not press the combination correctly or you are too slow, then you will need to start the combination from the beginning again.
* Pressing the combination whilst you are running RetroBat will do nothing.
* To change various options, right-click on the RetroBat icon in the system tray.

> [!TIP]
> You must use the same controller to complete the combination. You cannot press **SELECT/BACK** on one controller and **START** on a different controller.

## Installation instructions

The easiest approach is to store the executable somewhere on your computer (for example, "My Documents"), run the executable, right click on the icon in your system tray and click on "Start with Windows" so that it is checked.

The next time the current user logs into Windows (which will normally be when the computer powers on), RetroBat Runner will automatically start and sit in the System Tray.

To stop it starting with Windows, repeat the process again so that "Start with Windows" is unchecked.

To uninstall, delete the executable. There are no other files.

## 💻 Source code / developers

If you want to view or edit the source code (`RetroBat_Runner.ahk`) then you can use any text editor. I recommend [Notepad++](https://notepad-plus-plus.org/) or [Visual Studio Code](https://code.visualstudio.com/), but the built-in Notepad will do. The code needs the XInput library (`XInput.ahk`) to run, so don't delete this file. To run or compile the code, you will need [AutoHotkey v2](https://www.autohotkey.com/) installed.

There are two command line options available:

- **`/debug`**   
  Writes out a debug file to the same location and with the same name as the executable followed by `.log` (e.g. `RetroBat_Runner.exe.log`). This log contains additional information that can be useful when trying to resolve issues. Any existing log file will be overwritten.

- **`/test`**   
  Causes RetroBat Runner to launch `notepad.exe` instead of RetroBat. This is useful during development to speed up testing.   

## 🛟 Questions/problems?

Please raise an issue at https://github.com/mrsilver76/retrobat-runner/issues.

## 💡 Future development: open but unplanned

RetroBat Runner currently meets the needs it was designed for, and no major new features are planned at this time. However, the project remains open to community suggestions and improvements. If you have ideas or see ways to enhance the tool, please feel free to submit a [feature request](https://github.com/mrsilver76/retrobat-runner/issues).

## 📝 Attribution

- The Trail running icon was created by [Freepik - Flaticon](https://www.flaticon.com/free-icons/trail-running).
- RetroBat is copyright &copy; Adrien Chalard and the RetroBat Team. For more details visit the [website](https://www.retrobat.org/) or the [GitHub repository](https://github.com/RetroBat-Official). 

## 🕰️ Version history

### 1.4.0 (xx November 2025)
- Removed automatic preference for `RetroBat-new.exe` because RetroBat v7.5.1 no longer uses this executable and doesn’t delete it during upgrades, so RetroBat Runner can’t rely on it being the correct one.
- If "shutdown" or "restart" is used within EmulationStation, RetroBat Runner will attempt to execute any configured exit command prior to closing.

### 1.3.2 (22nd August 2025)
- Added support for RetroBat v7.3 by launching `RetroBat-new.exe` when the button combo is pressed. Older versions using `RetroBat.exe` are still supported.

### 1.3.1 (19th August 2025)
- Added a workaround for the unhelpful and random "invalid memory read/write" error.
- Changed the launch order so that external programs now run before windows are minimised, preventing them from covering RetroBat when it starts.
- Added a menu option to visit the RetroBat Runner website on Github.
 
### 1.3.0 (21st June 2025)
- Display a first run message and tooltip to guide new users.
- Enable configuring of a program to run before RetroBat is started.
- Enable configuring of a program to run after EmulationStation has been closed (thanks to tkropp17 for help in debugging)
- Added additional debug logging.
- Reduced CPU usage when idle.
- Updated README.

### 1.2.0 (1st May 2025)
- Added support for DirectInput and Bluetooth controllers.
- Added support for Switch input mode with 8bitdo controllers.
- Fixed bug where sometimes EmulationStation isn't correctly in focus after being launched.
- After EmulationStation is running, the mouse cursor is now moved away to the top-right and is no longer visible.
- To support DirectInput controllers, the ability to define custom combination buttons and the ability to complete a combination on different controllers was removed.
- Significantly improved the quality of the code and applied consistent code formatting.
- Reduced the CPU usage when EmulationStation is running.
- Increased button timeout from 1 second to 2 seconds to account for slow button presses and/or lag caused by Bluetooth.
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
