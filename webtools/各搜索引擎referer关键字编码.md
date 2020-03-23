# 各搜索引擎referer关键字，编码



在做商务E流量分析的时候，需要实现一个功能：如果访客是通过搜索引擎的搜索找到客户网站的，要统计出访客是通过哪个搜索引擎访问到页面，并且统计出是通过 什么关键字搜索到该网站的。在网上google一下，发出对这方面的描述文档还是比较少的，在做这个功能的过程中有些经验给人家分享一下。

实现这样的功能，基本原理是获取到来源地址，然后分析其中的内容，把所需要的搜索引擎名称和关键字取出。
获取来源地址很简单，在servlet 中可以通过HttpServletRequest.getHeader("Referer")方法取得,jsp页面中可以通过 request.getHeader("referer")取得。取得来源地址后便可以通过分析得到的来源地址分析出我们所需要的内容。通常我们常用的搜 索引擎有以下14个。
http://www.google.com;
http://www.google.cn;
http://www.sogou.com;
http://so.163.com;
http://www.iask.com;
http://www.yahoo.com;
http://www.baidu.com;
http://www.3721.com;
http://www.soso.com;
http://www.zhongsou.com;
http://www.alexa.com;
http://www.search.com;
http://www.lycos.com;
http://www.aol.com;

 要获取我们所需要的内容，我们必须分析 各个引擎的特性，由于各个搜索引擎的格式不一样，获取到的来源地址必然也不一致，下面我们来分析一下各种搜索引擎的地址格式。

  在搜索引擎里输入关键字，点击搜索之后地址栏中的内容就是我们通过HttpServletRequest.getHeader("Referer")或 request.getHeader("referer")取得的来源地址。


google搜索引擎：
http://www.google.com/search?hl= zh-N&newwindow=1&
q=%E4%BB%8A%E7%A7%91%E4%BF%A1%E6%81%AF%E7%A7%91%E6%8A%80&
btnG= %E6%90%9C%E7%B4%A2&lr=

http://www.google.cn/search?hl= zh-N&newwindow=1&
q=%E6%B0%B8%E5%AE%89%E8%B7%AF%E7%81%AF&
btnG= %E6%90%9C%E7%B4%A2&meta=

从这里我们可以得到我们所需要的搜索引擎名称和关键字。其中，搜索引擎显而易见，是google;而关键字呢？经过我仔细观察、
测试后发现关键字是编码后放 在参数q里，也就是说
%E4%BB%8A%E7%A7%91%E4%BF%A1%E6%81%AF%E7%A7%91%E6%8A%80和
%E6%B0 %B8%E5%AE%89%E8%B7%AF%E7%81%AF
就是输入的关键字。


(有人会问，那btnG这个参数的值是什么来头,他也编过码 啊?是用来干嘛的呢？呵呵，它什么来头都没有，什么也没干，多余的！你试试输入关键字之后点击搜索按钮看看地址栏，然后再试试输入关键字之后回车，再看看 地址栏，看出两种做法在地址栏中的一点点差别之后你就会明白的啦)

baidu搜索引擎：
(1)http://www.baidu.com/s?ie=gb2312&bs=%CB%B3%B5%C2%BC%D2%BE%DF&sr=&z=&cl=3&f=8&
wd=%BD%F1%BF%C6%BF%C6%BC%BC&ct=0
(2)http://www.baidu.com/baidu?tn=nanlingcb&word=%CB%B3%B5%C2%BC%D2%BE%DF

baidu 搜索引擎，这里需要说明一下，当我们在通过在http://www.baidu.com中 输入搜索关键字，获取的来源地址为(1)字符串；当通过其它方式，比如在一些浏览器插件中输入关键字搜索的获取的来源地址为(2)字符串。通过获取来的这来源地，我也可以很容易的知道当前的搜索引擎是baidu；而关键字呢?看看(1),这里有两个经过编码的字符串，到底哪个是关键字呢？wd的值是关键字！信我啦！那bs的值是什么呢？你输入关键字多搜索几次，看看你有什么发现？发现了吧，bs是你上一次搜索的关键字！这个我们不管，它不是我们所要的东 西。分析得知，在baidu搜索引擎里有两个地方放关键字，一个地方是编码后放在在参数wd里，另外一个地方是编码后放在word参数里。明白了吧？：)


