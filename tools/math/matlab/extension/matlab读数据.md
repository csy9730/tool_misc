
# matlab读数据

### matlab读xlsx文件
matlab读取Excel文件的命令为xlsread，xlsread的调用格式为xlsread(‘文件路径\文件名称’，‘工作表名称’)。
xlsread命令未指定工作表时，默认读取Sheet1中的数据。


```
Sheet1 = xlsread('E:\data.xlsx', 'Sheet1');	%读取Sheet1中的数据
Sheet2 = xlsread('E:\data.xlsx', 'Sheet2');	%读取Sheet2中的数据
Default = xlsread('E:\data.xlsx');	%未指定工作表时，默认读取Sheet1中的数据
```
### matlab写xlsx文件
matlab写入Excel的命令为xlswrite，xlswrite调用格式为xlsread(‘文件路径\文件名称’，写入的数据，‘工作表名称’)。
xlsread命令未指定工作表时，默认写入Sheet1中的数据。
注意：若文件不存在，在使用xlswrite时会自动创建该文件。
``` matlab
A = [1 2 3 4;3 1 4 8;9 4 7 5;6 1 2 3]
B = [1 2 3 4 5;4 5 6 1 9;7 8 9 2 0]
xlswrite('E:\data_副本.xlsx', A, 'Sheet1');	%将变量A中的数据写入data_副本.xlsx文件的Sheet1中
xlswrite('E:\data_副本.xlsx', B, 'Sheet2');	%将变量B中的数据写入data_副本.xlsx文件的Sheet2中
```
