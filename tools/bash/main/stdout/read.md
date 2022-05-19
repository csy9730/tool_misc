# Bash 读取用户输入
2020-06-17 14:37 更新
若想要读取 Bash 用户输入，您需要使用内置的 Bash 命令read。语法：
```
read <variable_name>
```
示例
#### 1.使用read命令从 Bash 脚本中分别读取单个和多个变量。
``` bash
#!/bin/bash
echo "Enter the your name: "
read user_name
echo "Your name is $user_name"
echo
echo "Enter your age, phone and email: "
read age phone email
echo "your age is:$age, phone is:$phone, email: $email "
``` 
#### 2.使用-p PROMPT命令行选项在同一行上输入。
``` bash
#!/bin/bash
read -p "username:" user_var
echo "The username is: " $user_var
```
#### 3.在静默模式下，使用命令行选项-s,-p来传递用户名并隐藏密码

注：-s指用户将输入保持在静默模式，-p指用户在新的命令提示符下输入。
``` bash
#!/bin/bash
read -p "username : " user_var
read -sp "password : " pass_var
echo
echo "username : " $user_var
echo "password : "  $pass_var
```

#### 4.使用-a命令行选项对数组进行多个输入。

注：-a指脚本读取数组，而variable_name是引用数组变量名称。
``` bash
#!/bin/bash
echo "Enter names : "
read -a names
echo "The entered names are : ${names[0]}, ${names[1]}."
```
以上内容是否对您有帮助