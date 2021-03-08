# git bash misc command



### file
factor 质因数分解

file
chroot

install

passwd


xargs
tee
nohup

tty 
stty 
```
du 
$ realpath .
```
## vim
ex vi vim
### ldd
```
$ ldd --help
Usage: ldd [OPTION]... FILE...

Print shared library dependencies

  -h, --help              print this help and exit
  -V, --version           print version information and exit
  -r, --function-relocs   process data and function relocations
                          (currently unimplemented)
  -u, --unused            print unused direct dependencies
                          (currently unimplemented)
  -v, --verbose           print all information
                          (currently unimplemented)
```



## gpg
```
 gpg.exe*                         pluginviewer.exe*
 gpg-agent.exe*                   pr.exe*
 gpgconf.exe*                     printenv.exe*
 gpg-connect-agent.exe*           printf.exe*
 gpg-error.exe*                   ps.exe*
 gpgparsemail.exe*                psl.exe*
 gpgscm.exe*                      psl-make-dafsa*
 gpgsm.exe*                       ptx.exe*
 gpgtar.exe*                      pwd.exe*
 gpgv.exe*                        readlink.exe*
 gpg-wks-server.exe*  
 ```



## sum
```
/usr/bin/sha224sum.exe*
/usr/bin/sha256sum.exe*
/usr/bin/sha384sum.exe*
/usr/bin/sha512sum.exe*
```
md5sum
bksum
### expr
```
$ expr --help
Usage: expr EXPRESSION
  or:  expr OPTION

      --help     display this help and exit
      --version  output version information and exit

Print the value of EXPRESSION to standard output.  A blank line below
separates increasing precedence groups.  EXPRESSION may be:

  ARG1 | ARG2       ARG1 if it is neither null nor 0, otherwise ARG2

  ARG1 & ARG2       ARG1 if neither argument is null or 0, otherwise 0

  ARG1 < ARG2       ARG1 is less than ARG2
  ARG1 <= ARG2      ARG1 is less than or equal to ARG2
  ARG1 = ARG2       ARG1 is equal to ARG2
  ARG1 != ARG2      ARG1 is unequal to ARG2
  ARG1 >= ARG2      ARG1 is greater than or equal to ARG2
  ARG1 > ARG2       ARG1 is greater than ARG2

  ARG1 + ARG2       arithmetic sum of ARG1 and ARG2
  ARG1 - ARG2       arithmetic difference of ARG1 and ARG2

  ARG1 * ARG2       arithmetic product of ARG1 and ARG2
  ARG1 / ARG2       arithmetic quotient of ARG1 divided by ARG2
  ARG1 % ARG2       arithmetic remainder of ARG1 divided by ARG2

  STRING : REGEXP   anchored pattern match of REGEXP in STRING

  match STRING REGEXP        same as STRING : REGEXP
  substr STRING POS LENGTH   substring of STRING, POS counted from 1
  index STRING CHARS         index in STRING where any CHARS is found, or 0
  length STRING              length of STRING
  + TOKEN                    interpret TOKEN as a string, even if it is a
                               keyword like 'match' or an operator like '/'

  ( EXPRESSION )             value of EXPRESSION

Beware that many operators need to be escaped or quoted for shells.
Comparisons are arithmetic if both ARGs are numbers, else lexicographical.
Pattern matches return the string matched between \( and \) or null; if
\( and \) are not used, they return the number of characters matched or 0.

Exit status is 0 if EXPRESSION is neither null nor 0, 1 if EXPRESSION is null
or 0, 2 if EXPRESSION is syntactically invalid, and 3 if an error occurred.

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report expr translation bugs to <https://translationproject.org/team/>
Full documentation at: <https://www.gnu.org/software/coreutils/expr>
or available locally via: info '(coreutils) expr invocation'
```

