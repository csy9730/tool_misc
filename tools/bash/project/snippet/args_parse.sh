#!/bin/bash
usage() {
  echo "Usage: ${0} [-s|--start] [-e|--end] [-i|--scfid] [-g|--gene]" 1>&2
  exit 1 
}
while [[ $# -gt 0 ]];do
  key=${1}
  case ${key} in
    -s|--start)
      START=${2}
      shift 2
      ;;
    -e|--end)
      END=${2}
      shift 2
      ;;
    -i|--scfid)
      SCFID=${2}
      shift 2
      ;;
    -g|--gene)
      GENE=${2}
      shift 2
      ;;
    *)
      usage
      shift
      ;;
  esac
done
    
# echo The ${GENE} is on Chr ${SCFID}:${START}-${END}
echo The args is : ${GENE}  ${SCFID} ${START} ${END}