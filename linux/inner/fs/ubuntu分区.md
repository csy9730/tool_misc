# ubuntu分区



/ 根目录划分    Ext4 jopurnaling file system
/home home目录划分  Ext4 jopurnaling file system
swap 内存交换区划分

/boot   Device for boot loader installation 可以选择 Windows Boot Manager，即与windows共用一个 efi 分区，故不需要 

步骤4：一定要选择其他选项(Something else)，否则就不会出现下一步的分区挂载选项。
步骤5！！！！！！：分区挂载
1st： 先点击右下方的新建分区表(New partition table…)，系统会将整个硬盘清空，然后最干净的Ubuntu将送入怀抱
2nd：
        efi + 逻辑分区 + 空间开始位置 + efi系统文件 + 2048M
        swap + 主分区 + 空间开始位置 + swap交换空间 + 16G
        /home + 逻辑分区 + 空间开始位置 + ext4日志文件系统 + 除其他三个外的剩余所有空间
        / + 逻辑分区 + 空间开始 + ext4日志文件系统 + 50G
3rd：上述的4个分区挂载会对应4个编号，然后在下面“安装启动引导器的设备”选择efi对应的那个编号
4th：点击右下角的安装(Install now)
备注：上面的4个挂载最好不要乱顺序。
          1.传统的Boot为主分区，UEFI模式则一定要选择逻辑分区，efi用来存储系统的启动文件，我给了2G，500M也行
          2.swap一定要选择主分区，这个就是虚拟内存，一般设置为内存同样大小(16G)或者内存的2倍(32G)
          3. /home 相当于你的个人文件夹，你的所有图片，视频，下载内容基本都在这儿，所以给剩余的所有空间
          4. / 即根目录，给50G或者30G之类的都行，不要太小
          增加上面4个挂载的方法就是选中未分配的整个硬盘，然后点左下方的+号