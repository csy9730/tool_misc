# matlab.exe

## arch
### file

* appdata/
* bin/      2GB
* cefclient/
* etc/
* examples/
* extern/
* help/  3.8GB
* java/
* lib/win64/*.lib
* licenses/
* mcr/
* notebook/pc/*.doc
* polyspace/
* resources/
* rtw/
* runtime/
* simulink/
* stateflow/c/ctc/*.tlc
* sys/
* toolbox/  4GB
* uninstall/
* patents.txt
* MCR_license.txt
* license.txt
* trademarks.txt


#### bin
C:\Program Files\MATLAB\R2014a\bin:

- m3iregistry/
- registry/
- util/
- win64/
- matlab.exe  核心文件 指向 win64/matlab.exe 
- matlab.bat    指向 matlab.exe   
- mcc.bat       指向 win64/mcc.exe   
- mbuild.bat    指向 win64/mex.exe  
- MemShieldStarter.bat
- mex.bat       指向 win64/mex.exe   
- mex.pl
- mexext.bat
- mw_mpiexec.bat
- worker.bat
- deploytool.bat    指向 win64/deploytool
- insttype.ini
- lcdata_utf8.xml
- lcdata.xml
- lcdata.xsd
- lcdata0.xml
- mexsetup.pm
- mexutils.pm


## script

```
matlab -nodesktop -nosplash -nojvm -r "dir;quit"
```
## help
```
$ matlab -h
matlab [-? ^| -h ^| -help]
       [-c licensefile]
       [-nosplash]
       [-nodesktop ^| -nojvm]
       [-win32]
       [-r MATLAB_command]
       [-logfile log]
       [-wait]
       [-noFigureWindows]
       [-automation] [-regserver] [-unregserver]


    -?^|-h^|-help        - Display arguments. Do not start MATLAB.
    -c licensefile       - Set location of the license file that MATLAB
                           should use. It can have the form port@host.
                           The LM_LICENSE_FILE and MLM_LICENSE_FILE
                           environment variables will be ignored.
    -nosplash            - Do not display the splash screen during startup.
    -nodesktop           - Do not start the MATLAB desktop. Use V5 MATLAB
                           command window for commands. The Java virtual
                           machine will be started.
    -singleCompThread    - Limit MATLAB to a single computational thread.
                           By default, MATLAB makes use of the multithreading
                           capabilities of the computer on which it is running.
    -nojvm               - Shut off all Java support by not starting the
                           Java virtual machine. In particular the MATLAB
                           desktop will not be started.
    -win32               - forces matlab to run in win32 mode even on 64 bit 
                           processors.
    -r MATLAB_command    - Start MATLAB and execute the MATLAB_command.
                           Any "M" file must be on the MATLAB path.
    -logfile log         - Make a copy of any output to the command window
                           in file log. This includes all crash reports.
    -wait                - MATLAB is started by a separate starter program
                           which normally launches MATLAB and then immediately
                           quits. Using the -wait option tells the starter
                           program not to quit until MATLAB has terminated.
                           This option is useful when you need to process the
                           the results from MATLAB in a script. The call to
                           MATLAB with this option will block the script from
                           continuing until the results are generated.
    -noFigureWindows     - Never display a figure window
    -automation          - Start MATLAB as an automation server,
                           minimized and without the MATLAB splash screen.
    -jdb [port]          - Enable remote Java debugging on port (default 4444)
    -regserver           - Register MATLAB as a COM server
    -unregserver         - Remove MATLAB COM server registry entries.
    -sd startup directory- Allows specification of the MATLAB startup
                           directory.  The token $documents can be used
                           to reference the Windows "Documents" folder 
    -shield level        - Win32 only: Protects integrity of address space to
                           ensure large contiguous free memory for array data
                           level - minimum (default)
                                   protects 5000000h-7000000h address range
                                   until before matlabrc.m is processed
                                 - none (safest) no protection is applied
                           The following are experimental and may be changed
                                   or removed:
                                 - medium (aggressive) protects
                                   5000000h-7000000h address range
                                   until after matlabrc.m is processed
                                 - maximum (very aggressive) calculated
                                   range held until after matlabrc.m is
                                   processed
    -shieldload <list>   - Win32 only: (experimental) loads dlls identified in
                                   comma separated list


    Version: 8.3.0,539
```

由于版权和授权原因，windows下matlab不能远程启动。不能终端中调用？