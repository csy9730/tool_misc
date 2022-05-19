#!/bin/bash

# current path
# cd "$(dirname "$0")"
SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)

usage()
{
	echo "DESCRIPTION"
	echo "compiler tool."
	echo " "
}

ls_files()
{
    for file in `ls *.md`
    do 
        echo -e "file:$file"
    done
}

echo_demo()
{
    shift
    echo shift demo
    echo num=$#
    if [ "$1" = "" ]; then
        echo "arg_1 is null"
    else
        echo $1
    fi
}

build_folder()
{
    [ ! $BUILD ] && export BUILD=build

    echo "set $BUILD "
    if [ -d "$BUILD" ]; then
        echo "$BUILD exist"
    else
        mkdir $BUILD
    fi

    cd $BUILD
    cmake ..
    echo "begin compile"
    make
    echo "compile finished"
    make install
    echo "install finished"
}

main()
{
	if [ $#!=1 ]; then
		usage
		return 1
	fi

	if [ "$1" = "all" ]; then
		for var in ${algorithm_list[@]}
		do
			build_folder $var
			encrypte_model $var
		done		
	elif ["$1" = "build"]; then
		build_folder $1
	elif ["$1" = "echo"]; then
		echo_demo $1 
    else
        ls_files
	fi
}

main "$@"