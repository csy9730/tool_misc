# [jQuery对checkbox的各种操作](https://www.cnblogs.com/junjieok/p/4107066.html)

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```js
 //注意： 操作checkbox的checked,disabled属性时jquery1.6以前版本用attr,1.6以上（包含）建议用prop

    //1、根据id获取checkbox
    $("#cbCheckbox1");

    //2、获取所有的checkbox
    $("input[type='checkbox']");//or
    $("input[name='cb']");

    //3、获取所有选中的checkbox
    $("input:checkbox:checked");//or
    $("input:[type='checkbox']:checked");//or
    $("input[type='checkbox']:checked");//or
    $("input:[name='ck']:checked");

    //4、获取checkbox值
    //用.val()即可，比如：
    $("#cbCheckbox1").val();


    //5、获取多个选中的checkbox值
    var vals = [];
    $('input:checkbox:checked').each(function (index, item) {
        vals.push($(this).val());
    });

    //6、判断checkbox是否选中（jquery 1.6以前版本 用  $(this).attr("checked")）
    $("#cbCheckbox1").click(function () {
        if ($(this).prop("checked")) {
            alert("选中");
        } else {
            alert("没有选中");
        }
    });

    //7、设置checkbox为选中状态
    $('input:checkbox').attr("checked", 'checked');//or
    $('input:checkbox').attr("checked", true);

    //8、设置checkbox为不选中状态
    $('input:checkbox').attr("checked", '');//or
    $('input:checkbox').attr("checked", false);

    //9、设置checkbox为禁用状态(jquery<1.6用attr,jquery>=1.6建议用prop)
    $("input[type='checkbox']").attr("disabled", "disabled");//or
    $("input[type='checkbox']").attr("disabled", true);//or
    $("input[type='checkbox']").prop("disabled", true);//or
    $("input[type='checkbox']").prop("disabled", "disabled");

    //10、设置checkbox为启用状态(jquery<1.6用attr,jquery>=1.6建议用prop)
    $("input[type='checkbox']").removeAttr("disabled");//or
    $("input[type='checkbox']").attr("disabled", false);//or
    $("input[type='checkbox']").prop("disabled", "");//or
    $("input[type='checkbox']").prop("disabled", false);
```





```html
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<body>
    <h3>jQuery操作checkbox
    </h3>
    <input type="checkbox" id="cbCheckbox1" value="1" />
    <input type="checkbox" value="2" />
    <input type="checkbox" disabled="disabled" value="3" />
    <input type="checkbox" value="4" />
    <input type="checkbox" disabled="true" value="5" />
    <br />
    <input type="button" id="btnDisabled" value="禁用" onclick="fn_disabled();" />
    <input type="button" id="Button1" value="启用" onclick="fn_enable();" /><br />
    <input type="button" id="Button2" value="获取选中的值" onclick="getCheckedValues();" /><br />
    <input type="button" id="Button3" value="选中第二个" onclick="checkedSecond();" />
    <input type="button" id="Button4" value="取消选中第二个" onclick="uncheckedSecond();" /><br />
</body>
</html>
<script src="js/jquery-1.9.1.min.js" type="text/javascript"></script>
<script type="text/javascript">

    function fn_disabled() {
        //$("input[type='checkbox']").attr("disabled", "disabled");
        //$("input[type='checkbox']").attr("disabled", true);
        $("input[type='checkbox']").prop("disabled", true);
        //  $("input[type='checkbox']").prop("disabled", "disabled");
    }

    function fn_enable() {
        //  $("input[type='checkbox']").removeAttr("disabled");
        // $("input[type='checkbox']").attr("disabled", false);
        // $("input[type='checkbox']").prop("disabled","");
        $("input[type='checkbox']").prop("disabled", false);
    }

    //获取选中的 checkbox的值
    function getCheckedValues() {
        var arr = [];
        $("input[type='checkbox']:checked").each(function (index, item) {//
            arr.push($(this).val());
        });
        alert(arr);
    }

    function checkedSecond() {
        // $("input[type='checkbox']:eq(1)").prop("checked", "checked");
        $("input[type='checkbox']:eq(1)").prop("checked", true);
    }

    function uncheckedSecond() {
        //  $("input[type='checkbox']:eq(1)").prop("checked", "");
        $("input[type='checkbox']:eq(1)").prop("checked", false);
    }

    $("#cbCheckbox1").click(function () {
        if ($(this).prop("checked")) {//jquery 1.6以前版本 用  $(this).attr("checked")
            alert("选中");
        } else {
            alert("没有选中");
        }
    });

</script>
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

分类: [jQuery](https://www.cnblogs.com/junjieok/category/414946.html)

