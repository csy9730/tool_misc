# file


## root

```
- acct 
- bugreports 
- config 
- data          
- dev        
- mnt 
- proc             
- res    
- storage
    - emulation
    - self
        - primary
- vendor
- apex 
- cache      
- cust   
- debug_ramdisk 
- etc        
- odm 
- product          
- sbin   
- sys
- bin  
- charger    
- d      
- default.prop  
- lost+found 
- oem 
- product_services 
- sdcard 
- system
```


```

C:\Users\gd_cs>"C:\Windows.old\Users\Administrator\AppData\Local\Android\Sdk\platform-tools\adb.exe" shell
umi:/ $ ls
ls: ./init.zygote64_32.rc: Permission denied
ls: ./init.rc: Permission denied
ls: ./init.usb.rc: Permission denied
ls: ./ueventd.rc: Permission denied
ls: ./init.zygote32.rc: Permission denied
ls: ./init.recovery.hardware.rc: Permission denied
ls: ./init: Permission denied
ls: ./init.miui.google_revenue_share_v2.rc: Permission denied
ls: ./init.miui.cust.rc: Permission denied
ls: ./init.environ.rc: Permission denied
ls: ./init.miui.post_boot.sh: Permission denied
ls: ./init.miui.qadaemon.rc: Permission denied
ls: ./verity_key: Permission denied
ls: ./init.recovery.qcom.rc: Permission denied
ls: ./init.miui.rc: Permission denied
ls: ./init.usb.configfs.rc: Permission denied
ls: ./init.exaid.hardware.rc: Permission denied
ls: ./init.miui.google_revenue_share.rc: Permission denied
ls: ./init.miui.nativedebug.rc: Permission denied
ls: ./init.miui.early_boot.sh: Permission denied
ls: ./metadata: Permission denied
acct bugreports config data          dev        mnt proc             res    storage vendor
apex cache      cust   debug_ramdisk etc        odm product          sbin   sys
bin  charger    d      default.prop  lost+found oem product_services sdcard system
1|umi:/ $ pwd
```

