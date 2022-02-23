# DevCon

DevCon 是一个带有内置文档的命令行实用工具。如果您运行 devcon help 命令，将会出现以下命令列表和描述信息。devcon help 命令可提供关于任何命令的详细帮助。使用其中的某些命令，您可以指定远程目标计算机。如果您在 WOW64 上使用 32 位版的 DevCon，则以下命令有效。

DevCon 实用工具是一种命令行实用工具，可以替代设备管理器。使用 DevCon，您可以启用、禁用、重新启动、更新、删除和查询单个设备或一组设备。DevCon 还提供与驱动程序开发人员有关、但无法在设备管理器中看到的信息。
可以将 DevCon 用于 Microsoft Windows 2000、Windows XP 和 Windows Server 2003，但不能将其用于 Windows 95、Windows 98 或 Windows Millennium Edition。



**使用 DevCon：**

DevCon 是一个带有内置文档的命令行实用工具。如果您运行devcon help命令，将会出现以下命令列表和描述信息。devcon help命令可提供关于任何命令的详细帮助。使用其中的某些命令，您可以指定远程目标计算机。如果您在 WOW64 上使用 32 位版的 DevCon，则以下命令有效。设备控制台帮助：
```
devcon.exe [-r] [-m:\\<machine>] <command> [<arg>...]
-r 如果指定它，在命令完成后若需要则重新启动计算机。
<machine> 是目标计算机的名称。
<command> 是将要执行的命令（如下所示）。
<arg>... 是命令需要的一个或多个参数。
要获取关于某一特定命令的帮助，请键入：devcon.exe help <command>
classfilter     允许修改类别筛选程序。
classes       列出所有设备安装类别。
disable       禁用与指定的硬件或实例 ID 匹配的设备。
driverfiles     列出针对设备安装的驱动程序文件。
drivernodes     列出设备的所有驱动程序节点。
enable        启用与指定的硬件或实例 ID 匹配的设备。
find         查找与指定的硬件或实例 ID 匹配的设备。
findall       查找设备，包括那些未显示的设备。
help         显示此信息。
hwids        列出设备的硬件 ID。
install       手动安装设备。
listclass      列出某一安装类别的所有设备。
reboot        重新启动本地计算机。
remove        删除与特定的硬件或实例 ID 匹配的设备。
rescan        扫描以发现新的硬件。
resources      列出设备的硬件资源。
restart       重新启动与特定的硬件或实例 ID 匹配的设备。
stack        列出预期的设备驱动程序堆栈。
status        列出设备的运行状态。
update        手动更新设备。
UpdateNI       手动更新设备，无用户提示 
SetHwID       添加、删除和更改根枚举设备的硬件 ID 的顺序。 
```

## DevCon 命令示例
**DevCon 命令示例：**
```
devcon -m:\\test find pci
```

列出计算机test上的所有已知 PCI 设备。（通过使用-m，您可以指定一个目标计算机。您必须使用“进程间通信”(IPC) 访问此计算机。）
```
devcon -r install %WINDIR%\Inf\Netloop.inf *MSLOOP
```
安装一个新的 Microsoft 环回适配器实例。这将创建一个新的根枚举设备节点，使用此节点您可以安装“虚拟设备”，如环回适配器。如果需要重新启动计算机，此命令还将以安静模式重新启动计算机。
#### 列出所有已知的安装类别
```
devcon classes
```
列出所有已知的安装类别。输出结果包含短的未本地化的名称（例如，“USB”）和描述性名称（例如，“通用串行总线控制器”）。

```
devcon classfilter upper !filter1 !filter2
```
删除这两个指定的筛选程序。

```
devcon classfilter lower !badfilter +goodfilter
```
用“goodfilter”替换“badfilter”。

```
devcon driverfiles =ports
```
列出与ports安装类别中的每一个设备关联的文件。

```
devcon disable *MSLOOP
```
禁用硬件 ID 以“MSLOOP”结尾（包括“*MSLOOP”）的所有设备。

```
devcon drivernodes @ROOT\PCI_HAL\PNP0A03
```
列出设备“ROOT\PCI_HAL\PNP0A03”的所有兼容驱动程序。这可以用来确定为什么选择原配的设备信息 (.inf) 文件而不选第三方 .inf 文件。

```
devcon enable '*MSLOOP
```
启用硬件 ID 为“\*MSLOOP”的所有设备。单引号指示必须严格按字面解释硬件 ID（换句话说，星号 [“\*”] 真的是一个星号，而不是通配符）。

