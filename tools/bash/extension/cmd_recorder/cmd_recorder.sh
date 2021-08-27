dt=`date +'%Y-%m-%d-%H-%M-%S'`
echo "${dt} $*" >> "$(dirname "$0")/cmd_recorder.log"
$* 2>&1 |tee "$(dirname "$0")/${dt}.txt"