sogou搜索引擎
http://www.sogou.com/web?query=%BD%F1%BF%C6%D0%C5%CF%A2%BF%C6%BC%BC
这个就没这么复杂了，我们通过字符串可以知道搜索引擎为sogou，关键字经编码后放在参数query里,这里值为
%BD%F1%BF%C6%D0%C5 %CF%A2%BF%C6%BC%BC,有时候也会附带多一些参数，但附带的这些参数对我们来说是没用的。

163搜索引擎
http://cha.so.163.com/so.php?in=seek&c=26&key=032152284&q=%BD%F1%BF%C6%D0%C5%CF%A2%BF%C6%BC%BC
&x=61&y=19
这个也不复杂，分析得知，搜索引擎名称为163,关键字在参数q里,这里值为%BD%F1%BF%C6%D0%C5%CF%A2%BF%C6%BC%BC


yahoo 搜索引擎
http://search.cn.yahoo.com/search?p=%D3%C0%B0%B2%C2%B7%B5%C6&
source=toolbar_yassist_button&pid=58061_1006&ei=gbk

http://search.cn.yahoo.com/search?lp=%E4%B8%AD%E5%B1%B1%E5%8F%A4%E9%95%87%E7%81%AF%E9%A5%B0&
p=%E4%BB%8A%E7%A7%91%E4%BF%A1%E6%81%AF%E7%A7%91%E6%8A%80&pid=&ei=UTF-8
很容易得到，搜索引擎名称为yahoo,那关键字是哪些呢?关键字是放在参数p里，而参数lp的值跟baidu类似，也是上一次搜索的关键字。

lycos 搜索引擎
http://search.lycos.com/?query=website
这 个我们用得比较少，同样我们通过这个字符串得出搜索引擎为lycos，关键字放在query里.

3721搜索引擎
http://seek.3721.com/index.htm?name=%D6%E9%BA%A3%CF%E3%D6%DE%C0%CD%CE%F1%CA%D0%B3%A1
容 易得到，搜索引擎名称为3721，关键字放在name里

search搜索引擎
http://www.search.com/search?lq=d%25E4%25B8%25AD%25E5%259B%25BDd&
q=%E4%B8%AD%E5%8D%8E%E4%BA%BA%E6%B0%91%E5%85%B1%E5%9B%BD%E5%92%8C
这 个我们用得很少，也容易得到搜索引擎名称为search,关键字放在p里，而lp放的是什么呢？尚未弄清楚，
反正与我们所要的东西无关。

soso 搜索引擎
http://www.soso.com/q?w=%BD%F1%BF%C6%D0%C5%CF%A2%BF%C6%BC%BC12&sc=web&
bs=%BD%F1%BF%C6%D0%C5%CF%A2%BF%C6%BC%BC1&ch=w.soso.pr&uin=&lr=chs&web_options=on
可 以看出搜索引擎名称为soso，关键字放在参数w里，需参数bs的值跟baidu相似，是上一次搜索的关键字

zhongsou搜索引擎
http://p.zhongsou.com/p?w=%BD%F1%BF%C6%D0%C5%CF%A2%BF%C6%BC%BC&l=&jk=&k=&r=&aid=&pt=1&dt=2
可 以看出搜索引擎名称为zhongsou,关键字在参数w里。

alexa搜索引擎
http://www.alexa.com/search?q=%E4%BB%8A%E7%A7%91%E4%BF%A1%E6%81%AF%E7%A7%91%E6%8A%80
得出搜索引擎名称为zhongsou，关键字放在参数q里。

  对各种搜索引擎的url的分析已完成，大家都对这些常用的搜索引擎的url的格式有所了解了，下面我们看看怎样从我们所取得的这些字符串中得到我们所要的信息,也就是怎样从这些字符串中提取我们所需的搜索引擎名称和搜索关键字.这里理所当然使用功能强大的正则表达式了.好,现在我们逐个逐个地分析各个搜索引擎用什么正则表达式提取我们所需要的内容.
首先还是先分析 google搜索引擎:
上面已经提到我们取得的google搜索引擎的地址是这样的:
http://www.google.com/search?hl= zh-N&newwindow=1
&q=%E4%BB%8A%E7%A7%91%E4%BF%A1%E6%81%AF%E7%A7%91%E6%8A%80&
btnG= %E6%90%9C%E7%B4%A2&lr=

