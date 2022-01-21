# union

支持嵌套union，嵌套union支持匿名union。
## 嵌套union

``` cpp
class Token {
public:
    // indicates which kind of value is in val
    enum TokenKind {INT, CHAR, DBL};
    TokenKind tok;
    union { // unnamed union
        char cval;
        int ival;
        double dval;
    } val; // member val is a union of the 3 listed types
};
```

``` cpp
Token token;
switch (token.tok) {
case Token::INT:
    token.val.ival = 42; break;
case Token::CHAR:
    token.val.cval = 'a'; break;
case Token::DBL:
    token.val.dval = 3.14; break;
}
```
## 匿名union
匿名 union 不能有私有成员或受保护成员，也不能定义成员函
数。
``` cpp
class Token {
public:
    // indicates which kind of token value is in val
    enum TokenKind {INT, CHAR, DBL};
    TokenKind tok;
    union { // anonymous union
        char cval;
        int ival;
        double dval;
    };
};
```

``` cpp
Token token;
switch (token.tok) {
case Token::INT:
    token.ival = 42; break;
case Token::CHAR:
    token.cval = 'a'; break;
case Token::DBL:
    token.dval = 3.14; break;
}
```
