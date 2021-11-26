# history
`C:\Users\Admin\AppData\Local\Google\Chrome\User Data\Default\Cookies`
可以使用sqlite格式打开
分为多个表
* downloads
* downloads_url_chains
* visits
* urls
* last_urls   保存最后浏览的网址
* keyword_search_terms  
* 其他表格例如meta segments

downloads保存下载时的配置，包括保存路径，起始结束时刻，文件大小，referer网站，mime_type,

downloads_url_chains保存下载源url，

keyword_search_terms保存term,url_id,keyword_id（对应搜索引擎序号）

urls 保存网页url，title，visit_count,last_visit_time,
visits 以关联表的形式，保存历史记录，包括网址，所有访问时间帧，持续时间


``` js
const HISTORYITEMS = document.querySelectorAll('#history-app /deep/ #content /deep/ #history /deep/ #infinite-list /deep/ history-item /deep/ #title');
for (let i = 0; i < HISTORYITEMS.length; i++) {
  let item = HISTORYITEMS[i];
  let url = item.getAttribute('href');
  let name = item.getAttribute('title');
  console.log(`${i}: ${name}'的URL地址是${url}`);
}

```

**Q**： 如何合并history文件？
