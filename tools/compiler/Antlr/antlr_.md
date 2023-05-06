# antlr


[https://github.com/antlr/antlr4](https://github.com/antlr/antlr4)

ANTLR 4 supports 10 target languages, and ensuring consistency across these targets is a unique and highly valuable feature. To ensure proper support of this feature, each release of ANTLR is a complete release of the tool and the 10 runtimes, all with the same version. As such, ANTLR versioning does not strictly follow semver semantics:

- a component may be released with the latest version number even though nothing has changed within that component since the previous release
- major version is bumped only when ANTLR is rewritten for a totally new "generation", such as ANTLR3 -> ANTLR4 (LL(*) -> ALL(*) parsing)
- minor version updates may include minor breaking changes, the policy is to regenerate parsers with every release (4.11 -> 4.12)
- backwards compatibility is only guaranteed for patch version bumps (4.11.1 -> 4.11.2)


If you use a semver verifier in your CI, you probably want to apply special rules for ANTLR, such as treating minor change as a major change.

ANTLR (ANother Tool for Language Recognition) is a powerful parser generator for reading, processing, executing, or translating structured text or binary files. It's widely used to build languages, tools, and frameworks. From a grammar, ANTLR generates a parser that can build parse trees and also generates a listener interface (or visitor) that makes it easy to respond to the recognition of phrases of interest.


Antlr4（Another Tool for Language Recognition）是一款基于Java开发的开源的语法分析器生成工具，能够根据语法规则文件生成对应的语法分析器，广泛应用于DSL构建，语言词法语法解析等领域。现在在非常多的流行的框架中都用使用，例如，在构建特定语言的AST方面，CheckStyle工具，就是基于Antlr来解析Java的语法结构的（当前Java Parser是基于JavaCC来解析Java文件的，据说有规划在下个版本改用Antlr来解析），还有就是广泛应用在DSL构建上，著名的Eclipse Xtext就有使用Antlr。

Antlr可以生成不同target的AST（https://www.antlr.org/download.html），包括Java、C++、JS、Python、C#等，可以满足不同语言的开发需求。当前Antlr最新稳定版本为4.9，Antlr4官方github仓库中，已经有数十种语言的grammer（https://github.com/antlr/grammars-v4，不过虽然这么多语言的规则文法定义都在一个仓库中，但是每种语言的grammer的license是不一样的，如果要使用，需要参考每种语言自己的语法结构的license）。