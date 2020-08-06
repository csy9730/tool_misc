@echo off
pushd %~dp0

if {%1}=={}  goto  :eof
matlab -nodesktop -nosplash -nojvm -r "pfn = '%1';dat= importdata(pfn);figure;plot(dat);"
popd 
pause & exit
pause