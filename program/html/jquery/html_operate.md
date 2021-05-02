# html operate

### insert
``` js
var newRow = "<tr><td>新行第一列</td><td>新行第二列</td><td>新行第三列</td><td>新行第四列</td></tr>";
$("table tr:last").after(newRow);
```

``` js
var tr = document.createElement('tr')
var td1 = document.createElement('td')
td1.innerHTML = "1233.txt"
var td2 = document.createElement('td')
td2.innerHTML = "zzz"
// tr.innerText = filePath;
tr.appendChild(td1)
tr.appendChild(td2)
$("table tr:last").after(tr);
```

``` js
var row = table.insertRow(table.rows.length+i);
var c1 = row.insertCell(0);
c1.innerHTML = String(i)
var c2 = row.insertCell(1);
c2.innerHTML = "aaa";
var c3 = row.insertCell(2);
c3.innerHTML = "<input type='checkbox' class='chk' name='checkbox22' value='checkbox' id='checkbox_" + String(data[i].Id) + "'>"
```

### delete

``` js
$("table tbody tr").empty();
```