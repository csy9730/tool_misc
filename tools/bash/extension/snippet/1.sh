echo abc
echo num=$#
if [ "$1" = "" ]; then
    echo "arg_1 is null"
else
    echo $1
fi

echo bcd
exit 0
echo def