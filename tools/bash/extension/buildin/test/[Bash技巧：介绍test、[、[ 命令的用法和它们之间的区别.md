# [Bash技巧：介绍test、[、[[ 命令的用法和它们之间的区别](https://segmentfault.com/a/1190000022265700)

[![头像](https://avatar-static.segmentfault.com/415/308/4153086576-5db438eaba715_huge128)](https://segmentfault.com/u/shuangyupian)

[**霜鱼片**](https://segmentfault.com/u/shuangyupian)

[2020-05-17](https://segmentfault.com/a/1190000022265700/revision)

阅读 7 分钟

![img](https://sponsor.segmentfault.com/lg.php?bannerid=0&campaignid=0&zoneid=25&loc=https%3A%2F%2Fsegmentfault.com%2Fa%2F1190000022265700&referer=https%3A%2F%2Fcn.bing.com%2F&cb=724f0ae903)

本篇文章 Linux bash 的 test 命令、[ 命令、[[ 命令的用法，以及它们之间的区别。

## [ 命令

在 bash 中，`[` 关键字本身是一个命令，它不是 `if` 命令的一部分。

查看 `help [` 的说明如下：

> [: [ arg... ]
>
> Evaluate conditional expression.
> This is a synonym for the "test" builtin, but the last argument must be a literal ']', to match the opening '['.

即，`[` 命令用于评估条件表达式。

该命令是 `test` 命令的同义词，它对条件表达式的判断结果和 `test` 命令完全一样。
但是 `[` 命令要求该命令的最后一个参数必须是 `]`，看起来是闭合的方括号效果。

在实际使用中，`test` 命令 和 `[` 命令常常跟 `if` 命令、`while` 命令结合使用，但这不是必须的。
`test` 命令 和 `[` 命令本身和 `if` 命令、`while` 命令是独立的，可以单独执行。

后面会用 `test` 命令来说明具体的用法，这些说明都适用于 `[` 命令。

**注意**：`]` 自身不是 bash 的命令，它只是 `[` 命令要求的参数，且必须是最后一个参数。

在使用 `[` 命令时，最大的误区是在这个命令之后没有加空格。例如 `[string1 = string2]` 这种写法是错误的。

要时刻注意 `[` 本身是一个命令，这个命令名就是 `[`，要在这个命令之后跟着一些参数，要用空格把命令名和参数隔开。

`[string1` 这个写法实际上会执行名为 `[string1` 的命令，不是执行 `[` 命令。

类似的，`]` 本身是一个参数，它也要用空格来隔开其他参数。
`string2]` 这个写法实际上是一个名为 "string2]" 的参数，而不是 `string2` 和 `]` 两个参数。

## test 命令

在 bash 中，可以使用 `test` 内置命令来评估条件表达式。

查看 man bash 对 `test` 命令的说明如下：

> test: test [expr]
>
> Evaluate conditional expression.
> Exits with a status of 0 (true) or 1 (false) depending on the evaluation of EXPR.
> The behavior of test depends on the number of arguments.
> Read the bash manual page for the complete specification.

这个说明提到，`test` 命令的参数个数会影响它的行为，具体要参考 man bash 的说明。

不同的参数个数会导致 `test` 命令返回很多不预期的结果，这是非常关键的点。

上面在介绍比较字符串的条件表达式时有所提及。详细说明可以查看 `bash-string.md` 文件。

`test` 命令支持 man bash 的 *CONDITIONAL EXPRESSIONS* 小节提到的所有条件表达式，并支持用下面的操作符来组合条件表达式，操作符优先级按从高到低排列：

| 操作符         | 含义                                                         |
| -------------- | ------------------------------------------------------------ |
| ! expr         | 如果 *expr* 条件表达式是 false，则 *! expr* 返回 true        |
| ( expr )       | 返回 *expr* 条件表达式的值                                   |
| expr1 -a expr2 | 当 *expr1* 和 *expr2* 条件表达式都为 true 时，整个表达式才是 true |
| expr1 -o expr2 | 当 *expr1* 或 *expr2* 条件表达式有一个为 true 时，整个表达式就是 true |

可以看到，`test` 命令使用 `-a` 操作符进行与操作，使用 `-o` 操作符进行或操作，不支持 `||`、`&&` 这种写法的操作符。

这些操作符用于组合条件表达式，它们的优先级都低于条件表达式自身的操作符。

**注意**：在 `test` 命令中，每一个操作符（operator）、以及每一个操作符参数（operand）之间都必须用空格隔开。
上面举例说明过条件表达式操作符要加空格的情况。
这里的 `!`、`(`、`)`、`-a`、`-o` 操作符前后也都要加空格。

另外，在 bash 中，小括号具有特殊含义，`(cmd)` 表示启动一个子 shell 来执行 *cmd* 命令。
所以这里的 `(` 和 `)` 要用 `\` 转义字符、或者引号来去掉它们的特殊含义，避免被当成命令替换（Command substitution）来处理。

具体举例说明如下：

```bash
$ test !a == b
-bash: !a: event not found
$ test ! a == b; echo $?
0
$ test ( a == b ); echo $?
-bash: syntax error near unexpected token 'a'
$ test (a == b); echo $?
-bash: syntax error near unexpected token 'a'
$ test \(a == a\); echo $?
1
$ test \( a == a \); echo $?
0
$ test '(' a == a ')'; echo $?
0
$ test '( a == a )'; echo $?
0
$ test a '||' b
-bash: test: ||: binary operator expected
```

可以看到，`test !a == b` 命令执行报错，`!` 和字符 a 之间没有用空格隔开，被当成引用历史命令。

`test ! a == b` 命令返回 0。这里的 `!` 操作符优先级低于 `==` 操作符，先判断 `a == b` 条件表达式，再对 `a == b` 条件表达式的判断结果取反，没有执行报错。

`test ( a == b )` 命令虽然在各个操作符、操作符参数之间都加了空格，但是没有对 `(` 和 `)` 进行转义、或者加引号，导致被当成命令替换处理，执行报错。

`test (a == b)` 命令也是把小括号当成命令替换处理，执行报错。

`test \(a == a\)` 命令没有执行报错，用 `\` 对小括号进行了转义，不会当成命令替换处理，但是返回为 1。
看起来认为 a 等于 a 是 false，这是错误的。
这个命令其实是比较 "(a" 字符串和 "a)" 字符串是否相等，这两个字符串显然不相等，所以返回为 1.

`test \( a == a \)` 命令在 `\(` 和 `\)` 前后加了空格，才是正确的写法，判断出 a 等于 a 为 true，返回为 0。

`test '(' a == a ')'` 命令用单引号把小括号括起来，小括号不会当成命令替换处理，也可以正常执行。

如果有多个需要转义的字符，可以用引号把整个表达式都括起来。
由于引号内大部分特殊字符都失去特殊含义，所以不需要再转义。

`test '( a == a )'` 命令用就采用了这个写法。

`test a '||' b` 命令执行报错，提示 `||` 不是有效的操作符，`test` 命令不支持这种写法的操作符。

在 `test` 命令中，如果要进行算术运算，需要用 `$((expression))` 来进行算术运算，并获取运算结果，直接写算术运算表达式会报错。

原因在于 bash 默认没有把 `-`、`+` 这两个字符当成减号、加号来处理，只是普通的字符参数。
`-` 常用于指定命令选项。

要在 `((expression))` 表达式中才能用 `-`、`+` 这两个字符来进行算术运算。
用 `$((expression))` 来获取运算结果。

具体举例如下：

```bash
$ count=4
$ test $count - 2 -eq 2
-bash: test: too many arguments
$ test $count + 2 -ne 2
-bash: test: too many arguments
$ test $(($count - 2)) -eq 2; echo $?
0
```

可以看到，`test $count - 2 -eq 2` 命令和 `test $count + 2 -ne 2` 命令都执行报错，提示提供的参数个数过多。

这里的 `-`、`+` 都作为字符参数，传递给 `test` 命令。
而该命令没有把这两个字符当成减号、加号来处理，不会进行算术运算，最终报错。

`test $(($count - 2)) -eq 2` 命令可以获取到 *count* 变量值，并减去 2，获取到这个算术运算的结果，然后跟整数 2 进行比较，最终返回 0。

## [[ 命令

在 bash 中，可以使用 `[[` 复合命令来评估条件表达式。

查看 man bash 对 `[[` 命令的说明如下：

> [[ expression ]]
>
> Return a status of 0 or 1 depending on the evaluation of the conditional expression expression.
> Expressions are composed of the primaries described below under CONDITIONAL EXPRESSIONS.
>
> Word splitting and pathname expansion are not performed on the words between the [[ and ]]; tilde expansion, parameter and variable expansion, arithmetic expansion, command substitution, process substitution, and quote removal are performed.
>
> See the description of the test builtin command (section SHELL BUILTIN COMMANDS below) for the handling of parameters (i.e. missing parameters).

即，`[[` 命令支持 man bash 的 *CONDITIONAL EXPRESSIONS* 小节提到的所有条件表达式，且对不同参数个数的判断结果跟 `test` 命令一致。

`test` 命令对不同参数个数的处理可以查看 `bash-string.md` 文件的说明。

`[[` 命令后面必须跟在 `]]` 命令，这两个命令前后都要用空格隔开。
`]]` 本身也是一个命令。

在这两个命令中间，不进行单词拆分（word splitting）和路径名扩展（pathname expansion）。

不进行单词拆分意味着获取字符串变量的值时，即使字符串中间带有空格，也不会被拆分成多个字符串。

具体举例如下：

```bash
$ value="test string"
$ [[ -n $value ]]; echo $?
0
$ test -n $value
-bash: test: test: binary operator expected
$ [[ -n "test string" ]]; echo $?
0
$ [[ -n test string ]]
-bash: syntax error in conditional expression
-bash: syntax error near 'string'
```

可以看到，*value* 变量对应的字符串带有空格，`[[ -n $value ]]` 命令可以正确判断到 *value* 变量值不是空字符串，没有对该变量值进行单词拆分。

而 `test -n $value` 命令会执行报错，*value* 变量值带有空格，`$value` 经过单词拆分后会变成两个字符串参数。
由于 `-n` 操作符不预期后面有多个参数，执行报错。

`[[ -n "test string" ]]` 命令也可以正常执行，"test string" 是一个字符串参数。

但是 `[[ -n test string ]]` 命令会执行报错，这种写法手动进行单词拆分，"test" 和 "string" 会被当成两个字符串参数。

在 bash 中，获取字符串变量值时，如果不用双引号把变量值括起来，常常会因为变量值为空、或者变量值带有空格进行单词拆分，导致不预期的结果。
大部分情况下，都建议用双引号把变量值括起来。

为了保持写法一致，虽然 `[[` 命令内部不进行单词拆分，还是建议用双引号把变量值括起来。

不进行路径名扩展，意味着 `*`、`?`、`[...]` 通配符不会扩展为当前目录下的文件名，而是保持这几个字符不变。
这些通配符只在部分操作符中可以用于模式匹配。

前面提到，`[[` 命令使用 `==`、`=`、`!=` 操作符时，操作符右边字符串可以使用 `*`、`?`、`[...]` 通配符来进行模式匹配。

在 `[[` 和 `]]` 之内，会进行算术扩展，不需要用 `$((expression))` 来获取运算结果，直接写为算术表达式即可，但是整个算术表达式之间不能有空格。

如果想要在算术表达式之间加空格，还是要使用 `$((expression))` 来进行扩展。

具体举例如下：

```bash
$ count=4
$ [[ $count - 2 -eq 2 ]]
-bash: conditional binary operator expected
-bash: syntax error near '-'
$ [[ $count-2 -eq 2 ]]; echo $?
0
$ [[ $(($count - 2)) -eq 2 ]]; echo $?
0
```

可以看到，`[[ $count - 2 -eq 2 ]]` 命令执行报错。

而 `[[ $count-2 -eq 2 ]]` 命令就可以正常执行。
这里面的 `$count-2` 会进行算术运算。

`[[ $(($count - 2)) -eq 2 ]]` 命令使用 `$(( ))` 进行算术扩展，可以在 `$count`、`-`、`2` 之间加空格，不会执行报错。

`[[` 命令使用 `==`、`=`、`!=` 操作符时，操作符右边字符串可以使用 bash 通配符来进行模式匹配。

另外，`[[` 命令还支持一个 `=~` 操作符，该操作符右边字符串可以使用扩展正则表达式来作为模式字符串，判断左边字符串是否包含右边的模式字符串。

注意是包含关系，而不是完整匹配，也就是判断右边的模式是否为左边字符串的子字符串，而不是判断右边的模式是否完全等于左边字符串。

由于 bash 通配符和扩展正则表达式的部分特殊字符是同一个字符，但是具体含义不同，要注意这两个情况的区别，使用正确的写法。

具体举例如下：

```bash
$ [[ main.c == *.c ]]; echo $?
0
$ [[ main.c =~ *.c ]]; echo $?
2
```

可以看到，`[[ main.c == *.c ]]` 命令返回 0，判断出左边的字符串以 `.c` 结尾。
这个写法可以用于判断某个文件名后缀是否为 `.c`。

而 `[[ main.c =~ *.c ]]` 命令返回 2，报错，右边的扩展正则表达式无效。
在扩展正则表达式中，`*` 不能出现在表达式开头。

**注意**：在 `==`、`=`、`!=`、`=~` 操作符中，操作符右边的字符串可以使用特殊字符来匹配特定模式，但是这些特殊字符不能用引号括起来。
这些特殊字符在引号内会失去特殊含义，只能匹配字符自身。

### [[ 命令的与或非操作符

`[[` 命令支持用下面的操作符来组合条件表达式，操作符优先级按从高到低排列：

| 操作符         | 含义                                                         |
| -------------- | ------------------------------------------------------------ |
| ( expr )       | 返回 *expr* 条件表达式的值                                   |
| ! expr         | 如果 *expr* 条件表达式是 false，则 *! expr* 返回 true        |
| expr1 && expr2 | 当 *expr1* 和 *expr2* 条件表达式都为 true 时，整个表达式才是 true |

| expr1 || expr2 | 当 *expr1* 或 *expr2* 条件表达式有一个为 true 时，整个表达式就是 true |

可以看到，`[[` 命令使用 `&&` 操作符进行与操作，使用 `||` 操作符进行或操作，不支持 `test` 命令的 `-a`、`-o` 的操作符。

在 `(`、`)`、`&&`、`||` 操作符前后可以不加空格，也不需要用 `\` 进行转义。而 `!` 操作符前后还是需要加空格。

举例说明如下：

```bash
$ [[ !a == b ]]
-bash: !a: event not found
$ [[ (a == a) ]]; echo $?
0
$ [[ a != b&&a != c ]]; echo $?
0
$ [[ a != b||a == a ]]; echo $?
0
$ [[ 1 < 2 ]]; echo $?
0
```

可以看到，`[[ !a == b ]]` 命令执行命令，`!` 操作符和字符 a 字之间没有用空格隔开。

`[[ (a == b) ]]` 命令没有执行报错，判断结果也正确，不需要用 `\` 对 `(`、`)` 进行转义，且小括号前后可以不加空格。

`[[ a != b&&a != c ]]` 命令在 `&&` 操作符前后没有加空格，没有执行报错。

`[[ a != b||a == a ]]` 命令的情况类似。

`[[ 1 < 2 ]]` 命令不会执行报错，不需要用 `\` 对 `<` 进行转义。
而 `test` 命令需要用 `\` 对 `<` 进行转义。

**注意**：Bash 自身、以及其他命令也支持 `&&`、`||` 操作符。一般来说也是分别对应逻辑与、逻辑或。
由于含义相近，在一些场景下可能会搞混。
在实际执行命令时，一定要注意区分是由哪个命令来处理 `&&`、`||` 操作符，按照对应命令的规则来理解这些操作符的作用，避免出现不预期的结果。

## test、[、[[ 命令的区别

下面说明 `test`、`[`、`[[` 这三个命令之间的区别。

### test、[ 命令的区别

`[` 命令是 `test` 命令的同义词，大部分用法都是一样的。

唯一明显的区别在于，`[` 命令要求最后一个参数必须是 `]`。

而 `test` 命令没有这个要求，也不能处理 `]` 参数。

下面会以 `[` 命令为例来说明跟 `[[` 命令的区别。

### [、[[ 命令的区别

`[` 命令和 `[[` 命令都可以用来评估条件表达式，在具体使用时，有一些差异，具体对比如下：

| 特性           | [ 命令                                         | [[ 命令                                        |
| -------------- | ---------------------------------------------- | ---------------------------------------------- |
| POSIX 标准     | POSIX 标准命令                                 | 不是标准命令，而是 bash 扩展的命令             |
| 命令组合       | 要求最后一个参数是 ]，] 不是一个命令           | 要求后面跟着 ]] 命令                           |
| 单词拆分       | 进行单词拆分，获取变量值建议加上双引号         | 不进行单词拆分，获取变量值可以不加双引号       |
| 路径名扩展     | 进行路径名扩展，要对路径名扩展特殊字符进行转义 | 不进行路径名扩展                               |
| 算术运算       | 不支持，要使用 $((expr)) 算术扩展获取运算结果  | 支持算术运算，不需要用 $((expr)) 进行扩展      |
| 模式匹配       | 不支持使用通配符模式匹配                       | ==、=、!= 操作符支持使用通配符进行模式匹配     |
| 判断字符串包含 | 不支持                                         | =~ 操作符支持判断字符串包含关系                |
| 扩展正则表达式 | 不支持                                         | =~ 操作符支持扩展正则表达式                    |
| 逻辑与         | 使用 -a 操作符进行与操作                       | 使用 && 操作符进行与操作                       |
| 逻辑或         | 使用 -o 操作符进行或操作                       | 使用两个竖线操作符进行或操作                   |
| 小括号写法     | 需要对小括号转义、或者加引号                   | 不需要对小括号转义，也不用加引号               |
| <、> 写法      | 需要对 <、> 转义、或者加引号                   | 不需要对 <、> 转义、也不用加引号               |
| <、> 编码集    | 用 <、> 比较字符串时，使用 ASCII 编码集        | 用 <、> 比较字符串时，使用当前语言环境的编码集 |

[linux](https://segmentfault.com/t/linux)[bash](https://segmentfault.com/t/bash)[shell](https://segmentfault.com/t/shell)