http://www.google.cn/search?hl= zh-N&newwindow=1
&q=%E6%B0%B8%E5%AE%89%E8%B7%AF%E7%81%AF&
btnG= %E6%90%9C%E7%B4%A2&meta=

其 实它还有一种形式是这样的:
(3)http://www.google.com/custom?hl=zh-CN&inlang=zh-CN&ie=GB2312&oe=GB2312&newwindow=1&
client=pub3261928361684765&cof=FORID%3A1%3BGL%3A1%3BBGC%3AFFFFFF%3BT%3A%23000000%3BLC%3A
%230000ff%3BVLC%3A%23663399%3BALC%3A%230000ff%3BGALT%3A%23008000%3BGFNT%3A
%230000ff%3BGIMP%3A%230000ff%3BDIV%3A%23336699%3BLBGC%3A336699%3BAH%3Acenter%3B
&q=%C5%B7%C2%FC%D5%D5%C3%F7&lr=
OH,my god,是不是看得头晕了?先不要晕,往下看你就不会觉得晕的啦....

我们仔细观察一下,这三种格式都有一个共通点,大家有没有发现呢?就是 他的格式都是这样的:


http://www.google.[...]/[...]&q= [关键字][...]
[...]表示有一个以上的字符.

就如(2)我们在里面放入一些[]就可以看得更清楚了:
http://www.google.[cn]/[search?hl=zh-CN&newwindow=1]
&q=[%E6%B0%B8%E5%AE%89%E8%B7%AF%E7%81%AF][&btnG=%E6%90%9C%E7%B4%A2&meta=]
看明白了吧?看明白了我们就接下去了.于是我们可以得出google搜索引擎的正则表达式了:

**http:\\/\\/www\\.google \\.[a-zA-Z]+\\/.+[\\&\\?]q=[^\\&]\*。**

  现在解释一下这个正则表达式的意思。
http:\\/ \\/www\\.这一段是匹配http://www.,为什么这里多了这么多\呢?因为字符 '/'和字符'.'在正则表达式中有特殊意义,要用'\'对这两个字符转义,'/'通过'\/'转义,相似的.也通过'\.'转义,而字符'\'在 java里也是一个特殊字符,本身也需要转义,所以'\/'写成'\\/',类似的'\.'写成'\\.'；

接下来google\\.[a-zA-Z]+ \\/.+匹配google.com/search?hl=zh-CN&newwindow=1,这里解释一下[a-zA-Z]+,意思是最少有 一个(包括一个)以上英文字母,[a-zA-Z]表示从a到z,从A到Z的字符,+表示至少一个以上,[\\&\\?]q=[^\\&amp;]*匹配的是&q=%E6%B0%B8%E5%AE%89%E8%B7%AF%E7%81%AF,[\\&\\?],表示字符&amp;或字符?由于&和?都是特殊字符，所以都要用转义符转义,q=[^\\&]*表示q=后面是零个（包括零个）以上的非& 字符,[^\\&]表示不为&的字符,为什么不为&呢，因为&后面的字符也经不再属于参数q的值了，我们要取的是q=之 后，字符&之前的字符串.这个正则表达式的解释就到此了。现在这个正则表达式已经可以从众多的获取过来的来源地址中分辩出哪些是google搜索引擎了，但是有一个问题，假如以后google搜索引擎不是这样，换成http://search.google.com/search?hl=zh-CN&newwindow=1&q=%E6%B0%B8%E5%AE%89%E8%B7%AF%E7%81%AF
&btnG=%E6%90%9C%E7%B4%A2&meta= 呢，

那这个正则表达式就不合适了，怎样能在以后改动之后我们写的正则表达式还适用呢？很简单，我们把它改成这个样子:\\.google\\.[a- zA-Z]+\\/.+[\\&\\?]q=[^\\&]*,意思是我们不必匹配http://www这 一串字符串。这样如果google搜索引擎做了类似http://search.google.com/..... 的修改，我们写的正则表达式也适用了，那假如它把域名也改了就没得说了,:);还有一种情况，在地址栏里输入www.google.com:80/也可以正常访问google,也就是说还有 一种情况就是加端口的访问，这种情况也要考虑到，因此之前我们的正则表达式应改成：\\.google\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]q=[^\\&]*， (:\\d{1,}){0,1}是什么意思呢？他匹配类似":80"也就是说冒号(:)后跟1个以上的数字字符，而端口是可选的，并且如果出现只会出现一 次，所以用{0,1}.这个正则表达式的用途是用于获取关键字，所以这里我把关键字部分划分为一个组(这在下面会用到),因此，最终的正则表达式为:

