Import-Module WASP.dll
Select-Window -Class "Alternate Modal Top Most" | Select-ChildWindow | Select-Control | Send-Click -ControlButton

Send-Keys -Keys "userName"