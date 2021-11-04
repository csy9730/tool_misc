# compile

预处理（Preprocessing）：宏替换和宏展开

1. 词法分析  （源码生成 token）
2. 语法分析     （生成AST）
3. 语义分析     （检查AST)
4. 中间代码 AST
5. 优化
6. 汇编生成

词法分析：在一个编译器中，词法分析的作用是将输入的字符串流进行分析，并按一定的规则将输入的字符串流进行分割，从而形成所使用的源程序语言所允许的记号(token)，在这些记号序列将送到随后的语法分析过程中，与此同时将不符合规范的记号识别出来，并产生错误提示信息。通常采用确定的有限状态自动机（Deterministic Finite Automaton，DFA）来构造词法分析工具。已有一些专门的、开源的词法分析程序自动生成器可供免费使用，例如Lex，其GNU版本为Flex。

语法分析：语法分析的过程是分析词法分析产生的记号序列，并按一定的语法规则识别并生成中间表示形式，以及符号表。符号表记录程序中所使用的标识符及其标识符的属性。同样，将不符合语法规则的记号识别出其位置并产生错误提示语句。词法分析与语法分析及其符号表的关系图如图 1所示。目前大多数开源编译器使用的语法分析方法有两类，一种是自顶向下（Top-Down Parsing）的分析方法，另一种是自底向上（Bottom-Up Parsing）的分析方法。目前已有一些专门的、开源的语法分析程序自动生成器可供免费使用，例如yacc，其GNU版本为bison。在编译器开发中通常联合使用词法分析工具LEX和语法分析工具YACC，这样可以大大减少前端设计工作量。

语义分析：也即静态语法检查，静态语义检查的作用是分析语法分析过程中产生的中间表示形式和符号表，以检查源程序的语义是否与源语言的静态语义属性相符合。由于现有的大部分高级编程语言的语言是语法制导翻译的语言，因此目前通常使用的静态语义检查的方法是语法制导翻译的方法。语法制导翻译的方法是通过语法制导的属性文法来进行程序的语义分析。静态语义检查的根本目的是确认程序是否满足源编程语言要求的静态语义属性，可以理解检查为标识符的声明和使用是否相一致。





其中前三个阶段词法分析、语法分析和语义分析称为编译器的前端，源语言程序经过前端的分析会产生中间表示形式。

抽象语法树（Abstract Syntax Tree AST）

前端可以使用不同的编译工具对代码文件做词法分析以形成抽象语法树AST，然后将分析好的代码转换成LLVM的中间表示IR（intermediate representation）；