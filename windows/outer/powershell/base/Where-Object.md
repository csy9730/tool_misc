# Windows中查找命令的路径 (类似Linux中的which命令)


1. `where` is a direct equivalent:

   ```
   C:\Users\Joey>where cmd
   
   
   
   C:\Windows\System32\cmd.exe
   ```

   Note that in PowerShell `where` itself is an alias for `Where-Object`, thus you need to use`where.exe` in PowerShell.

2. In `cmd` you can also use `for`:

   ```
   C:\Users\Joey>for %x in (powershell.exe) do @echo %~$PATH:x
   
   
   
   C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
   ```

3. In PowerShell you have `Get-Command` and its alias `gcm` which does the same if you pass an argument (but also works for aliases, cmdlets and functions in PowerShell):

   ```
   PS C:\Users\Joey> Get-Command where
   
   
   CommandType     Name          Definition
   
   
   
   -----------     ----          ----------
   
   
   
   Alias           where         Where-Object
   
   
   
   Application     where.exe     C:\Windows\system32\where.exe
   ```

   The first returned command is the one that would be executed.






