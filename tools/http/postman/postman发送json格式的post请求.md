# [postman发送json格式的post请求](https://www.cnblogs.com/shimh/p/6093229.html)



![img](https://images2015.cnblogs.com/blog/1054166/201611/1054166-20161123125625925-680027449.png)

![img](https://images2015.cnblogs.com/blog/1054166/201611/1054166-20161123124714034-1785548866.png)

在地址栏里输入请求url：http://127.0.0.1:8081/getmoney

选择“POST”方式，

在“headers”添加key:Content-Type  , value:application/json

点击"body",''raw''并设定为JSON

添加：

{"userid": 1}

点击send发送即可