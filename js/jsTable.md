# table操作


## base

api 列表
* 插入行
* 删除行
* 插入格子
* 删除格子
* 文本可编辑
* 

``` javascript
tableObject.deleteRow(index)

```

```
var oTable = document.getElementById("oTable");
var tBodies = oTable.tBodies;
var tbody = tBodies[0];
var tr = tbody.insertRow(tbody.rows.length);
var td_1 = tr.insertCell(0);
td_1.innerHTML = "<div contenteditable= 'true'<第1列>\/div>";
// &quot;&lt;div contenteditable=&#39;true&#39;&gt;第1列&lt;\/div&gt;&quot;;
var td_2 = tr.insertCell(1);
td_2.innerHTML = "<div contenteditable='true' <第3列>\/div>";
// &quot;&lt;div contenteditable=&#39;true&#39;&gt;第2列&lt;\/div&gt;&quot;;
```

