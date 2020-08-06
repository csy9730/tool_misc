@echo off
cd /d %~dp0
echo d|xcopy  ..\py\*.py .\pyTmp
echo d|xcopy  ..\py\ctrlSwigPyd  .\pyTmp\ctrlSwigPyd
echo d|xcopy  ..\py\ctrlPy  .\pyTmp\ctrlPy
echo d|xcopy  ..\py\ctrlPyd  .\pyTmp\ctrlPyd
echo d|xcopy  ..\py\ePlot  .\pyTmp\ePlot
echo d|xcopy  ..\py\kalmanSwigPyd  .\pyTmp\kalmanSwigPyd
echo d|xcopy  ..\py\pyMisc  .\pyTmp\pyMisc
echo d|xcopy  ..\py\*.ui  .\pyTmp
call e7zHashRecord.bat  .\pyTmp .\pyBak
rmdir  /s /q  pyTmp