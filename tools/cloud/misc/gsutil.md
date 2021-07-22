# gsutil


## install

```
pip install gsutil
```

## usage
``` bash
gsutil ls gs://uspto-pair/applications/0800401* # 列出找到的文件
gsutil cp gs://my-bucket/my-file localDirectory # 下载单个文件
gsutil cp gs://my-bucket/remoteDirectory localDirectory # 下载整个存储分区或指定目录
gsutil -m cp -r gs://my-bucket/remoteDirectory localDirectory # 可以将cp命令与-R（递归）和-m（多线程，如果要传输大量文件）选项一起使用
```

## help
```
(jupt) D:\Projects\mylib\tool_misc>gsutil --help
Usage: gsutil [-D] [-DD] [-h header]... [-i service_account] [-m] [-o section:flag=value]... [-q] [-u user_project] [command [opts...] args...]
Available commands:
  acl              Get, set, or change bucket and/or object ACLs
  bucketpolicyonly Configure uniform bucket-level access
  cat              Concatenate object content to stdout
  compose          Concatenate a sequence of objects into a new composite object.
  config           Obtain credentials and create configuration file
  cors             Get or set a CORS JSON document for one or more buckets
  cp               Copy files and objects
  defacl           Get, set, or change default ACL on buckets
  defstorageclass  Get or set the default storage class on buckets
  du               Display object size usage
  hash             Calculate file hashes
  help             Get help about commands and topics
  hmac             CRUD operations on service account HMAC keys.
  iam              Get, set, or change bucket and/or object IAM permissions.
  kms              Configure Cloud KMS encryption
  label            Get, set, or change the label configuration of a bucket.
  lifecycle        Get or set lifecycle configuration for a bucket
  logging          Configure or retrieve logging on buckets
  ls               List providers, buckets, or objects
  mb               Make buckets
  mv               Move/rename objects
  notification     Configure object change notification
  pap              Configure public access prevention
  perfdiag         Run performance diagnostic
  rb               Remove buckets
  requesterpays    Enable or disable requester pays for one or more buckets
  retention        Provides utilities to interact with Retention Policy feature.
  rewrite          Rewrite objects
  rm               Remove objects
  rsync            Synchronize content of two buckets/directories
  setmeta          Set metadata on already uploaded objects
  signurl          Create a signed url
  stat             Display object status
  test             Run gsutil unit/integration tests (for developers)
  ubla             Configure Uniform bucket-level access
  version          Print version info about gsutil
  versioning       Enable or suspend versioning for one or more buckets
  web              Set a main page and/or error page for one or more buckets

Additional help topics:
  acls             Working With Access Control Lists
  crc32c           CRC32C and Installing crcmod
  creds            Credential Types Supporting Various Use Cases
  dev              Contributing Code to gsutil
  encoding         Filename encoding and interoperability problems
  metadata         Working With Object Metadata
  naming           Object and Bucket Naming
  options          Top-Level Command-Line Options
  prod             Scripting Production Transfers
  security         Security and Privacy Considerations
  support          Google Cloud Storage Support
  versions         Object Versioning and Concurrency Control
  wildcards        Wildcard Names

Use gsutil help <command or topic> for detailed help.

```