
# PsTools

- 07/04/2016
- 2 minutes to read
- [![img](https://github.com/markruss.png?size=32) ![img](https://github.com/VSC-Service-Account.png?size=32) ![img](https://github.com/docouto.png?size=32)](https://github.com/MicrosoftDocs/sysinternals/blob/live/sysinternals/downloads/pstools.md)

[pstools](https://docs.microsoft.com/en-us/sysinternals/downloads/pstools)

**By Mark Russinovich**

Published: July 4, 2016

[![Download](https://docs.microsoft.com/en-us/media/landing/sysinternals/download_sm.png)](https://download.sysinternals.com/files/PSTools.zip) [**Download PsTools Suite**](https://download.sysinternals.com/files/PSTools.zip) **(2.7 MB)**

## Introduction

The Windows NT and Windows 2000 Resource Kits come with a number of command-line tools that help you administer your Windows NT/2K systems. Over time, I've grown a collection of similar tools, including some not included in the Resource Kits. What sets these tools apart is that they all allow you to manage remote systems as well as the local one. The first tool in the suite was PsList, a tool that lets you view detailed information about processes, and the suite is continually growing. The "Ps" prefix in PsList relates to the fact that the standard UNIX process listing command-line tool is named "ps", so I've adopted this prefix for all the tools in order to tie them together into a suite of tools named *PsTools*.

> Some anti-virus scanners report that one or more of the tools are infected with a "remote admin" virus. None of the PsTools contain viruses, but they have been used by viruses, which is why they trigger virus notifications.*

The tools included in the *PsTools* suite, which are downloadable as a package, are:

- [*PsExec*](https://docs.microsoft.com/en-us/sysinternals/downloads/psexec) - execute processes remotely
- [*PsFile*](https://docs.microsoft.com/en-us/sysinternals/downloads/psfile) - shows files opened remotely
- [*PsGetSid*](https://docs.microsoft.com/en-us/sysinternals/downloads/psgetsid) - display the SID of a computer or a user
- [*PsInfo*](https://docs.microsoft.com/en-us/sysinternals/downloads/psinfo) - list information about a system
- [*PsPing*](https://docs.microsoft.com/en-us/sysinternals/downloads/psping) - measure network performance
- [*PsKill*](https://docs.microsoft.com/en-us/sysinternals/downloads/pskill) - kill processes by name or process ID
- [*PsList*](https://docs.microsoft.com/en-us/sysinternals/downloads/pslist) - list detailed information about processes
- [*PsLoggedOn*](https://docs.microsoft.com/en-us/sysinternals/downloads/psloggedon) - see who's logged on locally and via resource sharing (full source is included)
- [*PsLogList*](https://docs.microsoft.com/en-us/sysinternals/downloads/psloglist) - dump event log records
- [*PsPasswd*](https://docs.microsoft.com/en-us/sysinternals/downloads/pspasswd) - changes account passwords
- [*PsService*](https://docs.microsoft.com/en-us/sysinternals/downloads/psservice) - view and control services
- [*PsShutdown*](https://docs.microsoft.com/en-us/sysinternals/downloads/psshutdown) - shuts down and optionally reboots a computer
- [*PsSuspend*](https://docs.microsoft.com/en-us/sysinternals/downloads/pssuspend) - suspends processes
- *PsUptime* - shows you how long a system has been running since its last reboot (PsUptime's functionality has been incorporated into [*PsInfo*](https://docs.microsoft.com/en-us/sysinternals/downloads/psinfo)

The *PsTools* download package includes an HTML help file with complete usage information for all the tools.

[![Download](https://docs.microsoft.com/en-us/media/landing/sysinternals/download_sm.png)](https://download.sysinternals.com/files/PSTools.zip) [**Download PsTools Suite**](https://download.sysinternals.com/files/PSTools.zip) **(2.7 MB)**

**Runs on:**

- Client: Windows Vista and higher
- Server: Windows Server 2008 and higher
- Nano Server: 2016 and higher

### Installation

None of the tools requires any special installation. You don't even need to install any client software on the remote computers at which you target them. Run them by typing their name and any command-line options you want. To show complete usage information, specify the "-? " command-line option. If you have questions or problems, please visit the [Sysinternals PsTools Forum](https://forum.sysinternals.com/forum_topics.asp?FID=8).

### Related Links

[Introduction to the PsTools](https://technet.microsoft.com/library/2007.03.desktopfiles.aspx): Wes Miller gives a high-level overview of the Sysinternals PsTools in the March column of his TechNet Magazine column.