\\.google\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]q=([^\\&]*)

对 google搜索引擎已经说得很详细，接下来的我就简略的说说了，原理都差不多的了。


baidu搜索引擎：
分 析得知baidu搜索引擎的正则表达式为：
\\.baidu\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]wd=([^\\&]*) 或
\\.baidu\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]word=([^\\&]*)

sogou 搜索引擎
http://www.sogou.com/web?query=%BD%F1%BF%C6%D0%C5%CF%A2%BF%C6%BC%BC
正 则表达式:
\\.sogou\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]query=([^\\&]*)

yahoo搜索引擎
正 则表达式:
\\.yahoo\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]p=([^\\&]*)

lycos 搜索引擎
http://search.lycos.com/?query=website
正 则表达式:
\\.lycos\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.*[\\&\\?]query=([^\\&]*)

3721 搜索引擎
http://seek.3721.com/index.htm?name=%D6%E9%BA%A3%CF%E3%D6%DE%C0%CD%CE%F1%CA%D0%B3%A1
http://seek.3721.com/index.htm?q=%D6%E9%BA%A3%CF%E3%D6%DE%C0%CD%CE%F1%CA%D0%B3%A1
正 则表达式:
\\.3721\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]p=([^\\&]*) 或
\\.3721\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]name=([^\\&]*)

search 搜索引擎 
正则表达式:
\\.search\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]q=([^\\&]*)

soso搜索引擎
正 则表达式:
\\.soso\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]w=([^\\&]*)

zhongsou搜索引擎
http://p.zhongsou.com/p?w=%BD%F1%BF%C6%D0%C5%CF%A2%BF%C6%BC%BC&l=&jk=&k=&r=&aid=&pt=1&dt=2
正 则表达式:
\\.zhongsou\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]w=([^\\&]*)

alexa搜索引擎
http://www.alexa.com/search?q=%E4%BB%8A%E7%A7%91%E4%BF%A1%E6%81%AF%E7%A7%91%E6%8A%80
正 则表达式:
\\.alexa\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]q=([^\\&]*)

iask搜索引擎
正则表达式:
\\.iask\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]k=([^\\&]*) 或
\\.iask\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]_searchkey=([^\\&]*)


好了，正则表达式已经写出来了，事情已经完成一半了。现在我们把话题转一下，等会我们再转回来，现在我们先看看如何获取搜索引擎的名称。同样，也 需要用正则表达式，正则表达式实在太强了：)。
我们可以通过以下的正则表达式匹配到google搜索引擎：
http:\\/\\/.* \\.google\\.com(:\\d{1,}){0,1}\\/或
http:\\/\\/.*\\.google\\.cn(:\\d{1,}){0,1}\\/

类 似的也可以匹配其它搜索引擎，我把他们写在一起:
http:\\/\\/.*\\.(google\\.com(:\\d{1,}){0,1}\\/|google\\.cn(:\\d{1,}){0,1}\\/|
baidu\\.com(:\\d{1,}){0,1}\\/|yahoo\\.com(:\\d{1,}){0,1}\\/|
iask\\.com(:\\d{1,}){0,1}\\/|sogou\\.com(:\\d{1,}){0,1}\\/|
163\\.com(:\\d{1,}){0,1}\\/|lycos\\.com(:\\d{1,}){0,1}\\/|
aol\\.com(:\\d{1,}){0,1}\\/|3721\\.com(:\\d{1,}){0,1}\\/|
search\\.com(:\\d{1,}){0,1}\\/|soso.com(:\\d{1,}){0,1}\\/|
zhongsou\\.com(:\\d{1,}){0,1}\\/|alexa\\.com(:\\d{1,}){0,1}\\/)
通过以下程序可以获取到搜索引擎的名称:

