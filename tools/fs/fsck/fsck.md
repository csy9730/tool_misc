# fsck

```

## fsck
UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY means there is some file system error in the disk. Run the fsck command manually. After that it will ask some more questions - just answer y and press enter and finally reboot the server. Type exit into the prompt, and it should tell you which partition has an error, e.g. /dev/sda6.

fsck /dev/sda6 
```

处理硬盘的文件系统错误。
