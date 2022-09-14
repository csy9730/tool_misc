# strace

strace 运行程序前加上strace，可以追踪到函数库调用过程

## help
```
D:\gcc>strace --help
Usage: strace [OPTIONS] <command-line>
Usage: strace [OPTIONS] -p <pid>

Trace system calls and signals

  -b, --buffer-size=SIZE       set size of output file buffer
  -d, --no-delta               don't display the delta-t microsecond timestamp
  -e, --events                 log all Windows DEBUG_EVENTS (toggle - default true)
  -f, --trace-children         trace child processes (toggle - default true)
  -h, --help                   output usage information and exit
  -m, --mask=MASK              set message filter mask
  -n, --crack-error-numbers    output descriptive text instead of error
                               numbers for Windows errors
  -o, --output=FILENAME        set output file to FILENAME
  -p, --pid=n                  attach to executing program with cygwin pid n
  -q, --quiet                  suppress messages about attaching, detaching, etc.
  -S, --flush-period=PERIOD    flush buffered strace output every PERIOD secs
  -t, --timestamp              use an absolute hh:mm:ss timestamp insted of
                               the default microsecond timestamp.  Implies -d
  -T, --toggle                 toggle tracing in a process already being
                               traced. Requires -p <pid>
  -u, --usecs                  toggle printing of microseconds timestamp
  -V, --version                output version information and exit
  -w, --new-window             spawn program under test in a new window

    MASK can be any combination of the following mnemonics and/or hex values
    (0x is optional).  Combine masks with '+' or ',' like so:

                      --mask=wm+system,malloc+0x00800

    Mnemonic Hex     Corresponding Def  Description
    =========================================================================
    all      0x000001 (_STRACE_ALL)      All strace messages.
    flush    0x000002 (_STRACE_FLUSH)    Flush output buffer after each message.
    inherit  0x000004 (_STRACE_INHERIT)  Children inherit mask from parent.
    uhoh     0x000008 (_STRACE_UHOH)     Unusual or weird phenomenon.
    syscall  0x000010 (_STRACE_SYSCALL)  System calls.
    startup  0x000020 (_STRACE_STARTUP)  argc/envp printout at startup.
    debug    0x000040 (_STRACE_DEBUG)    Info to help debugging.
    paranoid 0x000080 (_STRACE_PARANOID) Paranoid info.
    termios  0x000100 (_STRACE_TERMIOS)  Info for debugging termios stuff.
    select   0x000200 (_STRACE_SELECT)   Info on ugly select internals.
    wm       0x000400 (_STRACE_WM)       Trace Windows msgs (enable _strace_wm).
    sigp     0x000800 (_STRACE_SIGP)     Trace signal and process handling.
    minimal  0x001000 (_STRACE_MINIMAL)  Very minimal strace output.
    pthread  0x002000 (_STRACE_PTHREAD)  Pthread calls.
    exitdump 0x004000 (_STRACE_EXITDUMP) Dump strace cache on exit.
    system   0x008000 (_STRACE_SYSTEM)   Serious error; goes to console and log.
    nomutex  0x010000 (_STRACE_NOMUTEX)  Don't use mutex for synchronization.
    malloc   0x020000 (_STRACE_MALLOC)   Trace malloc calls.
    thread   0x040000 (_STRACE_THREAD)   Thread-locking calls.
    special  0x100000 (_STRACE_SPECIAL)  Special debugging printfs for
                                         non-checked-in code
```