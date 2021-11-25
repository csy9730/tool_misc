# tcl

[https://www.tcl.tk/about/language.html](https://www.tcl.tk/about/language.html)

Tcl is a very simple programming language. If you have programmed before, you can learn enough to write interesting Tcl programs within a few hours. This page provides a quick overview of the main features of Tcl. After reading this you'll probably be able to start writing simple Tcl scripts on your own; however, we recommend that you consult one of the many available Tcl books for more complete information.

### Basic syntax

Tcl scripts are made up of *commands* separated by newlines or semicolons. Commands all have the same basic form illustrated by the following example:

```
expr 20 + 10
```

This command computes the sum of 20 and 10 and returns the result, 30. You can try out this example and all the others in this page by typing them to a Tcl application such as `tclsh`; after a command completes, `tclsh` prints its result.

Each Tcl command consists of one or more *words* separated by spaces. In this example there are four words: `expr`, `20`, `+`, and `10`. The first word is the name of a command and the other words are *arguments* to that command. All Tcl commands consist of words, but different commands treat their arguments differently. The `expr` command treats all of its arguments together as an arithmetic expression, computes the result of that expression, and returns the result as a string. In the `expr` command the division into words isn't significant: you could just as easily have invoked the same command as

```
expr 20+10
```

However, for most commands the word structure is important, with each word used for a distinct purpose.

All Tcl commands return results. If a command has no meaningful result then it returns an empty string as its result.

### Variables

Tcl allows you to store values in variables and use the values later in commands. The `set` command is used to write and read variables. For example, the following command modifies the variable `x` to hold the value `32`:

```
set x 32
```

The command returns the new value of the variable. You can read the value of a variable by invoking `set` with only a single argument:

```
set x
```

You don't need to declare variables in Tcl: a variable is created automatically the first time it is set. Tcl variables don't have types: any variable can hold any value.

To use the value of a variable in a command, use *variable substitution* as in the following example:

```
expr $x*3
```

When a `$` appears in a command, Tcl treats the letters and digits following it as a variable name, and substitutes the value of the variable in place of the name. In this example, the actual argument received by the `expr` command will be `32*3` (assuming that variable `x` was set as in the previous example). You can use variable substitution in any word of any command, or even multiple times within a word:

```
set cmd expr
set x 11
$cmd $x*$x
```

### Command substitution

You can also use the result of one command in an argument to another command. This is called *command substitution*:

```
set a 44
set b [expr $a*4]
```

When a `[` appears in a command, Tcl treats everything between it and the matching `]` as a nested Tcl command. Tcl evaluates the nested command and substitutes its result into the enclosing command in place of the bracketed text. In the example above the second argument of the second `set` command will be `176`.

### Quotes and braces

Double-quotes allow you to specify words that contain spaces. For example, consider the following script:

```
set x 24
set y 18
set z "$x + $y is [expr $x + $y]"
```

After these three commands are evaluated variable `z` will have the value `24 + 18 is 42`. Everything between the quotes is passed to the `set` command as a single word. Note that (a) command and variable substitutions are performed on the text between the quotes, and (b) the quotes themselves are not passed to the command. If the quotes were not present, the `set` command would have received 6 arguments, which would have caused an error.

Curly braces provide another way of grouping information into words. They are different from quotes in that no substitutions are performed on the text between the curly braces:

```
set z {$x + $y is [expr $x + $y]}
```

This command sets variable `z` to the value "`$x + $y is [expr $x + $y]`".

### Control structures

Tcl provides a complete set of control structures including commands for conditional execution, looping, and procedures. Tcl control structures are just commands that take Tcl scripts as arguments. The example below creates a Tcl procedure called `power`, which raises a base to an integer power:

```
proc power {base p} {
    set result 1
    while {$p > 0} {
        set result [expr $result * $base]
        set p [expr $p - 1]
    }
    return $result
}
```

This script consists of a single command, `proc`. The `proc` command takes three arguments: the name of a procedure, a list of argument names, and the body of the procedure, which is a Tcl script. Note that everything between the curly brace at the end of the first line and the curly brace on the last line is passed verbatim to `proc` as a single argument. The `proc` command creates a new Tcl command named `power` that takes two arguments. You can then invoke `power` with commands like the following:

```
power 2 6
power 1.15 5
```

When `power` is invoked, the procedure body is evaluated. While the body is executing it can access its arguments as variables: `base` will hold the first argument and `p` will hold the second.

The body of the `power` procedure contains three Tcl commands: `set`, `while`, and `return`. The `while` command does most of the work of the procedure. It takes two arguments, an expression (`$p > 0`) and a body, which is another Tcl script. The `while` command evaluates its expression argument using rules similar to those of the C programming language and if the result is true (nonzero) then it evaluates the body as a Tcl script. It repeats this process over and over until eventually the expression evaluates to false (zero). In this case the body of the `while` command multiplied the result value by `base` and then decrements `p`. When `p` reaches zero the result contains the desired power of `base`. The `return` command causes the procedure to exit with the value of variable `result` as the procedure's result.

### Where do commands come from?

As you have seen, all of the interesting features in Tcl are represented by commands. Statements are commands, expressions are evaluated by executing commands, control structures are commands, and procedures are commands.

Tcl commands are created in three ways. One group of commands is provided by the Tcl interpreter itself. These commands are called *builtin commands*. They include all of the commands you have seen so far and many more (see below). The builtin commands are present in all Tcl applications.

The second group of commands is created using the Tcl extension mechanism. Tcl provides APIs that allow you to create a new command by writing a *command procedure* in C or C++ that implements the command. You then register the command procedure with the Tcl interpreter by telling Tcl the name of the command that the procedure implements. In the future, whenever that particular name is used for a Tcl command, Tcl will call your command procedure to execute the command. The builtin commands are also implemented using this same extension mechanism; their command procedures are simply part of the Tcl library.

When Tcl is used inside an application, the application incorporates its key features into Tcl using the extension mechanism. Thus the set of available Tcl commands varies from application to application. There are also numerous extension packages that can be incorporated into any Tcl application. One of the best known extensions is Tk, which provides powerful facilities for building graphical user interfaces. Other extensions provide object-oriented programming, database access, more graphical capabilities, and a variety of other features. One of Tcl's greatest advantages for building integration applications is the ease with which it can be extended to incorporate new features or communicate with other resources.

The third group of commands consists of procedures created with the `proc` command, such as the `power` command created above. Typically, extensions are used for lower-level functions where C programming is convenient, and procedures are used for higher-level functions where it is easier to write in Tcl.

### Other features

Tcl contains many other commands besides the ones used in the preceding examples. Here is a sampler of some of the features provided by the builtin Tcl commands:

- More control structures, such as `if`, `for`, `foreach`, and `switch`.
- String manipulation, including a powerful regular expression matching facility. Arbitrary-length strings can be passed around and manipulated just as easily as numbers.
- I/O, including files on disk, network sockets, and devices such as serial ports. Tcl provides particularly simple facilities for socket communication over the Internet.
- File management: Tcl provides several commands for manipulating file names, reading and writing file attributes, copying files, deleting files, creating directories, and so on.
- Subprocess invocation: you can run other applications with the `exec` command and communicate with them while they run.
- Lists: Tcl makes it easy to create collections of values (lists) and manipulate them in a variety of ways.
- Arrays: you can create structured values consisting of name-value pairs with arbitrary string values for the names and values.
- Time and date manipulation.
- Events: Tcl allows scripts to wait for certain events to occur, such as an elapsed time or the availability of input data on a network socket.

### Examples

- [A simple command line tool](https://www.tcl.tk/about/dos2unix.html)
- [A simple network server](https://www.tcl.tk/about/netserver.html)

### Tutorial

Have some time to delve a bit further into the language? The [Tcl Tutorial](https://www.tcl.tk/man/tcl8.5/tutorial/tcltutorial.html) is a great way to learn more about Tcl's various commands and language features.