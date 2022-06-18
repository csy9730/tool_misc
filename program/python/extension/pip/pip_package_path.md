# pip package path


- /usr/local/lib64/python3.6/site-packages/sphinx
- /usr/lib/python3.6/site-packages
- /usr/lib64/python3.6/site-packages
- /usr/local/bin/
    - sphinx-apidoc


### pip
```
➜  python3.6 pip list --verbose
Package                          Version    Location                                                    Installer
-------------------------------- ---------- ----------------------------------------------------------- ---------
backports.ssl-match-hostname     3.5.0.1    /usr/lib/python2.7/site-packages                                     
certifi                          2018.10.15 /usr/lib/python2.7/site-packages                            pip      
chardet                          3.0.4      /usr/lib/python2.7/site-packages                            pip      
Cheetah                          2.4.4      /usr/lib64/python2.7/site-packages                          pip      
click                            7.1.2      /usr/lib/python2.7/site-packages                            pip      
cloud-init                       0.7.6      /usr/lib/python2.7/site-packages/cloud_init-0.7.6-py2.7.egg          
configobj                        4.7.2      /usr/lib/python2.7/site-packages                                     
decorator                        3.4.0      /usr/lib/python2.7/site-packages                                     
DenyHosts                        3.0        /usr/lib/python2.7/site-packages                                     
enum34                           1.1.10     /usr/lib/python2.7/site-packages                            pip      
ethtool                          0.8        /usr/lib64/python2.7/site-packages                                   
Flask                            1.1.2      /usr/lib/python2.7/site-packages                            pip      
Flask-Admin                      1.5.7      /usr/lib64/python2.7/site-packages                          pip      
idna                             2.7        /usr/lib/python2.7/site-packages                            pip      
iniparse                         0.4        /usr/lib/python2.7/site-packages                                     
ipaddr                           2.2.0      /usr/lib/python2.7/site-packages                            pip      
ipaddress                        1.0.16     /usr/lib/python2.7/site-packages                                     
IPy                              0.75       /usr/lib/python2.7/site-packages                                     
itsdangerous                     1.1.0      /usr/lib/python2.7/site-packages                            pip      
javapackages                     1.0.0      /usr/lib/python2.7/site-packages                                     
Jinja2                           2.11.2     /usr/lib/python2.7/site-packages                            pip      
jsonpatch                        1.23       /usr/lib/python2.7/site-packages                            pip      
jsonpointer                      2.0        /usr/lib/python2.7/site-packages                            pip      
lxml                             3.2.1      /usr/lib64/python2.7/site-packages                                   
Markdown                         3.0.1      /usr/lib/python2.7/site-packages                            pip      
MarkupSafe                       1.1.0      /usr/lib64/python2.7/site-packages                          pip      
oauth                            1.0.1      /usr/lib/python2.7/site-packages                            pip      
perf                             0.1        /usr/lib64/python2.7/site-packages                                   
pip                              18.1       /usr/lib/python2.7/site-packages                            pip      
policycoreutils-default-encoding 0.1        /usr/lib64/python2.7/site-packages                                   
prettytable                      0.7.2      /usr/lib64/python2.7/site-packages                          pip      
psutil                           5.6.7      /usr/lib64/python2.7/site-packages                                   
pycurl                           7.19.0     /usr/lib64/python2.7/site-packages                                   
pygobject                        3.22.0     /usr/lib64/python2.7/site-packages                                   
pygpgme                          0.3        /usr/lib64/python2.7/site-packages                                   
pyinotify                        0.9.4      /usr/lib/python2.7/site-packages                                     
pyliblzma                        0.5.3      /usr/lib64/python2.7/site-packages                                   
python-dateutil                  1.5        /usr/lib/python2.7/site-packages                                     
python-dmidecode                 3.10.13    /usr/lib64/python2.7/site-packages                                   
python-linux-procfs              0.4.9      /usr/lib/python2.7/site-packages                                     
pytoml                           0.1.14     /usr/lib/python2.7/site-packages                                     
pyudev                           0.15       /usr/lib/python2.7/site-packages                                     
pyxattr                          0.5.1      /usr/lib64/python2.7/site-packages                                   
PyYAML                           3.13       /usr/lib64/python2.7/site-packages                          pip      
registries                       0.1        /usr/lib/python2.7/site-packages                                     
requests                         2.20.1     /usr/lib/python2.7/site-packages                            pip      
schedutils                       0.4        /usr/lib64/python2.7/site-packages                                   
seobject                         0.1        /usr/lib64/python2.7/site-packages                                   
sepolicy                         1.1        /usr/lib64/python2.7/site-packages                                   
setuptools                       36.4.0     /usr/lib/python2.7/site-packages                            pip      
six                              1.9.0      /usr/lib/python2.7/site-packages                                     
slip                             0.4.0      /usr/lib/python2.7/site-packages                                     
slip.dbus                        0.4.0      /usr/lib/python2.7/site-packages                                     
subscription-manager             1.24.51    /usr/lib64/python2.7/site-packages                                   
syspurpose                       1.24.51    /usr/lib/python2.7/site-packages                                     
Terminator                       1.91       /usr/lib/python2.7/site-packages                                     
urlgrabber                       3.10       /usr/lib/python2.7/site-packages                                     
urllib3                          1.24.1     /usr/lib/python2.7/site-packages                            pip      
Werkzeug                         1.0.1      /usr/lib/python2.7/site-packages                            pip      
wheel                            0.29.0     /usr/lib/python2.7/site-packages                            pip      
WTForms                          2.3.3      /usr/lib64/python2.7/site-packages                          pip      
yum-metadata-parser              1.1.4      /usr/lib64/python2.7/site-packages                                   
You are using pip version 18.1, however version 22.1.2 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
```
### pip3

