# default

主要大文件夹Media Cache，Cache，重要文件夹Extension，重要文件History，Bookmarks，Cookies，`Login Data`


|文件名|格式|描述|
|--|--|--|
|Network/Cookies		|sqlite3| 网址和加密通信信息|
|Extension Cookies|sqlite3|扩展访问的网址和加密通信信息|
|Bookmarks	|json| 书签文件|
|History 	|sqlite3|网站访问历史记录|
|"Top Sites" 	|sqlite3         |一个经常访问网站统计|
|Favicons |sqlite3格式|保存网址，图标blob信息|
|Preferences |json||
|Visited Links|VLnk?||
|Web Data	|sqlite3|保存搜索引擎信息|
|"Network Action Predictor" |sqlite3||
|"Last Session"	|snss||
|"Last Tabs"	|snss||
|tab_referer_url ||？|
|QuotaManager	|sqlite3||
|"Login Data"	|sqlite3 |登录信息，包含网址，账户，加密密码，统计登录次数|
|History-journal	||???|
|TransportSecurity	|json||
|Origin Bound Certs	|sqlite3||
|Shortcuts	|sqlite3| 搜索相关关键字|
|000021.log||类似hisotry.download内容|
|Secure Preferences	|json||
|heavy_ad_intervention_opt_out.db|||
|Translate Ranker Model|||
|LOG.old |log文件||


- databases\a.db
- \Local Storage\leveldb\001297.ldb
- Extension State\000023.ldb

ldb 文件为leveldb文件？

后缀为journal的文件保存当日信息？

``` bash

 H:\Program Files\360se\360Chrome\Chrome\User Data\Default 的目录

2019/12/14  01:17    <DIR>          .
2019/12/14  01:17    <DIR>          ..
2019/12/13  23:03    <DIR>          blob_storage
2019/12/14  01:17    <DIR>          Cache
2019/12/10  01:20    <DIR>          databases
2019/12/13  23:03    <DIR>          data_reduction_proxy_leveldb
2019/12/09  23:12    <DIR>          Download Service
2019/12/10  00:20    <DIR>          Extension Rules
2019/12/13  23:03    <DIR>          Extension State
2019/12/09  23:21    <DIR>          Extensions
2019/12/09  23:57    <DIR>          File System
2019/12/12  23:52    <DIR>          GPUCache
2019/12/14  01:01    <DIR>          JumpListIconsRecentClosed
2019/12/09  23:21    <DIR>          Local Extension Settings
2019/12/09  23:12    <DIR>          Local Storage
2019/12/11  21:46    <DIR>          Media Cache
2019/12/10  00:20    <DIR>          Pepper Data
2019/12/09  23:57    <DIR>          Service Worker
2019/12/14  00:57    <DIR>          Session Storage
2019/12/13  23:03    <DIR>          Thumbnails
2019/12/11  20:28    <DIR>          VideoDecodeStats
2019/12/14  01:17           262,144 Cookies
2019/12/14  01:17                 0 Cookies-journal
2019/12/14  01:13           175,126 Current Session
2019/12/14  01:01            27,795 Current Tabs
2019/12/14  01:01           229,376 Favicons
2019/12/14  01:01                 0 Favicons-journal
2019/12/09  23:12           196,340 Google Profile.ico
2019/12/14  01:05           327,680 History
2019/12/12  21:19            80,988 History Provider Cache
2019/12/14  01:05             8,720 History-journal
2019/12/14  01:01               410 in_progress_download_metadata_store
2019/12/13  22:10           174,634 Last Session
2019/12/13  21:48            88,541 Last Tabs
2019/12/13  23:03            16,384 Login Data
2019/12/13  23:03                 0 Login Data-journal
2019/12/14  01:00            73,728 Network Action Predictor
2019/12/14  01:00                 0 Network Action Predictor-journal
2019/12/14  00:51            31,483 Network Persistent State
2019/12/12  20:54            20,480 Origin Bound Certs
2019/12/12  20:54                 0 Origin Bound Certs-journal
2019/12/09  23:12            16,384 page_load_capping_opt_out.db
2019/12/09  23:12                 0 page_load_capping_opt_out.db-journal
2019/12/14  01:17            77,462 Preferences
2019/12/09  23:12            16,384 previews_opt_out.db
2019/12/09  23:12                 0 previews_opt_out.db-journal
2019/12/13  23:04            53,248 QuotaManager
2019/12/13  23:04                 0 QuotaManager-journal
2019/12/09  23:12               190 README
2019/12/09  23:12               119 Secure Preferences
2019/12/13  23:28            20,480 Shortcuts
2019/12/13  23:28                 0 Shortcuts-journal
2019/12/09  23:12            49,152 Sync360_V8.sqlite3
2019/12/09  23:12                 0 Sync360_V8.sqlite3-journal
2019/12/14  00:28            57,344 Top Sites
2019/12/14  00:28                 0 Top Sites-journal
2019/12/09  23:12             3,982 Translate Ranker Model
2019/12/14  01:17            37,133 TransportSecurity
2019/12/14  01:00           131,072 Visited Links
2019/12/14  00:59            73,728 Web Data
2019/12/14  00:59                 0 Web Data-journal
              40 个文件      2,250,507 字节
              21 个目录 212,891,762,688 可用字节
              ```