```
import java.util.regex.*;
public class GetEngine
{
public static void main(String[] arg)
{
   GetEngine engine=new GetEngine();
  
   String referer="http://www.baidu.com/s?wd=java%D1%A7%CF%B0%CA%D2";
   String engineName=engine.getSearchEngine(referer);
   System.out.println("搜索引擎名称:"+engineName);
}
public String getSearchEngine(String refUrl) {
    if(refUrl.length()>11)
    {
       //p是匹配各种搜索引擎的正则表达式
      Pattern p = Pattern.compile("http:\\/\\/.*\\.(google\\.com(:\\d{1,}){0,1}\\/|
        google\\.cn(:\\d{1,}){0,1}\\/|baidu\\.com(:\\d{1,}){0,1}\\/|
        yahoo\\.com(:\\d{1,}){0,1}\\/|iask\\.com(:\\d{1,}){0,1}\\/|
        sogou\\.com(:\\d{1,}){0,1}\\/|163\\.com(:\\d{1,}){0,1}\\/|
        lycos\\.com(:\\d{1,}){0,1}\\/|aol\\.com(:\\d{1,}){0,1}\\/|
        3721\\.com(:\\d{1,}){0,1}\\/|search\\.com(:\\d{1,}){0,1}\\/|
        soso.com(:\\d{1,}){0,1}\\/|zhongsou\\.com(:\\d{1,}){0,1}\\/|
        alexa\\.com(:\\d{1,}){0,1}\\/)");
      Matcher m = p.matcher(refUrl);
      if (m.find())//如果来源地址可以匹配以上的pattern
      {
//因为m.group(0)是域名，m.group(1)才是我们最合适我们所要的
        return insteadCode(m.group(1),"(\\.com(:\\d{1,}){0,1}\\/|\\.cn(:\\d{1,}){0,1}\\/|
\\.org(:\\d{1,}){0,1}\\/)","");//把.com,.cn,.org替换为""
      }
    }
    return "未发现搜索引擎";
}
public String insteadCode(String str,String regEx,String code){
    Pattern p=Pattern.compile(regEx);
    Matcher m=p.matcher(str);
    String s=m.replaceAll(code);
    return s;
}
}
```

 

通过以上的代码即可得出搜索引擎名称了，似乎任务完成一大半了。只是接着下来的要做的事情比之前所做的要麻烦点点,麻烦就麻烦在编码上。
现在我样回过头看我们上面写的一大堆各种搜索引擎的正则表达式。
由于这里要大量的字符串操作，这里使用StringBuffer来做字符串的连接。
StringBuffer sb=new StringBuffer();
sb.append("\\.google\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]q=([^\\&]*)")
.append("|\\.iask\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]k=([^\\&]*)")
.append("|\\.iask\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]_searchkey=([^\\&]*)")
.append("|\\.sogou\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]query=([^\\&]*)")
.append("|\\.163\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]q=([^\\&]*)")
.append("|\\.yahoo\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]p=([^\\&]*)")
.append("|\\.baidu\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]wd=([^\\&]*)")
.append("|\\.baidu\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]word=([^\\&]*)")
.append("|\\.lycos\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.*[\\&\\?]query=([^\\&]*)")
.append("|\\.aol\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]encquery=([^\\&]*)")
.append("|\\.3721\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]p=([^\\&]*)")
.append("|\\.3721\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]name=([^\\&]*)")
.append("|\\.search\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]q=([^\\&]*)")
.append("|\\.soso\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]w=([^\\&]*)")
.append("|\\.zhongsou\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]w=([^\\&]*)")
.append("|\\.alexa\\.[a-zA-Z]+(:\\d{1,}){0,1}\\/.+[\\&\\?]q=([^\\&]*)");

这个正则表达式是把所有搜索引擎用或"|"连接起来，因为只要匹配其中一个搜索引擎的正则表达式就可以。
前面已经说到，关键字是经过编码 的，我们直接取出的关键字会像%BD%F1%BF%C6%D0%C5%CF%A2%BF%C6%BC%BC12,
这样的关键字我们无法读懂，因些需要对这 些关键进行反编码，这要用到java.net.URLDecoder.decode(String s,String enc),这个方法有两个参数，一个参数是要进行反编码的字符串，另一个是指定的字符集。第一个参数很简单，只要我们把取得的关键放到这个参数里，至于第 二个参数怎样呢？这里我只讨论中文的情况，这些搜索引擎有两种字符集编码方式，一种是UTF-8，另外一种是GBK。
只有GBK一种编码方式的搜 索引擎：
3721，iask，sogou，163，baidu，soso，zhongsou
只有UTF-8一种编码方式的搜索引擎:
lycos,aol,search,alexa
有 两种编码方式的：
google,yahoo

