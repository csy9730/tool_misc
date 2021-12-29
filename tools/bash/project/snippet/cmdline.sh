#!/bin/bash

algorithm_list=('pcb_updown' 'elevator_detect')

usage()
{
	echo "DESCRIPTION"
	echo "compiler tool."
	echo " "
	echo "SYNOPSIS"
	echo "	./builsh <algorithm directory>"
	echo " "
	echo "OPTIONS"
	echo "	<algorithm directory>	algorithm directory name or 'all'"
}

compiler_algorithm()
{
	# compiler
	echo compiler_algorithm $1
}

encrypte_model()
{
    echo encrypte_model $1
}


main() {
	if [ $#!=1 ]; then
		usage
		return 1
	fi

	if [ "$1" = "all" ]; then
		
		for var in ${algorithm_list[@]}
		do
			compiler_algorithm $var
			encrypte_model $var
		done		
	else
		compiler_algorithm $1
	fi
}


main "$@"
