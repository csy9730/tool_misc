# [**gsutil**用法记录](https://www.cnblogs.com/hanchao/archive/2013/04/08/3006860.html)

[https://github.com/GoogleCloudPlatform/gsutil](https://github.com/GoogleCloudPlatform/gsutil)

**批量设置文件访问控制权限**

```
./gsutil -m setacl act.txt gs://bucket/**
```

 

**多线程****批量设置文件访问控制权限**
If you have a large number of ACLs to update you might want to use the
  **gsutil** -m option, to perform a parallel (multi-threaded/multi-processing)
  update:

```
gsutil -m setacl acl.txt gs://<bucket>/*.jpg
```


**设置某个文件为public-read（所有人可读）**

```
./gsutil setacl public-read gs://<bucket>/Info.plist
```


**获取某个bucket或文件的acl**

```
./gsutil getacl gs://<bucket> > acl.txt
```


**批量上传文件到服务器**

```
~/Desktop/gsutil/gsutil cp * gs://<bucket>/albunm
```


**从服务器批量下载文件到本地**

```
~/Desktop/gsutil/gsutil cp gs://<bucket>/albunm/* .
```