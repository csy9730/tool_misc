# switch case

case语句语法bash case语句的语法如下：
``` bash
case expression in  
    pattern_1)  
        statements  
        ;;  
    pattern_2)  
        statements  
        ;;  
    pattern_3|pattern_4|pattern_5)  
        statements  
        ;;  
    pattern-n)  
        statements  
        ;;  
    *)  
        statements  
        ;;  
esac
```

//更多请阅读：https://www.yiibai.com/bash/bash-case-statement.html
### demo
``` bash
#!/bin/bash  

echo "Do you know Java Programming?"  
read -p "Yes/No? :" Answer  
case $Answer in  
    Yes|yes|y|Y)  
        echo "That's amazing."  
        echo  
        ;;  
    No|no|N|n)  
        echo "It's easy. Let's start learning from yiibai.com."  
        ;;  
esac
```