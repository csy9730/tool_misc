# dvc

## main

### git init
### dvc init
### dvc add
dvc add Home\ Learning\ Tips\ for\ Students\ Instagram\ Carousel-2.pdf


Home Learning Tips for Students Instagram Carousel-2.pdf.dvc

/Home Learning Tips for Students Instagram Carousel-2.pdf
.gitignore

### dvc remote add
dvc remote add -d myremote ssh://admin@192.168.0.113/Resource/

### dvc push



## misc


```
pip install dvc[ssh] ssh 
pip install dvc-ssh
WARNING: Ignoring invalid distribution -equests (c:\programdata\anaconda3\lib\site-packages)
WARNING: Ignoring invalid distribution -equests (c:\programdata\anaconda3\lib\site-packages)
Collecting dvc-ssh
  Downloading dvc_ssh-0.0.1a0-py3-none-any.whl (11 kB)
```
### dvc push
```
H:\project\tmp\dvc_demo>dvc push
100% Querying cache in /Resource/Project|█| /Resource/Project/3b/b099c4d2e134cd3cc8d1b9af5ceb10 |1/1 [00:00<00:00,  3.2
ERROR: failed to transfer 'md5: 3bb099c4d2e134cd3cc8d1b9af5ceb10' - Permission denied
ERROR: failed to push data to the cloud - 1 files failed to upload


```

```
$ dvc push
ERROR: unexpected error - Connection lost

Having any troubles? Hit us up at https://dvc.org/support, we are always happy to help!
(base)

```


```
ERROR: configuration error - config file error: Unsupported URL type sftp:// for dictionary value @ data['remote']['myre
mote']

```

```
['remote "myremote"']
    url = ssh://my_nas:~/

H:\project\tmp\dvc_demo>dvc push
ERROR: unexpected error - invalid literal for int() with base 10: '~'

Having any troubles? Hit us up at https://dvc.org/support, we are always happy to help!
```
### dvc pull

## outside git
### dvc get
### dvc list
### dvc import
