# chocolatey

## install
[install](https://chocolatey.org/install)


1. First, ensure that you are using an **administrative shell** - you can also install as a non-admin, check out [Non-Administrative Installation](https://chocolatey.org/docs/installation#non-administrative-install).

2. Install with powershell.exe

   **NOTE:** Please inspect <https://chocolatey.org/install.ps1> prior to running any of these scripts to ensure safety. We already know it's safe, but you should verify the security and contents of **any** script from the internet you are not familiar with. All of these scripts download a remote PowerShell script and execute it on your machine. We take security very seriously. [Learn more about our security protocols](https://chocolatey.org/security).

   With PowerShell, you must ensure [Get-ExecutionPolicy](https://go.microsoft.com/fwlink/?LinkID=135170) is not Restricted. We suggest using `Bypass` to bypass the policy to get things installed or `AllSigned` for quite a bit more security.

   - Run `Get-ExecutionPolicy`. If it returns `Restricted`, then run `Set-ExecutionPolicy AllSigned` or `Set-ExecutionPolicy Bypass -Scope Process`.

   Now run the following command:

   *Copy Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) to Clipboard*

   ```
   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
   ```

3. Paste the copied text into your shell and press Enter.

4. Wait a few seconds for the command to complete.

5. If you don't see any errors, you are ready to use Chocolatey! Type `choco` or `choco -?` now, or see [Getting Started](https://chocolatey.org/docs/getting-started) for usage instructions.


[gitee的安装地址](https://gitee.com/mirrors/chocolatey/)



## manager

[commands](https://chocolatey.org/docs/commands-sources)
### list

``` bash
choco list -lo # 查看本地choco安装的软件
choco list --local
choco list --local-only # == -lo
choco list -li  # 查看第三方安装软件
choco list -lai
choco list --page=0 --page-size=25
choco search git
choco search git --source="'https://somewhere/out/there'"
choco search bob -s "'https://somewhere/protected'" -u user -p pass
```

### info
```
choco info chocolatey
choco info googlechrome
choco info powershell
```

### install
```
choco install sysinternals
choco install notepadplusplus googlechrome atom 7zip
choco install notepadplusplus --force --force-dependencies
choco install notepadplusplus googlechrome atom 7zip -dvfy
choco install git -y --params="'/GitAndUnixToolsOnPath /NoAutoCrlf'"
choco install git -y --params="'/GitAndUnixToolsOnPath /NoAutoCrlf'" --install-args="'/DIR=C:\git'"
# Params are package parameters, passed to the package
# Install args are installer arguments, appended to the silentArgs
#  in the package for the installer itself
choco install nodejs.install --version 0.10.35
choco install git -s "'https://somewhere/out/there'"
choco install git -s "'https://somewhere/protected'" -u user -p pass

choco install --yes Bandizip
```
### upgrade
```
choco upgrade chocolatey
choco upgrade notepadplusplus googlechrome atom 7zip
choco upgrade notepadplusplus googlechrome atom 7zip -dvfy
choco upgrade git -y --params="'/GitAndUnixToolsOnPath /NoAutoCrlf'"
choco upgrade git -y --params="'/GitAndUnixToolsOnPath /NoAutoCrlf'" --install-args="'/DIR=C:\git'"
# Params are package parameters, passed to the package
# Install args are installer arguments, appended to the silentArgs
#  in the package for the installer itself
choco upgrade nodejs.install --version 0.10.35
choco upgrade git -s "'https://somewhere/out/there'"
choco upgrade git -s "'https://somewhere/protected'" -u user -p pass
choco upgrade all
choco upgrade all --except="'skype,conemu'"
```
### uninstall

```
choco uninstall git
choco uninstall notepadplusplus googlechrome atom 7zip
choco uninstall notepadplusplus googlechrome atom 7zip -dv
choco uninstall ruby --version 1.8.7.37402
choco uninstall nodejs.install --all-versions
```

### download
```
choco config
choco config list
choco config get cacheLocation
choco config get --name cacheLocation
choco config set cacheLocation c:\temp\choco
choco config set --name cacheLocation --value c:\temp\choco
choco config unset proxy
choco config unset --name proxy
```