### /bin
/bin ~~ /system/bin
```
umi:/ $ ls bin
ls: bin/adbd: Permission denied
ls: bin/apexd: Permission denied
ls: bin/art_apex_boot_integrity: Permission denied
ls: bin/ashmemd: Permission denied
ls: bin/audioserver: Permission denied
ls: bin/auditctl: Permission denied
ls: bin/blank_screen: Permission denied
ls: bin/blkid: Permission denied
ls: bin/bootanimation: Permission denied
ls: bin/bootstat: Permission denied
ls: bin/bpfloader: Permission denied
ls: bin/bt_logger: Permission denied
ls: bin/cameraserver: Permission denied
ls: bin/charger: Permission denied
ls: bin/checknv: Permission denied
ls: bin/clatd: Permission denied
ls: bin/dex2oat: Permission denied
ls: bin/dexoptanalyzer: Permission denied
ls: bin/diag_mdlog_system: Permission denied
ls: bin/dnsmasq: Permission denied
ls: bin/drmserver: Permission denied
ls: bin/dumpstate: Permission denied
ls: bin/dun-server: Permission denied
ls: bin/e2fsck: Permission denied
ls: bin/e2fsdroid: Permission denied
ls: bin/fdpp: Permission denied
ls: bin/flags_health_check: Permission denied
ls: bin/fsck.exfat: Permission denied
ls: bin/fsck.f2fs: Permission denied
ls: bin/fsck.ntfs: Permission denied
ls: bin/fsck_msdos: Permission denied
ls: bin/fsverity_init: Permission denied
ls: bin/gatekeeperd: Permission denied
ls: bin/gpuservice: Permission denied
ls: bin/gsid: Permission denied
ls: bin/heapprofd: Permission denied
ls: bin/hwservicemanager: Permission denied
ls: bin/idmap: Permission denied
ls: bin/idmap2: Permission denied
ls: bin/idmap2d: Permission denied
ls: bin/incident_helper: Permission denied
ls: bin/incidentd: Permission denied
ls: bin/init: Permission denied
ls: bin/install-recovery.sh: Permission denied
ls: bin/installd: Permission denied
ls: bin/iorapd: Permission denied
ls: bin/iw: Permission denied
ls: bin/kernellog.sh: Permission denied
ls: bin/keystore: Permission denied
ls: bin/lmkd: Permission denied
ls: bin/logcatlog.sh: Permission denied
ls: bin/logd: Permission denied
ls: bin/lpdumpd: Permission denied
ls: bin/make_f2fs: Permission denied
ls: bin/mdnsd: Permission denied
ls: bin/mediadrmserver: Permission denied
ls: bin/mediaextractor: Permission denied
ls: bin/mediametrics: Permission denied
ls: bin/mediaserver: Permission denied
ls: bin/micd: Permission denied
ls: bin/migrate_legacy_obb_data.sh: Permission denied
ls: bin/millet_monitor: Permission denied
ls: bin/mke2fs: Permission denied
ls: bin/mkfs.exfat: Permission denied
ls: bin/mkfs.ntfs: Permission denied
ls: bin/mmi: Permission denied
ls: bin/mmi_diag: Permission denied
ls: bin/mtdoopslog.sh: Permission denied
ls: bin/mtpd: Permission denied
ls: bin/netd: Permission denied
ls: bin/netutils-wrapper-1.0: Permission denied
ls: bin/notify_traceur.sh: Permission denied
ls: bin/perfservice: Permission denied
ls: bin/pppd: Permission denied
ls: bin/profman: Permission denied
ls: bin/qseelogd: Permission denied
ls: bin/qspmsvc: Permission denied
ls: bin/racoon: Permission denied
ls: bin/recovery-persist: Permission denied
ls: bin/rss_hwm_reset: Permission denied
ls: bin/sdcard: Permission denied
ls: bin/servicemanager: Permission denied
ls: bin/sgdisk: Permission denied
ls: bin/sigma_miracasthalservice: Permission denied
ls: bin/sload_f2fs: Permission denied
ls: bin/statsd: Permission denied
ls: bin/storaged: Permission denied
ls: bin/subsystem_ramdump_system: Permission denied
ls: bin/surfaceflinger: Permission denied
ls: bin/tombstoned: Permission denied
ls: bin/traced: Permission denied
ls: bin/traced_probes: Permission denied
ls: bin/tune2fs: Permission denied
ls: bin/uncrypt: Permission denied
ls: bin/usbd: Permission denied
ls: bin/vdc: Permission denied
ls: bin/viewcompiler: Permission denied
ls: bin/vold: Permission denied
ls: bin/vold_prepare_subdirs: Permission denied
ls: bin/vpsservice: Permission denied
ls: bin/wait_for_keymaster: Permission denied
ls: bin/watchdogd: Permission denied
ls: bin/wfdservice: Permission denied
ls: bin/wificond: Permission denied
abb                    dmctl                  keystore_cli_v2   patch                 start
acpi                   dmesg                  kill              perfetto              stat
am                     dos2unix               killall           pgrep                 stop
app_process            dpm                    ld.mc             pidof                 strace
app_process32          du                     librank           ping                  strings
app_process64          dumpsys                linker            ping6                 stty
applypatch             echo                   linker64          pkill                 svc
appops                 egrep                  linker_asan       pm                    swapoff
appwidget              elliptic_engine_record linker_asan64     pmap                  swapon
atrace                 env                    ln                printenv              sync
awk                    expand                 load_policy       printf                sysctl
base64                 expr                   locksettings      procmem               tac
basename               fallocate              log               procrank              tail
bc                     false                  logcat            ps                    tar
bcc                    fgrep                  logcatkernel.sh   pwd                   taskset
blockdev               file                   logname           r                     tc
bmgr                   find                   logwrapper        readlink              tc-wrapper-1.0
bootstrap              flock                  losetup           realpath              tee
btcit                  fmt                    lpdump            reboot                telecom
bu                     free                   ls                remount               test-nusensors
bugreport              fsync                  lshal             renice                time
bugreportz             getconf                lsmod             requestsync           timeout
bunzip2                getenforce             lsof              resize.f2fs           tinycap
bzcat                  getevent               lspci             resize2fs             tinymix
bzip2                  getprop                lsusb             restorecon            tinypcminfo
cal                    grep                   mcd               rm                    tinyplay
cat                    groups                 md5sum            rmdir                 toolbox
chcon                  gsi_tool               media             rmmod                 top
chgrp                  gunzip                 microcom          rtspclient            touch
chmod                  gzip                   mini-keyctl       rtspserver            toybox
chown                  head                   mitop             run-as                tr
chroot                 hid                    mkdir             runcon                trigger_perfetto
chrt                   hostname               mkfifo            schedtest             true
cirrus_sp_load_tuning  hw                     mkfs.ext2         screencap             truncate
cirrus_sp_status       hwclock                mkfs.ext3         screenrecord          tty
cksum                  i2cdetect              mkfs.ext4         secdiscard            tzdatacheck
clear                  i2cdump                mknod             secilc                ueventd
climax                 i2cget                 mkswap            sed                   uiautomator
cmd                    i2cset                 mktemp            sendevent             ulimit
cmp                    iconv                  modinfo           sensorservice         umount
comm                   id                     modprobe          seq                   uname
content                ifconfig               monkey            service               uniq
copy_bugreport_file.sh ime                    more              setenforce            unix2dos
cp                     incident               mount             setprop               unlink
cpio                   inotifyd               mount.ntfs        setsid                unshare
crash_dump32           input                  mountpoint        settings              unzip
crash_dump64           insmod                 move_time_data.sh setup_fct             uptime
curl                   install                move_wifi_data.sh sh                    usleep
cut                    ionice                 mv                sha1sum               uudecode
dalvikvm               iorenice               mv_files.sh       sha224sum             uuencode
dalvikvm32             ip                     nc                sha256sum             uuidgen
dalvikvm64             ip-wrapper-1.0         ndc               sha384sum             vmstat
date                   ip6tables              ndc-wrapper-1.0   sha512sum             vr
dd                     ip6tables-restore      netcat            showmap               watch
debuggerd              ip6tables-save         netstat           simpleperf            wbridge
defrag.f2fs            ip6tables-wrapper-1.0  newfs_msdos       simpleperf_app_runner wc
device_config          iperf                  nice              sleep                 which
devmem                 iptables               nl                sm                    whoami
dexdiag                iptables-restore       nohup             sort                  wm
dexdump                iptables-save          nproc             spkcal                xargs
dexlist                iptables-wrapper-1.0   nsenter           spkcal_lmi            xxd
df                     iwconfig               oatdump           spklog_cspl_stereo    yes
diff                   iwlist                 od                split                 zcat
dirname                iwpriv                 paste             ss                    zip_utils
1|umi:/ $
```



