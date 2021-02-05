# doskey

- 2017/10/16

调用 Doskey.exe，这会回调先前输入的命令行命令、编辑命令行并创建宏。

## 语法



```
doskey [/reinstall] [/listsize=<size>] [/macros:[all | <exename>] [/history] [/insert | /overstrike] [/exename=<exename>] [/macrofile=<filename>] [<macroname>=[<text>]]
```

### 参数

| 参数                     | 说明                                                         |
| :----------------------- | :----------------------------------------------------------- |
| /reinstall               | 安装 Doskey.exe 的新副本并清除命令历史记录缓冲区。           |
| /listsize =`<size>`      | 指定历史记录缓冲区中的最大命令数。                           |
| /macros                  | 显示所有 **doskey** 宏的列表。 您可以使用重定向符号 (`>` 与 **/macros**) ，将列表重定向到文件。 可以缩写 **/macros** 到 **/m**。 |
| /macros： all            | 显示所有可执行文件的 **doskey** 宏。                         |
| macros`<exename>`        | 显示*exename*指定的可执行文件的**doskey**宏。                |
| /history                 | 显示存储在内存中的所有命令。 您可以使用重定向符号 (`>` 与 **/history**) ，将列表重定向到文件。 可以将 **/history** 缩写为 **/h**。 |
| /insert                  | 指定您键入的新文本将插入旧文本。                             |
| /overstrike              | 指定新文本覆盖旧文本。                                       |
| /exename =`<exename>`    | 指定程序 (即， **doskey** 宏运行) 。                         |
| /macrofile =`<filename>` | 指定一个文件，其中包含要安装的宏。                           |
| `<macroname>`=[`<text>`] | 创建一个宏，该宏执行 *文本*指定的命令。 *MacroName* 指定要分配给宏的名称。 *Text* 指定要记录的命令。 如果 *文本* 保留为空白，则将清除任何已分配命令的 *MacroName* 。 |
| /?                       | 在命令提示符下显示帮助。                                     |

#### 备注

- 某些基于字符的交互式程序（如程序调试器或文件传输程序） (FTP) 自动使用 Doskey.exe。 若要使用 Doskey.exe，程序必须是控制台进程并使用缓冲输入。 程序密钥分配将覆盖 **doskey** 密钥分配。 例如，如果程序对某个函数使用了 F7 键，则不能在弹出窗口中获取 **doskey** 命令历史记录。

- 您可以使用 Doskey.exe 编辑当前命令行，但不能在程序的命令提示符下使用命令行选项。 必须先运行 **doskey** 命令行选项，然后再启动程序。 如果您在程序中使用 Doskey.exe，则该程序的密钥分配优先，一些 Doskey.exe 编辑密钥可能不起作用。

- 使用 Doskey.exe，可以为启动或重复的每个程序维护命令历史记录。 你可以在程序的提示中编辑以前的命令，并启动为程序创建的 **doskey** 宏。 如果退出并重新启动同一个命令提示符窗口中的程序，则可使用上一个程序会话中的命令历史记录。

- 若要重新调用命令，你可以在开始 Doskey.exe 后使用以下任何项：

  | 密钥      | 说明                                 |
  | :-------- | :----------------------------------- |
  | 向上键    | 撤回在显示的命令之前使用的命令。     |
  | 向下键    | 撤回在显示后使用的命令。             |
  | Page Up   | 撤回在当前会话中使用的第一个命令。   |
  | Page Down | 撤回当前会话中使用的最近使用的命令。 |

- 下表列出了 **doskey** 编辑密钥及其功能：

  | 键或键组合  | 说明                                                         |
  | :---------- | :----------------------------------------------------------- |
  | 向左键      | 将插入点向后移动一个字符。                                   |
  | 向右键      | 将插入点向后移动一个字符。                                   |
  | Ctrl+向左键 | 将插入点向后移动一个单词。                                   |
  | Ctrl+向右键 | 将插入点向前移动一个单词。                                   |
  | Home        | 将插入点移动到行首。                                         |
  | End         | 将插入点移动到行的末尾。                                     |
  | ESC         | 清除显示的命令。                                             |
  | F1          | 将模板中的列中的一个字符复制到命令提示符窗口中的相同列。 (模板是包含所键入的最后一个命令的内存缓冲区 ) |
  | F2          | 按下 F2 后，在模板中向前搜索你键入的下一个键。 Doskey.exe 插入模板中的文本（直到（但不包括）指定字符。 |
  | F3          | 将模板的其余部分复制到命令行。 Doskey.exe 从模板中的位置开始复制字符，该位置与命令行上的插入点所指示的位置相对应。 |
  | F4          | 在按 F4 后，删除当前插入点位置中的所有字符，直到下一次出现的字符。 |
  | F5          | 将模板复制到当前命令行中。                                   |
  | F6          | 将文件尾字符 (CTRL + Z) 置于当前插入点位置。                 |
  | F7          | 显示对话框中的 () 存储在内存中的此程序的所有命令。 使用向上键和向下键选择所需的命令，然后按 ENTER 运行该命令。 还可以记下命令前面的序列号，并将此数字与 F9 键结合使用。 |
  | Alt+F7      | 为当前历史记录缓冲区删除存储在内存中的所有命令。             |
  | F8          | 显示历史缓冲区中以当前命令中的字符开头的所有命令。           |
  | F9          | 将提示您输入历史缓冲区命令编号，然后显示与您指定的号码关联的命令。 按 ENTER 运行该命令。 若要显示所有数字及其关联的命令，请按 F7。 |
  | Alt+F10     | 删除所有宏定义。                                             |

