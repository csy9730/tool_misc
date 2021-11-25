

# [Failed to install Python Cryptography package with PIP and setup.py](https://stackoverflow.com/questions/22073516/failed-to-install-python-cryptography-package-with-pip-and-setup-py)

​                        

When I try to install the [Cryptography](https://cryptography.io) package for Python through either `pip install cryptography` or by downloading the package from [their site](https://github.com/pyca/cryptography) and running `python setup.py`, I get the following error:

------

```py
D:\Anaconda\Scripts\pip-script.py run on 02/27/14 16:13:17
Downloading/unpacking cryptography
  Getting page https://pypi.python.org/simple/cryptography/
  URLs to search for versions for cryptography:
  * https://pypi.python.org/simple/cryptography/
  Analyzing links from page https://pypi.python.org/simple/cryptography/
    Skipping https://pypi.python.org/packages/cp26/c/cryptography/cryptography-0.2-cp26-none-win32.whl#md5=13e5c4b19520e7dc6f07c6502b3f74e2 (from https://pypi.python.org/simple/cryptography/) because it is not compatible with this Python
    Skipping https://pypi.python.org/packages/cp26/c/cryptography/cryptography-0.2.1-cp26-none-win32.whl#md5=00e733648ee5cdb9e58876238b1328f8 (from https://pypi.python.org/simple/cryptography/) because it is not compatible with this Python
    Skipping https://pypi.python.org/packages/cp27/c/cryptography/cryptography-0.2-cp27-none-win32.whl#md5=013ccafa6a5a3ea92c73f2c1c4879406 (from https://pypi.python.org/simple/cryptography/) because it is not compatible with this Python
    Skipping https://pypi.python.org/packages/cp27/c/cryptography/cryptography-0.2.1-cp27-none-win32.whl#md5=127d6a5dc687250721f892d55720a06c (from https://pypi.python.org/simple/cryptography/) because it is not compatible with this Python
    Skipping https://pypi.python.org/packages/cp32/c/cryptography/cryptography-0.2-cp32-none-win32.whl#md5=051424a36e91039807b72f112333ded3 (from https://pypi.python.org/simple/cryptography/) because it is not compatible with this Python
    Skipping https://pypi.python.org/packages/cp32/c/cryptography/cryptography-0.2.1-cp32-none-win32.whl#md5=53f6f57db8e952d64283baaa14cbde3d (from https://pypi.python.org/simple/cryptography/) because it is not compatible with this Python
    Skipping https://pypi.python.org/packages/cp33/c/cryptography/cryptography-0.2-cp33-none-win32.whl#md5=302812c1c1a035cf9ba3292f8dbf3f9e (from https://pypi.python.org/simple/cryptography/) because it is not compatible with this Python
    Skipping https://pypi.python.org/packages/cp33/c/cryptography/cryptography-0.2.1-cp33-none-win32.whl#md5=81acca90caf8a45f2ca73f3f9859fae4 (from https://pypi.python.org/simple/cryptography/) because it is not compatible with this Python
    Found link https://pypi.python.org/packages/source/c/cryptography/cryptography-0.1.tar.gz#md5=bdc1c5fe069deca7467b71a0cc538f17 (from https://pypi.python.org/simple/cryptography/), version: 0.1
    Found link https://pypi.python.org/packages/source/c/cryptography/cryptography-0.2.1.tar.gz#md5=872fc04268dadc66a0305ae5ab1c123b (from https://pypi.python.org/simple/cryptography/), version: 0.2.1
    Found link https://pypi.python.org/packages/source/c/cryptography/cryptography-0.2.tar.gz#md5=8a3d21e837a21e1b7634ee1f22b06bb6 (from https://pypi.python.org/simple/cryptography/), version: 0.2
  Using version 0.2.1 (newest of versions: 0.2.1, 0.2, 0.1)
  Downloading from URL https://pypi.python.org/packages/source/c/cryptography/cryptography-0.2.1.tar.gz#md5=872fc04268dadc66a0305ae5ab1c123b (from https://pypi.python.org/simple/cryptography/)
  Running setup.py (path:c:\users\paco\appdata\local\temp\pip_build_Paco\cryptography\setup.py) egg_info for package cryptography
    In file included from c/_cffi_backend.c:7:0:
    c/misc_win32.h:225:23: error: two or more data types in declaration specifiers
    c/misc_win32.h:225:1: warning: useless type name in empty declaration [enabled by default]
    c/_cffi_backend.c: In function 'convert_array_from_object':
    c/_cffi_backend.c:1105:26: warning: unknown conversion type character 'z' in format [-Wformat]
    c/_cffi_backend.c:1105:26: warning: too many arguments for format [-Wformat-extra-args]
    c/_cffi_backend.c:1130:30: warning: unknown conversion type character 'z' in format [-Wformat]
    c/_cffi_backend.c:1130:30: warning: too many arguments for format [-Wformat-extra-args]
    c/_cffi_backend.c:1150:30: warning: unknown conversion type character 'z' in format [-Wformat]
    c/_cffi_backend.c:1150:30: warning: too many arguments for format [-Wformat-extra-args]
    c/_cffi_backend.c: In function 'convert_struct_from_object':
    c/_cffi_backend.c:1183:26: warning: unknown conversion type character 'z' in format [-Wformat]
    c/_cffi_backend.c:1183:26: warning: too many arguments for format [-Wformat-extra-args]
    c/_cffi_backend.c:1196:30: warning: unknown conversion type character 'z' in format [-Wformat]
    c/_cffi_backend.c:1196:30: warning: too many arguments for format [-Wformat-extra-args]
    c/_cffi_backend.c: In function 'cdata_repr':
    c/_cffi_backend.c:1583:13: warning: unknown conversion type character 'L' in format [-Wformat]
    c/_cffi_backend.c:1583:13: warning: too many arguments for format [-Wformat-extra-args]
    c/_cffi_backend.c:1595:9: warning: unknown conversion type character 'z' in format [-Wformat]
    c/_cffi_backend.c:1595:9: warning: too many arguments for format [-Wformat-extra-args]
    c/_cffi_backend.c: In function 'cdataowning_repr':
    c/_cffi_backend.c:1647:30: warning: unknown conversion type character 'z' in format [-Wformat]
    c/_cffi_backend.c:1647:30: warning: too many arguments for format [-Wformat-extra-args]
    c/_cffi_backend.c: In function '_cdata_get_indexed_ptr':
    c/_cffi_backend.c:1820:26: warning: unknown conversion type character 'z' in format [-Wformat]
    c/_cffi_backend.c:1820:26: warning: unknown conversion type character 'z' in format [-Wformat]
    c/_cffi_backend.c:1820:26: warning: too many arguments for format [-Wformat-extra-args]
    c/_cffi_backend.c: In function '_cdata_getslicearg':
    c/_cffi_backend.c:1872:26: warning: unknown conversion type character 'z' in format [-Wformat]
    c/_cffi_backend.c:1872:26: warning: unknown conversion type character 'z' in format [-Wformat]
    c/_cffi_backend.c:1872:26: warning: too many arguments for format [-Wformat-extra-args]
    c/_cffi_backend.c: In function 'cdata_ass_slice':
    c/_cffi_backend.c:1951:26: warning: unknown conversion type character 'z' in format [-Wformat]
    c/_cffi_backend.c:1951:26: warning: unknown conversion type character 'z' in format [-Wformat]
    c/_cffi_backend.c:1951:26: warning: too many arguments for format [-Wformat-extra-args]
    c/_cffi_backend.c:1969:30: warning: unknown conversion type character 'z' in format [-Wformat]
    c/_cffi_backend.c:1969:30: warning: unknown conversion type character 'z' in format [-Wformat]
    c/_cffi_backend.c:1969:30: warning: too many arguments for format [-Wformat-extra-args]
    c/_cffi_backend.c:1983:22: warning: unknown conversion type character 'z' in format [-Wformat]
    c/_cffi_backend.c:1983:22: warning: too many arguments for format [-Wformat-extra-args]
    c/_cffi_backend.c: In function 'cdata_call':
    c/_cffi_backend.c:2367:30: warning: unknown conversion type character 'z' in format [-Wformat]
    c/_cffi_backend.c:2367:30: warning: format '%s' expects argument of type 'char *', but argument 3 has type 'Py_ssize_t' [-Wformat]
    c/_cffi_backend.c:2367:30: warning: too many arguments for format [-Wformat-extra-args]
    c/_cffi_backend.c: In function 'cast_to_integer_or_char':
    c/_cffi_backend.c:2916:26: warning: unknown conversion type character 'z' in format [-Wformat]
    c/_cffi_backend.c:2916:26: warning: format '%s' expects argument of type 'char *', but argument 3 has type 'Py_ssize_t' [-Wformat]
    c/_cffi_backend.c:2916:26: warning: too many arguments for format [-Wformat-extra-args]
    c/_cffi_backend.c:2928:26: warning: unknown conversion type character 'z' in format [-Wformat]
    c/_cffi_backend.c:2928:26: warning: format '%s' expects argument of type 'char *', but argument 3 has type 'Py_ssize_t' [-Wformat]
    c/_cffi_backend.c:2928:26: warning: too many arguments for format [-Wformat-extra-args]
    c/_cffi_backend.c: In function 'new_array_type':
    c/_cffi_backend.c:3480:9: warning: unknown conversion type character 'l' in format [-Wformat]
    c/_cffi_backend.c:3480:9: warning: too many arguments for format [-Wformat-extra-args]
    c/_cffi_backend.c: In function 'b_complete_struct_or_union':
    c/_cffi_backend.c:3878:22: warning: unknown conversion type character 'z' in format [-Wformat]
    c/_cffi_backend.c:3878:22: warning: unknown conversion type character 'z' in format [-Wformat]
    c/_cffi_backend.c:3878:22: warning: too many arguments for format [-Wformat-extra-args]
    Traceback (most recent call last):
      File "<string>", line 17, in <module>
      File "c:\users\paco\appdata\local\temp\pip_build_Paco\cryptography\setup.py", line 113, in <module>
        "build": cffi_build,
      File "D:\Anaconda\lib\distutils\core.py", line 112, in setup
        _setup_distribution = dist = klass(attrs)
      File "build\bdist.win-amd64\egg\setuptools\dist.py", line 239, in __init__
      File "build\bdist.win-amd64\egg\setuptools\dist.py", line 264, in fetch_build_eggs
      File "build\bdist.win-amd64\egg\pkg_resources.py", line 580, in resolve
        dist = best[req.key] = env.best_match(req, ws, installer)
      File "build\bdist.win-amd64\egg\pkg_resources.py", line 818, in best_match
        return self.obtain(req, installer) # try and download/install
      File "build\bdist.win-amd64\egg\pkg_resources.py", line 830, in obtain
        return installer(requirement)
      File "build\bdist.win-amd64\egg\setuptools\dist.py", line 314, in fetch_build_egg
      File "build\bdist.win-amd64\egg\setuptools\command\easy_install.py", line 593, in easy_install

      File "build\bdist.win-amd64\egg\setuptools\command\easy_install.py", line 623, in install_item

      File "build\bdist.win-amd64\egg\setuptools\command\easy_install.py", line 809, in install_eggs

      File "build\bdist.win-amd64\egg\setuptools\command\easy_install.py", line 1015, in build_and_install

      File "build\bdist.win-amd64\egg\setuptools\command\easy_install.py", line 1003, in run_setup

    distutils.errors.DistutilsError: Setup script exited with error: command 'gcc' failed with exit status 1
    Complete output from command python setup.py egg_info:
    In file included from c/_cffi_backend.c:7:0:

c/misc_win32.h:225:23: error: two or more data types in declaration specifiers

c/misc_win32.h:225:1: warning: useless type name in empty declaration [enabled by default]

c/_cffi_backend.c: In function 'convert_array_from_object':

c/_cffi_backend.c:1105:26: warning: unknown conversion type character 'z' in format [-Wformat]

c/_cffi_backend.c:1105:26: warning: too many arguments for format [-Wformat-extra-args]

c/_cffi_backend.c:1130:30: warning: unknown conversion type character 'z' in format [-Wformat]

c/_cffi_backend.c:1130:30: warning: too many arguments for format [-Wformat-extra-args]

c/_cffi_backend.c:1150:30: warning: unknown conversion type character 'z' in format [-Wformat]

c/_cffi_backend.c:1150:30: warning: too many arguments for format [-Wformat-extra-args]

c/_cffi_backend.c: In function 'convert_struct_from_object':

c/_cffi_backend.c:1183:26: warning: unknown conversion type character 'z' in format [-Wformat]

c/_cffi_backend.c:1183:26: warning: too many arguments for format [-Wformat-extra-args]

c/_cffi_backend.c:1196:30: warning: unknown conversion type character 'z' in format [-Wformat]

c/_cffi_backend.c:1196:30: warning: too many arguments for format [-Wformat-extra-args]

c/_cffi_backend.c: In function 'cdata_repr':

c/_cffi_backend.c:1583:13: warning: unknown conversion type character 'L' in format [-Wformat]

c/_cffi_backend.c:1583:13: warning: too many arguments for format [-Wformat-extra-args]

c/_cffi_backend.c:1595:9: warning: unknown conversion type character 'z' in format [-Wformat]

c/_cffi_backend.c:1595:9: warning: too many arguments for format [-Wformat-extra-args]

c/_cffi_backend.c: In function 'cdataowning_repr':

c/_cffi_backend.c:1647:30: warning: unknown conversion type character 'z' in format [-Wformat]

c/_cffi_backend.c:1647:30: warning: too many arguments for format [-Wformat-extra-args]

c/_cffi_backend.c: In function '_cdata_get_indexed_ptr':

c/_cffi_backend.c:1820:26: warning: unknown conversion type character 'z' in format [-Wformat]

c/_cffi_backend.c:1820:26: warning: unknown conversion type character 'z' in format [-Wformat]

c/_cffi_backend.c:1820:26: warning: too many arguments for format [-Wformat-extra-args]

c/_cffi_backend.c: In function '_cdata_getslicearg':

c/_cffi_backend.c:1872:26: warning: unknown conversion type character 'z' in format [-Wformat]

c/_cffi_backend.c:1872:26: warning: unknown conversion type character 'z' in format [-Wformat]

c/_cffi_backend.c:1872:26: warning: too many arguments for format [-Wformat-extra-args]

c/_cffi_backend.c: In function 'cdata_ass_slice':

c/_cffi_backend.c:1951:26: warning: unknown conversion type character 'z' in format [-Wformat]

c/_cffi_backend.c:1951:26: warning: unknown conversion type character 'z' in format [-Wformat]

c/_cffi_backend.c:1951:26: warning: too many arguments for format [-Wformat-extra-args]

c/_cffi_backend.c:1969:30: warning: unknown conversion type character 'z' in format [-Wformat]

c/_cffi_backend.c:1969:30: warning: unknown conversion type character 'z' in format [-Wformat]

c/_cffi_backend.c:1969:30: warning: too many arguments for format [-Wformat-extra-args]

c/_cffi_backend.c:1983:22: warning: unknown conversion type character 'z' in format [-Wformat]

c/_cffi_backend.c:1983:22: warning: too many arguments for format [-Wformat-extra-args]

c/_cffi_backend.c: In function 'cdata_call':

c/_cffi_backend.c:2367:30: warning: unknown conversion type character 'z' in format [-Wformat]

c/_cffi_backend.c:2367:30: warning: format '%s' expects argument of type 'char *', but argument 3 has type 'Py_ssize_t' [-Wformat]

c/_cffi_backend.c:2367:30: warning: too many arguments for format [-Wformat-extra-args]

c/_cffi_backend.c: In function 'cast_to_integer_or_char':

c/_cffi_backend.c:2916:26: warning: unknown conversion type character 'z' in format [-Wformat]

c/_cffi_backend.c:2916:26: warning: format '%s' expects argument of type 'char *', but argument 3 has type 'Py_ssize_t' [-Wformat]

c/_cffi_backend.c:2916:26: warning: too many arguments for format [-Wformat-extra-args]

c/_cffi_backend.c:2928:26: warning: unknown conversion type character 'z' in format [-Wformat]

c/_cffi_backend.c:2928:26: warning: format '%s' expects argument of type 'char *', but argument 3 has type 'Py_ssize_t' [-Wformat]

c/_cffi_backend.c:2928:26: warning: too many arguments for format [-Wformat-extra-args]

c/_cffi_backend.c: In function 'new_array_type':

c/_cffi_backend.c:3480:9: warning: unknown conversion type character 'l' in format [-Wformat]

c/_cffi_backend.c:3480:9: warning: too many arguments for format [-Wformat-extra-args]

c/_cffi_backend.c: In function 'b_complete_struct_or_union':

c/_cffi_backend.c:3878:22: warning: unknown conversion type character 'z' in format [-Wformat]

c/_cffi_backend.c:3878:22: warning: unknown conversion type character 'z' in format [-Wformat]

c/_cffi_backend.c:3878:22: warning: too many arguments for format [-Wformat-extra-args]

Traceback (most recent call last):

  File "<string>", line 17, in <module>

  File "c:\users\paco\appdata\local\temp\pip_build_Paco\cryptography\setup.py", line 113, in <module>

    "build": cffi_build,

  File "D:\Anaconda\lib\distutils\core.py", line 112, in setup

    _setup_distribution = dist = klass(attrs)

  File "build\bdist.win-amd64\egg\setuptools\dist.py", line 239, in __init__

  File "build\bdist.win-amd64\egg\setuptools\dist.py", line 264, in fetch_build_eggs

  File "build\bdist.win-amd64\egg\pkg_resources.py", line 580, in resolve

    dist = best[req.key] = env.best_match(req, ws, installer)

  File "build\bdist.win-amd64\egg\pkg_resources.py", line 818, in best_match

    return self.obtain(req, installer) # try and download/install

  File "build\bdist.win-amd64\egg\pkg_resources.py", line 830, in obtain

    return installer(requirement)

  File "build\bdist.win-amd64\egg\setuptools\dist.py", line 314, in fetch_build_egg

  File "build\bdist.win-amd64\egg\setuptools\command\easy_install.py", line 593, in easy_install



  File "build\bdist.win-amd64\egg\setuptools\command\easy_install.py", line 623, in install_item



  File "build\bdist.win-amd64\egg\setuptools\command\easy_install.py", line 809, in install_eggs



  File "build\bdist.win-amd64\egg\setuptools\command\easy_install.py", line 1015, in build_and_install



  File "build\bdist.win-amd64\egg\setuptools\command\easy_install.py", line 1003, in run_setup



distutils.errors.DistutilsError: Setup script exited with error: command 'gcc' failed with exit status 1

----------------------------------------
Cleaning up...
  Removing temporary dir c:\users\paco\appdata\local\temp\pip_build_Paco...
Command python setup.py egg_info failed with error code 1 in c:\users\paco\appdata\local\temp\pip_build_Paco\cryptography
Exception information:
Traceback (most recent call last):
  File "D:\Anaconda\lib\site-packages\pip-1.5.4-py2.7.egg\pip\basecommand.py", line 122, in main
    status = self.run(options, args)
  File "D:\Anaconda\lib\site-packages\pip-1.5.4-py2.7.egg\pip\commands\install.py", line 278, in run
    requirement_set.prepare_files(finder, force_root_egg_info=self.bundle, bundle=self.bundle)
  File "D:\Anaconda\lib\site-packages\pip-1.5.4-py2.7.egg\pip\req.py", line 1229, in prepare_files
    req_to_install.run_egg_info()
  File "D:\Anaconda\lib\site-packages\pip-1.5.4-py2.7.egg\pip\req.py", line 325, in run_egg_info
    command_desc='python setup.py egg_info')
  File "D:\Anaconda\lib\site-packages\pip-1.5.4-py2.7.egg\pip\util.py", line 697, in call_subprocess
    % (command_desc, proc.returncode, cwd))
InstallationError: Command python setup.py egg_info failed with error code 1 in c:\users\paco\appdata\local\temp\pip_build_Paco\cryptography
```

I found other egg_info error posts ([here](https://stackoverflow.com/questions/17886647/cant-install-via-pip-because-of-egg-info-error) and [here](https://stackoverflow.com/questions/11425106/python-pip-install-fails-invalid-command-egg-info)) but the solutions there provided wouldn't solve my problem. Also, I am able to install other packages through PIP.

PIP version 1.5.4 setuptools version 2.2

​                    [python](https://stackoverflow.com/questions/tagged/python) [cryptography](https://stackoverflow.com/questions/tagged/cryptography) [pip](https://stackoverflow.com/questions/tagged/pip)                 

​                



I had a similar issue, and found I was simply missing a dependency (libssl-dev, for me). As referenced in https://cryptography.io/en/latest/installation/, ensure that all dependencies are met:

### On Windows

If you’re on Windows you’ll need to make sure you have OpenSSL  installed. There are pre-compiled binaries available. If your  installation is in an unusual location set the LIB and INCLUDE  environment variables to include the corresponding locations. For example:

```py
C:\> \path\to\vcvarsall.bat x86_amd64
C:\> set LIB=C:\OpenSSL-1.0.1f-64bit\lib;%LIB%
C:\> set INCLUDE=C:\OpenSSL-1.0.1f-64bit\include;%INCLUDE%
C:\> pip install cryptography
```

### 

### Building cryptography on Linux

cryptography should build very easily on Linux provided you have a C compiler, headers for Python (if you’re not using pypy), and headers for the OpenSSL and libffi libraries available on your system.

For **Debian and Ubuntu**, the following command will ensure that the required dependencies are installed:

```py
sudo apt-get install build-essential libssl-dev libffi-dev python-dev
```

For **Fedora and RHEL-derivatives**, the following command will ensure that the required dependencies are installed:

```py
sudo yum install gcc libffi-devel python-devel OpenSSL-devel
```

You should now be able to build and install cryptography with the usual.

```py
pip install cryptography
```



​         

