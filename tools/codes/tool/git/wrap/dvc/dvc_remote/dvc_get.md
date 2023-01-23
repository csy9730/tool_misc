# dvc get

## dvc pull
## dvc get
```
dvc get https://github.com/iterative/example-get-started model.pkl
ls
model.pkl
```

## help
```
$ dvc get --help
usage: dvc get [-h] [-q | -v] [-o [<path>]] [--rev [<commit>]] [--show-url]
               [-j <number>]
               url path

Download file or directory tracked by DVC or by Git.
Documentation: <https://man.dvc.org/get>

positional arguments:
  url                   Location of DVC or Git repository to download from
  path                  Path to a file or directory within the repository

optional arguments:
  -h, --help            show this help message and exit
  -q, --quiet           Be quiet.
  -v, --verbose         Be verbose.
  -o [<path>], --out [<path>]
                        Destination path to download files to
  --rev [<commit>]      Git revision (e.g. SHA, branch, tag)
  --show-url            Print the storage location (URL) the target data would
                        be downloaded from, and exit.
  -j <number>, --jobs <number>
                        Number of jobs to run simultaneously. The default
                        value is 4 * cpu_count(). For SSH remotes, the default
                        is 4.
```