# calibre-db.exe

[calibredb](https://manual.calibre-ebook.com/generated/en/calibredb.html)


## help
```
show_metadata

set_metadata

search

fts_index 建立全文索引
calibredb fts_index [options] enable/disable/status/reindex

fts_search 全文搜索
calibredb fts_search [options] search expression


restore_database
calibredb restore_database [options]

show_metadata

set_metadata

```
#### list

```
C:\greensoftware\Calibre Portable\Calibre>calibredb.exe list
id title                                                authors
1 Quick Start Guide                                    John Schember
2 TRAJECTORY PLANNING FOR AUTOMATIC MACHINES AND       Luigi Biagiotti
  ROBOTS
3 S形加减速的嵌套式前瞻快速算法                        何均
6 Moving Along a Curve with Specified Speed            David Eberly
```

#### export
```
C:\greensoftware\Calibre Portable\Calibre>calibredb.exe export --all
```
#### add
```
C:\greensoftware\Calibre Portable\Calibre>calibredb.exe add C:\Mirror\calibre\ -r
Syntax Error: No display font for 'ArialNarrow'
Syntax Error: No display font for 'ArialNarrow,Bold'
Syntax Error: No display font for 'ArialNarrow,Italic'
```

#### catalog
导出目录，可以以csv格式

``` csv
author_sort,authors,comments,cover,formats,id,identifiers,isbn,languages,library_name,pubdate,publisher,rating,series,series_index,size,tags,timestamp,title,title_sort,uuid
书库","2008-09-12T20:53:11+08:00","","","","1.0","16164022","","2023-02-16T12:04:08+08:00","TRAJECTORY PLANNING FOR AUTOMATIC MACHINES AND ROBOTS","TRAJECTORY PLANNING FOR AUTOMATIC MACHINES AND ROBOTS","f145e701-fea4-43d0-92e7-5631cf1c336f"
```

## misc

Documented commands
- calibre 窗口程序
- calibre-customize
- calibre-debug
- calibre-server 启动内容服务器
- calibre-smtp
- calibredb 数据库管理器
- ebook-convert 电子书转换器
- ebook-edit 电子书编辑器
- ebook-meta
- ebook-polish
- ebook-viewer 电子书浏览器
- fetch-ebook-metadata 通过google、Amazon网站抓取书本的元信息，至少含有标题、作者或ISBN号
- lrf2lrs
- lrfviewer
- lrs2lrf
- web2disk


#### 5

``` xml
<?xml version='1.0' encoding='utf-8'?>
<package xmlns="http://www.idpf.org/2007/opf" unique-identifier="uuid_id" version="2.0">
    <metadata xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:opf="http://www.idpf.org/2007/opf">
        <dc:identifier opf:scheme="calibre" id="calibre_id">3</dc:identifier>
        <dc:identifier opf:scheme="uuid" id="uuid_id">897f8a85-4f44-458a-b1a4-b83a243a674e</dc:identifier>
        <dc:title>S形加减速的嵌套式前瞻快速算法</dc:title>
        <dc:creator opf:file-as="未知" opf:role="aut">何均</dc:creator>
        <dc:contributor opf:file-as="calibre" opf:role="bkp">calibre (6.12.0) [https://calibre-ebook.com]</dc:contributor>
        <dc:date>0101-01-01T00:00:00+00:00</dc:date>
        <dc:language>zh</dc:language>
        <meta name="calibre:author_link_map" content="{&quot;何均&quot;: &quot;&quot;}"/>
        <meta name="calibre:timestamp" content="2023-02-16T04:04:22+00:00"/>
        <meta name="calibre:title_sort" content="S形加减速的嵌套式前瞻快速算法"/>
    </metadata>
    <guide>
        <reference type="cover" title="封面" href="SXing Jia Jian Su De Qian Tao Shi Qian Zhan Kuai Su Suan Fa  - He Jun.jpg"/>
    </guide>
</package>
```


``` xml
<dc:title>书名</dc:title>
<dc:creator opf:file-as="保存作者路径？" opf:role="aut">作者</dc:creator>
<meta name="calibre:author_link_map" content="{&quot;作者&quot;: &quot;&quot;}"/>
<meta name="calibre:title_sort" content="保存书名文件路径"/>
```
