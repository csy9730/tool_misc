cd "$(dirname "$0")/.."
export PYTHONUNBUFFERED="True"
LOG="../logs/train-`date +'%Y-%m-%d-%H-%M-%S'`.log"

python runner/cpm_train.py -i /media/zal/data/project/Dataset/lsp_dataset  2>&1 | tee $LOG
