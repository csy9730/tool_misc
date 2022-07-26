import re


PRI_CONSTANT = 0
PRI_PLUS = 1
PRI_MULTI = 2
PRI_KUOHAO = 999

# 输入四则运算，输出结果
# todo 生成 AST 结构

class TokensCalc:
    def __init__(self, tks):
        self.tks = tks 
        self._genpri(tks)
    
    def _split(self):
        pass
        # re.split(r'[\+\-\*\/\(\)]', 'a+b-c')
        # re.split(r'([\+\-\*\/\(\)])', 'a+b-c*(3+6)/5')

    def _genpri0(self, tks):
        pri = []
        for tk in tks:
            if tk in ['*', '/']:
                pri += [PRI_MULTI]
            elif tk in ['+', '-']:
                pri += [PRI_PLUS]
            else:
                pri += [PRI_CONSTANT]
                  
        self.pri = pri

    def _genpri(self, tks):
        pri = []
        tk2 = []
        _cpri = 0
        for tk in tks:
            if tk in ['*', '/']:
                pri.append(PRI_MULTI + _cpri)
                tk2.append(tk)
            elif tk in ['+', '-']:
                pri.append(PRI_PLUS + _cpri)
                tk2.append(tk)
            elif tk == '(':
                _cpri += PRI_KUOHAO
            elif tk == ')':
                _cpri -= PRI_KUOHAO 
            else:
                pri += [PRI_CONSTANT]
                tk2.append(tk)
                  
        self.pri = pri
        self.tks = tk2

    def calc(self):
        if len(self.tks) <3:
            return self.tks[0]

        mx = max(self.pri)
        fd = self.pri.index(mx)
        rt = calc(self.tks[fd], self.tks[fd-1],self.tks[fd+1])
        print(fd, rt)
        self.tks[fd-1] = rt
        del self.pri[fd:fd+2]
        del self.tks[fd:fd+2]
        
        return self.calc()

def calc(cal, num, num2):
    if cal == '+':
        return num + num2
    elif cal == '-':
        return num - num2
    elif cal == '*':
        return num * num2
    elif cal == '/':
        return num / num2        

def demo():
    tks = [1,'+', 2, '*', 3, '-', 4]
    tkc = TokensCalc(tks)
    print(tkc.pri)
    val = tkc.calc()
    assert val == 3

def demo2():
    tks = [1,'+', 2, '*', 3, '/', 4, '-', 2, '*', 6]
    tkc = TokensCalc(tks)
    print(tkc.pri)
    print(tkc.calc())

def demo3():
    tks = ['(', 1,'+', 2, ')', '*', 3]
    tkc = TokensCalc(tks)
    print(tkc.pri)
    val = tkc.calc()
    assert val == 9

def demo3():
    tks = ['(', 1,'+', 2, ')', '*', '(', 3, '+', 4, ')']
    tkc = TokensCalc(tks)
    print(tkc.pri)
    val = tkc.calc()
    assert val == 21

def demo3():
    tks = ['(', 1,'+', '(', 2, ')',')', '*', '(', 3, '+', 4, ')']
    tkc = TokensCalc(tks)
    print(tkc.pri)
    val = tkc.calc()
    assert val == 21

def demo3():
    tks = [1, '+', '(', 2, '*', '(', 4, '-', 3, ')', '-', 5, ')', '*', 6]
    tkc = TokensCalc(tks)
    print(tkc.pri, tkc.tks)
    val = tkc.calc()
    assert val == -17

def main():
    demo3()

if __name__ == "__main__":
    main()