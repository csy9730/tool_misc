# size
```
Usage: size [option(s)] [file(s)]
 Displays the sizes of sections inside binary files
 If no input file(s) are specified, a.out is assumed
 The options are:
  -A|-B     --format={sysv|berkeley}  Select output style (default is berkeley)
  -o|-d|-x  --radix={8|10|16}         Display numbers in octal, decimal or hex
  -t        --totals                  Display the total sizes (Berkeley only)
            --common                  Display total size for *COM* syms
            --target=<bfdname>        Set the binary file format
            @<file>                   Read options from <file>
  -h        --help                    Display this information
  -v        --version                 Display the program's version

size: supported targets: pe-x86-64 pei-x86-64 pe-bigobj-x86-64 elf64-x86-64 elf64-l1om elf64-k1om pe-i386 pei-i386 elf32-i386 elf32-iamcu elf64-little elf64-big elf32-little elf32-big plugin srec symbolsrec verilog tekhex binary ihex
Report bugs to <http://www.sourceware.org/bugzilla/>
```
