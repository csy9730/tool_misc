dir  \\192.168.0.8\\软件

get-childitem \\192.168.0.8\\软件  -include *.txt -recurse -force
get-childitem \\192.168.23.12\\常用软件  -include *.txt -recurse -force >a.txt
get-childitem \\192.168.0.208\\download  -include *.txt -recurse -force >a.txt
get-childitem \\192.168.0.208\\download   -recurse -force >a.txt

