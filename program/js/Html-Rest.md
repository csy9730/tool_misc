# Html Rest

http://127.0.0.1:5000/signin?username=12345&password=qwert


* GET
* POST
* PUT
* DELETE


GET（SELECT）：从服务器取出资源（一项或多项）。
POST（CREATE）：在服务器新建一个资源。
PUT（UPDATE）：在服务器更新资源（客户端提供完整资源数据）。
PATCH（UPDATE）：在服务器更新资源（客户端提供需要修改的资源数据）。
DELETE（DELETE）：从服务器删除资源。

OPTIONS
HEAD
TRACE
CONNECT


### form
```
 function insertStu(){  
     document.getElementById('myForm').action = "ctl.jsp?op=insert";  
     document.getElementById("myForm").submit();  
 } 			    
table.
<form id="myForm" action="" method="post">
     <input type="button" name="qurray" value="查询" onclick="selectStu()" />
     <input type="button" name="updata" value="修改" onclick="modifyStu()" />
     <input type="button" value="添加" onclick="insertStu()" />
     <input type="button" name="del" value="删除" onclick="deleteStu()" />    
</form>
```

也可以把js语句直接写在input按钮的 onclick 里：

 ```
  <form name="form1" action=""> 
      <input type="button" value="action1" onclick="form1.action='1';form1.submit();"> 
      <input type="button" value="action2" onclick="form1.action='2';form1.submit();"> 
 </form>
 ```


