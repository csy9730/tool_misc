# dvc push

## help
```
$ dvc push --help
usage: dvc push [-h] [-q | -v] [-j <number>] [-r <name>] [-a] [-T]
                [--all-commits] [-d] [-R] [--run-cache] [--glob]
                [targets [targets ...]]

Upload tracked files or directories to remote storage.
Documentation: <https://man.dvc.org/push>

positional arguments:
  targets               Limit command scope to these tracked
                        files/directories, .dvc files, or stage names.

optional arguments:
  -h, --help            show this help message and exit
  -q, --quiet           Be quiet.
  -v, --verbose         Be verbose.
  -j <number>, --jobs <number>
                        Number of jobs to run simultaneously. The default
                        value is 4 * cpu_count(). For SSH remotes, the default
                        is 4.
  -r <name>, --remote <name>
                        Remote storage to push to
  -a, --all-branches    Push cache for all branches.
  -T, --all-tags        Push cache for all tags.
  --all-commits         Push cache for all commits.
  -d, --with-deps       Push cache for all dependencies of the specified
                        target.
  -R, --recursive       Push cache for subdirectories of specified directory.
  --run-cache           Push run history for all stages.
  --glob                Allows targets containing shell-style wildcards.
```