### /sdcard
/sdcard ~~ /storage/self/primary


```
umi:/sdcard $ ls
139PeSdk                         Pictures                             cache                mi_drive
5A968A4B377F25ED0A1FD3C67B0CEE31 Pindd                                ccb                  miad
ALIMP                            PluginProReader                      chelaile             mipush
AirDroid                         Podcasts                             cllAMapSdk           mishop
Alarms                           QQBrowser                            cmcc_download        mivideo
AndroLua                         Ringtones                            com                  mobilestat_info
Android                          TTKN                                 com.MobileTicket     monitor
AppTimer                         Tasker                               com.UCMobile         msc
Backucup                         TbsReaderTemp                        com.cn21.yj          null
BaiduNetdisk                     Tencent                              com.kingpoint.gmcchh ok.mp3
BaiduWM                          TuSDK                                com.miui.voiceassist qt
Book                             UCDownloads                          com.tencent.mm       ramdump
ByteDownload                     UZMap                                com.tencent.mtt      rolly_export.xml
Catfish                          VMOSfiletransferstation              com.vmos.app         shareImage.png
Ctrip                            WhatsApp                             ctrip.android.view   sogou
DCIM                             WoodenLetter                         data                 sysdata
DSaudio                          Xiaomi                               dctp                 system
Documents                        _0ServerSendToService.txt            did                  tbs
Download                         aaaa                                 douban               tbslog
DuoKan                           alipay                               downloaded_rom       tencentmapsdk
FileExplorer                     amap                                 duilite              tiebaMini
Fonts                            app                                  ecloud               tv.danmaku.bili
HCE_CCB                          autonavi                             flywheel             umeng_cache
KingsoftOffice                   aweme_monitor                        gifshow              userexperience
KuwoMusic                        b0194c086f7ab8e7                     gmcchh               voip-data
Log07-02-21-27.txt               backup                               hawaii               wpkFlowLog.txt
MIUI                             backups                              hawaii_log           wpk_uploading_fail
MiMarket                         baidu                                icbcimlite           wpk_uploading_ok
Mob                              bdb53ca9-e86b-4e62-95ac-63005069f317 iciba                yunpan
Movies                           bluetooth                            libs                 zhihu
Music                            browser                              media                异次元
Notifications                    bytedance                            mfcache
```

### /etc
/system/etc

```
umi:/etc $ ls
ls: ./cgroups.json: Permission denied
NOTICE.xml.gz              fs_config_files         mmi                      sensors
NOTICE_GPL.html.gz         gps_debug.conf          modem                    sepolicy_freeze_test
apns-conf.xml              gps_diag.cfg            ota_skip_apps            sepolicy_tests
audio_diag.cfg             hosts                   perf                     spn-conf.xml
audio_effects.conf         init                    permissions              sysconfig
bluetooth                  install_app_filter.xml  ppp                      task_profiles.json
bpf                        ld.config.29.txt        precust_theme            textclassifier
cdma_call_conf.xml         llndk.libraries.29.txt  preloaded-classes        treble_sepolicy_tests_26.0
clatd.conf                 mcd_default.conf        preloaded-miui-classes   treble_sepolicy_tests_27.0
cne                        mdb_pub.key             prop.default             treble_sepolicy_tests_28.0
cust                       mdbversion              public.libraries-qti.txt vintf
dirty-image-objects        media_profiles_V1_0.dtd public.libraries.txt     vndksp.libraries.29.txt
event-log-tags             miui-spn-conf.xml       qvr                      vold.fstab
excluded-input-devices.xml miui-voicemail-conf.xml seccomp_policy           wfdconfigsink.xml
fiveG-apns-conf.xml        miui_feature            security                 wifibt_diag.cfg
fonts.xml                  mke2fs.conf             selinux                  xtables.lock
fs_config_dirs             mkshrc                  sensor_diag.cfg          yellowpage
```

/sdcard/data/data/com.termux/files/usr/bin/vi


#### /etc/hosts
```
adb pull /etc/hosts
adb push hosts /etc/hosts

cat > /etc/hosts
```

```
/system/bin/sh: can't create /etc/hosts: Read-only file system
```
一行命令解决read-only file system问题

```

mount -o remount -w /factory (factory为文件夹所在分区名，这里替换成你的）

报错read-only file system的原因是你所在的分区只有读权限， 没有写权限

mount为挂载分区命令，mount -o remount -w 重新挂载分区并增加写权限，增加读写权限即为 -rw 

接下来就可以在分区内文件夹里自由读写啦~
```