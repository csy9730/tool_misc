# dvc

## install
`pip install dvc`

## demo
``` bash

(base) H:\tmp\dvc_demo>git commit
[master 4975e0c] dvc init
 9 files changed, 515 insertions(+)
 create mode 100644 .dvc/.gitignore
 create mode 100644 .dvc/config
 create mode 100644 .dvc/plots/confusion.json
 create mode 100644 .dvc/plots/confusion_normalized.json
 create mode 100644 .dvc/plots/default.json
 create mode 100644 .dvc/plots/linear.json
 create mode 100644 .dvc/plots/scatter.json
 create mode 100644 .dvc/plots/smooth.json
 create mode 100644 .dvcignore
 ```


```
dvc get https://github.com/iterative/dataset-registry get-started/data.xml -o data/data.xml
dvc add data/data.xml

```


```
git add data/data.xml.dvc data/.gitignore
git commit -m "Add raw data"
```

```
dvc remote add -d storage s3://mybucket/dvcstore
git add .dvc/config
git commit -m "Configure remote storage"
```

```
dvc push

dvc pull

dvc checkout
```

```
dvc list https://github.com/iterative/dataset-registry get-started

dvc import  #  similar to dvc get + dvc add
```


## core

* git
* dvc
* remote data file

dvc文件夹在git管理之下。
对dvc 的操作都会保存在 .dvc文件夹中。
dvc文件夹有多个文件数据库，可以管理远程数据，dvc 不保存数据，只保存数据的访问地址url和指纹。

## remote


* ssh/SFTP
* http
* S3
* google storage
* git/dvc repo
* HDFS


### local

``` bash
$ mkdir -P /tmp/dvc-storage
$ dvc remote add local /tmp/dvc-storage

# You should now be able to run:

$ dvc push -r local
```