# [语法规范：BNF与ABNF](https://kb.cnblogs.com/page/189566/)

发布时间: 2013-10-03 17:37  阅读: 34484 次  推荐: 8   [[收藏\]](javascript:void(0))  

　　**BNF**     

　　巴科斯范式(BNF: Backus-Naur Form 的缩写)是由 John Backus 和 Peter Naur 首先引入的用来描述计算机语言语法的符号集。现在，几乎每一位新编程语言书籍的作者都使用巴科斯范式来定义编程语言的语法规则。 

　　在BNF中，双引号中的字("word")代表着这些字符本身。而double_quote用来代表双引号。 

　　在双引号外的字（有可能有下划线）代表着语法部分。 

　　< > : 内包含的为必选项。 
　　[ ] : 内包含的为可选项。 
　　{ } : 内包含的为可重复0至无数次的项。 
　　|  : 表示在其左右两边任选一项，相当于"OR"的意思。 
　　::= : 是“被定义为”的意思 
　　"..." : 术语符号 
 　　[...] : 选项，最多出现一次 
　　{...} : 重复项，任意次数，包括 0 次 
　　(...) : 分组 
　　|   : 并列选项，只能选一个 
　　斜体字: 参数，在其它地方有解释 

　　下面是是用BNF来定义的Java语言中的For语句的实例： 

```
FOR_STATEMENT ::= 
      "for" "(" ( variable_declaration | 
  ( expression ";" ) | ";" ) 
      [ expression ] ";" 
      [ expression ] ";" 
      ")" statement
```

　　**ABNF**

　　RFC2234 定义了扩展的巴科斯范式(ABNF)。近年来在Internet的定义中 ABNF 被广泛使用。ABNF 做了更多的改进。扩充巴科斯-瑙尔范式(ABNF)基于了巴科斯-瑙尔范式(BNF)，但由它自己的语法和推导规则构成。这种元语言的发起原则是描述作为通信协议(双向规范)的语言的形式系统。它建档于 RFC 4234 中通常充当 IETF 通信协议的定义语言。

　　ABNF 规定是一组推导规则，写为：

```
规则 = 定义 ; 注释 CR LF
```

　　这里的规则是大小写敏感的非终止符，定义由定义这个规则的符号序列，一个文档注释组成，并结束于回车换行。

　　规则名字是大小写不敏感的: `<rulename>`, `<Rulename>`, `<RULENAME>` 和 `<rUlENamE>` 都提及同一个规则。规则名字由开始于一个字母的字母、数字和连字符组成。不要求用尖括号(“`<`”, “`>`”) (如 BNF 那样)包围规则名字。但是它们可以用来界定规则名字，比如在冗文中识别出规则名字的时候。ABNF 使用 7-位 ASCII 编码，在 8-位域中把高位置零。

　　终结符由一个或多个数值字符指定。数值字符可以指定为跟随着基数(b = 二进制, d = 十进制, x = 十六进制)的一个百分号“`%`”，随后是这个数值，或数值的串联(用“`.`” 来指示)。例如回车可以指定为十进制的 `%d13` 或十六进制的 `%x0D`。回车换行可以指定为 `%d13.10`。

　　文字正文通过使用包围在引号(`"`)中字符串来指定。这些字符串是大小写不敏感的，使用的字符集是 US-ASCII。所以字符串“abc”将匹配“abc”, “Abc”, “aBc”, “abC”, “ABc”, “AbC”, “aBC” 和 “ABC”。对于大小写敏感匹配，必须定义明确的字符: 要匹配 “aBc” 定义将是 `%d97 %d66 %d99`。

　　**操作符**

　　空白被用来分隔定义的各个元素: 要使空格被识别为分割符则必须明确的包含它。

　　**串联**

```
规则1 规则2   
```

　　规则可以通过列出一序列的规则名字来定义。

　　要匹配字符串“aba”可以使用下列规则:

```
fu = %x61; a
bar = %x62; b
mumble = fu bar fu
```

　　**选择**

```
规则1 / 规则2  
```

　　规则可以通过用反斜杠(“`/`”)分隔的多选一规则来定义。

　　要接受规则 <fu> 或规则 <bar> 可构造如下规则：

```
fubar = fu / bar    
```

　　**递增选择**

```
规则1 =/ 规则2  
```

　　可以通过使用在规则名字和定义之间的“`=/`”来向一个规则增加补充选择。

　　规则

```
ruleset = alt1 / alt2 / alt3 / alt4 / alt5
```

　　等价于

```
ruleset = alt1 / alt2
ruleset =/ alt3
ruleset =/ alt4 / alt5
```

　　**值范围**

```
%c##-##     
```

　　数值范围可以通过使用连字符(“`-`”)来指定。

