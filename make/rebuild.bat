@echo off
pushd %~dp0  

rem set CMakeGenerator=Visual Studio 15 2017 Win64
set CMakeGenerator=Visual Studio 14 2015
set sourcePath=..
set binPath=%USERPROFILE%\Desktop\build
set binPath=.\build
set debugFlag=Release
mkdir build

pushd "%binpath%"
cmake -G "%CMakeGenerator%"  "%sourcePath%"
if ERRORLEVEL 1 goto :nocmake
cmake --build . --config %debugFlag%
if ERRORLEVEL 1 goto :builderror
echo build finished
popd
popd
pause

:nocmake
echo cmake step failed
goto :eof
:builderror
echo cmake build error
goto :eof