- 如果按 INSERT 键，则可以在现有文本中间的 **doskey** 命令行上键入文本，而无需替换文本。 但在按 ENTER 后，Doskey.exe 会将键盘返回到 **替换** 模式。 必须再次按 INSERT 才能返回到 **插入** 模式。

- 当使用 INSERT 键从一种模式更改为另一种模式时，插入点会改变形状。

- 如果要自定义 Doskey.exe 如何处理程序并为该程序创建 **doskey** 宏，则可以创建一个批处理程序，用于修改 Doskey.exe 并启动程序。

- 您可以使用 Doskey.exe 来创建执行一个或多个命令的宏。 下表列出了可用于在定义宏时控制命令操作的特殊字符。

  | 字符             | 说明                                                         |
  | :--------------- | :----------------------------------------------------------- |
  | `$G` 或 `$g`     | 重定向输出。 使用这两个特殊字符将输出发送到设备或文件而不是屏幕。 此字符等效于 output () 的重定向符号 `>` 。 |
  | `$G$G` 或 `$g$g` | 将输出追加到文件末尾。 使用这两个双字符将输出追加到现有文件，而不是替换文件中的数据。 这些双字符等效于 output () 的追加重定向符号 `>>` 。 |
  | `$L` 或 `$l`     | 重定向输入。 使用上述任一特殊字符可以从设备或文件而不是键盘读取输入。 此字符等效于输入 () 的重定向符号 `<` 。 |
  | `$B` 或 `$b`     | 将宏输出发送到命令。 这些特殊字符等效于使用管道 `(` 和 `*` 。 |
  | `$T` 或 `$t`     | 分隔命令。 在 **doskey** 命令行上创建宏或类型命令时，可使用以下任一特殊字符分隔命令。 这些特殊字符等效于 `&` 在命令行上使用与号 () 。 |
  | `$$`             | 指定 () 的货币符号字符 `$` 。                                |
  | `$1` 周一至 `$9` | 表示运行宏时要指定的任何命令行信息。 使用的特殊 `$1` 字符 `$9` 是批处理参数，可让你在每次运行宏时在命令行上使用不同的数据。 `$1` **Doskey**命令中的字符类似于 `%1` 批处理程序中的字符。 |
  | `$*`             | 表示键入宏名时要指定的所有命令行信息。 特殊字符 `$*` 是类似于批处理参数的可替换参数 `$1` `$9` ，其中一个重要区别是：在宏名称后，在命令行上键入的所有内容都将替换为 `$*` 宏中的。 |

- 若要运行宏，请在命令提示符处键入宏名称，从第一个位置开始。 如果使用 `$*` 或任意批处理参数定义了宏 `$1` `$9` ，请使用空格分隔参数。 不能从批处理程序运行 **doskey** 宏。

- 如果始终使用特定命令和特定命令行选项，则可以创建一个与命令同名的宏。 若要指定是要运行宏还是运行命令，请遵循以下准则：

  - 若要运行此宏，请在命令提示符处键入宏名称。 不要在宏名之前加空格。
  - 若要运行此命令，请在命令提示符处插入一个或多个空格，然后键入命令名称。

### 示例

**/Macros**和 **/history**命令行选项可用于创建批处理程序以保存宏和命令。 例如，若要存储所有当前 **doskey** 宏，请键入：



```
doskey /macros > macinit
```

若要使用存储在 Macinit 中的宏，请键入：



```
doskey /macrofile=macinit
```

若要创建一个名为 Tmp.bat 的批处理程序，其中包含最近使用的命令，请键入：



```
doskey /history> tmp.bat
```

若要定义包含多个命令的宏，请使用 `$t` 分隔命令，如下所示：



```
doskey tx=cd temp$tdir/w $*
```

在前面的示例中，TX 宏将当前目录更改为 Temp，然后以宽显示格式显示目录列表。 `$*`当你运行 tx 选项时，你可以在宏的末尾使用将其他命令行选项追加到**dir** 。

以下宏对新目录名称使用 batch 参数：



```
doskey mc=md $1$tcd $1
```

宏创建一个新目录，然后从当前目录更改到新目录。

若要使用上述宏创建并更改到名为 *书籍*的目录，请键入：



```
mc books
```

若要为名为*Ftp.exe*的程序创建**doskey**宏，请包括 **/exename** ，如下所示：



```
doskey /exename=ftp.exe go=open 172.27.1.100$tmget *.TXT c:\reports$tbye
```

若要使用上述宏，请启动 FTP。 在 FTP 提示符下，键入：



```
go
```

FTP 运行 **open**、 **mget**和 **再见** 命令。

若要创建快速、无条件地格式化磁盘的宏，请键入：



```
doskey qf=format $1 /q /u
```

若要快速而无条件地格式化驱动器 A 中的磁盘，请键入：



```
qf a:
```

若要删除名为 *vlist*的宏，请键入：



```
doskey vlist =
```

## 其他参考

- [命令行语法项](https://docs.microsoft.com/zh-cn/windows-server/administration/windows-commands/command-line-syntax-key)

## 反馈

提交和查看相关反馈