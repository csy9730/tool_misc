# table����


## base

api �б�
* ������
* ɾ����
* �������
* ɾ������
* �ı��ɱ༭
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
td_1.innerHTML = "<div contenteditable= 'true'<��1��>\/div>";
// &quot;&lt;div contenteditable=&#39;true&#39;&gt;��1��&lt;\/div&gt;&quot;;
var td_2 = tr.insertCell(1);
td_2.innerHTML = "<div contenteditable='true' <��3��>\/div>";
// &quot;&lt;div contenteditable=&#39;true&#39;&gt;��2��&lt;\/div&gt;&quot;;
```

