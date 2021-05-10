# [bootstrap：时间日期日历控件（datetimepicker）](https://www.cnblogs.com/gcgc/p/11154611.html)





**目录**

- Bootstrap datetimepicker控件的使用
  - [涉及的样式及js:](https://www.cnblogs.com/gcgc/p/11154611.html#_label0_0)

 

------

<https://blog.csdn.net/qq_33368846/article/details/82223676>

 

[回到顶部](https://www.cnblogs.com/gcgc/p/11154611.html#_labelTop)

## Bootstrap datetimepicker控件的使用

1.支持日期选择，格式设定

2.支持时间选择

3.支持时间段选择控制

4.支持中文

 



### 涉及的样式及js:

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width" />
    <title>datetimpicker测试</title>
    <!--图标样式-->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.bootcss.com/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcss.com/moment.js/2.24.0/moment-with-locales.js"></script>
   <script src="https://cdn.bootcss.com/bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script>
</head>


<body>
<div class="row">
<div class='col-sm-6'>

        <div class="form-group">

            <label>选择日期：</label>

            <!--指定 date标记-->

            <div class='input-group date' id='datetimepicker1'>

                <input type='text' class="form-control" />

                <span class="input-group-addon">

                    <span class="glyphicon glyphicon-calendar"></span>

                </span>

            </div>

        </div>

    </div>

    <div class='col-sm-6'>

        <div class="form-group">

            <label>选择日期+时间：</label>

            <!--指定 date标记-->

            <div class='input-group date' id='datetimepicker2'>

                <input type='text' class="form-control" />

                <span class="input-group-addon">

                    <span class="glyphicon glyphicon-calendar"></span>

                </span>

            </div>

        </div>

    </div>

</div>



<script type="text/javascript">


$(function () {

    $('#datetimepicker1').datetimepicker({

        format: 'YYYY-MM-DD',

        locale: moment.locale('zh-cn')

    });

    $('#datetimepicker2').datetimepicker({

        format: 'YYYY-MM-DD hh:mm',

        locale: moment.locale('zh-cn')

    });

});


</script>
</html>
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 



分类: [bootstrap](https://www.cnblogs.com/gcgc/category/1402144.html)