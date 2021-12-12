mkdir -p usr/bin
mkdir -p tmp
mkdir -p bin
cp /usr/bin/bash.exe /usr/bin/ls.exe /usr/bin/msys-2.0.dll /usr/bin/msys-intl-8.dll  /usr/bin/msys-iconv-2.dll ./usr/bin
chroot .
# cd echo is bash buildin tool
