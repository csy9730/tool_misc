# dom operate
## prop
``` html
$("table tbody tr:last")[0]
<tr><td></td><td><a href="../">..</a></td><td></td><td></td></tr>

$("table tbody tr:last")[0].children[1]
<td>​…​</td>​
$("table tbody tr:last")[0].children[1].children[0]
<a href=​"../​">​..</a>​
$("table tbody tr:last")[0].children[1].children[0].href
"http://localhost:5150/"
```

## createElement
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