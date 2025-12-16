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

Get the latest version from https://github.com/mrsilver76/groupmachine/releases.

There is no installer. Just download the executable and run it either by double-clicking or from the command line. 

|Platform|Download|
|:--------|:-----------|
|Microsoft Windows 10 & 11|`RetroBat_Runner.exe` ✅ **Most users want this**|
|Other/Developers|Source code (zip / tar.gz)|

>[!WARNING]
>RetroBat v7.3 to v7.5 renamed the main executable to `RetroBat-new.exe`. If you wish to using any of those versions,
>you must download and use the older RetroBat Runner [v1.3.2](https://github.com/mrsilver76/retrobat-runner/releases/tag/1.3.2).

## 🚀 Usage

1. Launch RetroBat Runner by double-clicking `RetroBat_Runner.exe`.
   - RetroBat’s installation location will be detected automatically.
3. RetroBat Runner will appear in the system tray with the RetroBat icon.
4. Launch RetroBat with your controller:
   - Press **SELECT/BACK** and then **START** within 2 seconds on the same controller.
   - Controllers will vibrate (if supported) and a sound will play when the combination is correct.
   - RetroBat will start automatically.
   - If the combination is incorrect or too slow, you must start over.
   - Triggering the combination while RetroBat is running does nothing.
5. To configure options, right-click the system tray icon to access:
   - **Start with Windows** - Automatically start RetroBat Runner at login.
   - **RetroBat Runner events** - Opens a submenu for you to configure triggers on events.
     - **Command before launch** - Launch another program before RetroBat starts. ⚠️ See [this section](#executing-commands-before-and-after-launch-or-exit) below
     - **Command after exit** - Launch another program after RetroBat closes. ⚠️ See [this section](#executing-commands-before-and-after-launch-or-exit) below
   - **EmulationStation events** - Open the EmulationStation events folder. ⚠️ See [this section](#executing-commands-before-and-after-launch-or-exit) below
   - **Visit RetroBat Runner website** - Open the GitHub page in your browser.
   - **About RetroBat Runner** - View version info and credits.

> [!TIP]
> The same controller must be used to press both buttons. You cannot press **SELECT/BACK** on one controller and **START** on a different controller.

### Executing commands before and after launch or exit

EmulationStation includes its own event system. You can place programs, shortcuts or scripts in specific folders inside your RetroBat installation and EmulationStation will run whatever is inside these folders whenever the matching event occurs. These events run every time EmulationStation starts, stops or changes state. It does not matter whether you opened RetroBat directly or launched it through RetroBat Runner.

Use RetroBat Runner’s "command before launch" and "command after exit" when you want a script to run at the moment RetroBat is launched or closed **but only when it was started through the controller button combination.** These commands do not run if you open RetroBat in any other way.

Assuming you install to the default location, then the event folders are inside `C:\RetroBat\emulationstation\.emulationstation\scripts`:

| Subfolder name     | When it runs                                |
| :----------------- | :------------------------------------------ |
| `game-end`         | When a game ends                            |
| `game-start`       | When a game starts                          |
| `quit`             | When EmulationStation quits normally        |
| `reboot`           | When EmulationStation reboots the system    |
| `shutdown`         | When EmulationStation shuts down the system |
| `sleep`            | When the system enters sleep                |
| `start`            | When EmulationStation starts                |
| `update-gamelists` | When gamelists are updated                  |
| `wake`             | When the system wakes from sleep            |

>[!NOTE]
>- Scripts here run independently of RetroBat Runner.
>- RetroBat Runner settings run only when RetroBat is launched via the controller combination.
>- Avoid putting the same script in both places unless you want it to fire twice.

## ⚙️ Installation

- Place `RetroBat_Runner.exe` anywhere on your PC (e.g., "Documents").
  - Advanced users may wish to use `%LOCALAPPDATA%\Programs\RetroBat Runner`
- Run it once, then right-click the system tray icon and select "Start with Windows" to enable auto-start.
- To disable, uncheck the same menu item.
- To uninstall, simply delete the executable; no other files are created.
  - Although not essential, you might want to disable "Start with Windows" before deleting.

## 💻 Source code / developers

- RetroBat Runner was written using [AutoHotKey v2](https://www.autohotkey.com/). Do not use v1 as it is deprecated.
- You can view the source code (`RetroBat_Runner.ahk`) in any text editor - such as Notepad or [Visual Studio Code](https://code.visualstudio.com/).
- XInput controllers are handled by `XInput.ahk`. Do not delete this file otherwise RetroBat Runner will not run.

### Command line options

There are two command line options that are useful for developers:

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

### 1.5.0 (16 December 2025)
- "Command after exit" no longer runs when using EmulationStation's "shutdown" or "restart" options. Windows does not allow enough time for commands to run reliably; use EmulationStation’s own built-in event system for scripts triggered on shutdown or restart.
- Added new menu item "Open EmulationStation events" which opens Windows Explorer with the location to place scripts/shortcuts/programs for triggering.
- Added new menu item "Open RetroBat Runner events" and moved "Command before launch" and "Command after exit" into a sub-menu.
- Updated the copy on the pop-up for RetroBat Runner events to make clear that these will only run if EmulationStation was launched by RetroBat Runner.
- Updated documentation to explain how to use EmulationStation's event system.
- Fixed a bug where video intros over 5 second long would incorrectly trigger a pop-up claiming that EmulationStation did not appear to be launching.
- Fixed a bug where buffered controller presses could mean the video intro is inadvertently skipped before it starts.
- Applied a workaround to correct XInput controllers occasionally being treated as DirectInput, which would stop vibration from working.
- Tray menu cleaned up and reordered.
- Some code tidied up (mainly function naming and global declarations)

### 1.4.0 (20th November 2025)
- Removed automatic preference for `RetroBat-new.exe` because RetroBat v7.5.1 no longer uses this executable and doesn’t delete it during upgrades, so RetroBat Runner can’t rely on it being the correct one.
- If "shutdown" or "restart" is used within EmulationStation, RetroBat Runner will attempt to execute any configured "Command after exit" prior to closing.
- Improved ReadMe documentation.

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
