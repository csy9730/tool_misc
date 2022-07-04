# Java实现全文检索-Lucene

[![img](https://cdn2.jianshu.io/assets/default_avatar/7-0993d41a595d6ab6ef17b19496eb2f21.jpg)](https://www.jianshu.com/u/3a25975a93cb)

[Zephyr_07](https://www.jianshu.com/u/3a25975a93cb)关注

2019.02.12 14:55:53字数 3,119阅读 4,394

##### 1.1. 数据分类

结构化数据：指具有固定格式或有限长度的数据，如数据库，元数据等。
非结构化数据：指不定长或无固定格式的数据，如邮件，word文档等磁盘上的文件

##### 1.2. 非结构化数据查询方法

将非结构化数据中的一部分信息提取出来，重新组织，使其变得有一定结构，然后对此有一定结构的数据进行搜索，从而达到搜索相对较快的目的。这部分从非结构化数据中提取出的然后重新组织的信息，我们称之索引。
例如：字典。字典的拼音表和部首检字表就相当于字典的索引，对每一个字的解释是非结构化的，如果字典没有音节表和部首检字表，在茫茫辞海中找一个字只能顺序扫描。然而字的某些信息可以提取出来进行结构化处理，比如读音，就比较结构化，分声母和韵母，分别只有几种可以一一列举，于是将读音拿出来按一定的顺序排列，每一项读音都指向此字的详细解释的页数。我们搜索时按结构化的拼音搜到读音，然后按其指向的页数，便可找到我们的非结构化数据——也即对字的解释。
**这种先建立索引，再对索引进行搜索的过程就叫全文检索(Full-text Search)。**
虽然创建索引的过程也是非常耗时的，但是索引一旦创建就可以多次使用，全文检索主要处理的是查询，所以耗时间创建索引是值得的。

##### 2.1. 可以使用Lucene实现全文检索

**2.2.1. 获取原始文档**
Lucene不提供信息采集的类库，需要自己编写一个爬虫程序实现信息采集，也可以通过一些开源软件实现信息采集，如下：

Nutch（[http://lucene.apache.org/nutch](https://links.jianshu.com/go?to=http%3A%2F%2Flucene.apache.org%2Fnutch)）, Nutch是apache的一个子项目，包括大规模爬虫工具，能够抓取和分辨web网站数据。

jsoup（[http://jsoup.org/](https://links.jianshu.com/go?to=http%3A%2F%2Fjsoup.org%2F) ），jsoup 是一款Java 的HTML解析器，可直接解析某个URL地址、HTML文本内容。它提供了一套非常省力的API，可通过DOM，CSS以及类似于jQuery的操作方法来取出和操作数据。

heritrix（[http://sourceforge.net/projects/archive-crawler/files/](https://links.jianshu.com/go?to=http%3A%2F%2Fsourceforge.net%2Fprojects%2Farchive-crawler%2Ffiles%2F)），Heritrix 是一个由 java 开发的、开源的网络爬虫，用户可以使用它来从网上抓取想要的资源。其最出色之处在于它良好的可扩展性，方便用户实现自己的抓取逻辑。

本案例我们要获取磁盘上文件的内容，可以通过文件流来读取文本文件的内容，对于pdf、doc、xls等文件可通过第三方提供的解析工具读取文件内容，比如Apache POI读取doc和xls的文件内容。

**2.2.2. 创建文档对象**
在索引前需要将原始内容创建成**文档（Document）**，文档中包括一个一个的**域（Field）**，域中存储内容。
注意：每个Document可以有多个Field，不同的Document可以有不同的Field，同一个Document可以有相同的Field（域名和域值都相同）
每个文档都有一个唯一的编号，就是文档id。

此例子中



![img](https://upload-images.jianshu.io/upload_images/14588055-327b151e0f9d6069.jpg?imageMogr2/auto-orient/strip|imageView2/2/w/487/format/webp)

ABC.jpg

**2.2.3. 分析文档**
需要再对域中的内容进行分析，分析的过程是经过对原始文档提取单词、将字母转为小写、去除标点符号、去除停用词等过程生成最终的语汇单元，可以将语汇单元理解为一个一个的单词。

比如下边的文档经过分析如下：
原文档内容：
Lucene is a Java full-text search engine. Lucene is not a complete
application, but rather a code library and API that can easily be used
to add search capabilities to applications.
分析后得到的语汇单元：
lucene、java、full、search、engine。。。。

每个单词叫做一个**Term**，不同的域中拆分出来的相同的单词是不同的term。term中包含两部分一部分是文档的域名，另一部分是单词的内容。
例如：文件名中包含apache和文件内容中包含的apache是不同的term。

**2.2.4. 创建索引**
对所有文档分析得出的语汇单元进行索引，索引的目的是为了搜索
注意：创建索引是对语汇单元索引，通过词语找文档，这种索引的结构叫**倒排索引结构**。
传统方法是根据文件找到该文件的内容，在文件内容中匹配搜索关键字，这种方法是顺序扫描方法，数据量大、搜索慢。

**2.2.5. 查询索引**
用户输入查询关键字执行搜索之前需要先构建一个查询对象，查询对象中可以指定查询要搜索的Field文档域、查询关键字等，查询对象会生成具体的查询语法，
例如：
语法 “fileName:lucene”表示要搜索Field域的内容为“lucene”的文档
搜索过程就是在索引上查找域为fileName，并且关键字为Lucene的term，并根据term找到文档id列表。

##### 3.1. Lucene应用

**3.1.1. 功能一：创建索引库**

**3.1.2. Field域的属性**

![img](https://upload-images.jianshu.io/upload_images/14588055-6e76094f5c4d12e7.jpg?imageMogr2/auto-orient/strip|imageView2/2/w/696/format/webp)

sadb.jpg

代码实现



```tsx
//创建索引
    @Test
    public void createIndex() throws Exception {
        
        //指定索引库存放的路径
        //D:\temp\0108\index
        Directory directory = FSDirectory.open(new File("D:\\temp\\0108\\index"));
        //索引库还可以存放到内存中
        //Directory directory = new RAMDirectory();
        //创建一个标准分析器
        Analyzer analyzer = new StandardAnalyzer();
        //创建indexwriterCofig对象
        //第一个参数： Lucene的版本信息，可以选择对应的lucene版本也可以使用LATEST
        //第二根参数：分析器对象
        IndexWriterConfig config = new IndexWriterConfig(Version.LATEST, analyzer);
        //创建indexwriter对象
        IndexWriter indexWriter = new IndexWriter(directory, config);
        //原始文档的路径D:\传智播客\01.课程\04.lucene\01.参考资料\searchsource
        File dir = new File("D:\\传智播客\\01.课程\\04.lucene\\01.参考资料\\searchsource");
        for (File f : dir.listFiles()) {
            //文件名
            String fileName = f.getName();
            //文件内容
            String fileContent = FileUtils.readFileToString(f);
            //文件路径
            String filePath = f.getPath();
            //文件的大小
            long fileSize  = FileUtils.sizeOf(f);
            //创建文件名域
            //第一个参数：域的名称
            //第二个参数：域的内容
            //第三个参数：是否存储
            Field fileNameField = new TextField("filename", fileName, Store.YES);
            //文件内容域
            Field fileContentField = new TextField("content", fileContent, Store.YES);
            //文件路径域（不分析、不索引、只存储）
            Field filePathField = new StoredField("path", filePath);
            //文件大小域
            Field fileSizeField = new LongField("size", fileSize, Store.YES);
            
            //创建document对象
            Document document = new Document();
            document.add(fileNameField);
            document.add(fileContentField);
            document.add(filePathField);
            document.add(fileSizeField);
            //创建索引，并写入索引库
            indexWriter.addDocument(document);
        }
        //关闭indexwriter
        indexWriter.close();
    }
```

**3.2.1. 功能二：查询索引**

![img]()

sad.jpg



代码实现



```csharp
//查询索引库
    @Test
    public void searchIndex() throws Exception {
        //指定索引库存放的路径
        //D:\temp\0108\index
        Directory directory = FSDirectory.open(new File("D:\\temp\\0108\\index"));
        //创建indexReader对象
        IndexReader indexReader = DirectoryReader.open(directory);
        //创建indexsearcher对象
        IndexSearcher indexSearcher = new IndexSearcher(indexReader);
        //创建查询
        Query query = new TermQuery(new Term("filename", "apache"));
        //执行查询
        //第一个参数是查询对象，第二个参数是查询结果返回的最大值
        TopDocs topDocs = indexSearcher.search(query, 10);
        //查询结果的总条数
        System.out.println("查询结果的总条数："+ topDocs.totalHits);
        //遍历查询结果
        //topDocs.scoreDocs存储了document对象的id
        for (ScoreDoc scoreDoc : topDocs.scoreDocs) {
            //scoreDoc.doc属性就是document对象的id
            //根据document的id找到document对象
            Document document = indexSearcher.doc(scoreDoc.doc);
            System.out.println(document.get("filename"));
            //System.out.println(document.get("content"));
            System.out.println(document.get("path"));
            System.out.println(document.get("size"));
        }
        //关闭indexreader对象
        indexReader.close();
    }
```

**3.3 功能三：分析器**

**3.3.1常规分析器的分词效果**



```java
//查看标准分析器的分词效果
    public void testTokenStream() throws Exception {
        //创建一个标准分析器对象
        Analyzer analyzer = new StandardAnalyzer();
        //获得tokenStream对象
        //第一个参数：域名，可以随便给一个
        //第二个参数：要分析的文本内容
        TokenStream tokenStream = analyzer.tokenStream("test", "The Spring Framework provides a comprehensive programming and configuration model.");
        //添加一个引用，可以获得每个关键词
        CharTermAttribute charTermAttribute = tokenStream.addAttribute(CharTermAttribute.class);
        //添加一个偏移量的引用，记录了关键词的开始位置以及结束位置
        OffsetAttribute offsetAttribute = tokenStream.addAttribute(OffsetAttribute.class);
        //将指针调整到列表的头部
        tokenStream.reset();
        //遍历关键词列表，通过incrementToken方法判断列表是否结束
        while(tokenStream.incrementToken()) {
            //关键词的起始位置
            System.out.println("start->" + offsetAttribute.startOffset());
            //取关键词
            System.out.println(charTermAttribute);
            //结束位置
            System.out.println("end->" + offsetAttribute.endOffset());
        }
        tokenStream.close();
    }
```

**3.3.2 中文分析器**

Lucene自带中文分词器
 StandardAnalyzer：
单字分词：就是按照中文一个字一个字地进行分词。如：“我爱中国”，
效果：“我”、“爱”、“中”、“国”。
 CJKAnalyzer：
二分法分词：按两个字进行切分。如：“我是中国人”，效果：“我是”、“是中”、“中国”“国人”。

上边两个分词器无法满足需求。
 SmartChineseAnalyzer：
对中文支持较好，但扩展性差，扩展词库，禁用词库和同义词库等不好处理

第三方中文分析器
· paoding： 庖丁解牛最新版在 [https://code.google.com/p/paoding/](https://links.jianshu.com/go?to=https%3A%2F%2Fcode.google.com%2Fp%2Fpaoding%2F) 中最多支持Lucene 3.0，且最新提交的代码在 2008-06-03，在svn中最新也是2010年提交，已经过时，不予考虑。

· mmseg4j：最新版已从 [https://code.google.com/p/mmseg4j/](https://links.jianshu.com/go?to=https%3A%2F%2Fcode.google.com%2Fp%2Fmmseg4j%2F) 移至 [https://github.com/chenlb/mmseg4j-solr](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fchenlb%2Fmmseg4j-solr)，支持Lucene 4.10，且在github中最新提交代码是2014年6月，从09年～14年一共有：18个版本，也就是一年几乎有3个大小版本，有较大的活跃度，用了mmseg算法。

· IK-analyzer： 最新版在[https://code.google.com/p/ik-analyzer/](https://links.jianshu.com/go?to=https%3A%2F%2Fcode.google.com%2Fp%2Fik-analyzer%2F)上，支持Lucene 4.10从2006年12月推出1.0版开始， IKAnalyzer已经推出了4个大版本。最初，它是以开源项目Luence为应用主体的，结合词典分词和文法分析算法的中文分词组件。从3.0版本开 始，IK发展为面向Java的公用分词组件，独立于Lucene项目，同时提供了对Lucene的默认优化实现。在2012版本中，IK实现了简单的分词 歧义排除算法，标志着IK分词器从单纯的词典分词向模拟语义分词衍化。 但是也就是2012年12月后没有在更新。

· ansj_seg：最新版本在 [https://github.com/NLPchina/ansj_seg](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2FNLPchina%2Fansj_seg) tags仅有1.1版本，从2012年到2014年更新了大小6次，但是作者本人在2014年10月10日说明：“可能我以后没有精力来维护ansj_seg了”，现在由”nlp_china”管理。2014年11月有更新。并未说明是否支持Lucene，是一个由CRF（条件随机场）算法所做的分词算法。

· imdict-chinese-analyzer：最新版在 [https://code.google.com/p/imdict-chinese-analyzer/](https://links.jianshu.com/go?to=https%3A%2F%2Fcode.google.com%2Fp%2Fimdict-chinese-analyzer%2F) ， 最新更新也在2009年5月，下载源码，不支持Lucene 4.10 。是利用HMM（隐马尔科夫链）算法。

· Jcseg：最新版本在git.oschina.net/lionsoul/jcseg，支持Lucene 4.10，作者有较高的活跃度。利用mmseg算法。

**3.3.3 Analyzer使用时机**

1. 索引时使用Analyzer：对文档域内容进行分析，需要经过Analyzer分析器处理生成语汇单元（Token）。
2. 搜索时使用Analyzer：对搜索关键字进行分析、分词处理，使用分析后每个词语进行搜索
   注意：搜索使用的分析器要和索引使用的分析器一致。

**3.4 功能四：索引库的维护**



```tsx
//添加索引
    @Test
    public void addDocument() throws Exception {
        //索引库存放路径
        Directory directory = FSDirectory.open(new File("D:\\temp\\0108\\index"));
        
        IndexWriterConfig config = new IndexWriterConfig(Version.LATEST, new IKAnalyzer());
        //创建一个indexwriter对象
        IndexWriter indexWriter = new IndexWriter(directory, config);
        //创建一个Document对象
        Document document = new Document();
        //向document对象中添加域。
        //不同的document可以有不同的域，同一个document可以有相同的域。
        document.add(new TextField("filename", "新添加的文档", Store.YES));
        document.add(new TextField("content", "新添加的文档的内容", Store.NO));
        document.add(new TextField("content", "新添加的文档的内容第二个content", Store.YES));
        document.add(new TextField("content1", "新添加的文档的内容要能看到", Store.YES));
        //添加文档到索引库
        indexWriter.addDocument(document);
        //关闭indexwriter
        indexWriter.close();
        
    }
```

3.4.1. 索引库的添加



```tsx
//添加索引
    @Test
    public void addDocument() throws Exception {
        //索引库存放路径
        Directory directory = FSDirectory.open(new File("D:\\temp\\0108\\index"));
        
        IndexWriterConfig config = new IndexWriterConfig(Version.LATEST, new IKAnalyzer());
        //创建一个indexwriter对象
        IndexWriter indexWriter = new IndexWriter(directory, config);
        //创建一个Document对象
        Document document = new Document();
        //向document对象中添加域。
        //不同的document可以有不同的域，同一个document可以有相同的域。
        document.add(new TextField("filename", "新添加的文档", Store.YES));
        document.add(new TextField("content", "新添加的文档的内容", Store.NO));
        document.add(new TextField("content", "新添加的文档的内容第二个content", Store.YES));
        document.add(new TextField("content1", "新添加的文档的内容要能看到", Store.YES));
        //添加文档到索引库
        indexWriter.addDocument(document);
        //关闭indexwriter
        indexWriter.close();
        
    }
```

3.4.3. 索引库的删除

1. 删除全部



```java
//删除全部索引
    @Test
    public void deleteAllIndex() throws Exception {
        IndexWriter indexWriter = getIndexWriter();
        //删除全部索引
        indexWriter.deleteAll();
        //关闭indexwriter
        indexWriter.close();
    }
```

1. 指定查询条件删除



```java
//根据查询条件删除索引
    @Test
    public void deleteIndexByQuery() throws Exception {
        IndexWriter indexWriter = getIndexWriter();
        //创建一个查询条件
        Query query = new TermQuery(new Term("filename", "apache"));
        //根据查询条件删除
        indexWriter.deleteDocuments(query);
        //关闭indexwriter
        indexWriter.close();
    }
```

1. 索引库的修改



```tsx
//修改索引库
    @Test
    public void updateIndex() throws Exception {
        IndexWriter indexWriter = getIndexWriter();
        //创建一个Document对象
        Document document = new Document();
        //向document对象中添加域。
        //不同的document可以有不同的域，同一个document可以有相同的域。
        document.add(new TextField("filename", "要更新的文档", Store.YES));
        document.add(new TextField("content", "2013年11月18日 - Lucene 简介 Lucene 是一个基于 Java 的全文信息检索工具包,它不是一个完整的搜索应用程序,而是为你的应用程序提供索引和搜索功能。", Store.YES));
        indexWriter.updateDocument(new Term("content", "java"), document);
        //关闭indexWriter
        indexWriter.close();
    }
```

**3.5.1 Lucene索引库查询**

可通过两种方法创建查询对象：
**1）使用Lucene提供Query子类**
Query是一个抽象类，lucene提供了很多查询对象，比如TermQuery项精确查询，NumericRangeQuery数字范围查询等。
如下代码：
Query query = new TermQuery(new Term("name", "lucene"));
**2）使用QueryParse解析查询表达式**
QueryParse会将用户输入的查询表达式解析成Query对象实例。
如下代码：
QueryParser queryParser = new QueryParser("name", new IKAnalyzer());
Query query = queryParser.parse("name:lucene");

3.5.2. 使用query的子类查询
①MatchAllDocsQuery

使用MatchAllDocsQuery查询索引目录中的所有文档



```java
@Test
    public void testMatchAllDocsQuery() throws Exception {
        IndexSearcher indexSearcher = getIndexSearcher();
        //创建查询条件
        Query query = new MatchAllDocsQuery();
        //执行查询
        printResult(query, indexSearcher);
    }
```

②TermQuery

TermQuery，通过项查询，TermQuery不使用分析器所以建议匹配不分词的Field域查询，比如订单号、分类ID号等。
指定要查询的域和要查询的关键词。



```csharp
//使用Termquery查询
    @Test
    public void testTermQuery() throws Exception {
        IndexSearcher indexSearcher = getIndexSearcher();
        //创建查询对象
        Query query = new TermQuery(new Term("content", "lucene"));
        //执行查询
        TopDocs topDocs = indexSearcher.search(query, 10);
        //共查询到的document个数
        System.out.println("查询结果总数量：" + topDocs.totalHits);
        //遍历查询结果
        for (ScoreDoc scoreDoc : topDocs.scoreDocs) {
            Document document = indexSearcher.doc(scoreDoc.doc);
            System.out.println(document.get("filename"));
            //System.out.println(document.get("content"));
            System.out.println(document.get("path"));
            System.out.println(document.get("size"));
        }
        //关闭indexreader
        indexSearcher.getIndexReader().close();
    }
```

③NumericRangeQuery

可以根据数值范围查询。



```java
//数值范围查询
    @Test
    public void testNumericRangeQuery() throws Exception {
        IndexSearcher indexSearcher = getIndexSearcher();
        //创建查询
        //参数：
        //1.域名
        //2.最小值
        //3.最大值
        //4.是否包含最小值
        //5.是否包含最大值
        Query query = NumericRangeQuery.newLongRange("size", 1l, 1000l, true, true);
        //执行查询
        printResult(query, indexSearcher);
    }
```

④BooleanQuery
可以组合查询条件。



```csharp
//组合条件查询
    @Test
    public void testBooleanQuery() throws Exception {
        IndexSearcher indexSearcher = getIndexSearcher();
        //创建一个布尔查询对象
        BooleanQuery query = new BooleanQuery();
        //创建第一个查询条件
        Query query1 = new TermQuery(new Term("filename", "apache"));
        Query query2 = new TermQuery(new Term("content", "apache"));
        //组合查询条件
        query.add(query1, Occur.MUST);
        query.add(query2, Occur.MUST);
        //执行查询
        printResult(query, indexSearcher);
    }
//Occur.MUST：必须满足此条件，相当于and
//Occur.SHOULD：应该满足，但是不满足也可以，相当于or
//Occur.MUST_NOT：必须不满足。相当于not
```

3.5.3. 使用queryparser查询
通过QueryParser也可以创建Query，QueryParser提供一个Parse方法，此方法可以直接根据查询语法来查询。Query对象执行的查询语法可通过System.out.println(query);查询。
需要使用到分析器。建议创建索引时使用的分析器和查询索引时使用的分析器要一致。

程序实现



```java
@Test
    public void testQueryParser() throws Exception {
        IndexSearcher indexSearcher = getIndexSearcher();
        //创建queryparser对象
        //第一个参数默认搜索的域
        //第二个参数就是分析器对象
        QueryParser queryParser = new QueryParser("content", new IKAnalyzer());
        Query query = queryParser.parse("Lucene是java开发的");
        //执行查询
        printResult(query, indexSearcher);
    }
```

**查询语法**
1、基础的查询语法，关键词查询：

域名+“：”+搜索的关键字

例如：content:java

2、范围查询

域名+“:”+[最小值 TO 最大值]

例如：size:[1 TO 1000]

范围查询在lucene中支持数值类型，不支持字符串类型。在solr中支持字符串类型。

3、组合条件查询

1）+条件1 +条件2：两个条件之间是并且的关系and

例如：+filename:apache +content:apache

2）+条件1 条件2：必须满足第一个条件，应该满足第二个条件

例如：+filename:apache content:apache

3）条件1 条件2：两个条件满足其一即可。

例如：filename:apache content:apache

4）-条件1 条件2：必须不满足条件1，要满足条件2

例如：-filename:apache content:apache

Occur.MUST 查询条件必须满足，相当于and → +（加号）
Occur.SHOULD 查询条件可选，相当于or → 空（不用符号）
Occur.MUST_NOT 查询条件不能满足，相当于not非 → -（减号）

第二种写法：

条件1 AND 条件2

条件1 OR 条件2

条件1 NOT 条件2

**MultiFieldQueryParser**
可以指定多个默认搜索域



```java
@Test
    public void testMultiFiledQueryParser() throws Exception {
        IndexSearcher indexSearcher = getIndexSearcher();
        //可以指定默认搜索的域是多个
        String[] fields = {"filename", "content"};
        //创建一个MulitFiledQueryParser对象
        MultiFieldQueryParser queryParser = new MultiFieldQueryParser(fields, new IKAnalyzer());
        Query query = queryParser.parse("java AND apache");
        System.out.println(query);
        //执行查询
        printResult(query, indexSearcher);
        
    }
```

e.g. 本文仅供个人笔记使用，借鉴部分网上资料。