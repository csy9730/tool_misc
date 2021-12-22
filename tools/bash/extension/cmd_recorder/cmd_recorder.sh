dt=`date +'%Y-%m-%d-%H-%M-%S'`
export DN=$(dirname "$0")/tmp
mkdir -p ${DN}
echo "${dt} `pwd`:$*" >> "${DN}/cmd_recorder.log"
$* 2>&1 |tee "${DN}/${dt}.txt"