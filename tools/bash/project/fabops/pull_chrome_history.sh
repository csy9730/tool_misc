export dt=`date +'%Y-%m-%d-%H-%M-%S'`
mkdir $dt
scp "zlg_csy:~/AppData/Local/Google/Chrome/User\ Data/Default/History"  $dt