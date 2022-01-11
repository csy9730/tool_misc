# ConEmu

ConEmu-Maximus5 aims to be handy, comprehensive, fast and reliable terminal window where you may host any [console application](https://conemu.github.io/en/ConsoleApplication.html) developed either for [WinAPI](https://conemu.github.io/en/WinApi.html) (cmd, powershell, far) or [Unix PTY](https://conemu.github.io/en/CygwinMsysConnector.html) (cygwin, msys, wsl bash).

As Windows console window enhancement (local terminal emulator), ConEmu presents multiple consoles and [simple GUI applications](https://conemu.github.io/en/ChildGui.html) (like PuTTY for example) as one customizable tabbed [GUI](https://en.wikipedia.org/wiki/Graphical_user_interface) window with various features.

Moreover, due to deep integration, ConEmu is the best companion for [Far Manager](http://www.farmanager.com/download.php?l=en) ([FAR in Wikipedia](http://en.wikipedia.org/wiki/FAR_Manager)), my favorite [shell](https://conemu.github.io/en/TerminalVsShell.html) replacement.

ConEmu is an active project, open to [suggestions](https://conemu.github.io/en/Issues.html).



[![Download](https://conemu.github.io/img/Downloads.png)](https://www.fosshub.com/ConEmu.html)    [![Donate](https://conemu.github.io/img/Donate.png)](https://conemu.github.io/donate.html)



Take a look at [screencasts](https://conemu.github.io/en/Screencasts.html) about ConEmu.

![ConEmu screenshot](https://conemu.github.io/img/ConEmu-Maximus5.png)

## Disclaimer 

ConEmu is not a shell, so it does not provide "shell features" like remote access, tab-completion, command history and others. ConEmu is an advanced console window where you can run any shell of your choice. However, some of these features have been placed in the [RoadMap](https://conemu.github.io/en/RoadMap.html). You may also try [Clink](https://conemu.github.io/en/ConEmuClink.html) for bash-style completion in cmd.exe and [PSReadLine](http://github.com/lzybkr/PSReadLine) or [PowerTab](http://powertab.codeplex.com/) in powershell.exe.

Or even choose bash or any other unix-like shell from [cygwin](https://www.cygwin.com/), [git-for-windows](https://gitforwindows.org/), [msys2](https://sourceforge.net/projects/msys2/), [mingw](http://www.mingw.org/) and others.

## Documentation and links 



- [Table of contents](https://conemu.github.io/en/TableOfContents.html)
- [What's new](https://conemu.github.io/en/Whats_New.html)
- [FAQ](https://conemu.github.io/en/ConEmuFAQ.html)
- [Screenshots](https://conemu.github.io/en/Screenshots.html)
- [Video](https://conemu.github.io/en/Screencasts.html)
- [Reviews](https://conemu.github.io/en/Reviews.html)



## Description 

ConEmu starts a console program in a [hidden console window](https://conemu.github.io/en/RealConsole.html), and provides an alternative customizable GUI window with various features:



- smooth and friendly window resizing;
- tabs for editors, viewers, panels and consoles;
- run simple [GUI apps](https://conemu.github.io/en/ChildGui.html) like PuTTY in tabs;
- Windows 7 [Jump Lists](https://conemu.github.io/en/Windows7Taskbar.html#Customizable_Jump_list) and [Progress](https://conemu.github.io/en/Progress.html) on Taskbar buttons;
- easily run old [DOS applications](https://conemu.github.io/en/DosBox.html) (games) in Windows 7 or 64-bit OS;
- thumbnails and tiles in Far Manager;
- normal, maximized and full screen graphical window modes;
- window font anti-aliasing: standard, ClearType, disabled;
- window fonts: family, height, width, bold, italic, etc.;
- Chinese versions of Windows supported;
- using [normal/bold/italic](http://github.com/Maximus5/conemu-old-issues/issues/153) fonts for different parts of the console simultaneously;
- using 24-bit colors in Far Manager 3.x;
- [ANSI X3.64 and Xterm 256 colors](https://conemu.github.io/en/AnsiEscapeCodes.html);
- cursor: standard console (horizontal) or GUI (vertical);
- optional per-application settings (e.g. palette);
- vertical console buffer scrolling using the keyboard (BufferHeight mode);
- show full output (1K+ lines) of last command in Far Manager's editor/viewer;
- customizable Far Manager right click behaviour (long click opens context menu);
- drag and drop (explorer style) of files and folders in Far Manager;
- limited support of BDF fonts;
- user friendly text and block selection;
- transparency and desktop mode;
- customizable starting tabs;
- configurable and clickable status bar;
- and more, and more... take a look at [Documentation](https://conemu.github.io/en/TableOfContents.html), [Settings pages](https://conemu.github.io/en/Settings.html) and [What's New](https://conemu.github.io/en/Whats_New.html).



All settings are read from the registry or [ConEmu.xml](https://conemu.github.io/en/Settings.html#ConEmu_.xml) file (multiple named configurations are supported), after which the command line parameters are applied. Parameters /Config and /BufferHeight can only be specified on the command line. Most settings are configured using the Settings dialog, not from the command line.

## Requirements 

- Windows XP or later for 32-bit.
- Windows Vista or later for 64-bit.

## Installation 

In general, ConEmu installation is easy. Just unpack or install to any folder and run `ConEmu.exe`.

For more information about installation options refer to [Installation](https://conemu.github.io/en/Installation.html) page.