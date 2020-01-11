# nni入门


## quickstart
``` bash
    nnictl create --config nni\examples\trials\mnist-tfv1\config_windows.yml
```
D:/ProgramData/Miniconda3/python.exe e:/nnCollect/nni/examples/trials/mnist-tfv1/mnist.py

## 文件夹结构

## 命令行



``` bash


E:\nni>nnictl -h
usage: nnictl [-h] [--version]
              {ss_gen,create,resume,view,update,stop,trial,experiment,platform,webui,config,log,package,tensorboard,top}
              ...

use nnictl command to control nni experiments

positional arguments:
  {ss_gen,create,resume,view,update,stop,trial,experiment,platform,webui,config,log,package,tensorboard,top}
    ss_gen              automatically generate search space file from trial
                        code
    create              create a new experiment
    resume              resume a new experiment
    view                view a stopped experiment
    update              update the experiment
    stop                stop the experiment
    trial               get trial information
    experiment          get experiment information
    platform            get platform information
    webui               get web ui information
    config              get config information
    log                 get log information
    package             control nni tuner and assessor packages
    tensorboard         manage tensorboard
    top                 monitor the experiment

optional arguments:
  -h, --help            show this help message and exit
  --version, -v

```
## 入口entry
命令行入口为tools\nni_cmd\nnictl.py的parse_args函数。
1. tools\nni_cmd\nnictl.py的parse_args()
2. launcher.py:create_experiment()
3. launch_experiment()


``` python
NNICTL_HOME_DIR = os.path.join(os.path.expanduser('~'), '.local', 'nnictl')

BASE_URL = 'http://localhost'
API_ROOT_URL = '/api/v1/nni'
EXPERIMENT_API = '/experiment'
CLUSTER_METADATA_API = '/experiment/cluster-metadata'
IMPORT_DATA_API = '/experiment/import-data'
CHECK_STATUS_API = '/check-status'
TRIAL_JOBS_API = '/trial-jobs'
EXPORT_DATA_API = '/export-data'
TENSORBOARD_API = '/tensorboard'

def get_log_path(config_file_name):
    '''generate stdout and stderr log path'''
    stdout_full_path = os.path.join(NNICTL_HOME_DIR, config_file_name, 'stdout')
    stderr_full_path = os.path.join(NNICTL_HOME_DIR, config_file_name, 'stderr')
    return stdout_full_path, stderr_full_path

def start_rest_server():
    cmds = [node_command, entry_file, '--port', str(port), '--mode', platform]
    stdout_full_path, stderr_full_path = get_log_path(config_file_name)
    process = Popen(cmds, cwd=entry_dir, stdout=stdout_file, stderr=stderr_file)
```
训练脚本入口：
从nni的tuner获取超参数，覆盖默认参数，然后进入网络训练流程。
``` python

if __name__ == '__main__':
    PARSER = argparse.ArgumentParser()
    PARSER.add_argument("--batch_size", type=int, default=200, help="batch size", required=False)
    PARSER.add_argument("--epochs", type=int, default=10, help="Train epochs", required=False)
    PARSER.add_argument("--num_train", type=int, default=60000, help="Number of train samples to be used, maximum 60000", required=False)
    PARSER.add_argument("--num_test", type=int, default=10000, help="Number of test samples to be used, maximum 10000", required=False)
    ARGS, UNKNOWN = PARSER.parse_known_args()
    try:
        # get parameters from tuner
        RECEIVED_PARAMS = nni.get_next_parameter()
        LOG.debug(RECEIVED_PARAMS)
        PARAMS = generate_default_params()
        PARAMS.update(RECEIVED_PARAMS)
        # train
        train(ARGS, PARAMS)
    except Exception as e:
        LOG.exception(e)
        raise
```