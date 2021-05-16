@echo off

cd /d %~dp0
set module=zalaiyolo

if "%1" == "" (
goto :help
) else (
if "%1" == "clean" ( goto :clean
) else (
if "%1" == "test" ( goto :test
) else (
if "%1" == "create" ( goto :create
) else (
if "%1" == "build" ( goto :build
) else (
goto :help
)
)
)
)
)

:help
echo usage: %module% ^<command^> [^<args^>]
echo .
echo            Available sub-commands:
echo            create             create conda venv
echo            build              build wheel
echo            test               test wheel
echo            clean              clean wheel

goto :eof

:test
echo begin bdist_wheel
rem call conda activate zal_pytorch120
python setup.py bdist_wheel 1>nul
python setup2.py bdist_wheel 1>nul

pip install %module% -f dist

shift /0
SHIFT /1
pushd %module%
pytest  %1 %2 %3 %4 %5 %6 %7 %8 %9 
popd
if not %errorlevel%==0 (echo test error
    pip uninstall %module% -y
    goto :eof
)
pip uninstall %module% -y
echo finished pytest
goto :eof


:build
python setup.py bdist_wheel
python setup2.py bdist_wheel
echo finished bdist_wheel
goto :eof

:create
conda create -n torch_venv python=3.6
if not %errorlevel%==0 (echo create env error
    goto :eof
)
call conda activate torch_venv
conda install pytorch==1.2.0 torchvision==0.4.0 cudatoolkit==10.0 cudnn -c pytorch
if not %errorlevel%==0 (echo install env error
    goto :eof
)
pip install -r requirements.txt
echo finished create conda venv
goto :eof

:clean
rm -r ./*.egg-info
rm -r ./build
rm  dist/*.whl
echo finished clean
:eof