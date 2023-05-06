# 递归下降解析与EBNF, BNF

[![知乎用户HofBt6](https://pic2.zhimg.com/v2-abed1a8c04700ba7d72b45195223e0ff_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/ZuoddXX)

[知乎用户HofBt6](https://www.zhihu.com/people/ZuoddXX)





12 人赞同了该文章

学习知识要抓住核心. 我虽然编译原理都忘得差不多了, 但还记得我的总结, Parser的核心就是递归.

为什么这么说呢? 先思考一个问题, 正则表达式为什么不能识别HTML是否合法?

因为正则表达式基于有限状态机, 而HTML是有限状态机所不能识别的. HTML标签可以递归自身. 任意层嵌套的HTML是无限状态的. 比方说, 单层DIV的正则是`\<div\>.*\<\/div\>`. 单层或双层DIV的正则非得是`(\<div\>.*\<\/div\>)|(\<div\>.*\<div\>.*\<\/div\>*\<\/div\>)`. 很多情况下, 这其实还是错的. 不过有一点很明确, 层数越来越多, 正则也要手写得越来越长. 标签嵌套标签, 总是能进入一个新的状态, 写是永远写不完的.



所以我们必须用支持递归或者类似的技术来做Parser. 这就是Recursive Descent Parsing. 数学算式就可以用它解析.

一个支持括号, 加减和乘法的算式BNF表达如下,

```text
<expr> ::= <expr> <addop> <term> | <term>
<term> ::= <term> ‘*’ <factor> | <factor>
<factor> ::= '(' <expr> ')' | num
<addop> ::= ‘+’ | ‘-’
```

可以看到在描述expr的时候, expr递归了自身.

展开流程如下:

```text
expr = 1 + 2 * 3
expr = 1, addop = +, term = 2 * 3
term = 1
factor = 1
num =1
term = 2, '*' = *, factor = 3
```



BNF有个什么问题呢? 它有点麻烦, 所以我们有了更接近正则的EBNF, 具体可以去看Wiki. 但就表现力上限而言, EBNF和BNF是没有差别的. 正则表达式是EBNF和BNF的子集.

BNF与EBNF只是一种规范化的描述方式. 它们不限制具体的Parser实现方式. 如果你有了一个巨复杂的语法, 一定要backtracking, it's fine; 如果你只当成正则来用, 聪明的Parser Generator同样可以转成minimal DFA.



最后, 眼尖的小朋友应该发现了我上面BNF语法的问题了. 我展开是从左边展开的, 这叫LL Parser, 但我却没有解决左递归的问题.

expr为什么不能继续重复展开成expr? 以致于死循环? 这个问题就是下一篇的内容了.

编辑于 2018-07-14 11:51

计算机语言

编译原理