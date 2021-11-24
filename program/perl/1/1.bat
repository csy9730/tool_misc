echo abc>tmp.txt
echo abcdef>>tmp.txt
echo abdefghi>>tmp.txt
type tmp.txt & pause
perl -pi.bak -e "s/cde/xyz/gi" tmp.txt
type tmp.txt & pause