### timeout
```
$ timeout --help
Usage: timeout [OPTION] DURATION COMMAND [ARG]...
  or:  timeout [OPTION]
Start COMMAND, and kill it if still running after DURATION.

Mandatory arguments to long options are mandatory for short options too.
      --preserve-status
                 exit with the same status as COMMAND, even when the
                   command times out
      --foreground
                 when not running timeout directly from a shell prompt,
                   allow COMMAND to read from the TTY and get TTY signals;
                   in this mode, children of COMMAND will not be timed out
  -k, --kill-after=DURATION
                 also send a KILL signal if COMMAND is still running
                   this long after the initial signal was sent
  -s, --signal=SIGNAL
                 specify the signal to be sent on timeout;
                   SIGNAL may be a name like 'HUP' or a number;
                   see 'kill -l' for a list of signals
  -v, --verbose  diagnose to stderr any signal sent upon timeout
      --help     display this help and exit
      --version  output version information and exit

DURATION is a floating point number with an optional suffix:
's' for seconds (the default), 'm' for minutes, 'h' for hours or 'd' for days.
A duration of 0 disables the associated timeout.

If the command times out, and --preserve-status is not set, then exit with
status 124.  Otherwise, exit with the status of COMMAND.  If no signal
is specified, send the TERM signal upon timeout.  The TERM signal kills
any process that does not block or catch that signal.  It may be necessary
to use the KILL (9) signal, since this signal cannot be caught, in which
case the exit status is 128+9 rather than 124.

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report timeout translation bugs to <https://translationproject.org/team/>
Full documentation at: <https://www.gnu.org/software/coreutils/timeout>
or available locally via: info '(coreutils) timeout invocation'

```
### stty
```
$ stty --help
Usage: stty [-F DEVICE | --file=DEVICE] [SETTING]...
  or:  stty [-F DEVICE | --file=DEVICE] [-a|--all]
  or:  stty [-F DEVICE | --file=DEVICE] [-g|--save]
Print or change terminal characteristics.

Mandatory arguments to long options are mandatory for short options too.
  -a, --all          print all current settings in human-readable form
  -g, --save         print all current settings in a stty-readable form
  -F, --file=DEVICE  open and use the specified DEVICE instead of stdin
      --help     display this help and exit
      --version  output version information and exit

Optional - before SETTING indicates negation.  An * marks non-POSIX
settings.  The underlying system defines which settings are available.

Special characters:
 * discard CHAR  CHAR will toggle discarding of output
   eof CHAR      CHAR will send an end of file (terminate the input)
   eol CHAR      CHAR will end the line
 * eol2 CHAR     alternate CHAR for ending the line
   erase CHAR    CHAR will erase the last character typed
   intr CHAR     CHAR will send an interrupt signal
   kill CHAR     CHAR will erase the current line
 * lnext CHAR    CHAR will enter the next character quoted
   quit CHAR     CHAR will send a quit signal
 * rprnt CHAR    CHAR will redraw the current line
   start CHAR    CHAR will restart the output after stopping it
   stop CHAR     CHAR will stop the output
   susp CHAR     CHAR will send a terminal stop signal
 * swtch CHAR    CHAR will switch to a different shell layer
 * werase CHAR   CHAR will erase the last word typed

Special settings:
   N             set the input and output speeds to N bauds
 * cols N        tell the kernel that the terminal has N columns
 * columns N     same as cols N
 * [-]drain      wait for transmission before applying settings (on by default)
   ispeed N      set the input speed to N
 * line N        use line discipline N
   min N         with -icanon, set N characters minimum for a completed read
   ospeed N      set the output speed to N
 * rows N        tell the kernel that the terminal has N rows
 * size          print the number of rows and columns according to the kernel
   speed         print the terminal speed
   time N        with -icanon, set read timeout of N tenths of a second

Control settings:
   [-]clocal     disable modem control signals
   [-]cread      allow input to be received
 * [-]crtscts    enable RTS/CTS handshaking
   csN           set character size to N bits, N in [5..8]
   [-]cstopb     use two stop bits per character (one with '-')
   [-]hup        send a hangup signal when the last process closes the tty
   [-]hupcl      same as [-]hup
   [-]parenb     generate parity bit in output and expect parity bit in input
   [-]parodd     set odd parity (or even parity with '-')

Input settings:
   [-]brkint     breaks cause an interrupt signal
   [-]icrnl      translate carriage return to newline
   [-]ignbrk     ignore break characters
   [-]igncr      ignore carriage return
   [-]ignpar     ignore characters with parity errors
 * [-]imaxbel    beep and do not flush a full input buffer on a character
   [-]inlcr      translate newline to carriage return
   [-]inpck      enable input parity checking
   [-]istrip     clear high (8th) bit of input characters
 * [-]iutf8      assume input characters are UTF-8 encoded
 * [-]iuclc      translate uppercase characters to lowercase
 * [-]ixany      let any character restart output, not only start character
   [-]ixoff      enable sending of start/stop characters
   [-]ixon       enable XON/XOFF flow control
   [-]parmrk     mark parity errors (with a 255-0-character sequence)
   [-]tandem     same as [-]ixoff

Output settings:
 * bsN           backspace delay style, N in [0..1]
 * crN           carriage return delay style, N in [0..3]
 * ffN           form feed delay style, N in [0..1]
 * nlN           newline delay style, N in [0..1]
 * [-]ocrnl      translate carriage return to newline
 * [-]ofdel      use delete characters for fill instead of NUL characters
 * [-]ofill      use fill (padding) characters instead of timing for delays
 * [-]olcuc      translate lowercase characters to uppercase
 * [-]onlcr      translate newline to carriage return-newline
 * [-]onlret     newline performs a carriage return
 * [-]onocr      do not print carriage returns in the first column
   [-]opost      postprocess output
 * tabN          horizontal tab delay style, N in [0..3]
 * tabs          same as tab0
 * -tabs         same as tab3
 * vtN           vertical tab delay style, N in [0..1]

Local settings:
   [-]crterase   echo erase characters as backspace-space-backspace
 * crtkill       kill all line by obeying the echoprt and echoe settings
 * -crtkill      kill all line by obeying the echoctl and echok settings
 * [-]ctlecho    echo control characters in hat notation ('^c')
   [-]echo       echo input characters
 * [-]echoctl    same as [-]ctlecho
   [-]echoe      same as [-]crterase
   [-]echok      echo a newline after a kill character
 * [-]echoke     same as [-]crtkill
   [-]echonl     echo newline even if not echoing other characters
 * [-]flusho     discard output
   [-]icanon     enable special characters: erase, kill, werase, rprnt
   [-]iexten     enable non-POSIX special characters
   [-]isig       enable interrupt, quit, and suspend special characters
   [-]noflsh     disable flushing after interrupt and quit special characters
 * [-]tostop     stop background jobs that try to write to the terminal

Combination settings:
   cbreak        same as -icanon
   -cbreak       same as icanon
   cooked        same as brkint ignpar istrip icrnl ixon opost isig
                 icanon, eof and eol characters to their default values
   -cooked       same as raw
   crt           same as echoe echoctl echoke
   dec           same as echoe echoctl echoke -ixany intr ^c erase 0177
                 kill ^u
 * [-]decctlq    same as [-]ixany
   ek            erase and kill characters to their default values
   evenp         same as parenb -parodd cs7
   -evenp        same as -parenb cs8
   litout        same as -parenb -istrip -opost cs8
   -litout       same as parenb istrip opost cs7
   nl            same as -icrnl -onlcr
   -nl           same as icrnl -inlcr -igncr onlcr -ocrnl -onlret
   oddp          same as parenb parodd cs7
   -oddp         same as -parenb cs8
   [-]parity     same as [-]evenp
   pass8         same as -parenb -istrip cs8
   -pass8        same as parenb istrip cs7
   raw           same as -ignbrk -brkint -ignpar -parmrk -inpck -istrip
                 -inlcr -igncr -icrnl -ixon -ixoff -icanon -opost
                 -isig -iuclc -ixany -imaxbel min 1 time 0
   -raw          same as cooked
   sane          same as cread -ignbrk brkint -inlcr -igncr icrnl
                 icanon iexten echo echoe echok -echonl -noflsh
                 -ixoff -iutf8 -iuclc -ixany imaxbel -olcuc -ocrnl
                 opost -ofill onlcr -onocr -onlret nl0 cr0 tab0 bs0 vt0 ff0
                 isig -tostop -ofdel echoctl echoke -flusho,
                 all special characters to their default values

Handle the tty line connected to standard input.  Without arguments,
prints baud rate, line discipline, and deviations from stty sane.  In
settings, CHAR is taken literally, or coded as in ^c, 0x37, 0177 or
127; special values ^- or undef used to disable special characters.

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Report stty translation bugs to <https://translationproject.org/team/>
Full documentation at: <https://www.gnu.org/software/coreutils/stty>
or available locally via: info '(coreutils) stty invocation'

