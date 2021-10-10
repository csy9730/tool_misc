# diskmgmt

diskpart.exe是命令行工具，diskmgmt.msc 是可视化工具，两者功能接近。
位于C:\Windows\System32\diskmgmt.msc。

该工具可以显示/转换/创建/删除等管理：磁盘/基本卷/分区。

![1](2021-02-28_232332.png)


可以看到磁盘0（GPT) 有
- 分区1恢复分区 OEM分区 529MB
- 分区2 EFI系统分区 100MB
- 分区3 保留分区？ 16MB
- 分区4（C盘）  主分区，启动分区 69GB    NTFS
- 分区5 EFI 191MB
- 分区6 主分区 4.55GB
- 分区7 主分区 37.25GB