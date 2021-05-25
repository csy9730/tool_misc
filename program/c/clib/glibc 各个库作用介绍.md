# glibc 各个库作用介绍



| **Library component**                                        | **Content**                                                  | **Inclusion guidelines**                                     |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| **ld**(This library component is not itself a library. Instead, ld.so is an executable invoked by the ELF binary format loader to load the dynamically linked libraries into an application’s memory space.) | Dynamic linker.                                              | Compulsory. Needed to use any shared libraries.Theoretically not necessary if using only a staticallybuilt root filesystem—although this is quite rare,unless you are only using BusyBox, for example. |
| **libBrokenLocale**                                          | Fixup routines to get applications that havebroken locale features to run. Overrides applicationdefaults through preloading. (Need touse LD_PRELOAD.) | Rarely used.                                                 |
| **libSegFault**                                              | Routines for catching segmentation faults anddoing backtraces. | Rarely used.                                                 |
| **libanl**                                                   | Asynchronous name lookup routines.                           | Rarely used.                                                 |
| **libbsd-compat**                                            | Dummy library for certain BSD programs thatare compiled with -lbsd-compat. | Rarely used.                                                 |
| **libc**                                                     | Main C library routines                                      | Compulsory.                                                  |
| **libcrypt**                                                 | Cryptography routines.                                       | Required for most applications involved inauthentication.    |
| **libdl**                                                    | Routines for loading shared objectsdynamically               | Required for applications that use functions such asdlopen(). |
| **libm**                                                     | Math routines.                                               | Required for math functions.                                 |
| **libmemusage**                                              | Routines for heap and stack memory profiling.                | Rarely used.                                                 |
| **libnsl**                                                   | NIS network services library routines.                       | Rarely used.                                                 |
| **libnss_compat**                                            | Name Switch Service (NSS) compatibility routines for NIS.    | Loaded automatically by the glibc NSS                        |
| **libnss_dns**                                               | NSS routines for DNS.                                        | Loaded automatically by the glibc NSS                        |
| **libnss_files**                                             | NSS routines for file lookups.                               | Loaded automatically by the glibc NSS                        |
| **libnss_hesiod**                                            | NSS routines for Hesiod name service.                        | Loaded automatically by the glibc NSS                        |
| **libnss_nis**                                               | NSS routines for NIS.                                        | Loaded automatically by the glibc NSS                        |
| **libnss_nisplus**                                           | NSS routines for NIS plus.                                   | Loaded automatically by the glibc NSS                        |
| **libpcprofile**                                             | Program counter profiling routines                           | Rarely used.                                                 |
| **libpthread**                                               | POSIX 1003.1c threads routines for Linux.                    | Required for threads programming.                            |
| **libresolv**                                                | Name resolver routines.                                      | Required for name resolution.                                |
| **librt**                                                    | Asynchronous I/O routines.                                   | Rarely used.                                                 |
| **libthread_db**                                             | Thread debugging routines.                                   | Loaded automatically by gdb when debugging threadedapplications. Never actually linked to by anyapplication. |
| **libutil**                                                  | Login routines, part of the user accounting database.        | Required for terminal connection management.                 |

from

 <<Building Embedded Linux Systems

\>>