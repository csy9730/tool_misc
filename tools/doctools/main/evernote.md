# evernote

## import&export

### 导入

印象笔记只支持 envx格式和onenote格式

**Q**: 如何导入html格式？

**A**: 
通过 服务器软件挂起静态网页，通过浏览器使用减藏功能。


**Q**: 
如果你有大量文件存放在电脑上，希望全部添加到印象笔记

**A**: 可以按照如下方法批量操作

\1. 打开印象笔记 Windows 客户端，点击工具栏的工具>导入文件夹...，在弹出窗口中点击「添加」

 ![img](https://dn-udeskpub.qbox.me/1-1543209836.jpg)

 
2.在弹出的文件夹选择器对话框中，选择你希望导入的文件夹，点击「确定」


![img](https://dn-udeskpub.qbox.me/2-1543209858.jpg)

 
 

你可以做一些细节的设置

「子文件夹」选项：如果你希望同时导入子文件夹中的文件，请设置为「是」，如果不需要则设置为「否」

![img](https://dn-udeskpub.qbox.me/3-1543209898.jpg)

*温馨提示：仅支持导入最多一层子文件夹*



### 导出

导出支持：
* html格式
* envx格式
* mht格式

为知笔记支持导入html格式

### demo

evernote导出html格式，转化成markdown格式，（注意：不是标准的md格式）。
原件使用markdown格式或rst格式，通过pandoc转化成html格式，导出到evernote。