```
➜  python3.6 pip3 list -vvv                    
WARNING: pip is being invoked by an old script wrapper. This will fail in a future version of pip.
Please see https://github.com/pypa/pip/issues/5599 for advice on fixing the underlying issue.
To avoid this problem you can invoke Python with '-m pip' instead of running pip directly.
Package                       Version Location                                 Installer
----------------------------- ------- ---------------------------------------- ---------
alabaster                     0.7.12  /usr/local/lib/python3.6/site-packages   pip
alembic                       1.4.3   /usr/local/lib/python3.6/site-packages   pip
attrs                         21.4.0  /usr/local/lib/python3.6/site-packages   pip
Babel                         2.10.1  /usr/local/lib64/python3.6/site-packages pip
bcrypt                        3.2.0   /usr/local/lib64/python3.6/site-packages pip
blinker                       1.4     /usr/local/lib/python3.6/site-packages
cached-property               1.5.1   /usr/lib/python3.6/site-packages
cffi                          1.14.4  /usr/local/lib64/python3.6/site-packages pip
chardet                       3.0.4   /usr/lib/python3.6/site-packages
click                         7.1.2   /usr/local/lib/python3.6/site-packages   pip
commonmark                    0.9.1   /usr/local/lib/python3.6/site-packages   pip
dnspython                     2.0.0   /usr/local/lib/python3.6/site-packages   pip
docker                        2.6.1   /usr/lib/python3.6/site-packages
docker-compose                1.18.0  /usr/lib/python3.6/site-packages
docker-pycreds                0.2.1   /usr/lib/python3.6/site-packages
dockerpty                     0.4.1   /usr/lib/python3.6/site-packages
docopt                        0.6.2   /usr/lib/python3.6/site-packages
docutils                      0.17.1  /usr/local/lib/python3.6/site-packages   pip
dominate                      2.6.0   /usr/local/lib/python3.6/site-packages   pip
email-validator               1.1.2   /usr/local/lib/python3.6/site-packages   pip
Flask                         1.1.2   /usr/local/lib64/python3.6/site-packages pip
Flask-Admin                   1.5.7   /usr/local/lib/python3.6/site-packages
Flask-Bcrypt                  0.7.1   /usr/local/lib/python3.6/site-packages
Flask-Bootstrap               3.3.7.1 /usr/local/lib/python3.6/site-packages
Flask-Login                   0.5.0   /usr/local/lib64/python3.6/site-packages pip
Flask-Mail                    0.9.1   /usr/local/lib/python3.6/site-packages
Flask-Migrate                 2.5.3   /usr/local/lib64/python3.6/site-packages pip
Flask-Moment                  0.10.0  /usr/local/lib64/python3.6/site-packages pip
Flask-SQLAlchemy              2.4.4   /usr/local/lib64/python3.6/site-packages pip
Flask-WTF                     0.14.3  /usr/local/lib64/python3.6/site-packages pip
gevent                        20.12.1 /usr/local/lib64/python3.6/site-packages
greenlet                      0.4.17  /usr/local/lib64/python3.6/site-packages pip
gunicorn                      20.0.4  /usr/local/lib/python3.6/site-packages   pip
idna                          2.10    /usr/local/lib/python3.6/site-packages   pip
imagesize                     1.3.0   /usr/local/lib/python3.6/site-packages   pip
importlib-metadata            4.8.3   /usr/local/lib/python3.6/site-packages   pip
iniconfig                     1.1.1   /usr/local/lib/python3.6/site-packages   pip
itsdangerous                  1.1.0   /usr/local/lib/python3.6/site-packages   pip
Jinja2                        2.11.2  /usr/local/lib/python3.6/site-packages   pip
jsonschema                    2.5.1   /usr/lib/python3.6/site-packages
Mako                          1.1.3   /usr/local/lib/python3.6/site-packages   pip
MarkupSafe                    1.1.1   /usr/local/lib64/python3.6/site-packages pip
packaging                     21.3    /usr/local/lib/python3.6/site-packages   pip
pip                           21.3.1  /usr/local/lib/python3.6/site-packages   pip
pluggy                        1.0.0   /usr/local/lib/python3.6/site-packages   pip
py                            1.11.0  /usr/local/lib/python3.6/site-packages   pip
pycparser                     2.20    /usr/local/lib/python3.6/site-packages   pip
Pygments                      2.12.0  /usr/local/lib/python3.6/site-packages   pip
pyparsing                     3.0.9   /usr/local/lib/python3.6/site-packages   pip
PySocks                       1.6.8   /usr/lib/python3.6/site-packages
pytest                        7.0.1   /usr/local/lib/python3.6/site-packages   pip
python-dateutil               2.8.1   /usr/local/lib/python3.6/site-packages   pip
python-editor                 1.0.4   /usr/local/lib/python3.6/site-packages   pip
pytz                          2022.1  /usr/local/lib/python3.6/site-packages   pip
PyYAML                        3.13    /usr/lib64/python3.6/site-packages
recommonmark                  0.7.1   /usr/local/lib/python3.6/site-packages   pip
requests                      2.14.2  /usr/lib/python3.6/site-packages
setuptools                    39.2.0  /usr/lib/python3.6/site-packages         pip
six                           1.15.0  /usr/local/lib/python3.6/site-packages   pip
snowballstemmer               2.2.0   /usr/local/lib/python3.6/site-packages   pip
speedtest-cli                 2.1.3   /usr/local/lib/python3.6/site-packages   pip
Sphinx                        4.5.0   /usr/local/lib64/python3.6/site-packages pip
sphinx-rtd-theme              1.0.0   /usr/local/lib/python3.6/site-packages   pip
sphinxcontrib-applehelp       1.0.2   /usr/local/lib/python3.6/site-packages   pip
sphinxcontrib-devhelp         1.0.2   /usr/local/lib/python3.6/site-packages   pip
sphinxcontrib-htmlhelp        2.0.0   /usr/local/lib/python3.6/site-packages   pip
sphinxcontrib-jsmath          1.0.1   /usr/local/lib/python3.6/site-packages   pip
sphinxcontrib-qthelp          1.0.3   /usr/local/lib/python3.6/site-packages   pip
sphinxcontrib-serializinghtml 1.1.5   /usr/local/lib/python3.6/site-packages   pip
SQLAlchemy                    1.3.20  /usr/local/lib64/python3.6/site-packages pip
texttable                     1.6.2   /usr/lib/python3.6/site-packages
tomli                         1.2.3   /usr/local/lib/python3.6/site-packages   pip
typing_extensions             4.1.1   /usr/local/lib/python3.6/site-packages   pip
urllib3                       1.25.6  /usr/lib/python3.6/site-packages
visitor                       0.1.3   /usr/local/lib/python3.6/site-packages
websocket-client              0.47.0  /usr/lib/python3.6/site-packages
Werkzeug                      1.0.1   /usr/local/lib/python3.6/site-packages   pip
wheel                         0.37.1  /usr/local/lib/python3.6/site-packages   pip
WTForms                       2.3.3   /usr/local/lib/python3.6/site-packages   pip
zipp                          3.6.0   /usr/local/lib/python3.6/site-packages   pip
zope.event                    4.5.0   /usr/local/lib/python3.6/site-packages   pip
zope.interface                5.2.0   /usr/local/lib64/python3.6/site-packages pip
1 location(s) to search for versions of pip:
* http://mirrors.cloud.aliyuncs.com/pypi/simple/pip/
WARNING: The repository located at mirrors.cloud.aliyuncs.com is not a trusted or secure host and is being ignored. If this repository is available via HTTPS we recommend you use HTTPS instead, otherwise you may silence this warning and allow it anyway with '--trusted-host mirrors.cloud.aliyuncs.com'.
Skipping link: not a file: http://mirrors.cloud.aliyuncs.com/pypi/simple/pip/
Given no hashes to check 0 links for project 'pip': discarding no candidates
```