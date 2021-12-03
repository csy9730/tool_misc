# cc1plus

cc1plus

> What is the difference between the two,

The `g++` is a compiler driver. It knows how to invoke the actual compiler (`cc1plus`), assembler and linker. It does *not* know how to parse or compile the sources.

> and should I ever call cc1plus directly?

No.


## help
```
The following options are specific to just the language Ada:
 None found.  Use --help=Ada to show *all* the options supported by the Ada front-end.

The following options are specific to just the language AdaSCIL:
 None found.  Use --help=AdaSCIL to show *all* the options supported by the AdaSCIL front-end.

The following options are specific to just the language AdaWhy:
 None found.  Use --help=AdaWhy to show *all* the options supported by the AdaWhy front-end.

The following options are specific to just the language C:
 None found.  Use --help=C to show *all* the options supported by the C front-end.

The following options are specific to just the language C++:
  -Wplacement-new             		
  -Wplacement-new=            		0xffffffff

The following options are specific to just the language Fortran:
  -J<directory>               		
  -Waliasing                  		[disabled]
  -Walign-commons             		[enabled]
  -Wampersand                 		[disabled]
  -Warray-temporaries         		[disabled]
  -Wc-binding-type            		[disabled]
  -Wcharacter-truncation      		[disabled]
  -Wcompare-reals             		[disabled]
  -Wconversion-extra          		[disabled]
  -Wextra                     		[disabled]
  -Wfunction-elimination      		[disabled]
  -Wimplicit-interface        		[disabled]
  -Wimplicit-procedure        		[disabled]
  -Winteger-division          		[disabled]
  -Wintrinsic-shadow          		[disabled]
  -Wintrinsics-std            		[disabled]
  -Wline-truncation           		[enabled]
  -Wreal-q-constant           		[disabled]
  -Wrealloc-lhs               		[disabled]
  -Wrealloc-lhs-all           		[disabled]
  -Wsurprising                		[disabled]
  -Wtabs                      		[disabled]
  -Wtarget-lifetime           		[disabled]
  -Wunderflow                 		[enabled]
  -Wunused-dummy-argument     		[disabled]
  -Wuse-without-only          		[disabled]
  -Wzerotrip                  		[disabled]
  -cpp                        		
  -faggressive-function-elimination 	[disabled]
  -falign-commons             		[enabled]
  -fall-intrinsics            		[disabled]
  -fautomatic                 		[enabled]
  -fbackslash                 		[disabled]
  -fbacktrace                 		[enabled]
  -fblas-matmul-limit=<n>     		0x1e
  -fcheck-array-temporaries   		
  -fcheck=[...]               		
  -fcoarray=<none|single|lib> 		none
  -fconvert=                  		native
  -fcray-pointer              		[disabled]
  -fd-lines-as-code           		
  -fd-lines-as-comments       		
  -fdec                       		
  -fdec-structure             		
  -fdefault-double-8          		[disabled]
  -fdefault-integer-8         		[disabled]
  -fdefault-real-8            		[disabled]
  -fdollar-ok                 		[disabled]
  -fdump-core                 		
  -fdump-fortran-optimized    		[disabled]
  -fdump-fortran-original     		[disabled]
  -fdump-parse-tree           		
  -fexternal-blas             		[disabled]
  -ff2c                       		[disabled]
  -ffixed-form                		
  -ffixed-line-length-<n>     		0x48
  -ffixed-line-length-none    		[disabled]
  -ffpe-summary=[...]         		
  -ffpe-trap=[...]            		
  -ffree-form                 		
  -ffree-line-length-<n>      		0x84
  -ffree-line-length-none     		[disabled]
  -ffrontend-optimize         		[enabled]
  -fimplicit-none             		[disabled]
  -finit-character=<n>        		
  -finit-integer=<n>          		
  -finit-local-zero           		
  -finit-logical=<true|false> 		
  -finit-real=<zero|snan|nan|inf|-inf> 	[default]
  -finline-matmul-limit=<n>   		0xffffffff
  -finteger-4-integer-8       		[disabled]
  -fintrinsic-modules-path    		
  -fintrinsic-modules-path=   		
  -fmax-array-constructor=<n> 		0xffff
  -fmax-identifier-length=<n> 		
  -fmax-stack-var-size=<n>    		0xfffffffe
  -fmax-subrecord-length=<n>  		0
  -fmodule-private            		[disabled]
  -fpack-derived              		[disabled]
  -fprotect-parens            		[enabled]
  -frange-check               		[enabled]
  -freal-4-real-10            		[disabled]
  -freal-4-real-16            		[disabled]
  -freal-4-real-8             		[disabled]
  -freal-8-real-10            		[disabled]
  -freal-8-real-16            		[disabled]
  -freal-8-real-4             		[disabled]
  -frealloc-lhs               		[enabled]
  -frecord-marker=4           		[disabled]
  -frecord-marker=8           		[disabled]
  -frecursive                 		[disabled]
  -frepack-arrays             		[disabled]
  -fsecond-underscore         		[enabled]
  -fsign-zero                 		[enabled]
  -fstack-arrays              		[enabled]
  -funderscoring              		[enabled]
  -fwhole-file                		
  -nocpp                      		
  -static-libgfortran         		
  -std=f2003                  		
  -std=f2008                  		
  -std=f2008ts                		
  -std=f95                    		
  -std=gnu                    		
  -std=legacy                 		

The following options are specific to just the language Go:
  -fgo-check-divide-overflow  		[enabled]
  -fgo-check-divide-zero      		[enabled]
  -fgo-dump-<type>            		
  -fgo-optimize-<type>        		
  -fgo-pkgpath=<string>       		
  -fgo-prefix=<string>        		
  -fgo-relative-import-path=  		
  -frequire-return-statement  		[enabled]

The following options are specific to just the language Java:
  -Wextraneous-semicolon      		[disabled]
  -Wout-of-date               		[enabled]
  -Wredundant-modifiers       		[disabled]
  -Wunused-label              		[disabled]
  		                          		
  -fassert                    		[enabled]
  --bootclasspath=<path>      		
  -fbootstrap-classes         		[disabled]
  -fcheck-references          		[disabled]
  --classpath=<path>          		
  -femit-class-file           		[disabled]
  -femit-class-files          		[disabled]
  --encoding=<encoding>       		
  --extdirs=<path>            		
  -ffilelist-file             		[disabled]
  -fforce-classes-archive-check 	[disabled]
  -fhash-synchronization      		[disabled]
  -findirect-classes          		[enabled]
  -findirect-dispatch         		[disabled]
  -finline-functions          		[disabled]
  -fjni                       		[disabled]
  -foptimize-static-class-initialization 	[disabled]
  -freduced-reflection        		[disabled]
  -fsource=                   		
  -fstore-check               		[enabled]
  -ftarget=                   		
  -fuse-atomic-builtins       		[disabled]
  -fuse-boehm-gc              		[disabled]
  -fuse-divide-subroutine     		[enabled]
  -version                    		[disabled]

The following options are specific to just the language LTO:
  -flinker-output=            		unknown
  -fltrans                    		[disabled]
  -fltrans-output-list=       		
  -fresolution=               		
  -fwpa                       		
  -fwpa=                      		

The following options are specific to just the language ObjC:
 None found.  Use --help=ObjC to show *all* the options supported by the ObjC front-end.

The following options are specific to just the language ObjC++:
  -fobjc-call-cxx-cdtors      		[disabled]

The following options are language-related:
  -A<question>=<answer>       		
  -C                          		
  -CC                         		
  -D<macro>[=<val>]           		
  -F <dir>                    		
  -H                          		
  -I <dir>                    		
  -M                          		
  -MD                         		
  -MF <file>                  		
  -MG                         		
  -MM                         		
  -MMD                        		
  -MP                         		
  -MQ <target>                		
  -MT <target>                		
  -P                          		
  -U<macro>                   		
  -Wabi                       		[disabled]
  -Wabi-tag                   		[disabled]
  -Wabi=                      		
  -Waddress                   		[disabled]
  -Wall                       		
  -Wassign-intercept          		[disabled]
  -Wbad-function-cast         		[disabled]
  -Wbool-compare              		[disabled]
  -Wbuiltin-macro-redefined   		[enabled]
  -Wc++-compat                		[disabled]
  -Wc++11-compat              		[disabled]
  -Wc++14-compat              		[disabled]
  -Wc90-c99-compat            		[enabled]
  -Wc99-c11-compat            		[enabled]
  -Wcast-qual                 		[disabled]
  -Wchar-subscripts           		[disabled]
  -Wchkp                      		[disabled]
  -Wclobbered                 		[disabled]
  -Wcomment                   		[disabled]
  -Wcomments                  		
  -Wconditionally-supported   		[disabled]
  -Wconversion                		[disabled]
  -Wconversion-null           		[enabled]
  -Wcpp                       		[enabled]
  -Wctor-dtor-privacy         		[disabled]
  -Wdate-time                 		[disabled]
  -Wdeclaration-after-statement 	[enabled]
  -Wdelete-incomplete         		[enabled]
  -Wdelete-non-virtual-dtor   		[disabled]
  -Wdeprecated                		[enabled]
  -Wdesignated-init           		[enabled]
  -Wdiscarded-array-qualifiers 		[enabled]
  -Wdiscarded-qualifiers      		[enabled]
  -Wdiv-by-zero               		[enabled]
  -Wdouble-promotion          		[disabled]
  -Wduplicated-cond           		[disabled]
  -Weffc++                    		[disabled]
  -Wempty-body                		[disabled]
  -Wendif-labels              		[enabled]
  -Wenum-compare              		[enabled]
  -Werror                     		[disabled]
  -Werror-implicit-function-declaration 	
  -Wfloat-conversion          		[disabled]
  -Wfloat-equal               		[disabled]
  -Wformat                    		
  -Wformat-contains-nul       		[disabled]
  -Wformat-extra-args         		[disabled]
  -Wformat-nonliteral         		[disabled]
  -Wformat-security           		[disabled]
  -Wformat-signedness         		[disabled]
  -Wformat-y2k                		[disabled]
  -Wformat-zero-length        		[disabled]
  -Wformat=                   		0
  -Wframe-address             		[disabled]
  -Wignored-attributes        		[enabled]
  -Wignored-qualifiers        		[disabled]
  -Wimplicit                  		[disabled]
  -Wimplicit-function-declaration 	[enabled]
  -Wimplicit-int              		[enabled]
  -Wincompatible-pointer-types 		[enabled]
  -Winherited-variadic-ctor   		[enabled]
  -Winit-self                 		[disabled]
  -Wint-conversion            		[enabled]
  -Wint-to-pointer-cast       		[enabled]
  -Winvalid-offsetof          		[enabled]
  -Winvalid-pch               		[disabled]
  -Wjump-misses-init          		[disabled]
  -Wliteral-suffix            		[enabled]
  -Wlogical-not-parentheses   		[disabled]
  -Wlogical-op                		[disabled]
  -Wlong-long                 		[enabled]
  -Wmain                      		[enabled]
  -Wmaybe-uninitialized       		[disabled]
  -Wmemset-transposed-args    		[disabled]
  -Wmisleading-indentation    		[disabled]
  -Wmissing-braces            		[disabled]
  -Wmissing-declarations      		[disabled]
  -Wmissing-field-initializers 		[disabled]
  -Wmissing-include-dirs      		[disabled]
  -Wmissing-parameter-type    		[disabled]
  -Wmissing-prototypes        		[disabled]
  -Wmultichar                 		[disabled]
  -Wmultiple-inheritance      		[disabled]
  -Wnamespaces                		[disabled]
  -Wnarrowing                 		[enabled]
  -Wnested-externs            		[disabled]
  -Wnoexcept                  		[disabled]
  -Wnon-template-friend       		[enabled]
  -Wnon-virtual-dtor          		[disabled]
  -Wnonnull                   		[disabled]
  -Wnonnull-compare           		[disabled]
  -Wnormalized=<none|id|nfc|nfkc> 	nfc
  -Wold-style-cast            		[disabled]
  -Wold-style-declaration     		[disabled]
  -Wold-style-definition      		[disabled]
  -Wopenmp-simd               		[disabled]
  -Woverlength-strings        		[disabled]
  -Woverloaded-virtual        		[disabled]
  -Woverride-init             		[disabled]
  -Woverride-init-side-effects 		[enabled]
  -Wpacked-bitfield-compat    		[enabled]
  -Wparentheses               		[disabled]
  -Wpedantic                  		[disabled]
  -Wpmf-conversions           		[enabled]
  -Wpointer-arith             		[enabled]
  -Wpointer-sign              		[disabled]
  -Wpointer-to-int-cast       		[enabled]
  -Wpragmas                   		[enabled]
  -Wproperty-assign-default   		[enabled]
  -Wprotocol                  		[enabled]
  -Wredundant-decls           		[disabled]
  -Wreorder                   		[disabled]
  -Wreturn-type               		[disabled]
  -Wscalar-storage-order      		
  -Wselector                  		[disabled]
  -Wsequence-point            		[disabled]
  -Wshadow-ivar               		[enabled]
  -Wshift-count-negative      		[enabled]
  -Wshift-count-overflow      		[enabled]
  -Wshift-negative-value      		[enabled]
  -Wshift-overflow            		
  -Wshift-overflow=           		0xffffffff
  -Wsign-compare              		[disabled]
  -Wsign-conversion           		[disabled]
  -Wsign-promo                		[disabled]
  -Wsized-deallocation        		[disabled]
  -Wsizeof-array-argument     		[enabled]
  -Wsizeof-pointer-memaccess  		[disabled]
  -Wstrict-aliasing=          		0
  -Wstrict-null-sentinel      		[disabled]
  -Wstrict-overflow=          		0
  -Wstrict-prototypes         		[disabled]
  -Wstrict-selector-match     		[disabled]
  -Wsubobject-linkage         		[enabled]
  -Wsuggest-attribute=format  		[disabled]
  -Wsuggest-override          		[disabled]
  -Wswitch                    		[disabled]
  -Wswitch-bool               		[enabled]
  -Wswitch-default            		[disabled]
  -Wswitch-enum               		[disabled]
  -Wsync-nand                 		[enabled]
  -Wsynth                     		[disabled]
  -Wsystem-headers            		[disabled]
  -Wtautological-compare      		[disabled]
  -Wtemplates                 		[disabled]
  -Wterminate                 		[enabled]
  -Wtraditional               		[disabled]
  -Wtraditional-conversion    		[disabled]
  -Wtrigraphs                 		[enabled]
  -Wundeclared-selector       		[disabled]
  -Wundef                     		[disabled]
  -Wuninitialized             		[disabled]
  -Wunknown-pragmas           		[disabled]
  -Wunsuffixed-float-constants 		[disabled]
  -Wunused                    		[disabled]
  -Wunused-const-variable     		
  -Wunused-const-variable=    		0
  -Wunused-local-typedefs     		[disabled]
  -Wunused-macros             		[disabled]
  -Wunused-result             		[enabled]
  -Wunused-variable           		[disabled]
  -Wuseless-cast              		[disabled]
  -Wvarargs                   		[enabled]
  -Wvariadic-macros           		[disabled]
  -Wvirtual-inheritance       		[disabled]
  -Wvirtual-move-assign       		[enabled]
  -Wvla                       		[enabled]
  -Wvolatile-register-var     		[disabled]
  -Wwrite-strings             		[enabled]
  -Wzero-as-null-pointer-constant 	[disabled]
  -ansi                       		
  -d<letters>                 		
  -fRTS=                      		
  -fabi-compat-version=       		0xffffffff
  -faccess-control            		[enabled]
  -fada-spec-parent=          		
  -fallow-parameterless-variadic-functions 	[disabled]
  -falt-external-templates    		
  -fasm                       		[enabled]
  -fbuiltin                   		[enabled]
  -fcanonical-system-headers  		
  -fcheck-pointer-bounds      		[disabled]
  -fchkp-check-incomplete-type 		[enabled]
  -fchkp-check-read           		[enabled]
  -fchkp-check-write          		[enabled]
  -fchkp-first-field-has-own-bounds 	[disabled]
  -fchkp-instrument-calls     		[enabled]
  -fchkp-instrument-marked-only 	[disabled]
  -fchkp-narrow-bounds        		[enabled]
  -fchkp-narrow-to-innermost-array 	[disabled]
  -fchkp-optimize             		[enabled]
  -fchkp-store-bounds         		[enabled]
  -fchkp-treat-zero-dynamic-size-as-infinite 	[disabled]
  -fchkp-use-fast-string-functions 	[disabled]
  -fchkp-use-nochk-string-functions 	[disabled]
  -fchkp-use-static-bounds    		[enabled]
  -fchkp-use-static-const-bounds 	[enabled]
  -fchkp-use-wrappers         		[enabled]
  -fchkp-zero-input-bounds-for-main 	[disabled]
  -fcilkplus                  		[disabled]
  -fconcepts                  		[disabled]
  -fcond-mismatch             		
  -fconserve-space            		[disabled]
  -fconst-string-class=<name> 		
  -fconstexpr-depth=<number>  		0x200
  -fdebug-cpp                 		
  -fdeclone-ctor-dtor         		[enabled]
  -fdeduce-init-list          		[disabled]
  -fdefault-inline            		
  -fdirectives-only           		
  -fdollars-in-identifiers    		
  -fdump-ada-spec             		[disabled]
  -fdump-ada-spec-slim        		[disabled]
  -femit-struct-debug-baseonly 		
  -femit-struct-debug-detailed=<spec-list> 	
  -femit-struct-debug-reduced 		
  -fenforce-eh-specs          		[enabled]
  -fexec-charset=<cset>       		
  -fext-numeric-literals      		
  -fextended-identifiers      		
  -fextern-tls-init           		[enabled]
  -ffor-scope                 		[enabled]
  -ffreestanding              		
  -ffriend-injection          		[disabled]
  -fgnu-keywords              		[enabled]
  -fgnu-runtime               		[enabled]
  -fgnu89-inline              		[enabled]
  -fhosted                    		
  -fhuge-objects              		
  -fimplement-inlines         		[enabled]
  -fimplicit-inline-templates 		[enabled]
  -fimplicit-templates        		[enabled]
  -finput-charset=<cset>      		
  -fvisibility=[private|protected|public|package] 	protected
  -flax-vector-conversions    		[disabled]
  -flocal-ivars               		[enabled]
  -fms-extensions             		[disabled]
  -fnext-runtime              		[disabled]
  -fnil-receivers             		[enabled]
  -fnothrow-opt               		[disabled]
  -fobjc-abi-version=         		0
  -fobjc-direct-dispatch      		[disabled]
  -fobjc-exceptions           		[disabled]
  -fobjc-gc                   		[disabled]
  -fobjc-nilcheck             		[disabled]
  -fobjc-sjlj-exceptions      		[enabled]
  -fobjc-std=objc1            		[disabled]
  -fopenacc                   		[disabled]
  -fopenacc-dim=              		
  -fopenmp                    		[disabled]
  -fopenmp-simd               		[disabled]
  -foperator-names            		
  -foptional-diags            		
  -fpch-preprocess            		
  -fpermissive                		[disabled]
  -fplan9-extensions          		[disabled]
  -fpreprocessed              		
  -fpretty-templates          		[enabled]
  -freplace-objc-classes      		[disabled]
  -frepo                      		
  -frtti                      		[enabled]
  -fshort-enums               		[enabled]
  -fshort-wchar               		[disabled]
  -fsigned-bitfields          		[enabled]
  -fsigned-char               		[disabled]
  -fsized-deallocation        		[enabled]
  -fsso-struct=[big-endian|little-endian] 	[default]
  -fstats                     		[disabled]
  -fstrict-enums              		[disabled]
  -ftabstop=<number>          		
  -ftemplate-backtrace-limit= 		0xa
  -ftemplate-depth=<number>   		
  -fno-threadsafe-statics     		[enabled]
  -ftrack-macro-expansion=    		
  -funsigned-bitfields        		[disabled]
  -funsigned-char             		[enabled]
  -fuse-cxa-atexit            		[enabled]
  -fuse-cxa-get-exception-ptr 		[enabled]
  -fvisibility-inlines-hidden 		
  -fvisibility-ms-compat      		[disabled]
  -fvtable-gc                 		
  -fvtable-thunks             		
  -fweak                      		[enabled]
  -fwide-exec-charset=<cset>  		
  -fworking-directory         		[enabled]
  -fxref                      		
  -fzero-link                 		[disabled]
  -gen-decls                  		[disabled]
  -gnat<options>              		
  -gnatO                      		
  -idirafter <dir>            		
  -imacros <file>             		
  -imultilib <dir>            		
  -include <file>             		
  -iprefix <path>             		
  -iquote <dir>               		
  -isysroot <dir>             		
  -isystem <dir>              		
  -iwithprefix <dir>          		
  -iwithprefixbefore <dir>    		
  -nostdinc                   		
  -nostdinc++                 		
  -nostdlib                   		
  -o <file>                   		
  -print-objc-runtime-info    		
  -remap                      		
  -std=c++03                  		
  -std=c++11                  		
  -std=c++14                  		
  -std=c++1z                  		
  -std=c++98                  		
  -std=c11                    		
  -std=c1x                    		
  -std=c89                    		
  -std=c90                    		
  -std=c99                    		
  -std=c9x                    		
  -std=gnu++03                		
  -std=gnu++11                		
  -std=gnu++14                		
  -std=gnu++1z                		
  -std=gnu++98                		
  -std=gnu11                  		
  -std=gnu1x                  		
  -std=gnu89                  		
  -std=gnu90                  		
  -std=gnu99                  		
  -std=gnu9x                  		
  -std=iso9899:1990           		
  -std=iso9899:199409         		
  -std=iso9899:1999           		
  -std=iso9899:199x           		
  -std=iso9899:2011           		
  -traditional-cpp            		
  -trigraphs                  		
  -undef                      		[disabled]
  -v                          		[disabled]
  -w                          		[disabled]

The --param option recognizes the following as parameters:
  predictable-branch-outcome  default 2 minimum 0 maximum 50
  inline-min-speedup          default 10 minimum 0 maximum 0
  max-inline-insns-single     default 400 minimum 0 maximum 0
  max-inline-insns-auto       default 40 minimum 0 maximum 0
  max-inline-insns-recursive  default 450 minimum 0 maximum 0
  max-inline-insns-recursive-auto default 450 minimum 0 maximum 0
  max-inline-recursive-depth  default 8 minimum 0 maximum 0
  max-inline-recursive-depth-auto default 8 minimum 0 maximum 0
  min-inline-recursive-probability default 10 minimum 0 maximum 0
  max-early-inliner-iterations default 1 minimum 0 maximum 0
  comdat-sharing-probability  default 20 minimum 0 maximum 0
  partial-inlining-entry-probability default 70 minimum 0 maximum 0
  max-variable-expansions-in-unroller default 1 minimum 0 maximum 0
  min-vect-loop-bound         default 1 minimum 1 maximum 0
  max-delay-slot-insn-search  default 100 minimum 0 maximum 0
  max-delay-slot-live-search  default 333 minimum 0 maximum 0
  max-pending-list-length     default 32 minimum 0 maximum 0
  max-modulo-backtrack-attempts default 40 minimum 0 maximum 0
  large-function-insns        default 2700 minimum 0 maximum 0
  large-function-growth       default 100 minimum 0 maximum 0
  large-unit-insns            default 10000 minimum 0 maximum 0
  inline-unit-growth          default 20 minimum 0 maximum 0
  ipcp-unit-growth            default 10 minimum 0 maximum 0
  early-inlining-insns        default 14 minimum 0 maximum 0
  large-stack-frame           default 256 minimum 0 maximum 0
  large-stack-frame-growth    default 1000 minimum 0 maximum 0
  max-gcse-memory             default 134217728 minimum 0 maximum 0
  max-gcse-insertion-ratio    default 20 minimum 0 maximum 0
  gcse-after-reload-partial-fraction default 3 minimum 0 maximum 0
  gcse-after-reload-critical-fraction default 10 minimum 0 maximum 0
  gcse-cost-distance-ratio    default 10 minimum 0 maximum 0
  gcse-unrestricted-cost      default 3 minimum 0 maximum 0
  max-hoist-depth             default 30 minimum 0 maximum 0
  max-pow-sqrt-depth          default 5 minimum 1 maximum 32
  max-unrolled-insns          default 200 minimum 0 maximum 0
  max-average-unrolled-insns  default 80 minimum 0 maximum 0
  max-unroll-times            default 8 minimum 0 maximum 0
  max-peeled-insns            default 100 minimum 0 maximum 0
  max-peel-times              default 16 minimum 0 maximum 0
  max-peel-branches           default 32 minimum 0 maximum 0
  max-completely-peeled-insns default 200 minimum 0 maximum 0
  max-completely-peel-times   default 16 minimum 0 maximum 0
  max-once-peeled-insns       default 400 minimum 0 maximum 0
  max-completely-peel-loop-nest-depth default 8 minimum 0 maximum 0
  max-unswitch-insns          default 50 minimum 0 maximum 0
  max-unswitch-level          default 3 minimum 0 maximum 0
  max-iterations-to-track     default 1000 minimum 0 maximum 0
  max-iterations-computation-cost default 10 minimum 0 maximum 0
  sms-max-ii-factor           default 100 minimum 0 maximum 0
  sms-min-sc                  default 2 minimum 1 maximum 1
  sms-dfa-history             default 0 minimum 0 maximum 0
  sms-loop-average-count-threshold default 0 minimum 0 maximum 0
  hot-bb-count-ws-permille    default 999 minimum 0 maximum 1000
  hot-bb-frequency-fraction   default 1000 minimum 0 maximum 0
  unlikely-bb-count-fraction  default 20 minimum 1 maximum 10000
  align-threshold             default 100 minimum 1 maximum 0
  align-loop-iterations       default 4 minimum 0 maximum 0
  max-predicted-iterations    default 100 minimum 0 maximum 0
  builtin-expect-probability  default 90 minimum 0 maximum 100
  tracer-dynamic-coverage-feedback default 95 minimum 0 maximum 100
  tracer-dynamic-coverage     default 75 minimum 0 maximum 100
  tracer-max-code-growth      default 100 minimum 0 maximum 0
  tracer-min-branch-ratio     default 10 minimum 0 maximum 100
  tracer-min-branch-probability-feedback default 80 minimum 0 maximum 100
  tracer-min-branch-probability default 50 minimum 0 maximum 100
  max-crossjump-edges         default 100 minimum 0 maximum 0
  min-crossjump-insns         default 5 minimum 1 maximum 0
  max-grow-copy-bb-insns      default 8 minimum 0 maximum 0
  max-goto-duplication-insns  default 8 minimum 0 maximum 0
  max-cse-path-length         default 10 minimum 1 maximum 0
  max-cse-insns               default 1000 minimum 0 maximum 0
  lim-expensive               default 20 minimum 0 maximum 0
  iv-consider-all-candidates-bound default 40 minimum 0 maximum 0
  iv-max-considered-uses      default 250 minimum 0 maximum 0
  iv-always-prune-cand-set-bound default 10 minimum 0 maximum 0
  scev-max-expr-size          default 100 minimum 0 maximum 0
  scev-max-expr-complexity    default 10 minimum 0 maximum 0
  vect-max-version-for-alignment-checks default 6 minimum 0 maximum 0
  vect-max-version-for-alias-checks default 10 minimum 0 maximum 0
  vect-max-peeling-for-alignment default -1 minimum -1 maximum 64
  max-cselib-memory-locations default 500 minimum 0 maximum 0
  ggc-min-expand              default 100 minimum 0 maximum 0
  ggc-min-heapsize            default 131072 minimum 0 maximum 0
  max-reload-search-insns     default 100 minimum 0 maximum 0
  sink-frequency-threshold    default 75 minimum 0 maximum 100
  max-sched-region-blocks     default 10 minimum 0 maximum 0
  max-sched-region-insns      default 100 minimum 0 maximum 0
  max-pipeline-region-blocks  default 15 minimum 0 maximum 0
  max-pipeline-region-insns   default 200 minimum 0 maximum 0
  min-spec-prob               default 40 minimum 0 maximum 0
  max-sched-extend-regions-iters default 0 minimum 0 maximum 0
  max-sched-insn-conflict-delay default 3 minimum 1 maximum 10
  sched-spec-prob-cutoff      default 40 minimum 0 maximum 100
  sched-state-edge-prob-cutoff default 10 minimum 0 maximum 100
  selsched-max-lookahead      default 50 minimum 0 maximum 0
  selsched-max-sched-times    default 2 minimum 1 maximum 0
  selsched-insns-to-rename    default 2 minimum 0 maximum 0
  sched-mem-true-dep-cost     default 1 minimum 0 maximum 0
  sched-autopref-queue-depth  default -1 minimum 0 maximum 0
  max-last-value-rtl          default 10000 minimum 0 maximum 0
  max-combine-insns           default 4 minimum 2 maximum 4
  integer-share-limit         default 251 minimum 2 maximum 2
  ssp-buffer-size             default 8 minimum 1 maximum 0
  min-size-for-stack-sharing  default 32 minimum 0 maximum 0
  max-jump-thread-duplication-stmts default 15 minimum 0 maximum 0
  max-fields-for-field-sensitive default 0 minimum 0 maximum 0
  max-sched-ready-insns       default 100 minimum 0 maximum 0
  max-dse-active-local-stores default 5000 minimum 0 maximum 0
  prefetch-latency            default 200 minimum 0 maximum 0
  simultaneous-prefetches     default 3 minimum 0 maximum 0
  l1-cache-size               default 64 minimum 0 maximum 0
  l1-cache-line-size          default 32 minimum 0 maximum 0
  l2-cache-size               default 512 minimum 0 maximum 0
  use-canonical-types         default 1 minimum 0 maximum 1
  max-partial-antic-length    default 100 minimum 0 maximum 0
  sccvn-max-scc-size          default 10000 minimum 10 maximum 0
  sccvn-max-alias-queries-per-access default 1000 minimum 0 maximum 0
  ira-max-loops-num           default 100 minimum 0 maximum 0
  ira-max-conflict-table-size default 1000 minimum 0 maximum 0
  ira-loop-reserved-regs      default 2 minimum 0 maximum 0
  lra-max-considered-reload-pseudos default 500 minimum 0 maximum 0
  lra-inheritance-ebb-probability-cutoff default 40 minimum 0 maximum 100
  switch-conversion-max-branch-ratio default 8 minimum 1 maximum 0
  loop-block-tile-size        default 51 minimum 0 maximum 0
  graphite-max-nb-scop-params default 7 minimum 0 maximum 0
  graphite-max-bbs-per-function default 100 minimum 0 maximum 0
  graphite-max-arrays-per-scop default 100 minimum 0 maximum 0
  graphite-min-loops-per-function default 2 minimum 0 maximum 0
  max-isl-operations          default 350000 minimum 0 maximum 0
  loop-max-datarefs-for-datadeps default 1000 minimum 0 maximum 0
  loop-invariant-max-bbs-in-loop default 10000 minimum 0 maximum 0
  profile-func-internal-id    default 0 minimum 0 maximum 1
  indir-call-topn-profile     default 0 minimum 0 maximum 1
  slp-max-insns-in-bb         default 1000 minimum 0 maximum 0
  min-insn-to-prefetch-ratio  default 9 minimum 0 maximum 0
  prefetch-min-insn-to-mem-ratio default 3 minimum 0 maximum 0
  max-vartrack-size           default 50000000 minimum 0 maximum 0
  max-vartrack-expr-depth     default 12 minimum 0 maximum 0
  max-vartrack-reverse-op-size default 50 minimum 0 maximum 0
  min-nondebug-insn-uid       default 0 minimum 1 maximum 0
  ipa-sra-ptr-growth-factor   default 2 minimum 0 maximum 0
  tm-max-aggregate-size       default 9 minimum 0 maximum 0
  sra-max-scalarization-size-Ospeed default 0 minimum 0 maximum 0
  sra-max-scalarization-size-Osize default 0 minimum 0 maximum 0
  ipa-cp-value-list-size      default 8 minimum 0 maximum 0
  ipa-cp-eval-threshold       default 500 minimum 0 maximum 0
  ipa-cp-recursion-penalty    default 40 minimum 0 maximum 100
  ipa-cp-single-call-penalty  default 15 minimum 0 maximum 100
  ipa-max-agg-items           default 16 minimum 0 maximum 0
  ipa-cp-loop-hint-bonus      default 64 minimum 0 maximum 0
  ipa-cp-array-index-hint-bonus default 48 minimum 0 maximum 0
  ipa-max-aa-steps            default 25000 minimum 0 maximum 0
  lto-partitions              default 32 minimum 1 maximum 0
  lto-min-partition           default 10000 minimum 0 maximum 0
  lto-max-partition           default 1000000 minimum 0 maximum 2147483647
  cxx-max-namespaces-for-diagnostic-help default 1000 minimum 0 maximum 0
  max-stores-to-sink          default 2 minimum 0 maximum 0
  case-values-threshold       default 0 minimum 0 maximum 0
  allow-store-data-races      default 0 minimum 0 maximum 1
  tree-reassoc-width          default 0 minimum 0 maximum 0
  max-tail-merge-comparisons  default 10 minimum 0 maximum 0
  max-tail-merge-iterations   default 2 minimum 0 maximum 0
  max-tracked-strlens         default 10000 minimum 0 maximum 0
  sched-pressure-algorithm    default 1 minimum 1 maximum 2
  max-slsr-cand-scan          default 50 minimum 1 maximum 999999
  asan-stack                  default 1 minimum 0 maximum 1
  asan-globals                default 1 minimum 0 maximum 1
  asan-instrument-writes      default 1 minimum 0 maximum 1
  asan-instrument-reads       default 1 minimum 0 maximum 1
  asan-memintrin              default 1 minimum 0 maximum 1
  asan-use-after-return       default 1 minimum 0 maximum 1
  asan-instrumentation-with-call-threshold default 7000 minimum 0 maximum 2147483647
  uninit-control-dep-attempts default 1000 minimum 1 maximum 0
  chkp-max-ctor-size          default 5000 minimum 100 maximum 0
  fsm-scale-path-stmts        default 2 minimum 1 maximum 10
  fsm-maximum-phi-arguments   default 100 minimum 1 maximum 999999
  fsm-scale-path-blocks       default 3 minimum 1 maximum 10
  max-fsm-thread-path-insns   default 100 minimum 1 maximum 999999
  max-fsm-thread-length       default 10 minimum 1 maximum 999999
  max-fsm-thread-paths        default 50 minimum 1 maximum 999999
  parloops-chunk-size         default 0 minimum 0 maximum 0
  parloops-schedule           default 0 minimum 0 maximum 4
  max-ssa-name-query-depth    default 3 minimum 1 maximum 10
  max-rtl-if-conversion-insns default 10 minimum 0 maximum 99
  hsa-gen-debug-stores        default 0 minimum 0 maximum 1
  max-speculative-devirt-maydefs default 50 minimum 0 maximum 0

The following options control compiler warning messages:
  -W                          		
  -Waggregate-return          		[disabled]
  -Waggressive-loop-optimizations 	[enabled]
  -Warray-bounds              		[disabled]
  -Warray-bounds=             		0
  -Wattributes                		[enabled]
  -Wcast-align                		[disabled]
  -Wcoverage-mismatch         		[enabled]
  -Wdeprecated-declarations   		[enabled]
  -Wdisabled-optimization     		[disabled]
  -Wframe-larger-than=<number> 		
  -Wfree-nonheap-object       		[enabled]
  -Whsa                       		[enabled]
  -Winline                    		[disabled]
  -Winvalid-memory-model      		[enabled]
  -Wlarger-than=<number>      		
  -Wlto-type-mismatch         		[enabled]
  -Wnull-dereference          		[disabled]
  -Wodr                       		[enabled]
  -Woverflow                  		[enabled]
  -Wpacked                    		[disabled]
  -Wpadded                    		[disabled]
  -Wreturn-local-addr         		[enabled]
  -Wshadow                    		[disabled]
  -Wstack-protector           		[disabled]
  -Wstack-usage=              		0xffffffff
  -Wstrict-aliasing           		
  -Wstrict-overflow           		
  -Wsuggest-attribute=const   		[disabled]
  -Wsuggest-attribute=noreturn 		[disabled]
  -Wsuggest-attribute=pure    		[disabled]
  -Wsuggest-final-methods     		[disabled]
  -Wsuggest-final-types       		[disabled]
  -Wtrampolines               		[disabled]
  -Wtype-limits               		[disabled]
  -Wunreachable-code          		
  -Wunsafe-loop-optimizations 		[disabled]
  -Wunused-but-set-parameter  		[disabled]
  -Wunused-but-set-variable   		[disabled]
  -Wunused-function           		[disabled]
  -Wunused-parameter          		[disabled]
  -Wunused-value              		[disabled]
  -Wvector-operation-performance 	[disabled]

The following options control optimizations:
  -O<number>                  		
  -Ofast                      		
  -Og                         		
  -Os                         		
  -faggressive-loop-optimizations 	[enabled]
  -falign-functions           		[disabled]
  -falign-jumps               		[disabled]
  -falign-labels              		[disabled]
  -falign-loops               		[disabled]
  -fassociative-math          		[disabled]
  -fasynchronous-unwind-tables 		[disabled]
  -fauto-inc-dec              		[enabled]
  -fbranch-count-reg          		[disabled]
  -fbranch-probabilities      		[disabled]
  -fbranch-target-load-optimize 	[disabled]
  -fbranch-target-load-optimize2 	[disabled]
  -fbtr-bb-exclusive          		[disabled]
  -fcaller-saves              		[disabled]
  -fcombine-stack-adjustments 		[disabled]
  -fcompare-elim              		[disabled]
  -fconserve-stack            		[disabled]
  -fcprop-registers           		[disabled]
  -fcrossjumping              		[disabled]
  -fcse-follow-jumps          		[disabled]
  -fcx-fortran-rules          		[disabled]
  -fcx-limited-range          		[disabled]
  -fdce                       		[enabled]
  -fdefer-pop                 		[disabled]
  -fdelayed-branch            		[disabled]
  -fdelete-dead-exceptions    		[disabled]
  -fdelete-null-pointer-checks 		[enabled]
  -fdevirtualize              		[disabled]
  -fdevirtualize-speculatively 		[disabled]
  -fdse                       		[enabled]
  -fearly-inlining            		[enabled]
  -fexceptions                		[enabled]
  -fexpensive-optimizations   		[disabled]
  -ffinite-math-only          		[disabled]
  -ffloat-store               		[disabled]
  -fforward-propagate         		[disabled]
  -ffp-contract=              		fast
  -ffunction-cse              		[enabled]
  -fgcse                      		[disabled]
  -fgcse-after-reload         		[disabled]
  -fgcse-las                  		[disabled]
  -fgcse-lm                   		[enabled]
  -fgcse-sm                   		[disabled]
  -fgraphite                  		[disabled]
  -fgraphite-identity         		[disabled]
  -fguess-branch-probability  		[disabled]
  -fhoist-adjacent-loads      		[disabled]
  -fif-conversion             		[disabled]
  -fif-conversion2            		[disabled]
  -findirect-inlining         		[disabled]
  -finline                    		[enabled]
  -finline-atomics            		[enabled]
  -finline-functions-called-once 	[disabled]
  -finline-small-functions    		[disabled]
  -fipa-cp                    		[disabled]
  -fipa-cp-alignment          		[disabled]
  -fipa-cp-clone              		[disabled]
  -fipa-icf                   		[disabled]
  -fipa-icf-functions         		[disabled]
  -fipa-profile               		[disabled]
  -fipa-pta                   		[disabled]
  -fipa-pure-const            		[disabled]
  -fipa-ra                    		[disabled]
  -fipa-reference             		[disabled]
  -fipa-sra                   		[disabled]
  -fira-algorithm=            		CB
  -fira-hoist-pressure        		[enabled]
  -fira-loop-pressure         		[disabled]
  -fira-region=               		[default]
  -fira-share-save-slots      		[enabled]
  -fira-share-spill-slots     		[enabled]
  -fisolate-erroneous-paths-attribute 	[disabled]
  -fisolate-erroneous-paths-dereference 	[disabled]
  -fivopts                    		[enabled]
  -fjump-tables               		[enabled]
  -flifetime-dse              		[enabled]
  -flive-range-shrinkage      		[disabled]
  -floop-nest-optimize        		[disabled]
  -floop-parallelize-all      		[disabled]
  -flra-remat                 		[disabled]
  -fmath-errno                		[enabled]
  -fmodulo-sched              		[disabled]
  -fmodulo-sched-allow-regmoves 	[disabled]
  -fmove-loop-invariants      		[disabled]
  -fnon-call-exceptions       		[disabled]
  -fomit-frame-pointer        		[disabled]
  -fopt-info                  		[disabled]
  -foptimize-sibling-calls    		[disabled]
  -foptimize-strlen           		[disabled]
  -fpack-struct               		[disabled]
  -fpack-struct=<number>      		
  -fpartial-inlining          		[disabled]
  -fpeel-loops                		[disabled]
  -fpeephole                  		[enabled]
  -fpeephole2                 		[disabled]
  -fplt                       		[enabled]
  -fpredictive-commoning      		[disabled]
  -fprefetch-loop-arrays      		[enabled]
  -freciprocal-math           		[disabled]
  -freg-struct-return         		[enabled]
  -frename-registers          		[enabled]
  -freorder-blocks            		[disabled]
  -freorder-blocks-algorithm= 		simple
  -freorder-blocks-and-partition 	[disabled]
  -freorder-functions         		[disabled]
  -frerun-cse-after-loop      		[disabled]
  -freschedule-modulo-scheduled-loops 	[disabled]
  -frounding-math             		[disabled]
  -fsched-critical-path-heuristic 	[enabled]
  -fsched-dep-count-heuristic 		[enabled]
  -fsched-group-heuristic     		[enabled]
  -fsched-interblock          		[enabled]
  -fsched-last-insn-heuristic 		[enabled]
  -fsched-pressure            		[disabled]
  -fsched-rank-heuristic      		[enabled]
  -fsched-spec                		[enabled]
  -fsched-spec-insn-heuristic 		[enabled]
  -fsched-spec-load           		[disabled]
  -fsched-spec-load-dangerous 		[disabled]
  -fsched-stalled-insns       		[disabled]
  -fsched-stalled-insns-dep   		[enabled]
  -fsched-stalled-insns-dep=<number> 	
  -fsched-stalled-insns=<number> 	
  -fsched2-use-superblocks    		[disabled]
  -fschedule-fusion           		[enabled]
  -fschedule-insns            		[disabled]
  -fschedule-insns2           		[disabled]
  -fsection-anchors           		[disabled]
  -fsel-sched-pipelining      		[disabled]
  -fsel-sched-pipelining-outer-loops 	[disabled]
  -fsel-sched-reschedule-pipelined 	[disabled]
  -fselective-scheduling      		[disabled]
  -fselective-scheduling2     		[disabled]
  -fshrink-wrap               		[disabled]
  -fsignaling-nans            		[disabled]
  -fsigned-zeros              		[enabled]
  -fsimd-cost-model=          		unlimited
  -fsingle-precision-constant 		[disabled]
  -fsplit-ivs-in-unroller     		[enabled]
  -fsplit-paths               		[disabled]
  -fsplit-wide-types          		[disabled]
  -fssa-backprop              		[enabled]
  -fssa-phiopt                		[disabled]
  -fstack-reuse=              		all
  -fstdarg-opt                		[enabled]
  -fstrict-aliasing           		[disabled]
  -fstrict-overflow           		[disabled]
  -fstrict-volatile-bitfields 		[enabled]
  -fthread-jumps              		[disabled]
  -ftracer                    		[disabled]
  -ftrapping-math             		[enabled]
  -ftrapv                     		[disabled]
  -ftree-bit-ccp              		[disabled]
  -ftree-builtin-call-dce     		[disabled]
  -ftree-ccp                  		[disabled]
  -ftree-ch                   		[disabled]
  -ftree-coalesce-vars        		[disabled]
  -ftree-copy-prop            		[disabled]
  -ftree-cselim               		[enabled]
  -ftree-dce                  		[disabled]
  -ftree-dominator-opts       		[disabled]
  -ftree-dse                  		[disabled]
  -ftree-forwprop             		[enabled]
  -ftree-fre                  		[disabled]
  -ftree-loop-distribute-patterns 	[disabled]
  -ftree-loop-distribution    		[disabled]
  -ftree-loop-if-convert      		[enabled]
  -ftree-loop-if-convert-stores 	[disabled]
  -ftree-loop-im              		[enabled]
  -ftree-loop-ivcanon         		[enabled]
  -ftree-loop-optimize        		[enabled]
  -ftree-loop-vectorize       		[disabled]
  -ftree-lrs                  		[disabled]
  -ftree-parallelize-loops=   		0x1
  -ftree-partial-pre          		[disabled]
  -ftree-phiprop              		[enabled]
  -ftree-pre                  		[disabled]
  -ftree-pta                  		[disabled]
  -ftree-reassoc              		[enabled]
  -ftree-scev-cprop           		[enabled]
  -ftree-sink                 		[disabled]
  -ftree-slp-vectorize        		[disabled]
  -ftree-slsr                 		[disabled]
  -ftree-sra                  		[disabled]
  -ftree-switch-conversion    		[disabled]
  -ftree-tail-merge           		[disabled]
  -ftree-ter                  		[disabled]
  -ftree-vectorize            		[disabled]
  -ftree-vrp                  		[disabled]
  -funconstrained-commons     		[disabled]
  -funroll-all-loops          		[disabled]
  -funroll-loops              		[disabled]
  -funsafe-loop-optimizations 		[disabled]
  -funsafe-math-optimizations 		[disabled]
  -funswitch-loops            		[disabled]
  -funwind-tables             		[disabled]
  -fvar-tracking              		[enabled]
  -fvar-tracking-assignments  		[enabled]
  -fvar-tracking-assignments-toggle 	[disabled]
  -fvar-tracking-uninit       		[disabled]
  -fvariable-expansion-in-unroller 	[disabled]
  -fvect-cost-model=          		[default]
  -fvpt                       		[disabled]
  -fweb                       		[enabled]
  -fwrapv                     		[disabled]
  -mlow-precision-div         		[disabled]
  -mlow-precision-recip-sqrt  		[disabled]
  -mlow-precision-sqrt        		[disabled]

The following options are target specific:
  -mabi=ABI                   		lp64
  -march=ARCH                 		
  -mbig-endian                		[disabled]
  -mbionic                    		[disabled]
  -mcmodel=                   		small
  -mcpu=CPU                   		
  -mfix-cortex-a53-835769     		[enabled]
  -mfix-cortex-a53-843419     		[enabled]
  -mgeneral-regs-only         		[disabled]
  -mglibc                     		[enabled]
  -mlittle-endian             		[enabled]
  -mmusl                      		[disabled]
  -momit-leaf-frame-pointer   		[enabled]
  -moverride=STRING           		
  -mpc-relative-literal-loads 		[enabled]
  -mstrict-align              		[disabled]
  -mtls-dialect=              		desc
  -mtls-size=                 		[default]
  -mtune=CPU                  		
  -muclibc                    		[disabled]

  Known AArch64 ABIs (for use with the -mabi= option):
    ilp32 lp64

  The code model option names for -mcmodel:
    large small tiny

  The possible TLS dialects:
    desc trad

The following options are language-independent:
  --help                      		[enabled]
  --help=<class>              		
  --param <param>=<value>     		
  --target-help               		
  -Werror=                    		
  -Wfatal-errors              		[disabled]
  -aux-info <file>            		[enabled]
  -dumpbase <file>            		[enabled]
  -dumpdir <dir>              		[enabled]
  -fPIC                       		[disabled]
  -fPIE                       		[disabled]
  -fabi-version=              		0
  -fargument-alias            		
  -fargument-noalias          		
  -fargument-noalias-anything 		
  -fargument-noalias-global   		
  -fasan-shadow-offset=<number> 	
  -fauto-profile              		[disabled]
  -fauto-profile=             		
  -fbounds-check              		[disabled]
  -fcall-saved-<register>     		
  -fcall-used-<register>      		
  -fcheck-data-deps           		[disabled]
  -fcheck-new                 		[disabled]
  -fchecking                  		[disabled]
  -fcommon                    		[enabled]
  -fcompare-debug-second      		[disabled]
  -fcompare-debug[=<opts>]    		
  -fcse-skip-blocks           		
  -fdata-sections             		[disabled]
  -fdbg-cnt-list              		
  -fdbg-cnt=<counter>:<limit>[,<counter>:<limit>,...] 	
  -fdebug-prefix-map=         		
  -fdebug-types-section       		[disabled]
  -fdevirtualize-at-ltrans    		[disabled]
  -fdiagnostics-color=[never|always|auto] 	never
  -fdiagnostics-show-caret    		[enabled]
  -fdiagnostics-show-location=[once|every-line] 	
  -fdiagnostics-show-option   		[enabled]
  -fdisable-                  		
  -fdump-<type>               		
  -fdump-final-insns=filename 		
  -fdump-go-spec=filename     		
  -fdump-internal-locations   		[disabled]
  -fdump-noaddr               		[disabled]
  -fdump-passes               		[disabled]
  -fdump-unnumbered           		[disabled]
  -fdump-unnumbered-links     		[disabled]
  -fdwarf2-cfi-asm            		[enabled]
  -feliminate-dwarf2-dups     		[disabled]
  -feliminate-unused-debug-symbols 	[disabled]
  -feliminate-unused-debug-types 	[enabled]
  -femit-class-debug-always   		[disabled]
  -fenable-                   		
  -fexcess-precision=[fast|standard] 	[default]
  -ffat-lto-objects           		[disabled]
  -ffixed-<register>          		
  -fforce-addr                		
  -ffunction-sections         		[disabled]
  -fgnu-tm                    		[disabled]
  -fgnu-unique                		[enabled]
  -fident                     		[enabled]
  -finhibit-size-directive    		[disabled]
  -finline-limit=<number>     		
  -finstrument-functions      		[disabled]
  -finstrument-functions-exclude-file-list= 	
  -finstrument-functions-exclude-function-list= 	
  -fipa-icf-variables         		[disabled]
  -fipa-matrix-reorg          		
  -fipa-struct-reorg          		
  -fira-verbose=<number>      		0x5
  -fkeep-inline-functions     		[disabled]
  -fkeep-static-consts        		[enabled]
  -fkeep-static-functions     		[disabled]
  -fleading-underscore        		[enabled]
  -floop-block                		
  -floop-flatten              		
  -floop-interchange          		
  -floop-optimize             		
  -floop-strip-mine           		
  -floop-unroll-and-jam       		
  -flto                       		
  -flto-compression-level=<number> 	0xffffffff
  -flto-odr-type-merging      		[enabled]
  -flto-partition=            		balanced
  -flto-report                		[disabled]
  -flto-report-wpa            		[disabled]
  -flto=                      		
  -fmax-errors=<number>       		0
  -fmem-report                		[disabled]
  -fmem-report-wpa            		[disabled]
  -fmerge-all-constants       		[disabled]
  -fmerge-constants           		[disabled]
  -fmerge-debug-strings       		[enabled]
  -fmessage-length=<number>   		
  -fno-vect-cost-model        		
  -foffload-abi=              		[default]
  -foffload=                  		
  -fopt-info[-<type>=filename] 		
  -foptimize-register-move    		
  -fpcc-struct-return         		[disabled]
  -fpic                       		[disabled]
  -fpie                       		[disabled]
  -fplugin-arg-<name>-<key>[=<value>] 	
  -fplugin=                   		
  -fpost-ipa-mem-report       		[disabled]
  -fpre-ipa-mem-report        		[disabled]
  -fprofile                   		[disabled]
  -fprofile-arcs              		[disabled]
  -fprofile-correction        		[disabled]
  -fprofile-dir=              		
  -fprofile-generate          		
  -fprofile-generate=         		
  -fprofile-reorder-functions 		[disabled]
  -fprofile-report            		[disabled]
  -fprofile-use               		[disabled]
  -fprofile-use=              		
  -fprofile-values            		[disabled]
  -frandom-seed=<string>      		
  -frecord-gcc-switches       		[disabled]
  -free                       		[disabled]
  -fregmove                   		
  -freport-bug                		[disabled]
  -frerun-loop-opt            		
  -fsanitize-coverage=trace-pc 		[disabled]
  -fsanitize-recover          		
  -fsanitize-recover=         		
  -fsanitize-sections=<sec1,sec2,...> 	
  -fsanitize-undefined-trap-on-error 	[disabled]
  -fsanitize=                 		
  -fsched-verbose=<number>    		0x1
  -fsched2-use-traces         		
  -fsee                       		
  -fsemantic-interposition    		[enabled]
  -fshow-column               		[enabled]
  -fsplit-stack               		[enabled]
  -fstack-check               		
  -fstack-check=[no|generic|specific] 	
  -fstack-limit-register=<register> 	
  -fstack-limit-symbol=<name> 		
  -fstack-protector           		[disabled]
  -fstack-protector-all       		[disabled]
  -fstack-protector-explicit  		[disabled]
  -fstack-protector-strong    		[disabled]
  -fstack-usage               		[disabled]
  -fstrength-reduce           		
  -fsync-libcalls             		[enabled]
  -fsyntax-only               		[disabled]
  -ftest-coverage             		[disabled]
  -ftime-report               		[disabled]
  -ftls-model=[global-dynamic|local-dynamic|initial-exec|local-exec] 	global-dynamic
  -ftoplevel-reorder          		[enabled]
  -ftree-coalesce-inlined-vars 		
  -ftree-copyrename           		
  -ftree-loop-linear          		
  -ftree-salias               		
  -ftree-store-ccp            		
  -ftree-store-copy-prop      		
  -ftree-vect-loop-version    		
  -ftree-vectorizer-verbose=  		
  -funit-at-a-time            		[enabled]
  -fuse-ld=bfd                		
  -fuse-ld=gold               		
  -fvect-cost-model           		
  -fverbose-asm               		[disabled]
  -fvisibility=[default|internal|hidden|protected] 	default
  -fvtable-verify=            		none
  -fvtv-counts                		[disabled]
  -fvtv-debug                 		[disabled]
  -fwhole-program             		[disabled]
  -fzee                       		
  -fzero-initialized-in-bss   		[enabled]
  -g                          		
  -gcoff                      		
  -gdwarf                     		
  -gdwarf-                    		0x4
  -ggdb                       		
  -ggnu-pubnames              		[disabled]
  -gno-pubnames               		[disabled]
  -gno-record-gcc-switches    		[disabled]
  -gno-split-dwarf            		[enabled]
  -gno-strict-dwarf           		[enabled]
  -gpubnames                  		[disabled]
  -grecord-gcc-switches       		[enabled]
  -gsplit-dwarf               		[disabled]
  -gstabs                     		
  -gstabs+                    		
  -gstrict-dwarf              		[disabled]
  -gtoggle                    		[disabled]
  -gvms                       		
  -gxcoff                     		
  -gxcoff+                    		
  -gz                         		
  -gz=<format>                		
  -imultiarch <dir>           		
  -iplugindir=<dir>           		
  -p                          		[disabled]
  -pedantic-errors            		[disabled]
  -quiet                      		[disabled]

```