# remote


## Supported storage types

The following are the types of remote storage (protocols) supported:

Click for Amazon S3

[``](https://dvc.org/doc/command-reference/remote/modify)

> [``](https://dvc.org/doc/command-reference/remote/modify)

Click for S3-compatible storage

[``](https://dvc.org/doc/command-reference/remote/modify)


Click for Microsoft Azure Blob Storage

[``](https://dvc.org/doc/command-reference/remote/modify)

Click for Google Drive

[``](https://dvc.org/doc/command-reference/pull)[``](https://dvc.org/doc/command-reference/push)

[``](https://dvc.org/doc/command-reference/remote/modify)

[``](https://dvc.org/doc/command-reference/remote/modify#available-parameters-for-all-remotes)[``](https://dvc.org/doc/command-reference/pull)

Click for Google Cloud Storage


[``](https://dvc.org/doc/command-reference/remote/modify)

Click for Aliyun OSS



[``](https://dvc.org/doc/command-reference/remote/modify)``


Click for SSH

> [``](https://dvc.org/doc/command-reference/remote/modify)


Click for HDFS

[``](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-hdfs/LibHdfs.html)


> [``](https://dvc.org/doc/command-reference/remote/modify)

Click for WebHDFS

> [``](https://dvc.org/doc/command-reference/remote/modify)

Click for HTTP

> [``](https://dvc.org/doc/command-reference/remote/modify)

Click for WebDAV


> [``](https://dvc.org/doc/command-reference/remote/modify)

Click for local remote

``[``](https://dvc.org/doc/command-reference/remote)

[``](https://dvc.org/doc/user-guide/project-structure/internal-files)


## Example

``` bash
# 不添加前缀协议名，会被当成本地目录
dvc remote add -d myremote ali_foo:~/repos/

# 不支持路径中含有~符号
dvc remote add -d myremote ssh://ali_foo:~/repos/
```