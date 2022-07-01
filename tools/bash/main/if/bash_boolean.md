# boolean bash
``` bash
if true;then echo "YES"; else echo "NO"; fi
# YES


if false; then echo "YES"; else echo "NO"; fi
# NO

abc=false

if $abc; then echo "YES"; else echo "NO"; fi
# NO
```