　　规则

```
OCTAL = "0" / "1" / "2" / "3" / "4" / "5" / "6" / "7"
```

　　等价于

```
OCTAL = %x30-37
```

　　**序列分组**

```
(规则1 规则2)  
```

　　元素可以放置在圆括号中来组合定义中的规则。

　　要匹配“elem fubar snafu”或“elem tarfu snafu”可以构造下列规则：

```
group = elem (fubar / tarfu) snafu
```

　　要匹配“elem fubar”或“tarfu snafu”可以构造下列规则：

```
group = elem fubar / tarfu snafu
group = (elem fubar) / (tarfu snafu)
```

　　**可变重复**

```
n*n规则     
```

　　要指示一个元素的重复可以使用形式 `<a>*<b> 元素`。可选的 `<a>` 给出要包括的元素的最小数目，缺省为 0。可选的 `<b>` 给出要包括的元素的最大数目，缺省为无穷。

　　对零或多个元素使用 `*元素`，对一或多个元素使用 `1*元素`，对二或三个元素使用 `2*3元素`。

　　**特定重复**`　　`

```
n规则       
```

　　要指示明确数目的元素可使用形式 `<a> 元素`，它等价于 `<a>*<a>元素`。

　　使用 `2DIGIT` 得到两个数字，使用 `3DIGIT` 得到三个数字。(DIGIT 在下面的核心规则中定义)。

　　**可选序列**

```
[规则]        
```

　　要指示可选元素下列构造是等价的：

```
[fubar snafu]
*1(fubar snafu)
0*1(fubar snafu)
```

　　**注释**

```
; 注释       
```

　　分号(“`;`”)开始一个注释并持续到此行的结束。

　　**操作符优先级**

　　上述操作符有从最紧绑定(binding)到最松绑定的给定优先级:

1. 字符串，名字形成(formation)
2. 注释
3. 值范围
4. 重复
5. 分组，可选
6. 串联
7. 选择

　　与串联一起使用选择操作符可以造成混淆，建议使用分组来做明确串联分组。

　　**核心规则**

　　核心规则定义于 ABNF 标准中。

| 规则   | 形式定义                                  | 意义                                |
| ------ | ----------------------------------------- | ----------------------------------- |
| ALPHA  | %x41-5A / %x61-7A                         | 大写和小写 ASCII 字母 (A-Z a-z)     |
| DIGIT  | %x30-39                                   | 数字 (0-9)                          |
| HEXDIG | DIGIT / "A" / "B" / "C" / "D" / "E" / "F" | 十六进制数字 (0-9 A-F a-f)          |
| DQUOTE | %x22                                      | 双引号                              |
| SP     | %x20                                      | 空格                                |
| HTAB   | %x09                                      | 水平tab                             |
| WSP    | SP / HTAB                                 | 空格和水平tab                       |
| LWSP   | *(WSP / CRLF WSP)                         | 线性空白(晚于换行)                  |
| VCHAR  | %x21-7E                                   | 可见(打印)字符                      |
| CHAR   | %x01-7F                                   | 任何 7-位 US-ASCII 字符，不包括 NUL |
| OCTET  | %x00-FF                                   | 8 位数据                            |
| CTL    | %x00-1F / %x7F                            | 控制字符                            |
| CR     | %x0D                                      | 回车                                |
| LF     | %x0A                                      | 换行                                |
| CRLF   | CR LF                                     | 互联网标准换行                      |
| BIT    | "0" / "1"                                 |                                     |

　　**例子**

　　在巴科斯范式(BNF)条目中的邮政地址的例子可以被指定为：

```
postal-address = name-part street zip-part

name-part = *(personal-part SP) last-name [SP suffix] CRLF
name-part = / personal-part CRLF

personal-part = first-name / (initial ".")
first-name = *ALPHA
initial = ALPHA
last-name = *ALPHA
suffix = ("Jr." / "Sr." / 1*("I" / "V" / "X"))

street = [apt SP] house-num SP street-name CRLF
apt = 1*4DIGIT
house-num = 1*8（DIGIT / ALPHA）
street-name = 1*VCHAR

zip-part = town-name "," SP state 1*2SP zip-code CRLF
town-name = 1*(ALPHA / SP)
state = 2ALPHA
zip-code = 5DIGIT ["-" 4DIGIT]
```

　　**引用**

- [RFC 4234Augmented BNF for Syntax Specifications: ABNF](http://www.ietf.org/rfc/rfc5234.txt)

　　**参考**

- [http://zh.wikipedia.org/wiki/扩充巴科斯范式](http://zh.wikipedia.org/wiki/%E6%89%A9%E5%85%85%E5%B7%B4%E7%A7%91%E6%96%AF%E8%8C%83%E5%BC%8F)