只有一种编码方式的问题容易解决，有两种编码方式的怎办呢？办法总比问题多，其实采用哪一个编码方工，它是有”暗示“的，对于google，大多数情况下它是采用UTF-8的编码方式，我们在浏览器的地址栏上输入[www.google.com](http://www.google.com/)搜索的都是以这种方式来编码的，但有种情况如：
http://www.google.com/custom?hl=zh-CN&inlang=zh-CN&ie=GB2312&oe=GB2312&newwindow=1&client=pub-3261928361684765&
cof=FORID%3A1%3BGL%3A1%3BBGC%3AFFFFFF%3BT%3A%23000000%3BLC%3A%230000ff
%3BVLC%3A%23663399%3BALC%3A%230000ff%3BGALT%3A%23008000%3BGFNT%3A%230000ff%3BGIMP%3A
%230000ff%3BDIV%3A%23336699%3BLBGC%3A336699%3BAH%3Acenter%3B&q=%C5%B7%C2%FC%D5%D5%C3%F7&lr=

这种情况下就不一定是UTF-8编码了，这种情况下以ie这个参数指定，这里ie=gb2312,所以编码方式为gb2312，而gb2312是gbk的字 集，所以这里我们用gbk而不用gb2312;对于yahoo情况类似，只不过yahoo在大多数情况下使用GBK编码，如：
http://search.cn.yahoo.com/search?p=%C5%B7%C2%FC%BF%C6%BC%BC%CA%B5%D2%B5
&source=toolbar_yassist_button&pid=54554_1006&f=A279_1
就是GBK编码,但这种情况:
http://search.cn.yahoo.com/search?ei=gbk&fr=fp-tab-web-ycn&source=errhint_up_web
&p=%BD%F1%BF%C6&meta=vl%3Dlang_zh-CN%26vl%3Dlang_zh-TW&pid=ysearch
就 用ei参数里指定的纺码方式了,这里有可能指定的是gbk，也有可能指定的是UTF-8。
根据以上的解释，于是有以下的程序来获得各种搜索引擎的关键字:



``` java
package com.mytophome.framework;  
  
import java.util.regex.*;  
import java.net.URLDecoder;  
import java.io.*;  
  
public class GetKeyword {  
    public static void main(String[] arg) {  
        String referer = "http://www.baidu.com/s?wd=java%D1%A7%CF%B0%CA%D2";  
        if (arg.length != 0) {  
            referer = arg[0];  
        }  
        GetKeyword getKeyword = new GetKeyword();  
        String searchEngine = getKeyword.getSearchEngine(referer);  
        System.out.println("searchEngine:" + searchEngine);  
        System.out.println("keyword:" + getKeyword.getKeyword(referer));  
    }  
  
    public String getKeyword(String refererUrl) {  
        StringBuffer sb = new StringBuffer();  
        if (refererUrl != null) {  
            sb.append("(google\\.[a-zA-Z]+/.+[\\&|\\?]q=([^\\&]*)")  
                    .append("|iask\\.[a-zA-Z]+/.+[\\&|\\?]k=([^\\&]*)")  
                    .append("|iask\\.[a-zA-Z]+/.+[\\&|\\?]_searchkey=([^\\&]*)")  
                    .append("|sogou\\.[a-zA-Z]+/.+[\\&|\\?]query=([^\\&]*)")  
                    .append("|163\\.[a-zA-Z]+/.+[\\&|\\?]q=([^\\&]*)")  
                    .append("|yahoo\\.[a-zA-Z]+/.+[\\&|\\?]p=([^\\&]*)")  
                    .append("|baidu\\.[a-zA-Z]+/.+[\\&|\\?]wd=([^\\&]*)")  
                    .append("|baidu\\.[a-zA-Z]+/.+[\\&|\\?]word=([^\\&]*)")  
                    .append("|lycos\\.[a-zA-Z]+/.*[\\&|\\?]query=([^\\&]*)")  
                    .append("|aol\\.[a-zA-Z]+/.+[\\&|\\?]encquery=([^\\&]*)")  
                    .append("|3721\\.[a-zA-Z]+/.+[\\&|\\?]p=([^\\&]*)")  
                    .append("|3721\\.[a-zA-Z]+/.+[\\&|\\?]name=([^\\&]*)")  
                    .append("|search\\.[a-zA-Z]+/.+[\\&|\\?]q=([^\\&]*)")  
                    .append("|soso\\.[a-zA-Z]+/.+[\\&|\\?]w=([^\\&]*)")  
                    .append("|zhongsou\\.[a-zA-Z]+/.+[\\&|\\?]w=([^\\&]*)")  
                    .append("|alexa\\.[a-zA-Z]+/.+[\\&|\\?]q=([^\\&]*)")  
                    .append(")");  
            Pattern p = Pattern.compile(sb.toString());  
            Matcher m = p.matcher(refererUrl);  
            return decoderKeyword(m, refererUrl);  
        }  
        return null;  
    }  
  
    /** 
     * 添加了百度搜索引擎的编码问题 
     * @param m 
     * @param refererUrl 
     * @return 
     */  
    public String decoderKeyword(Matcher m, String refererUrl) {  
        String keyword = null;  
        String encode = "UTF-8";  
        String searchEngine = getSearchEngine(refererUrl);  
        if (searchEngine != null) {  
            if ((checkCode("3721|iask|sogou|163|soso|zhongsou", searchEngine)   
                    || (checkCode("yahoo", searchEngine) && !checkCode("ei=utf-8",refererUrl.toLowerCase())))  
                    || (checkCode("baidu", searchEngine) && !checkCode("ie=utf-8", refererUrl.toLowerCase()))) {  
                encode = "GBK";  
            }  
  
            if (m.find()) {  
                for (int i = 2; i <= m.groupCount(); i++) {  
                    if (m.group(i) != null)// 在这里对关键字分组就用到了  
                    {  
                        try {  
                            keyword = URLDecoder.decode(m.group(i), encode);  
                        } catch (UnsupportedEncodingException e) {  
                            System.out.println(e.getMessage());  
                        }  
                        break;  
                    }  
                }  
            }  
        }  
        return keyword;  
    }  
  
    public String getSearchEngine(String refUrl) {  
        if (refUrl.length() > 11) {  
            // p是匹配各种搜索引擎的正则表达式  
            // p是匹配各种搜索引擎的正则表达式  
            Pattern p = Pattern  
                    .compile("http:\\/\\/.*\\.(google\\.com(:\\d{1,}){0,1}\\/"  
                            + "|google\\.cn(:\\d{1,}){0,1}\\/"  
                            + "|baidu\\.com(:\\d{1,}){0,1}\\/"  
                            + "|yahoo\\.com(:\\d{1,}){0,1}\\/"  
                            + "|iask\\.com(:\\d{1,}){0,1}\\/"  
                            + "|sogou\\.com(:\\d{1,}){0,1}\\/"  
                            + "|163\\.com(:\\d{1,}){0,1}\\/"  
                            + "|lycos\\.com(:\\d{1,}){0,1}\\/"  
                            + "|aol\\.com(:\\d{1,}){0,1}\\/"  
                            + "|3721\\.com(:\\d{1,}){0,1}\\/"  
                            + "|search\\.com(:\\d{1,}){0,1}\\/"  
                            + "|soso.com(:\\d{1,}){0,1}\\/"  
                            + "|zhongsou\\.com(:\\d{1,}){0,1}\\/"  
                            + "|alexa\\.com(:\\d{1,}){0,1}\\/)");  
            Matcher m = p.matcher(refUrl);  
            if (m.find()) {  
                return insteadCode(m.group(1),"(\\.com(:\\d{1,}){0,1}\\/|\\.cn(:\\d{1,}){0,1}\\/|\\.org(:\\d{1,}){0,1}\\/)","");  
            }  
        }  
        return "未发现有搜索引擎";  
    }  
  
    public String insteadCode(String str, String regEx, String code) {  
        Pattern p = Pattern.compile(regEx);  
        Matcher m = p.matcher(str);  
        String s = m.replaceAll(code);  
        return s;  
    }  
  
    public boolean checkCode(String regEx, String str) {  
        Pattern p = Pattern.compile(regEx);  
        Matcher m = p.matcher(str);  
        return m.find();  
    }  
}
```

