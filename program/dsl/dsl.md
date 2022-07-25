# DSL



DSL



### python

[https://www.chaindev.cn/339217-writing-a-compiler-for-a-dsl-in-python/](https://www.chaindev.cn/339217-writing-a-compiler-for-a-dsl-in-python/)


pyparsing

据我所见，PLY 和 SPARK 很受欢迎。PLY就像 yacc，但你用 Python 做所有事情，因为你用文档字符串编写语法。

除了其他人提到的库之外，如果我正在编写更复杂的东西并且需要适当的解析功能，我可能会使用支持 Python（和其他语言）的ANTLR 

其他使用 AST 的模块，其源代码可能是有用的参考：

textX-LS：用于描述形状集合并为我们绘制的 DSL。

pony orm：您可以使用 Python 生成器和 lambdas 编写数据库查询，并转换为 SQL 查询字符串——pony orm 在后台使用 AST

osso：基于角色的访问控制框架处理权限。

``` python
from tokenize import untokenize, tokenize, NUMBER, STRING, NAME, OP, COMMA
import io
import ast

s = b"a <=> b\n" # i may read it from file
b = io.BytesIO(s)
g = tokenize(b.readline)
result = []
for token_num, token_val, _, _, _ in g:
    # naive simple approach to compile a<=>b to a,b = b,a
    if token_num == OP and token_val == '<=' and next(g).string == '>':
        first  = result.pop()
        next_token = next(g)
        second = (NAME, next_token.string)
        result.extend([
            first,
            (COMMA, ','),
            second,
            (OP, '='),
            second,
            (COMMA, ','),
            first,
        ])
    else:
        result.append((token_num, token_val))

src = untokenize(result).decode('utf-8')
exp = ast.parse(src)
code = compile(exp, filename='', mode='exec')


def my_swap(a, b):
    global code
    env = {
        "a": a,
        "b": b
    }
    exec(code, env)
    return env['a'], env['b']

print(my_swap(1,10))
```
