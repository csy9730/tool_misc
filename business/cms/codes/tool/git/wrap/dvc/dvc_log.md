# dvc

## main

1. git init
2. dvc init
3. dvc add 
4. dvc remote add
5. dvc push
6. dvc pull
7. dvc commit


### git init
### dvc init
### dvc add

```
dvc add Home.pdf


Home.pdf.dvc

/Home Learning Tips for Students Instagram Carousel-2.pdf
.gitignore
```

### dvc remote add
```
dvc remote add -d myremote ssh://admin@192.168.0.113/Resource/
```
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
## help

```
$ dvc help
ERROR: argument COMMAND: invalid choice: 'help' (choose from 'init', 'get', 'get-url', 'destroy', 'add', 'remove', 'move', 'unprotect', 'run', 'repro', 'pull', 'push', 'fetch', 'status', 'gc', 'import', 'import-url', 'config', 'checkout', 'remote', 'cache', 'metrics', 'params', 'install', 'root', 'list', 'freeze', 'unfreeze', 'dag', 'daemon', 'commit', 'completion', 'diff', 'version', 'doctor', 'update', 'git-hook', 'plots', 'stage', 'experiments', 'exp', 'check-ignore', 'live')
usage: dvc [-q | -v] [-h] [-V] [--cd <path>] COMMAND ...

Data Version Control

optional arguments:
  -q, --quiet        Be quiet.
  -v, --verbose      Be verbose.
  -h, --help         Show this help message and exit.
  -V, --version      Show program's version.
  --cd <path>        Change to directory before executing.

Available Commands:
  COMMAND            Use `dvc COMMAND --help` for command-specific help.
    init             Initialize DVC in the current directory.
    get              Download file or directory tracked by DVC or by Git.
    get-url          Download or copy files from URL.
    destroy          Remove DVC files, local DVC config and data cache.
    add              Track data files or directories with DVC.
    remove           Remove stages from dvc.yaml and/or stop tracking files or directories.
    move             Rename or move a DVC controlled data file or a directory.
    unprotect        Unprotect tracked files or directories (when hardlinks or symlinks have been enabled with `dvc config cache.type`)
    run              Generate a dvc.yaml file from a command and execute the command.
    repro            Reproduce complete or partial pipelines by executing their stages.
    pull             Download tracked files or directories from remote storage.
    push             Upload tracked files or directories to remote storage.
    fetch            Download files or directories from remote storage to the cache.
    status           Show changed stages, compare local cache and a remote storage.
    gc               Garbage collect unused objects from cache or remote storage.
    import           Download file or directory tracked by DVC or by Git into the workspace, and track it.
    import-url       Download or copy file from URL and take it under DVC control.
    config           Get or set config options.
    checkout         Checkout data files from cache.
    remote           Set up and manage data remotes.
    cache            Manage cache settings.
    metrics          Commands to display and compare metrics.
    params           Commands to display params.
    install          Install DVC git hooks into the repository.
    root             Return the relative path to the root of the DVC project.
    list             List repository contents, including files and directories tracked by DVC and by Git.
    freeze           Freeze stages or .dvc files.
    unfreeze         Unfreeze stages or .dvc files.
    dag              Visualize DVC project DAG.
    commit           Record changes to files or directories tracked by DVC by storing the current versions in the cache.
    completion       Generate shell tab completion.
    diff             Show added, modified, or deleted data between commits in the DVC repository, or between a commit and the workspace.
    version (doctor)
                     Display the DVC version and system/environment information.
    update           Update data artifacts imported from other DVC repositories.
    plots            Commands to visualize and compare plot metrics in structured files (JSON, YAML, CSV, TSV)
    stage            Commands to list and create stages.
    experiments (exp)
                     Commands to run and compare experiments.
    check-ignore     Check whether files or directories are excluded due to `.dvcignore`.
```

??????????????????git-like????????????
### git-like??
get ,get-url ,move ,remove ,pull ,push ,fetch	 ,status ,gc ,remote ,list ,commit

### ????????
run ,repro ,metrics ,params ,dag ,stage