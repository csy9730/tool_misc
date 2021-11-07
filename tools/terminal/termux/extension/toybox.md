# toybox

```
toybox 0.8.2
toybox : [ acpi arch ascii base64 basename blkid blockdev bunzip2 bzcat cal cat catv chattr chgrp chmod chown chroot chrt chvt cksum clear cmp comm count cp cpio crc32 cut date devmem df dirname dmesg dnsdomainname dos2unix du echo egrep eject env expand factor fallocate false fgrep file find flock fmt free freeramdisk fsfreeze fstype fsync ftpget ftpput getconf grep groups gunzip halt head help hexedit hostname hwclock i2cdetect i2cdump i2cget i2cset iconv id ifconfig inotifyd insmod install ionice iorenice iotop kill killall killall5 link ln logger login logname losetup ls lsattr lsmod lspci lsusb makedevs mcookie md5sum microcom mix mkdir mkfifo mknod mkpasswd mkswap mktemp modinfo mount mountpoint mv nbd-client nbd_client nc netcat netstat nice nl nohup nproc nsenter od oneit partprobe passwd paste patch pgrep pidof ping ping6 pivot_root pkill pmap poweroff printenv printf prlimit ps pwd pwdx readahead readlink realpath reboot renice reset rev rfkill rm rmdir rmmod sed seq setfattr setsid sha1sum shred sleep sntp sort split stat strings su swapoff swapon switch_root sync sysctl tac tail tar taskset tee test time timeout top touch true truncate tty tunctl ulimit umount uname uniq unix2dos unlink unshare uptime usleep uudecode uuencode uuidgen vconfig vmstat w watch wc which who whoami xargs xxd yes zcat

toybox
usage: toybox [--long | --help | --version | [command] [arguments...]]

With no arguments, shows available commands. First argument is
name of a command to run, followed by any arguments to that command.

--long	Show path to each command

To install command symlinks with paths, try:
  for i in $(/bin/toybox --long); do ln -s /bin/toybox $i; done
or all in one directory:
  for i in $(./toybox); do ln -s toybox $i; done; PATH=$PWD:$PATH

Most toybox commands also understand the following arguments:

--help		Show command help (only)
--version	Show toybox version (only)

The filename "-" means stdin/stdout, and "--" stops argument parsing.

Numerical arguments accept a single letter suffix for
kilo, mega, giga, tera, peta, and exabytes, plus an additional
"d" to indicate decimal 1000's instead of 1024.

Durations can be decimal fractions and accept minute ("m"), hour ("h"),
or day ("d") suffixes (so 0.1m = 6s).
:
Return zero.
[
usage: test [-bcdefghLPrSsuwx PATH] [-nz STRING] [-t FD] [X ?? Y]

Return true or false by performing tests. (With no arguments return false.)

--- Tests with a single argument (after the option):
PATH is/has:
  -b  block device   -f  regular file   -p  fifo           -u  setuid bit
  -c  char device    -g  setgid         -r  read bit       -w  write bit
  -d  directory      -h  symlink        -S  socket         -x  execute bit
  -e  exists         -L  symlink        -s  nonzero size
STRING is:
  -n  nonzero size   -z  zero size      (STRING by itself implies -n)
FD (integer file descriptor) is:
  -t  a TTY

--- Tests with one argument on each side of an operator:
Two strings:
  =  are identical   !=  differ
Two integers:
  -eq  equal         -gt  first > second    -lt  first < second
  -ne  not equal     -ge  first >= second   -le  first <= second

--- Modify or combine tests:
  ! EXPR     not (swap true/false)   EXPR -a EXPR    and (are both true)
  ( EXPR )   evaluate this first     EXPR -o EXPR    or (is either true)
acpi
usage: acpi [-abctV]

Show status of power sources and thermal devices.

-a	Show power adapters
-b	Show batteries
-c	Show cooling device state
-t	Show temperatures
-V	Show everything
arch
usage: arch

Print machine (hardware) name, same as uname -m.
ascii
usage: ascii

Display ascii character set.
base64
usage: base64 [-di] [-w COLUMNS] [FILE...]

Encode or decode in base64.

-d	Decode
-i	Ignore non-alphabetic characters
-w	Wrap output at COLUMNS (default 76 or 0 for no wrap)
basename
usage: basename [-a] [-s SUFFIX] NAME... | NAME [SUFFIX]

Return non-directory portion of a pathname removing suffix.

-a		All arguments are names
-s SUFFIX	Remove suffix (implies -a)
blkid
usage: blkid [-s TAG] [-UL] DEV...

Print type, label and UUID of filesystem on a block device or image.

-U	Show UUID only (or device with that UUID)
-L	Show LABEL only (or device with that LABEL)
-s TAG	Only show matching tags (default all)
blockdev
usage: blockdev --OPTION... BLOCKDEV...

Call ioctl(s) on each listed block device

--setro		Set read only
--setrw		Set read write
--getro		Get read only
--getss		Get sector size
--getbsz	Get block size
--setbsz BYTES	Set block size
--getsz		Get device size in 512-byte sectors
--getsize	Get device size in sectors (deprecated)
--getsize64	Get device size in bytes
--getra		Get readahead in 512-byte sectors
--setra SECTORS	Set readahead
--flushbufs	Flush buffers
--rereadpt	Reread partition table
bunzip2
usage: bunzip2 [-cftkv] [FILE...]

Decompress listed files (file.bz becomes file) deleting archive file(s).
Read from stdin if no files listed.

-c	Force output to stdout
-f	Force decompression (if FILE doesn't end in .bz, replace original)
-k	Keep input files (-c and -t imply this)
-t	Test integrity
-v	Verbose
bzcat
usage: bzcat [FILE...]

Decompress listed files to stdout. Use stdin if no files listed.
cal
usage: cal [[month] year]

Print a calendar.

With one argument, prints all months of the specified year.
With two arguments, prints calendar for month and year.
cat
usage: cat [-u] [file...]

Copy (concatenate) files to stdout.  If no files listed, copy from stdin.
Filename "-" is a synonym for stdin.

-u	Copy one byte at a time (slow)
catv
usage: catv [-evt] [filename...]

Display nonprinting characters as escape sequences. Use M-x for
high ascii characters (>127), and ^x for other nonprinting chars.

-e	Mark each newline with $
-t	Show tabs as ^I
-v	Don't use ^x or M-x escapes
chattr
usage: chattr [-R] [-+=AacDdijsStTu] [-v version] [File...]

Change file attributes on a Linux second extended file system.

-R	Recurse
-v	Set the file's version/generation number

Operators:
  '-' Remove attributes
  '+' Add attributes
  '=' Set attributes

Attributes:
  A  Don't track atime
  a  Append mode only
  c  Enable compress
  D  Write dir contents synchronously
  d  Don't backup with dump
  i  Cannot be modified (immutable)
  j  Write all data to journal first
  s  Zero disk storage when deleted
  S  Write file contents synchronously
  t  Disable tail-merging of partial blocks with other files
  u  Allow file to be undeleted
chgrp
usage: chgrp/chown [-RHLP] [-fvh] group file...

Change group of one or more files.

-f	Suppress most error messages
-h	Change symlinks instead of what they point to
-R	Recurse into subdirectories (implies -h)
-H	With -R change target of symlink, follow command line symlinks
-L	With -R change target of symlink, follow all symlinks
-P	With -R change symlink, do not follow symlinks (default)
-v	Verbose
chmod
usage: chmod [-R] MODE FILE...

Change mode of listed file[s] (recursively with -R).

MODE can be (comma-separated) stanzas: [ugoa][+-=][rwxstXugo]

Stanzas are applied in order: For each category (u = user,
g = group, o = other, a = all three, if none specified default is a),
set (+), clear (-), or copy (=), r = read, w = write, x = execute.
s = u+s = suid, g+s = sgid, o+s = sticky. (+t is an alias for o+s).
suid/sgid: execute as the user/group who owns the file.
sticky: can't delete files you don't own out of this directory
X = x for directories or if any category already has x set.

Or MODE can be an octal value up to 7777	ug uuugggooo	top +
bit 1 = o+x, bit 1<<8 = u+w, 1<<11 = g+1	sstrwxrwxrwx	bottom

Examples:
chmod u+w file - allow owner of "file" to write to it.
chmod 744 file - user can read/write/execute, everyone else read only
chown
usage: chgrp/chown [-RHLP] [-fvh] group file...

Change group of one or more files.

-f	Suppress most error messages
-h	Change symlinks instead of what they point to
-R	Recurse into subdirectories (implies -h)
-H	With -R change target of symlink, follow command line symlinks
-L	With -R change target of symlink, follow all symlinks
-P	With -R change symlink, do not follow symlinks (default)
-v	Verbose
chroot
usage: chroot NEWROOT [COMMAND [ARG...]]

Run command within a new root directory. If no command, run /bin/sh.
chrt
usage: chrt [-Rmofrbi] {-p PID [PRIORITY] | [PRIORITY COMMAND...]}

Get/set a process' real-time scheduling policy and priority.

-p	Set/query given pid (instead of running COMMAND)
-R	Set SCHED_RESET_ON_FORK
-m	Show min/max priorities available

Set policy (default -r):

  -o  SCHED_OTHER    -f  SCHED_FIFO    -r  SCHED_RR
  -b  SCHED_BATCH    -i  SCHED_IDLE
chvt
usage: chvt N

Change to virtual terminal number N. (This only works in text mode.)

Virtual terminals are the Linux VGA text mode displays, ordinarily
switched between via alt-F1, alt-F2, etc. Use ctrl-alt-F1 to switch
from X to a virtual terminal, and alt-F6 (or F7, or F8) to get back.
cksum
usage: cksum [-IPLN] [file...]

For each file, output crc32 checksum value, length and name of file.
If no files listed, copy from stdin.  Filename "-" is a synonym for stdin.

-H	Hexadecimal checksum (defaults to decimal)
-L	Little endian (defaults to big endian)
-P	Pre-inversion
-I	Skip post-inversion
-N	Do not include length in CRC calculation (or output)
clear
Clear the screen.
cmp
usage: cmp [-l] [-s] FILE1 [FILE2 [SKIP1 [SKIP2]]]

Compare the contents of two files. (Or stdin and file if only one given.)

-l	Show all differing bytes
-s	Silent
comm
usage: comm [-123] FILE1 FILE2

Read FILE1 and FILE2, which should be ordered, and produce three text
columns as output: lines only in FILE1; lines only in FILE2; and lines
in both files. Filename "-" is a synonym for stdin.

-1	Suppress the output column of lines unique to FILE1
-2	Suppress the output column of lines unique to FILE2
-3	Suppress the output column of lines duplicated in FILE1 and FILE2
count
usage: count

Copy stdin to stdout, displaying simple progress indicator to stderr.
cp
usage: cp [--preserve=motcxa] [-adlnrsvfipRHLP] SOURCE... DEST

Copy files from SOURCE to DEST.  If more than one SOURCE, DEST must
be a directory.
-v	Verbose
-s	Symlink instead of copy
-r	Synonym for -R
-n	No clobber (don't overwrite DEST)
-l	Hard link instead of copy
-d	Don't dereference symlinks
-a	Same as -dpr
-P	Do not follow symlinks [default]
-L	Follow all symlinks
-H	Follow symlinks listed on command line
-R	Recurse into subdirectories (DEST must be a directory)
-p	Preserve timestamps, ownership, and mode
-i	Interactive, prompt before overwriting existing DEST
-F	Delete any existing destination file first (--remove-destination)
-f	Delete destination files we can't write to
-D	Create leading dirs under DEST (--parents)
--preserve takes either a comma separated list of attributes, or the first
letter(s) of:

        mode - permissions (ignore umask for rwx, copy suid and sticky bit)
   ownership - user and group
  timestamps - file creation, modification, and access times.
     context - security context
       xattr - extended attributes
         all - all of the above
cpio
usage: cpio -{o|t|i|p DEST} [-v] [--verbose] [-F FILE] [--no-preserve-owner]
       [ignored: -mdu -H newc]

Copy files into and out of a "newc" format cpio archive.

-F FILE	Use archive FILE instead of stdin/stdout
-p DEST	Copy-pass mode, copy stdin file list to directory DEST
-i	Extract from archive into file system (stdin=archive)
-o	Create archive (stdin=list of files, stdout=archive)
-t	Test files (list only, stdin=archive, stdout=list of files)
-v	Verbose
--no-preserve-owner (don't set ownership during extract)
--trailer Add legacy trailer (prevents concatenation)
crc32
usage: crc32 [file...]

Output crc32 checksum for each file.
cut
usage: cut [-Ds] [-bcfF LIST] [-dO DELIM] [FILE...]

Print selected parts of lines from each FILE to standard output.

Each selection LIST is comma separated, either numbers (counting from 1)
or dash separated ranges (inclusive, with X- meaning to end of line and -X
from start). By default selection ranges are sorted and collated, use -D
to prevent that.

-b	Select bytes
-c	Select UTF-8 characters
-C	Select unicode columns
-d	Use DELIM (default is TAB for -f, run of whitespace for -F)
-D	Don't sort/collate selections or match -fF lines without delimiter
-f	Select fields (words) separated by single DELIM character
-F	Select fields separated by DELIM regex
-O	Output delimiter (default one space for -F, input delim for -f)
-s	Skip lines without delimiters
date
usage: date [-u] [-r FILE] [-d DATE] [+DISPLAY_FORMAT] [-D SET_FORMAT] [SET]

Set/get the current date/time. With no SET shows the current date.

-d	Show DATE instead of current time (convert date format)
-D	+FORMAT for SET or -d (instead of MMDDhhmm[[CC]YY][.ss])
-r	Use modification time of FILE instead of current date
-u	Use UTC instead of current timezone

Supported input formats:

MMDDhhmm[[CC]YY][.ss]     POSIX
@UNIXTIME[.FRACTION]      seconds since midnight 1970-01-01
YYYY-MM-DD [hh:mm[:ss]]   ISO 8601
hh:mm[:ss]                24-hour time today

All input formats can be preceded by TZ="id" to set the input time zone
separately from the output time zone. Otherwise $TZ sets both.

+FORMAT specifies display format string using strftime(3) syntax:

%% literal %             %n newline              %t tab
%S seconds (00-60)       %M minute (00-59)       %m month (01-12)
%H hour (0-23)           %I hour (01-12)         %p AM/PM
%y short year (00-99)    %Y year                 %C century
%a short weekday name    %A weekday name         %u day of week (1-7, 1=mon)
%b short month name      %B month name           %Z timezone name
%j day of year (001-366) %d day of month (01-31) %e day of month ( 1-31)
%N nanosec (output only)

%U Week of year (0-53 start sunday)   %W Week of year (0-53 start monday)
%V Week of year (1-53 start monday, week < 4 days not part of this year)

%D = "%m/%d/%y"    %r = "%I : %M : %S %p"   %T = "%H:%M:%S"   %h = "%b"
%x locale date     %X locale time           %c locale date/time
devmem
usage: devmem ADDR [WIDTH [DATA]]

Read/write physical address via /dev/mem.

WIDTH is 1, 2, 4, or 8 bytes (default 4).
df
usage: df [-HPkhi] [-t type] [FILESYSTEM ...]

The "disk free" command shows total/used/available disk space for
each filesystem listed on the command line, or all currently mounted
filesystems.

-a	Show all (including /proc and friends)
-P	The SUSv3 "Pedantic" option
-k	Sets units back to 1024 bytes (the default without -P)
-h	Human readable (K=1024)
-H	Human readable (k=1000)
-i	Show inodes instead of blocks
-t type	Display only filesystems of this type

Pedantic provides a slightly less useful output format dictated by Posix,
and sets the units to 512 bytes instead of the default 1024 bytes.
dirname
usage: dirname PATH...

Show directory portion of path.
dmesg
usage: dmesg [-Cc] [-r|-t|-T] [-n LEVEL] [-s SIZE] [-w]

Print or control the kernel ring buffer.

-C	Clear ring buffer without printing
-c	Clear ring buffer after printing
-n	Set kernel logging LEVEL (1-9)
-r	Raw output (with )
-S	Use syslog(2) rather than /dev/kmsg
-s	Show the last SIZE many bytes
-T	Human readable timestamps
-t	Don't print timestamps
-w	Keep waiting for more output (aka --follow)
dnsdomainname
usage: dnsdomainname

Show domain this system belongs to (same as hostname -d).
dos2unix
usage: dos2unix [FILE...]

Convert newline format from dos "\r\n" to unix "\n".
If no files listed copy from stdin, "-" is a synonym for stdin.
du
usage: du [-d N] [-askxHLlmc] [file...]

Show disk usage, space consumed by files and directories.

Size in:
-k	1024 byte blocks (default)
-K	512 byte blocks (posix)
-m	Megabytes
-h	Human readable (e.g., 1K 243M 2G)

What to show:
-a	All files, not just directories
-H	Follow symlinks on cmdline
-L	Follow all symlinks
-s	Only total size of each argument
-x	Don't leave this filesystem
-c	Cumulative total
-d N	Only depth < N
-l	Disable hardlink filter
echo
usage: echo [-neE] [args...]

Write each argument to stdout, with one space between each, followed
by a newline.

-n	No trailing newline
-E	Print escape sequences literally (default)
-e	Process the following escape sequences:
	\\	Backslash
	\0NNN	Octal values (1 to 3 digits)
	\a	Alert (beep/flash)
	\b	Backspace
	\c	Stop output here (avoids trailing newline)
	\f	Form feed
	\n	Newline
	\r	Carriage return
	\t	Horizontal tab
	\v	Vertical tab
	\xHH	Hexadecimal values (1 to 2 digits)
egrep
usage: grep [-EFrivwcloqsHbhn] [-ABC NUM] [-m MAX] [-e REGEX]... [-MS PATTERN]... [-f REGFILE] [FILE]...

Show lines matching regular expressions. If no -e, first argument is
regular expression to match. With no files (or "-" filename) read stdin.
Returns 0 if matched, 1 if no match found, 2 for command errors.

-e  Regex to match. (May be repeated.)
-f  File listing regular expressions to match.

file search:
-r  Recurse into subdirectories (defaults FILE to ".")
-R  Recurse into subdirectories and symlinks to directories
-M  Match filename pattern (--include)
-S  Skip filename pattern (--exclude)
--exclude-dir=PATTERN  Skip directory pattern
-I  Ignore binary files

match type:
-A  Show NUM lines after     -B  Show NUM lines before match
-C  NUM lines context (A+B)  -E  extended regex syntax
-F  fixed (literal match)    -a  always text (not binary)
-i  case insensitive         -m  match MAX many lines
-v  invert match             -w  whole word (implies -E)
-x  whole line               -z  input NUL terminated

display modes: (default: matched line)
-c  count of matching lines  -l  show only matching filenames
-o  only matching part       -q  quiet (errors only)
-s  silent (no error msg)    -Z  output NUL terminated

output prefix (default: filename if checking more than 1 file)
-H  force filename           -b  byte offset of match
-h  hide filename            -n  line number of match
eject
usage: eject [-stT] [DEVICE]

Eject DEVICE or default /dev/cdrom

-s	SCSI device
-t	Close tray
-T	Open/close tray (toggle)
env
usage: env [-i] [-u NAME] [NAME=VALUE...] [COMMAND [ARG...]]

Set the environment for command invocation, or list environment variables.

-i	Clear existing environment
-u NAME	Remove NAME from the environment
-0	Use null instead of newline in output
expand
usage: expand [-t TABLIST] [FILE...]

Expand tabs to spaces according to tabstops.

-t	TABLIST

Specify tab stops, either a single number instead of the default 8,
or a comma separated list of increasing numbers representing tabstop
positions (absolute, not increments) with each additional tab beyond
that becoming one space.
factor
usage: factor NUMBER...

Factor integers.
fallocate
usage: fallocate [-l size] [-o offset] file

Tell the filesystem to allocate space for a file.
false
Return nonzero.
fgrep
usage: grep [-EFrivwcloqsHbhn] [-ABC NUM] [-m MAX] [-e REGEX]... [-MS PATTERN]... [-f REGFILE] [FILE]...

Show lines matching regular expressions. If no -e, first argument is
regular expression to match. With no files (or "-" filename) read stdin.
Returns 0 if matched, 1 if no match found, 2 for command errors.

-e  Regex to match. (May be repeated.)
-f  File listing regular expressions to match.

file search:
-r  Recurse into subdirectories (defaults FILE to ".")
-R  Recurse into subdirectories and symlinks to directories
-M  Match filename pattern (--include)
-S  Skip filename pattern (--exclude)
--exclude-dir=PATTERN  Skip directory pattern
-I  Ignore binary files

match type:
-A  Show NUM lines after     -B  Show NUM lines before match
-C  NUM lines context (A+B)  -E  extended regex syntax
-F  fixed (literal match)    -a  always text (not binary)
-i  case insensitive         -m  match MAX many lines
-v  invert match             -w  whole word (implies -E)
-x  whole line               -z  input NUL terminated

display modes: (default: matched line)
-c  count of matching lines  -l  show only matching filenames
-o  only matching part       -q  quiet (errors only)
-s  silent (no error msg)    -Z  output NUL terminated

output prefix (default: filename if checking more than 1 file)
-H  force filename           -b  byte offset of match
-h  hide filename            -n  line number of match
file
usage: file [-bhLs] [file...]

Examine the given files and describe their content types.

-b	Brief (no filename)
-h	Don't follow symlinks (default)
-L	Follow symlinks
-s	Show block/char device contents
find
usage: find [-HL] [DIR...] []

Search directories for matching files.
Default: search ".", match all, -print matches.

-H  Follow command line symlinks         -L  Follow all symlinks

Match filters:
-name  PATTERN   filename with wildcards  (-iname case insensitive)
-path  PATTERN   path name with wildcards (-ipath case insensitive)
-user  UNAME     belongs to user UNAME     -nouser     user ID not known
-group GROUP     belongs to group GROUP    -nogroup    group ID not known
-perm  [-/]MODE  permissions (-=min /=any) -prune      ignore dir contents
-size  N[c]      512 byte blocks (c=bytes) -xdev       only this filesystem
-links N         hardlink count            -atime N[u] accessed N units ago
-ctime N[u]      created N units ago       -mtime N[u] modified N units ago
-newer FILE      newer mtime than FILE     -mindepth N at least N dirs down
-depth           ignore contents of dir    -maxdepth N at most N dirs down
-inum N          inode number N            -empty      empty files and dirs
-type [bcdflps]  type is (block, char, dir, file, symlink, pipe, socket)
-true            always true               -false      always false
-context PATTERN security context
-newerXY FILE    X=acm time > FILE's Y=acm time (Y=t: FILE is literal time)

Numbers N may be prefixed by a - (less than) or + (greater than). Units for
-Xtime are d (days, default), h (hours), m (minutes), or s (seconds).

Combine matches with:
!, -a, -o, ( )    not, and, or, group expressions

Actions:
-print  Print match with newline  -print0        Print match with null
-exec   Run command with path     -execdir       Run command in file's dir
-ok     Ask before exec           -okdir         Ask before execdir
-delete Remove matching file/dir  -printf FORMAT Print using format string

Commands substitute "{}" with matched file. End with ";" to run each file,
or "+" (next argument after "{}") to collect and run with multiple files.

-printf FORMAT characters are \ escapes and:
%b  512 byte blocks used
%f  basename            %g  textual gid          %G  numeric gid
%i  decimal inode       %l  target of symlink    %m  octal mode
%M  ls format type/mode %p  path to file         %P  path to file minus DIR
%s  size in bytes       %T@ mod time as unixtime
%u  username            %U  numeric uid          %Z  security context
flock
usage: flock [-sxun] fd

Manage advisory file locks.

-s	Shared lock
-x	Exclusive lock (default)
-u	Unlock
-n	Non-blocking: fail rather than wait for the lock
fmt
usage: fmt [-w WIDTH] [FILE...]

Reformat input to wordwrap at a given line length, preserving existing
indentation level, writing to stdout.

-w WIDTH	Maximum characters per line (default 75)
free
usage: free [-bkmgt]

Display the total, free and used amount of physical memory and swap space.

-bkmgt	Output units (default is bytes)
-h	Human readable (K=1024)
freeramdisk
usage: freeramdisk [RAM device]

Free all memory allocated to specified ramdisk
fsfreeze
usage: fsfreeze {-f | -u} MOUNTPOINT

Freeze or unfreeze a filesystem.

-f	Freeze
-u	Unfreeze
fstype
usage: fstype DEV...

Print type of filesystem on a block device or image.
fsync
usage: fsync [-d] [FILE...]

Synchronize a file's in-core state with storage device.

-d	Avoid syncing metadata
ftpget
usage: ftpget [-cvgslLmMdD] [-P PORT] [-p PASSWORD] [-u USER] HOST [LOCAL] REMOTE

Talk to ftp server. By default get REMOTE file via passive anonymous
transfer, optionally saving under a LOCAL name. Can also send, list, etc.

-c	Continue partial transfer
-p	Use PORT instead of "21"
-P	Use PASSWORD instead of "ftpget@"
-u	Use USER instead of "anonymous"
-v	Verbose

Ways to interact with FTP server:
-d	Delete file
-D	Remove directory
-g	Get file (default)
-l	List directory
-L	List (filenames only)
-m	Move file on server from LOCAL to REMOTE
-M	mkdir
-s	Send file
ftpput
usage: ftpget [-cvgslLmMdD] [-P PORT] [-p PASSWORD] [-u USER] HOST [LOCAL] REMOTE

Talk to ftp server. By default get REMOTE file via passive anonymous
transfer, optionally saving under a LOCAL name. Can also send, list, etc.

-c	Continue partial transfer
-p	Use PORT instead of "21"
-P	Use PASSWORD instead of "ftpget@"
-u	Use USER instead of "anonymous"
-v	Verbose

Ways to interact with FTP server:
-d	Delete file
-D	Remove directory
-g	Get file (default)
-l	List directory
-L	List (filenames only)
-m	Move file on server from LOCAL to REMOTE
-M	mkdir
-s	Send file
getconf
usage: getconf -a [PATH] | -l | NAME [PATH]

Get system configuration values. Values from pathconf(3) require a path.

-a	Show all (defaults to "/" if no path given)
-l	List available value names (grouped by source)
grep
usage: grep [-EFrivwcloqsHbhn] [-ABC NUM] [-m MAX] [-e REGEX]... [-MS PATTERN]... [-f REGFILE] [FILE]...

Show lines matching regular expressions. If no -e, first argument is
regular expression to match. With no files (or "-" filename) read stdin.
Returns 0 if matched, 1 if no match found, 2 for command errors.

-e  Regex to match. (May be repeated.)
-f  File listing regular expressions to match.

file search:
-r  Recurse into subdirectories (defaults FILE to ".")
-R  Recurse into subdirectories and symlinks to directories
-M  Match filename pattern (--include)
-S  Skip filename pattern (--exclude)
--exclude-dir=PATTERN  Skip directory pattern
-I  Ignore binary files

match type:
-A  Show NUM lines after     -B  Show NUM lines before match
-C  NUM lines context (A+B)  -E  extended regex syntax
-F  fixed (literal match)    -a  always text (not binary)
-i  case insensitive         -m  match MAX many lines
-v  invert match             -w  whole word (implies -E)
-x  whole line               -z  input NUL terminated

display modes: (default: matched line)
-c  count of matching lines  -l  show only matching filenames
-o  only matching part       -q  quiet (errors only)
-s  silent (no error msg)    -Z  output NUL terminated

output prefix (default: filename if checking more than 1 file)
-H  force filename           -b  byte offset of match
-h  hide filename            -n  line number of match
groups
usage: groups [user]

Print the groups a user is in.
gunzip
usage: gunzip [-cfk] [FILE...]

Decompress files. With no files, decompresses stdin to stdout.
On success, the input files are removed and replaced by new
files without the .gz suffix.

-c	Output to stdout (act as zcat)
-f	Force: allow read from tty
-k	Keep input files (default is to remove)
halt
usage: reboot/halt/poweroff [-fn]

Restart, halt or powerdown the system.

-f	Don't signal init
-n	Don't sync before stopping the system
head
usage: head [-n number] [file...]

Copy first lines from files to stdout. If no files listed, copy from
stdin. Filename "-" is a synonym for stdin.

-n	Number of lines to copy
-c	Number of bytes to copy
-q	Never print headers
-v	Always print headers
help
usage: help [-ah] [command]

Show usage information for toybox commands.
Run "toybox" with no arguments for a list of available commands.

-h	HTML output
-a	All commands
hexedit
usage: hexedit FILENAME

Hexadecimal file editor. All changes are written to disk immediately.

-r	Read only (display but don't edit)

Keys:
Arrows        Move left/right/up/down by one line/column
Pg Up/Pg Dn   Move up/down by one page
0-9, a-f      Change current half-byte to hexadecimal value
u             Undo
q/^c/^d/ Quit
hostname
usage: hostname [-bdsf] [-F FILENAME] [newname]

Get/set the current hostname.

-b	Set hostname to 'localhost' if otherwise unset
-d	Show DNS domain name (no host)
-f	Show fully-qualified name (host+domain, FQDN)
-F	Set hostname to contents of FILENAME
-s	Show short host name (no domain)
hwclock
usage: hwclock [-rswtluf]

Get/set the hardware clock.

-f FILE	Use specified device file instead of /dev/rtc (--rtc)
-l	Hardware clock uses localtime (--localtime)
-r	Show hardware clock time (--show)
-s	Set system time from hardware clock (--hctosys)
-t	Set the system time based on the current timezone (--systz)
-u	Hardware clock uses UTC (--utc)
-w	Set hardware clock from system time (--systohc)
i2cdetect
usage: i2cdetect [-ary] BUS [FIRST LAST]
usage: i2cdetect -F BUS
usage: i2cdetect -l

Detect i2c devices.

-a	All addresses (0x00-0x7f rather than 0x03-0x77)
-F	Show functionality
-l	List all buses
-r	Probe with SMBus Read Byte
-y	Answer "yes" to confirmation prompts (for script use)
i2cdump
usage: i2cdump [-fy] BUS CHIP

Dump i2c registers.

-f	Force access to busy devices
-y	Answer "yes" to confirmation prompts (for script use)
i2cget
usage: i2cget [-fy] BUS CHIP ADDR

Read an i2c register.

-f	Force access to busy devices
-y	Answer "yes" to confirmation prompts (for script use)
i2cset
usage: i2cset [-fy] BUS CHIP ADDR VALUE... MODE

Write an i2c register. MODE is b for byte, w for 16-bit word, i for I2C block.

-f	Force access to busy devices
-y	Answer "yes" to confirmation prompts (for script use)
iconv
usage: iconv [-f FROM] [-t TO] [FILE...]

Convert character encoding of files.

-c	Omit invalid chars
-f	Convert from (default utf8)
-t	Convert to   (default utf8)
id
usage: id [-nGgru] [USER...]

Print user and group ID.

-n	Print names instead of numeric IDs (to be used with -Ggu)
-G	Show only the group IDs
-g	Show only the effective group ID
-r	Show real ID instead of effective ID
-u	Show only the effective user ID
ifconfig
usage: ifconfig [-aS] [INTERFACE [ACTION...]]

Display or configure network interface.

With no arguments, display active interfaces. First argument is interface
to operate on, one argument by itself displays that interface.

-a	All interfaces displayed, not just active ones
-S	Short view, one line per interface

Standard ACTIONs to perform on an INTERFACE:

ADDR[/MASK]        - set IPv4 address (1.2.3.4/5) and activate interface
add|del ADDR[/LEN] - add/remove IPv6 address (1111::8888/128)
up|down            - activate or deactivate interface

Advanced ACTIONs (default values usually suffice):

default          - remove IPv4 address
netmask ADDR     - set IPv4 netmask via 255.255.255.0 instead of /24
txqueuelen LEN   - number of buffered packets before output blocks
mtu LEN          - size of outgoing packets (Maximum Transmission Unit)
broadcast ADDR   - Set broadcast address
pointopoint ADDR - PPP and PPPOE use this instead of "route add default gw"
hw TYPE ADDR     - set hardware (mac) address (type = ether|infiniband)

Flags you can set on an interface (or -remove by prefixing with -):

arp       - don't use Address Resolution Protocol to map LAN routes
promisc   - don't discard packets that aren't to this LAN hardware address
multicast - force interface into multicast mode if the driver doesn't
allmulti  - promisc for multicast packets
inotifyd
usage: inotifyd PROG FILE[:MASK] ...

When a filesystem event matching MASK occurs to a FILE, run PROG as:

  PROG EVENTS FILE [DIRFILE]

If PROG is "-" events are sent to stdout.

This file is:
  a  accessed    c  modified    e  metadata change  w  closed (writable)
  r  opened      D  deleted     M  moved            0  closed (unwritable)
  u  unmounted   o  overflow    x  unwatchable

A file in this directory is:
  m  moved in    y  moved out   n  created          d  deleted

When x event happens for all FILEs, inotifyd exits (after waiting for PROG).
insmod
usage: insmod MODULE [MODULE_OPTIONS]

Load the module named MODULE passing options if given.
install
usage: install [-dDpsv] [-o USER] [-g GROUP] [-m MODE] [SOURCE...] DEST

Copy files and set attributes.

-d	Act like mkdir -p
-D	Create leading directories for DEST
-g	Make copy belong to GROUP
-m	Set permissions to MODE
-o	Make copy belong to USER
-p	Preserve timestamps
-s	Call "strip -p"
-v	Verbose
ionice
usage: ionice [-t] [-c CLASS] [-n LEVEL] [COMMAND...|-p PID]

Change the I/O scheduling priority of a process. With no arguments
(or just -p), display process' existing I/O class/priority.

-c	CLASS = 1-3: 1(realtime), 2(best-effort, default), 3(when-idle)
-n	LEVEL = 0-7: (0 is highest priority, default = 5)
-p	Affect existing PID instead of spawning new child
-t	Ignore failure to set I/O priority

System default iopriority is generally -c 2 -n 4.
iorenice
usage: iorenice PID [CLASS] [PRIORITY]

Display or change I/O priority of existing process. CLASS can be
"rt" for realtime, "be" for best effort, "idle" for only when idle, or
"none" to leave it alone. PRIORITY can be 0-7 (0 is highest, default 4).
iotop
usage: iotop [-AaKObq] [-n NUMBER] [-d SECONDS] [-p PID,] [-u USER,]

Rank processes by I/O.

-A	All I/O, not just disk
-a	Accumulated I/O (not percentage)
-H	Show threads
-K	Kilobytes
-k	Fallback sort FIELDS (default -[D]IO,-ETIME,-PID)
-m	Maximum number of tasks to show
-O	Only show processes doing I/O
-o	Show FIELDS (default PID,PR,USER,[D]READ,[D]WRITE,SWAP,[D]IO,COMM)
-s	Sort by field number (0-X, default 6)
-b	Batch mode (no tty)
-d	Delay SECONDS between each cycle (default 3)
-n	Exit after NUMBER iterations
-p	Show these PIDs
-u	Show these USERs
-q	Quiet (no header lines)

Cursor LEFT/RIGHT to change sort, UP/DOWN move list, space to force
update, R to reverse sort, Q to exit.
kill
usage: kill [-l [SIGNAL] | -s SIGNAL | -SIGNAL] pid...

Send signal to process(es).

-l	List signal name(s) and number(s)
-s	Send SIGNAL (default SIGTERM)
killall
usage: killall [-l] [-iqv] [-SIGNAL|-s SIGNAL] PROCESS_NAME...

Send a signal (default: TERM) to all processes with the given names.

-i	Ask for confirmation before killing
-l	Print list of all available signals
-q	Don't print any warnings or error messages
-s	Send SIGNAL instead of SIGTERM
-v	Report if the signal was successfully sent
-w	Wait until all signaled processes are dead
killall5
usage: killall5 [-l [SIGNAL]] [-SIGNAL|-s SIGNAL] [-o PID]...

Send a signal to all processes outside current session.

-l	List signal name(s) and number(s)
-o PID	Omit PID
-s	Send SIGNAL (default SIGTERM)
link
usage: link FILE NEWLINK

Create hardlink to a file.
ln
usage: ln [-sfnv] [-t DIR] [FROM...] TO

Create a link between FROM and TO.
One/two/many arguments work like "mv" or "cp".

-s	Create a symbolic link
-f	Force the creation of the link, even if TO already exists
-n	Symlink at TO treated as file
-t	Create links in DIR
-T	TO always treated as file, max 2 arguments
-v	Verbose
logger
usage: logger [-s] [-t TAG] [-p [FACILITY.]PRIORITY] [message...]

Log message (or stdin) to syslog.

-s	Also write message to stderr
-t	Use TAG instead of username to identify message source
-p	Specify PRIORITY with optional FACILITY. Default is "user.notice"
login
usage: login [-p] [-h host] [-f USERNAME] [USERNAME]

Log in as a user, prompting for username and password if necessary.

-p	Preserve environment
-h	The name of the remote host for this login
-f	login as USERNAME without authentication
logname
usage: logname

Print the current user name.
losetup
usage: losetup [-cdrs] [-o OFFSET] [-S SIZE] {-d DEVICE...|-j FILE|-af|{DEVICE FILE}}

Associate a loopback device with a file, or show current file (if any)
associated with a loop device.

Instead of a device:
-a	Iterate through all loopback devices
-f	Find first unused loop device (may create one)
-j FILE	Iterate through all loopback devices associated with FILE

existing:
-c	Check capacity (file size changed)
-d DEV	Detach loopback device
-D	Detach all loopback devices

new:
-s	Show device name (alias --show)
-o OFF	Start association at offset OFF into FILE
-r	Read only
-S SIZE	Limit SIZE of loopback association (alias --sizelimit)
ls
usage: ls [-ACFHLRSZacdfhiklmnpqrstux1] [--color[=auto]] [directory...]

List files.

what to show:
-a  all files including .hidden    -b  escape nongraphic chars
-c  use ctime for timestamps       -d  directory, not contents
-i  inode number                   -p  put a '/' after dir names
-q  unprintable chars as '?'       -s  storage used (1024 byte units)
-u  use access time for timestamps -A  list all files but . and ..
-H  follow command line symlinks   -L  follow symlinks
-R  recursively list in subdirs    -F  append /dir *exe @sym |FIFO
-Z  security context

output formats:
-1  list one file per line         -C  columns (sorted vertically)
-g  like -l but no owner           -h  human readable sizes
-l  long (show full details)       -m  comma separated
-n  like -l but numeric uid/gid    -o  like -l but no group
-x  columns (horizontal sort)      -ll long with nanoseconds (--full-time)
--color  device=yellow  symlink=turquoise/red  dir=blue  socket=purple
         files: exe=green  suid=red  suidfile=redback  stickydir=greenback
         =auto means detect if output is a tty.

sorting (default is alphabetical):
-f  unsorted    -r  reverse    -t  timestamp    -S  size
lsattr
usage: lsattr [-Radlv] [Files...]

List file attributes on a Linux second extended file system.
(AacDdijsStu defined in chattr --help)

-R	Recursively list attributes of directories and their contents
-a	List all files in directories, including files that start with '.'
-d	List directories like other files, rather than listing their contents
-l	List long flag names
-v	List the file's version/generation number
lsmod
usage: lsmod

Display the currently loaded modules, their sizes and their dependencies.
lspci
usage: lspci [-ekmn] [-i FILE ] 

List PCI devices.
-e	Print all 6 digits in class
-i	PCI ID database (default /usr/share/misc/pci.ids)
-k	Print kernel driver
-m	Machine parseable format
-n	Numeric output (repeat for readable and numeric)
lsusb
usage: lsusb

List USB hosts/devices.
makedevs
usage: makedevs [-d device_table] rootdir

Create a range of special files as specified in a device table.

-d	File containing device table (default reads from stdin)

Each line of the device table has the fields:
         
Where name is the file name, and type is one of the following:

b	Block device
c	Character device
d	Directory
f	Regular file
p	Named pipe (fifo)

Other fields specify permissions, user and group id owning the file,
and additional fields for device special files. Use '-' for blank entries,
unspecified fields are treated as '-'.
mcookie
usage: mcookie [-vV]

Generate a 128-bit strong random number.

-v  show entropy source (verbose)
-V  show version
md5sum
usage: md5sum [-bcs] [FILE]...

Calculate md5 hash for each input file, reading from stdin if none.
Output one hash (32 hex digits) for each input file, followed by filename.

-b	Brief (hash only, no filename)
-c	Check each line of each FILE is the same hash+filename we'd output
-s	No output, exit status 0 if all hashes match, 1 otherwise
microcom
usage: microcom [-s SPEED] [-X] DEVICE

Simple serial console.

-s	Set baud rate to SPEED
-X	Ignore ^@ (send break) and ^] (exit)
mix
usage: mix [-d DEV] [-c CHANNEL] [-l VOL] [-r RIGHT]

List OSS sound channels (module snd-mixer-oss), or set volume(s).

-c CHANNEL	Set/show volume of CHANNEL (default first channel found)
-d DEV		Device node (default /dev/mixer)
-l VOL		Volume level
-r RIGHT	Volume of right stereo channel (with -r, -l sets left volume)
mkdir
usage: mkdir [-vp] [-m mode] [dirname...]

Create one or more directories.

-m	Set permissions of directory to mode
-p	Make parent directories as needed
-v	Verbose
mkfifo
usage: mkfifo [NAME...]

Create FIFOs (named pipes).
mknod
usage: mknod [-m MODE] NAME TYPE [MAJOR MINOR]

Create a special file NAME with a given type. TYPE is b for block device,
c or u for character device, p for named pipe (which ignores MAJOR/MINOR).

-m	Mode (file permissions) of new device, in octal or u+x format
mkpasswd
usage: mkpasswd [-P FD] [-m TYPE] [-S SALT] [PASSWORD] [SALT]

Crypt PASSWORD using crypt(3)

-P FD	Read password from file descriptor FD
-m TYPE	Encryption method (des, md5, sha256, or sha512; default is des)
-S SALT
mkswap
usage: mkswap [-L LABEL] DEVICE

Set up a Linux swap area on a device or file.
mktemp
usage: mktemp [-dqu] [-p DIR] [TEMPLATE]

Safely create a new file "DIR/TEMPLATE" and print its name.

-d	Create directory instead of file (--directory)
-p	Put new file in DIR (--tmpdir)
-q	Quiet, no error messages
-t	Prefer $TMPDIR > DIR > /tmp (default DIR > $TMPDIR > /tmp)
-u	Don't create anything, just print what would be created

Each X in TEMPLATE is replaced with a random printable character. The
default TEMPLATE is tmp.XXXXXXXXXX.
modinfo
usage: modinfo [-0] [-b basedir] [-k kernel] [-F field] [module|file...]

Display module fields for modules specified by name or .ko path.

-F  Only show the given field
-0  Separate fields with NUL rather than newline
-b  Use  as root for /lib/modules/
-k  Look in given directory under /lib/modules/
mount
usage: mount [-afFrsvw] [-t TYPE] [-o OPTION,] [[DEVICE] DIR]

Mount new filesystem(s) on directories. With no arguments, display existing
mounts.

-a	Mount all entries in /etc/fstab (with -t, only entries of that TYPE)
-O	Only mount -a entries that have this option
-f	Fake it (don't actually mount)
-r	Read only (same as -o ro)
-w	Read/write (default, same as -o rw)
-t	Specify filesystem type
-v	Verbose

OPTIONS is a comma separated list of options, which can also be supplied
as --longopts.

Autodetects loopback mounts (a file on a directory) and bind mounts (file
on file, directory on directory), so you don't need to say --bind or --loop.
You can also "mount -a /path" to mount everything in /etc/fstab under /path,
even if it's noauto. DEVICE starting with UUID= is identified by blkid -U.
mountpoint
usage: mountpoint [-qd] DIR
       mountpoint [-qx] DEVICE

Check whether the directory or device is a mountpoint.

-q	Be quiet, return zero if directory is a mountpoint
-d	Print major/minor device number of the directory
-x	Print major/minor device number of the block device
mv
usage: mv [-fivn] SOURCE... DEST

-f	Force copy by deleting destination file
-i	Interactive, prompt before overwriting existing DEST
-v	Verbose
-n	No clobber (don't overwrite DEST)
nbd-client
usage: nbd-client [-ns] HOST PORT DEVICE

-n	Do not fork into background
-s	nbd swap support (lock server into memory)
nbd_client
usage: nbd-client [-ns] HOST PORT DEVICE

-n	Do not fork into background
-s	nbd swap support (lock server into memory)
nc
usage: netcat [-46Ut] [-lL COMMAND...] [-u] [-wpq #] [-s addr] {IPADDR PORTNUM|-f FILENAME}

Forward stdin/stdout to a file or network connection.

-4	Force IPv4
-6	Force IPv6
-L	Listen for multiple incoming connections (server mode)
-U	Use a UNIX domain socket
-W	SECONDS timeout for more data on an idle connection
-f	Use FILENAME (ala /dev/ttyS0) instead of network
-l	Listen for one incoming connection
-p	Local port number
-q	Quit SECONDS after EOF on stdin, even if stdout hasn't closed yet
-s	Local source address
-t	Allocate tty (must come before -l or -L)
-u	Use UDP
-w	SECONDS timeout to establish connection

Use "stty 115200 -F /dev/ttyS0 && stty raw -echo -ctlecho" with
netcat -f to connect to a serial port.

The command line after -l or -L is executed (as a child process) to handle
each incoming connection. If blank -l waits for a connection and forwards
it to stdin/stdout. If no -p specified, -l prints port it bound to and
backgrounds itself (returning immediately).

For a quick-and-dirty server, try something like:
netcat -s 127.0.0.1 -p 1234 -tL /bin/bash -l
netcat
usage: netcat [-46Ut] [-lL COMMAND...] [-u] [-wpq #] [-s addr] {IPADDR PORTNUM|-f FILENAME}

Forward stdin/stdout to a file or network connection.

-4	Force IPv4
-6	Force IPv6
-L	Listen for multiple incoming connections (server mode)
-U	Use a UNIX domain socket
-W	SECONDS timeout for more data on an idle connection
-f	Use FILENAME (ala /dev/ttyS0) instead of network
-l	Listen for one incoming connection
-p	Local port number
-q	Quit SECONDS after EOF on stdin, even if stdout hasn't closed yet
-s	Local source address
-t	Allocate tty (must come before -l or -L)
-u	Use UDP
-w	SECONDS timeout to establish connection

Use "stty 115200 -F /dev/ttyS0 && stty raw -echo -ctlecho" with
netcat -f to connect to a serial port.

The command line after -l or -L is executed (as a child process) to handle
each incoming connection. If blank -l waits for a connection and forwards
it to stdin/stdout. If no -p specified, -l prints port it bound to and
backgrounds itself (returning immediately).

For a quick-and-dirty server, try something like:
netcat -s 127.0.0.1 -p 1234 -tL /bin/bash -l
netstat
usage: netstat [-pWrxwutneal]

Display networking information. Default is netstat -tuwx

-r	Routing table
-a	All sockets (not just connected)
-l	Listening server sockets
-t	TCP sockets
-u	UDP sockets
-w	Raw sockets
-x	Unix sockets
-e	Extended info
-n	Don't resolve names
-W	Wide display
-p	Show PID/program name of sockets
nice
usage: nice [-n PRIORITY] COMMAND [ARG...]

Run a command line at an increased or decreased scheduling priority.

Higher numbers make a program yield more CPU time, from -20 (highest
priority) to 19 (lowest).  By default processes inherit their parent's
niceness (usually 0).  By default this command adds 10 to the parent's
priority.  Only root can set a negative niceness level.
nl
usage: nl [-E] [-l #] [-b MODE] [-n STYLE] [-s SEPARATOR] [-v #] [-w WIDTH] [FILE...]

Number lines of input.

-E	Use extended regex syntax (when doing -b pREGEX)
-b	Which lines to number: a (all) t (non-empty, default) pREGEX (pattern)
-l	Only count last of this many consecutive blank lines
-n	Number STYLE: ln (left justified) rn (right justified) rz (zero pad)
-s	Separator to use between number and line (instead of TAB)
-v	Starting line number for each section (default 1)
-w	Width of line numbers (default 6)
nohup
usage: nohup COMMAND [ARG...]

Run a command that survives the end of its terminal.

Redirect tty on stdin to /dev/null, tty on stdout to "nohup.out".
nproc
usage: nproc [--all]

Print number of processors.

--all	Show all processors, not just ones this task can run on
nsenter
usage: nsenter [-t pid] [-F] [-i] [-m] [-n] [-p] [-u] [-U] COMMAND...

Run COMMAND in an existing (set of) namespace(s).

-t	PID to take namespaces from    (--target)
-F	don't fork, even if -p is used (--no-fork)

The namespaces to switch are:

-i	SysV IPC: message queues, semaphores, shared memory (--ipc)
-m	Mount/unmount tree (--mount)
-n	Network address, sockets, routing, iptables (--net)
-p	Process IDs and init, will fork unless -F is used (--pid)
-u	Host and domain names (--uts)
-U	UIDs, GIDs, capabilities (--user)

If -t isn't specified, each namespace argument must provide a path
to a namespace file, ala "-i=/proc/$PID/ns/ipc"
od
usage: od [-bcdosxv] [-j #] [-N #] [-w #] [-A doxn] [-t acdfoux[#]]

Dump data in octal/hex.

-A	Address base (decimal, octal, hexadecimal, none)
-j	Skip this many bytes of input
-N	Stop dumping after this many bytes
-t	Output type a(scii) c(har) d(ecimal) f(loat) o(ctal) u(nsigned) (he)x
	plus optional size in bytes
	aliases: -b=-t o1, -c=-t c, -d=-t u2, -o=-t o2, -s=-t d2, -x=-t x2
-v	Don't collapse repeated lines together
-w	Total line width in bytes (default 16)
oneit
usage: oneit [-p] [-c /dev/tty0] command [...]

Simple init program that runs a single supplied command line with a
controlling tty (so CTRL-C can kill it).

-c	Which console device to use (/dev/console doesn't do CTRL-C, etc)
-p	Power off instead of rebooting when command exits
-r	Restart child when it exits
-3	Write 32 bit PID of each exiting reparented process to fd 3 of child
	(Blocking writes, child must read to avoid eventual deadlock.)

Spawns a single child process (because PID 1 has signals blocked)
in its own session, reaps zombies until the child exits, then
reboots the system (or powers off with -p, or restarts the child with -r).

Responds to SIGUSR1 by halting the system, SIGUSR2 by powering off,
and SIGTERM or SIGINT reboot.
partprobe
usage: partprobe DEVICE...

Tell the kernel about partition table changes

Ask the kernel to re-read the partition table on the specified devices.
passwd
usage: passwd [-a ALGO] [-dlu] [USER]

Update user's authentication tokens. Defaults to current user.

-a ALGO	Encryption method (des, md5, sha256, sha512) default: des
-d		Set password to ''
-l		Lock (disable) account
-u		Unlock (enable) account
paste
usage: paste [-s] [-d DELIMITERS] [FILE...]

Merge corresponding lines from each input file.

-d	List of delimiter characters to separate fields with (default is \t)
-s	Sequential mode: turn each input file into one line of output
patch
usage: patch [-d DIR] [-i file] [-p depth] [-Rlsu] [--dry-run]

Apply a unified diff to one or more files.

-d	Modify files in DIR
-i	Input file (default=stdin)
-l	Loose match (ignore whitespace)
-p	Number of '/' to strip from start of file paths (default=all)
-R	Reverse patch
-s	Silent except for errors
-u	Ignored (only handles "unified" diffs)
--dry-run Don't change files, just confirm patch applies

This version of patch only handles unified diffs, and only modifies
a file when all hunks to that file apply.  Patch prints failed hunks
to stderr, and exits with nonzero status if any hunks fail.

A file compared against /dev/null (or with a date <= the epoch) is
created/deleted as appropriate.
pgrep
usage: pgrep [-clfnovx] [-d DELIM] [-L SIGNAL] [PATTERN] [-G GID,] [-g PGRP,] [-P PPID,] [-s SID,] [-t TERM,] [-U UID,] [-u EUID,]

Search for process(es). PATTERN is an extended regular expression checked
against command names.

-c	Show only count of matches
-d	Use DELIM instead of newline
-L	Send SIGNAL instead of printing name
-l	Show command name
-f	Check full command line for PATTERN
-G	Match real Group ID(s)
-g	Match Process Group(s) (0 is current user)
-n	Newest match only
-o	Oldest match only
-P	Match Parent Process ID(s)
-s	Match Session ID(s) (0 for current)
-t	Match Terminal(s)
-U	Match real User ID(s)
-u	Match effective User ID(s)
-v	Negate the match
-x	Match whole command (not substring)
pidof
usage: pidof [-s] [-o omitpid[,omitpid...]] [NAME]...

Print the PIDs of all processes with the given names.

-s	Single shot, only return one pid
-o	Omit PID(s)
-x	Match shell scripts too
ping
usage: ping [OPTIONS] HOST

Check network connectivity by sending packets to a host and reporting
its response.

Send ICMP ECHO_REQUEST packets to ipv4 or ipv6 addresses and prints each
echo it receives back, with round trip time. Returns true if host alive.

Options:
-4, -6		Force IPv4 or IPv6
-c CNT		Send CNT many packets (default 3, 0 = infinite)
-f		Flood (print . and \b to show drops, default -c 15 -i 0.2)
-i TIME		Interval between packets (default 1, need root for < .2)
-I IFACE/IP	Source interface or address
-m MARK		Tag outgoing packets using SO_MARK
-q		Quiet (stops after one returns true if host is alive)
-s SIZE		Data SIZE in bytes (default 56)
-t TTL		Set Time To Live (number of hops)
-W SEC		Seconds to wait for response after last -c packet (default 3)
-w SEC		Exit after this many seconds
ping6
usage: ping [OPTIONS] HOST

Check network connectivity by sending packets to a host and reporting
its response.

Send ICMP ECHO_REQUEST packets to ipv4 or ipv6 addresses and prints each
echo it receives back, with round trip time. Returns true if host alive.

Options:
-4, -6		Force IPv4 or IPv6
-c CNT		Send CNT many packets (default 3, 0 = infinite)
-f		Flood (print . and \b to show drops, default -c 15 -i 0.2)
-i TIME		Interval between packets (default 1, need root for < .2)
-I IFACE/IP	Source interface or address
-m MARK		Tag outgoing packets using SO_MARK
-q		Quiet (stops after one returns true if host is alive)
-s SIZE		Data SIZE in bytes (default 56)
-t TTL		Set Time To Live (number of hops)
-W SEC		Seconds to wait for response after last -c packet (default 3)
-w SEC		Exit after this many seconds
pivot_root
usage: pivot_root OLD NEW

Swap OLD and NEW filesystems (as if by simultaneous mount --move), and
move all processes with chdir or chroot under OLD into NEW (including
kernel threads) so OLD may be unmounted.

The directory NEW must exist under OLD. This doesn't work on initramfs,
which can't be moved (about the same way PID 1 can't be killed; see
switch_root instead).
pkill
usage: pkill [-fnovx] [-SIGNAL|-l SIGNAL] [PATTERN] [-G GID,] [-g PGRP,] [-P PPID,] [-s SID,] [-t TERM,] [-U UID,] [-u EUID,]

-l	Send SIGNAL (default SIGTERM)
-V	Verbose
-f	Check full command line for PATTERN
-G	Match real Group ID(s)
-g	Match Process Group(s) (0 is current user)
-n	Newest match only
-o	Oldest match only
-P	Match Parent Process ID(s)
-s	Match Session ID(s) (0 for current)
-t	Match Terminal(s)
-U	Match real User ID(s)
-u	Match effective User ID(s)
-v	Negate the match
-x	Match whole command (not substring)
pmap
usage: pmap [-xq] [pids...]

Report the memory map of a process or processes.

-x	Show the extended format
-q	Do not display some header/footer lines
poweroff
usage: reboot/halt/poweroff [-fn]

Restart, halt or powerdown the system.

-f	Don't signal init
-n	Don't sync before stopping the system
printenv
usage: printenv [-0] [env_var...]

Print environment variables.

-0	Use \0 as delimiter instead of \n
printf
usage: printf FORMAT [ARGUMENT...]

Format and print ARGUMENT(s) according to FORMAT, using C printf syntax
(% escapes for cdeEfgGiosuxX, \ escapes for abefnrtv0 or \OCTAL or \xHEX).
prlimit
usage: ulimit [-P PID] [-SHRacdefilmnpqrstuv] [LIMIT]

Print or set resource limits for process number PID. If no LIMIT specified
(or read-only -ap selected) display current value (sizes in bytes).
Default is ulimit -P $PPID -Sf" (show soft filesize of your shell).

-S  Set/show soft limit          -H  Set/show hard (maximum) limit
-a  Show all limits              -c  Core file size
-d  Process data segment         -e  Max scheduling priority
-f  Output file size             -i  Pending signal count
-l  Locked memory                -m  Resident Set Size
-n  Number of open files         -p  Pipe buffer
-q  Posix message queue          -r  Max Real-time priority
-R  Realtime latency (usec)      -s  Stack size
-t  Total CPU time (in seconds)  -u  Maximum processes (under this UID)
-v  Virtual memory size          -P  PID to affect (default $PPID)
ps
usage: ps [-AadefLlnwZ] [-gG GROUP,] [-k FIELD,] [-o FIELD,] [-p PID,] [-t TTY,] [-uU USER,]

List processes.

Which processes to show (-gGuUpPt selections may be comma separated lists):

-A  All					-a  Has terminal not session leader
-d  All but session leaders		-e  Synonym for -A
-g  In GROUPs				-G  In real GROUPs (before sgid)
-p  PIDs (--pid)			-P  Parent PIDs (--ppid)
-s  In session IDs			-t  Attached to selected TTYs
-T  Show threads also			-u  Owned by selected USERs
-U  Real USERs (before suid)

Output modifiers:

-k  Sort FIELDs (-FIELD to reverse)	-M  Measure/pad future field widths
-n  Show numeric USER and GROUP		-w  Wide output (don't truncate fields)

Which FIELDs to show. (-o HELP for list, default = -o PID,TTY,TIME,CMD)

-f  Full listing (-o USER:12=UID,PID,PPID,C,STIME,TTY,TIME,ARGS=CMD)
-l  Long listing (-o F,S,UID,PID,PPID,C,PRI,NI,ADDR,SZ,WCHAN,TTY,TIME,CMD)
-o  Output FIELDs instead of defaults, each with optional :size and =title
-O  Add FIELDS to defaults
-Z  Include LABEL
pwd
usage: pwd [-L|-P]

Print working (current) directory.

-L	Use shell's path from $PWD (when applicable)
-P	Print canonical absolute path
pwdx
usage: pwdx PID...

Print working directory of processes listed on command line.
readahead
usage: readahead FILE...

Preload files into disk cache.
readlink
usage: readlink FILE...

With no options, show what symlink points to, return error if not symlink.

Options for producing canonical paths (all symlinks/./.. resolved):

-e	Canonical path to existing entry (fail if missing)
-f	Full path (fail if directory missing)
-m	Ignore missing entries, show where it would be
-n	No trailing newline
-q	Quiet (no output, just error code)
realpath
usage: realpath FILE...

Display the canonical absolute pathname
reboot
usage: reboot/halt/poweroff [-fn]

Restart, halt or powerdown the system.

-f	Don't signal init
-n	Don't sync before stopping the system
renice
usage: renice [-gpu] -n increment ID ...
reset
usage: reset

Reset the terminal.
rev
usage: rev [FILE...]

Output each line reversed, when no files are given stdin is used.
rfkill
usage: rfkill COMMAND [DEVICE]

Enable/disable wireless devices.

Commands:
list [DEVICE]   List current state
block DEVICE    Disable device
unblock DEVICE  Enable device

DEVICE is an index number, or one of:
all, wlan(wifi), bluetooth, uwb(ultrawideband), wimax, wwan, gps, fm.
rm
usage: rm [-fiRrv] FILE...

Remove each argument from the filesystem.

-f	Force: remove without confirmation, no error if it doesn't exist
-i	Interactive: prompt for confirmation
-rR	Recursive: remove directory contents
-v	Verbose
rmdir
usage: rmdir [-p] [dirname...]

Remove one or more directories.

-p	Remove path
--ignore-fail-on-non-empty	Ignore failures caused by non-empty directories
rmmod
usage: rmmod [-wf] [MODULE]

Unload the module named MODULE from the Linux kernel.
-f	Force unload of a module
-w	Wait until the module is no longer used
sed
usage: sed [-inrzE] [-e SCRIPT]...|SCRIPT [-f SCRIPT_FILE]... [FILE...]

Stream editor. Apply one or more editing SCRIPTs to each line of input
(from FILE or stdin) producing output (by default to stdout).

-e	Add SCRIPT to list
-f	Add contents of SCRIPT_FILE to list
-i	Edit each file in place (-iEXT keeps backup file with extension EXT)
-n	No default output (use the p command to output matched lines)
-r	Use extended regular expression syntax
-E	POSIX alias for -r
-s	Treat input files separately (implied by -i)
-z	Use \0 rather than \n as the input line separator

A SCRIPT is a series of one or more COMMANDs separated by newlines or
semicolons. All -e SCRIPTs are concatenated together as if separated
by newlines, followed by all lines from -f SCRIPT_FILEs, in order.
If no -e or -f SCRIPTs are specified, the first argument is the SCRIPT.

Each COMMAND may be preceded by an address which limits the command to
apply only to the specified line(s). Commands without an address apply to
every line. Addresses are of the form:

  [ADDRESS[,ADDRESS]][!]COMMAND

The ADDRESS may be a decimal line number (starting at 1), a /regular
expression/ within a pair of forward slashes, or the character "$" which
matches the last line of input. (In -s or -i mode this matches the last
line of each file, otherwise just the last line of the last file.) A single
address matches one line, a pair of comma separated addresses match
everything from the first address to the second address (inclusive). If
both addresses are regular expressions, more than one range of lines in
each file can match. The second address can be +N to end N lines later.

REGULAR EXPRESSIONS in sed are started and ended by the same character
(traditionally / but anything except a backslash or a newline works).
Backslashes may be used to escape the delimiter if it occurs in the
regex, and for the usual printf escapes (\abcefnrtv and octal, hex,
and unicode). An empty regex repeats the previous one. ADDRESS regexes
(above) require the first delimiter to be escaped with a backslash when
it isn't a forward slash (to distinguish it from the COMMANDs below).

Sed mostly operates on individual lines one at a time. It reads each line,
processes it, and either writes it to the output or discards it before
reading the next line. Sed can remember one additional line in a separate
buffer (using the h, H, g, G, and x commands), and can read the next line
of input early (using the n and N command), but other than that command
scripts operate on individual lines of text.

Each COMMAND starts with a single character. The following commands take
no arguments:

  !  Run this command when the test _didn't_ match.

  {  Start a new command block, continuing until a corresponding "}".
     Command blocks may nest. If the block has an address, commands within
     the block are only run for lines within the block's address range.

  }  End command block (this command cannot have an address)

  d  Delete this line and move on to the next one
     (ignores remaining COMMANDs)

  D  Delete one line of input and restart command SCRIPT (same as "d"
     unless you've glued lines together with "N" or similar)

  g  Get remembered line (overwriting current line)

  G  Get remembered line (appending to current line)

  h  Remember this line (overwriting remembered line)

  H  Remember this line (appending to remembered line, if any)

  l  Print line, escaping \abfrtv (but not newline), octal escaping other
     nonprintable characters, wrapping lines to terminal width with a
     backslash, and appending $ to actual end of line.

  n  Print default output and read next line, replacing current line
     (If no next line available, quit processing script)

  N  Append next line of input to this line, separated by a newline
     (This advances the line counter for address matching and "=", if no
     next line available quit processing script without default output)

  p  Print this line

  P  Print this line up to first newline (from "N")

  q  Quit (print default output, no more commands processed or lines read)

  x  Exchange this line with remembered line (overwrite in both directions)

  =  Print the current line number (followed by a newline)

The following commands (may) take an argument. The "text" arguments (to
the "a", "b", and "c" commands) may end with an unescaped "\" to append
the next line (for which leading whitespace is not skipped), and also
treat ";" as a literal character (use "\;" instead).

  a [text]   Append text to output before attempting to read next line

  b [label]  Branch, jumps to :label (or with no label, to end of SCRIPT)

  c [text]   Delete line, output text at end of matching address range
             (ignores remaining COMMANDs)

  i [text]   Print text

  r [file]   Append contents of file to output before attempting to read
             next line.

  s/S/R/F    Search for regex S, replace matched text with R using flags F.
             The first character after the "s" (anything but newline or
             backslash) is the delimiter, escape with \ to use normally.

             The replacement text may contain "&" to substitute the matched
             text (escape it with backslash for a literal &), or \1 through
             \9 to substitute a parenthetical subexpression in the regex.
             You can also use the normal backslash escapes such as \n and
             a backslash at the end of the line appends the next line.

             The flags are:

             [0-9]    A number, substitute only that occurrence of pattern
             g        Global, substitute all occurrences of pattern
             i        Ignore case when matching
             p        Print the line if match was found and replaced
             w [file] Write (append) line to file if match replaced

  t [label]  Test, jump to :label only if an "s" command found a match in
             this line since last test (replacing with same text counts)

  T [label]  Test false, jump only if "s" hasn't found a match.

  w [file]   Write (append) line to file

  y/old/new/ Change each character in 'old' to corresponding character
             in 'new' (with standard backslash escapes, delimiter can be
             any repeated character except \ or \n)

  : [label]  Labeled target for jump commands

  #  Comment, ignore rest of this line of SCRIPT

Deviations from POSIX: allow extended regular expressions with -r,
editing in place with -i, separate with -s, NUL-separated input with -z,
printf escapes in text, line continuations, semicolons after all commands,
2-address anywhere an address is allowed, "T" command, multiline
continuations for [abc], \; to end [abc] argument before end of line.
seq
usage: seq [-w|-f fmt_str] [-s sep_str] [first] [increment] last

Count from first to last, by increment. Omitted arguments default
to 1. Two arguments are used as first and last. Arguments can be
negative or floating point.

-f	Use fmt_str as a printf-style floating point format string
-s	Use sep_str as separator, default is a newline character
-w	Pad to equal width with leading zeroes
setfattr
usage: setfattr [-h] [-x|-n NAME] [-v VALUE] FILE...

Write POSIX extended attributes.

-h	Do not dereference symlink
-n	Set given attribute
-x	Remove given attribute
-v	Set value for attribute -n (default is empty)
setsid
usage: setsid [-t] command [args...]

Run process in a new session.

-t	Grab tty (become foreground process, receiving keyboard signals)
sha1sum
usage: sha?sum [-bcs] [FILE]...

Calculate sha hash for each input file, reading from stdin if none. Output
one hash (40 hex digits for sha1, 56 for sha224, 64 for sha256, 96 for sha384,
and 128 for sha512) for each input file, followed by filename.

-b	Brief (hash only, no filename)
-c	Check each line of each FILE is the same hash+filename we'd output
-s	No output, exit status 0 if all hashes match, 1 otherwise
shred
usage: shred [-fuz] [-n COUNT] [-s SIZE] FILE...

Securely delete a file by overwriting its contents with random data.

-f		Force (chmod if necessary)
-n COUNT	Random overwrite iterations (default 1)
-o OFFSET	Start at OFFSET
-s SIZE		Use SIZE instead of detecting file size
-u		Unlink (actually delete file when done)
-x		Use exact size (default without -s rounds up to next 4k)
-z		Zero at end

Note: data journaling filesystems render this command useless, you must
overwrite all free space (fill up disk) to erase old data on those.
sleep
usage: sleep DURATION

Wait before exiting.

DURATION can be a decimal fraction. An optional suffix can be "m"
(minutes), "h" (hours), "d" (days), or "s" (seconds, the default).
sntp
usage: sntp [-saSdDqm] [-r SHIFT] [-m ADDRESS] [-p PORT] [SERVER]

Simple Network Time Protocol client. Query SERVER and display time.

-p	Use PORT (default 123)
-s	Set system clock suddenly
-a	Adjust system clock gradually
-S	Serve time instead of querying (bind to SERVER address if specified)
-m	Wait for updates from multicast ADDRESS (RFC 4330 says use 224.0.1.1)
-M	Multicast server on ADDRESS
-d	Daemonize (run in background re-querying )
-D	Daemonize but stay in foreground: re-query time every 1000 seconds
-r	Retry shift (every 1<

sort
usage: sort [-Mbcdfginrsuz] [FILE...] [-k#[,#[x]] [-t X]] [-o FILE]

Sort all lines of text from input files (or stdin) to stdout.
-M	Month sort (jan, feb, etc)
-V	Version numbers (name-1.234-rc6.5b.tgz)
-b	Ignore leading blanks (or trailing blanks in second part of key)
-c	Check whether input is sorted
-d	Dictionary order (use alphanumeric and whitespace chars only)
-f	Force uppercase (case insensitive sort)
-g	General numeric sort (double precision with nan and inf)
-i	Ignore nonprinting characters
-k	Sort by "key" (see below)
-n	Numeric order (instead of alphabetical)
-o	Output to FILE instead of stdout
-r	Reverse
-s	Skip fallback sort (only sort with keys)
-t	Use a key separator other than whitespace
-u	Unique lines only
-x	Hexadecimal numerical sort
-z	Zero (null) terminated lines

Sorting by key looks at a subset of the words on each line. -k2 uses the
second word to the end of the line, -k2,2 looks at only the second word,
-k2,4 looks from the start of the second to the end of the fourth word.
-k2.4,5 starts from the fourth character of the second word, to the end
of the fifth word. Specifying multiple keys uses the later keys as tie
breakers, in order. A type specifier appended to a sort key (such as -2,2n)
applies only to sorting that key.
split
usage: split [-a SUFFIX_LEN] [-b BYTES] [-l LINES] [INPUT [OUTPUT]]

Copy INPUT (or stdin) data to a series of OUTPUT (or "x") files with
alphabetically increasing suffix (aa, ab, ac... az, ba, bb...).

-a	Suffix length (default 2)
-b	BYTES/file (10, 10k, 10m, 10g...)
-l	LINES/file (default 1000)
stat
usage: stat [-tfL] [-c FORMAT] FILE...

Display status of files or filesystems.

-c	Output specified FORMAT string instead of default
-f	Display filesystem status instead of file status
-L	Follow symlinks
-t	terse (-c "%n %s %b %f %u %g %D %i %h %t %T %X %Y %Z %o")
	      (with -f = -c "%n %i %l %t %s %S %b %f %a %c %d")

The valid format escape sequences for files:
%a  Access bits (octal) |%A  Access bits (flags)|%b  Size/512
%B  Bytes per %b (512)  |%C  Security context   |%d  Device ID (dec)
%D  Device ID (hex)     |%f  All mode bits (hex)|%F  File type
%g  Group ID            |%G  Group name         |%h  Hard links
%i  Inode               |%m  Mount point        |%n  Filename
%N  Long filename       |%o  I/O block size     |%s  Size (bytes)
%t  Devtype major (hex) |%T  Devtype minor (hex)|%u  User ID
%U  User name           |%x  Access time        |%X  Access unix time
%y  Modification time   |%Y  Mod unix time      |%z  Creation time
%Z  Creation unix time

The valid format escape sequences for filesystems:
%a  Available blocks    |%b  Total blocks       |%c  Total inodes
%d  Free inodes         |%f  Free blocks        |%i  File system ID
%l  Max filename length |%n  File name          |%s  Fragment size
%S  Best transfer size  |%t  FS type (hex)      |%T  FS type (driver name)
strings
usage: strings [-fo] [-t oxd] [-n LEN] [FILE...]

Display printable strings in a binary file

-f	Show filename
-n	At least LEN characters form a string (default 4)
-o	Show offset (ala -t d)
-t	Show offset type (o=octal, d=decimal, x=hexadecimal)
su
usage: su [-lp] [-u UID] [-g GID,...] [-s SHELL] [-c CMD] [USER [COMMAND...]]

Switch user, prompting for password of new user when not run as root.

With one argument, switch to USER and run user's shell from /etc/passwd.
With no arguments, USER is root. If COMMAND line provided after USER,
exec() it as new USER (bypasing shell). If -u or -g specified, first
argument (if any) isn't USER (it's COMMAND).

first argument is USER name to switch to (which must exist).
Non-root users are prompted for new user's password.

-s	Shell to use (default is user's shell from /etc/passwd)
-c	Command line to pass to -s shell (ala sh -c "CMD")
-l	Reset environment as if new login.
-u	Switch to UID instead of USER
-g	Switch to GID (only root allowed, can be comma separated list)
-p	Preserve environment (except for $PATH and $IFS)
swapoff
usage: swapoff swapregion

Disable swapping on a given swapregion.
swapon
usage: swapon [-d] [-p priority] filename

Enable swapping on a given device/file.

-d	Discard freed SSD pages
-p	Priority (highest priority areas allocated first)
switch_root
usage: switch_root [-c /dev/console] NEW_ROOT NEW_INIT...

Use from PID 1 under initramfs to free initramfs, chroot to NEW_ROOT,
and exec NEW_INIT.

-c	Redirect console to device in NEW_ROOT
-h	Hang instead of exiting on failure (avoids kernel panic)
sync
usage: sync

Write pending cached data to disk (synchronize), blocking until done.
sysctl
usage: sysctl [-aAeNnqw] [-p [FILE] | KEY[=VALUE]...]

Read/write system control data (under /proc/sys).

-a,A	Show all values
-e	Don't warn about unknown keys
-N	Don't print key values
-n	Don't print key names
-p	Read values from FILE (default /etc/sysctl.conf)
-q	Don't show value after write
-w	Only write values (object to reading)
tac
usage: tac [FILE...]

Output lines in reverse order.
tail
usage: tail [-n|c NUMBER] [-f] [FILE...]

Copy last lines from files to stdout. If no files listed, copy from
stdin. Filename "-" is a synonym for stdin.

-n	Output the last NUMBER lines (default 10), +X counts from start
-c	Output the last NUMBER bytes, +NUMBER counts from start
-f	Follow FILE(s), waiting for more data to be appended
tar
usage: tar [-cxt] [-fvohmjkOS] [-XTCf NAME] [FILES]

Create, extract, or list files in a .tar (or compressed t?z) file.

Options:
c  Create                x  Extract               t  Test (list)
f  tar FILE (default -)  C  Change to DIR first   v  Verbose display
o  Ignore owner          h  Follow symlinks       m  Ignore mtime
J  xz compression        j  bzip2 compression     z  gzip compression
O  Extract to stdout     X  exclude names in FILE T  include names in FILE

--exclude        FILENAME to exclude    --full-time   Show seconds with -tv
--mode MODE      Adjust modes           --mtime TIME  Override timestamps
--owner NAME     Set file owner to NAME --group NAME  Set file group to NAME
--sparse         Record sparse files
--restrict       All archive contents must extract under one subdirctory
--numeric-owner  Save/use/display uid and gid, not user/group name
--no-recursion   Don't store directory contents
taskset
usage: taskset [-ap] [mask] [PID | cmd [args...]]

Launch a new task which may only run on certain processors, or change
the processor affinity of an existing PID.

Mask is a hex string where each bit represents a processor the process
is allowed to run on. PID without a mask displays existing affinity.

-p	Set/get the affinity of given PID instead of a new command
-a	Set/get the affinity of all threads of the PID
tee
usage: tee [-ai] [file...]

Copy stdin to each listed file, and also to stdout.
Filename "-" is a synonym for stdout.

-a	Append to files
-i	Ignore SIGINT
test
usage: test [-bcdefghLPrSsuwx PATH] [-nz STRING] [-t FD] [X ?? Y]

Return true or false by performing tests. (With no arguments return false.)

--- Tests with a single argument (after the option):
PATH is/has:
  -b  block device   -f  regular file   -p  fifo           -u  setuid bit
  -c  char device    -g  setgid         -r  read bit       -w  write bit
  -d  directory      -h  symlink        -S  socket         -x  execute bit
  -e  exists         -L  symlink        -s  nonzero size
STRING is:
  -n  nonzero size   -z  zero size      (STRING by itself implies -n)
FD (integer file descriptor) is:
  -t  a TTY

--- Tests with one argument on each side of an operator:
Two strings:
  =  are identical   !=  differ
Two integers:
  -eq  equal         -gt  first > second    -lt  first < second
  -ne  not equal     -ge  first >= second   -le  first <= second

--- Modify or combine tests:
  ! EXPR     not (swap true/false)   EXPR -a EXPR    and (are both true)
  ( EXPR )   evaluate this first     EXPR -o EXPR    or (is either true)
time
usage: time [-pv] COMMAND [ARGS...]

Run command line and report real, user, and system time elapsed in seconds.
(real = clock on the wall, user = cpu used by command's code,
system = cpu used by OS on behalf of command.)

-p	POSIX format output (default)
-v	Verbose
timeout
usage: timeout [-k DURATION] [-s SIGNAL] DURATION COMMAND...

Run command line as a child process, sending child a signal if the
command doesn't exit soon enough.

DURATION can be a decimal fraction. An optional suffix can be "m"
(minutes), "h" (hours), "d" (days), or "s" (seconds, the default).

-s	Send specified signal (default TERM)
-k	Send KILL signal if child still running this long after first signal
-v	Verbose
--foreground       Don't create new process group
--preserve-status  Exit with the child's exit status
top
usage: top [-Hbq] [-k FIELD,] [-o FIELD,] [-s SORT] [-n NUMBER] [-m LINES] [-d SECONDS] [-p PID,] [-u USER,]

Show process activity in real time.

-H	Show threads
-k	Fallback sort FIELDS (default -S,-%CPU,-ETIME,-PID)
-o	Show FIELDS (def PID,USER,PR,NI,VIRT,RES,SHR,S,%CPU,%MEM,TIME+,CMDLINE)
-O	Add FIELDS (replacing PR,NI,VIRT,RES,SHR,S from default)
-s	Sort by field number (1-X, default 9)
-b	Batch mode (no tty)
-d	Delay SECONDS between each cycle (default 3)
-m	Maximum number of tasks to show
-n	Exit after NUMBER iterations
-p	Show these PIDs
-u	Show these USERs
-q	Quiet (no header lines)

Cursor LEFT/RIGHT to change sort, UP/DOWN move list, space to force
update, R to reverse sort, Q to exit.
touch
usage: touch [-amch] [-d DATE] [-t TIME] [-r FILE] FILE...

Update the access and modification times of each FILE to the current time.

-a	Change access time
-m	Change modification time
-c	Don't create file
-h	Change symlink
-d	Set time to DATE (in YYYY-MM-DDThh:mm:SS[.frac][tz] format)
-t	Set time to TIME (in [[CC]YY]MMDDhhmm[.ss][frac] format)
-r	Set time same as reference FILE
true
Return zero.
truncate
usage: truncate [-c] -s SIZE file...

Set length of file(s), extending sparsely if necessary.

-c	Don't create file if it doesn't exist
-s	New size (with optional prefix and suffix)

SIZE prefix: + add, - subtract, < shrink to, > expand to,
             / multiple rounding down, % multiple rounding up
SIZE suffix: k=1024, m=1024^2, g=1024^3, t=1024^4, p=1024^5, e=1024^6
tty
usage: tty [-s]

Show filename of terminal connected to stdin.

Prints "not a tty" and exits with nonzero status if no terminal
is connected to stdin.

-s	Silent, exit code only
tunctl
usage: tunctl [-dtT] [-u USER] NAME

Create and delete tun/tap virtual ethernet devices.

-T	Use tap (ethernet frames) instead of tun (ip packets)
-d	Delete tun/tap device
-t	Create tun/tap device
-u	Set owner (user who can read/write device without root access)
ulimit
usage: ulimit [-P PID] [-SHRacdefilmnpqrstuv] [LIMIT]

Print or set resource limits for process number PID. If no LIMIT specified
(or read-only -ap selected) display current value (sizes in bytes).
Default is ulimit -P $PPID -Sf" (show soft filesize of your shell).

-S  Set/show soft limit          -H  Set/show hard (maximum) limit
-a  Show all limits              -c  Core file size
-d  Process data segment         -e  Max scheduling priority
-f  Output file size             -i  Pending signal count
-l  Locked memory                -m  Resident Set Size
-n  Number of open files         -p  Pipe buffer
-q  Posix message queue          -r  Max Real-time priority
-R  Realtime latency (usec)      -s  Stack size
-t  Total CPU time (in seconds)  -u  Maximum processes (under this UID)
-v  Virtual memory size          -P  PID to affect (default $PPID)
umount
usage: umount [-a [-t TYPE[,TYPE...]]] [-vrfD] [DIR...]

Unmount the listed filesystems.

-a	Unmount all mounts in /proc/mounts instead of command line list
-D	Don't free loopback device(s)
-f	Force unmount
-l	Lazy unmount (detach from filesystem now, close when last user does)
-n	Don't use /proc/mounts
-r	Remount read only if unmounting fails
-t	Restrict "all" to mounts of TYPE (or use "noTYPE" to skip)
-v	Verbose
uname
usage: uname [-asnrvm]

Print system information.

-s	System name
-n	Network (domain) name
-r	Kernel Release number
-v	Kernel Version
-m	Machine (hardware) name
-a	All of the above
uniq
usage: uniq [-cduiz] [-w maxchars] [-f fields] [-s char] [input_file [output_file]]

Report or filter out repeated lines in a file

-c	Show counts before each line
-d	Show only lines that are repeated
-u	Show only lines that are unique
-i	Ignore case when comparing lines
-z	Lines end with \0 not \n
-w	Compare maximum X chars per line
-f	Ignore first X fields
-s	Ignore first X chars
unix2dos
usage: unix2dos [FILE...]

Convert newline format from unix "\n" to dos "\r\n".
If no files listed copy from stdin, "-" is a synonym for stdin.
unlink
usage: unlink FILE

Delete one file.
unshare
usage: unshare [-imnpuUr] COMMAND...

Create new container namespace(s) for this process and its children, so
some attribute is not shared with the parent process.

-f	Fork command in the background (--fork)
-i	SysV IPC (message queues, semaphores, shared memory) (--ipc)
-m	Mount/unmount tree (--mount)
-n	Network address, sockets, routing, iptables (--net)
-p	Process IDs and init (--pid)
-r	Become root (map current euid/egid to 0/0, implies -U) (--map-root-user)
-u	Host and domain names (--uts)
-U	UIDs, GIDs, capabilities (--user)

A namespace allows a set of processes to have a different view of the
system than other sets of processes.
uptime
usage: uptime [-ps]

Tell the current time, how long the system has been running, the number
of users, and the system load averages for the past 1, 5 and 15 minutes.

-p	Pretty (human readable) uptime
-s	Since when has the system been up?
usleep
usage: usleep MICROSECONDS

Pause for MICROSECONDS microseconds.
uudecode
usage: uudecode [-o OUTFILE] [INFILE]

Decode file from stdin (or INFILE).

-o	Write to OUTFILE instead of filename in header
uuencode
usage: uuencode [-m] [file] encode-filename

Uuencode stdin (or file) to stdout, with encode-filename in the output.

-m	Base64
uuidgen
usage: uuidgen

Create and print a new RFC4122 random UUID.
vconfig
usage: vconfig COMMAND [OPTIONS]

Create and remove virtual ethernet devices

add             [interface-name] [vlan_id]
rem             [vlan-name]
set_flag        [interface-name] [flag-num]       [0 | 1]
set_egress_map  [vlan-name]      [skb_priority]   [vlan_qos]
set_ingress_map [vlan-name]      [skb_priority]   [vlan_qos]
set_name_type   [name-type]
vmstat
usage: vmstat [-n] [DELAY [COUNT]]

Print virtual memory statistics, repeating each DELAY seconds, COUNT times.
(With no DELAY, prints one line. With no COUNT, repeats until killed.)

Show processes running and blocked, kilobytes swapped, free, buffered, and
cached, kilobytes swapped in and out per second, file disk blocks input and
output per second, interrupts and context switches per second, percent
of CPU time spent running user code, system code, idle, and awaiting I/O.
First line is since system started, later lines are since last line.

-n	Display the header only once
w
usage: w

Show who is logged on and since how long they logged in.
watch
usage: watch [-teb] [-n SEC] PROG ARGS

Run PROG every -n seconds, showing output. Hit q to quit.

-n	Loop period in seconds (default 2)
-t	Don't print header
-e	Exit on error
-b	Beep on command error
-x	Exec command directly (vs "sh -c")
wc
usage: wc -lwcm [FILE...]

Count lines, words, and characters in input.

-l	Show lines
-w	Show words
-c	Show bytes
-m	Show characters

By default outputs lines, words, bytes, and filename for each
argument (or from stdin if none). Displays only either bytes
or characters.
which
usage: which [-a] filename ...

Search $PATH for executable files matching filename(s).

-a	Show all matches
who
usage: who

Print information about logged in users.
whoami
usage: logname

Print the current user name.
xargs
usage: xargs [-0prt] [-s NUM] [-n NUM] [-E STR] COMMAND...

Run command line one or more times, appending arguments from stdin.

If COMMAND exits with 255, don't launch another even if arguments remain.

-0	Each argument is NULL terminated, no whitespace or quote processing
-E	Stop at line matching string
-n	Max number of arguments per command
-o	Open tty for COMMAND's stdin (default /dev/null)
-p	Prompt for y/n from tty before running each command
-r	Don't run command with empty input (otherwise always run command once)
-s	Size in bytes per command line
-t	Trace, print command line to stderr
xxd
usage: xxd [-c n] [-g n] [-i] [-l n] [-o n] [-p] [-r] [-s n] [file]

Hexdump a file to stdout.  If no file is listed, copy from stdin.
Filename "-" is a synonym for stdin.

-c n	Show n bytes per line (default 16)
-g n	Group bytes by adding a ' ' every n bytes (default 2)
-i	Include file output format (comma-separated hex byte literals)
-l n	Limit of n bytes before stopping (default is no limit)
-o n	Add n to display offset
-p	Plain hexdump (30 bytes/line, no grouping)
-r	Reverse operation: turn a hexdump into a binary file
-s n	Skip to offset n
yes
usage: yes [args...]

Repeatedly output line until killed. If no args, output 'y'.
zcat
usage: zcat [FILE...]

Decompress files to stdout. Like `gzip -dc`.

-f	Force: allow read from tty
```