#### 列出所有设备实例
```
devcon find *
```
列出本地计算机上存在的所有设备的设备实例。
```
devcon find pci\*
```
列出本地计算机上所有已知的“外围组件互连”(PCI) 设备（如果一个设备的硬件 ID 以“PCI\”为前缀，此命令就认为该设备是 PCI 设备）。

```
devcon find =ports *pnp*
```
列出存在的作为ports安装类别的成员而且硬件 ID 中包含“PNP”的设备。

```
devcon find =ports @root\*
```
列出存在的作为ports安装类别的成员而且在枚举树的“root”分支中的设备（实例 ID 以“root\”为前缀）。请注意，有关实例 ID 的格式化方式，不应作任何编程假定。要确定根设备，可以检查设备状态位。此功能包括在 DevCon 中是为了帮助进行调试。

devcon findall =ports

列出ports类别的“不存在”的设备和存在的设备。这包括已经被删除的设备、从一个插槽移到另一个插槽的设备，以及在某些情况下由于 BIOS 改变而被不同地枚举的设备。

devcon listclass usb 1394

列出命令中所列的每个类别（本例中是 USB 和 1394）的所有存在的设备。

devcon remove @usb\*

删除所有 USB 设备。被删除的设备列出时将显示其删除状态。
#### 重新扫描新的“即插即用”设备
```
devcon rescan
```
重新扫描以发现新的“即插即用”设备。

devcon resources =ports

列出由ports安装类别中的所有设备使用的资源。

devcon restart =net @'ROOT\*MSLOOP\0000

重新启动环回适配器“ROOT\*MSLOOP\0000”。命令中的单引号指示必须按字面解释实例 ID。
#### 列出鼠标类设备
```
devcon hwids =mouse
```
列出系统中鼠标类设备的所有硬件 ID。

devcon sethwid @ROOT\LEGACY_BEEP\0000 := beep

将硬件 ID beep 赋予旧式蜂鸣设备。

devcon stack =ports

列出设备预期的驱动程序堆栈。包括设备和类别高层/低层筛选程序，以及控制服务。

devcon status @pci\*

列出实例 ID 以“pci\”开头的每一个存在设备的状态。

devcon status @ACPI\PNP0501\1

列出特定设备实例的状态，在本例中是一个高级配置和电源界面 (ACPI) - 枚举的串行端口。

devcon status @root\rdp_mou\0000

列出 Microsoft 终端服务器或终端服务鼠标驱动程序的状态。
#### 列出COM端口的状态
```
devcon status *PNP05*
```
列出所有 COM 端口的状态。

devcon update mydev.inf *pnp0501

更新与硬件 ID*pnp0501严格匹配的所有设备，让它们使用 Mydev.inf 中与硬件 ID*pnp0501关联的最好的驱动程序。

注意：即使系统上已经存在更好的匹配项，这一更新也将强制所有设备使用 Mydev.inf 中的驱动程序。如果在获得签名之前，您想要在开发过程中安装驱动程序的新版本，则这是很有用的。此更新仅影响与指定的硬件 ID 匹配的设备，不会影响到其子设备。如果指定的 .inf 文件未经签名，则 Windows 可能会显示一个对话框，提示您确认是否应安装此驱动程序。如果需要重新启动计算机，将报告这一情况并且 DevCon 返回一个级别 1 错误。如果指定-r，在需要重新启动计算机时就会自动重启。


## 注意

DevCon 将返回一个在脚本中使用的错误级别：

“0”指示成功。
“1”指示需要重新启动。
“2”指示失败。
“3”指示语法错误。

如果您指定-r并且需要重新启动，则在处理完所有设备后，将在无任何警告信息的情况下重新启动。

如果您指定-m:\\computer并且命令对远程计算机不起作用，将报告一个错误。

为便于交互，DevCon 允许在实例 ID 中使用通配符。不要根据一台计算机或一种操作系统版本去推测有关另一台计算机或另一种操作系统版本的实例 ID 格式的任何信息。



**设备控制台帮助： devcon.exe [-r] [-m:\\<machine>] <command> [<arg>...] -r 如果指定它，在命令完成后若需要则重新启动计算机。 <machine> 是目标计算机的名称。 <command> 是将要执行的命令（如下所示）。 <arg>... 是命令需要的一个或多个参数。**

![截图1](https://img.pconline.com.cn/images/upload/upc/tx/pcdlc/1612/14/c4/32398760_1481646621390.jpg)

软件截图1