#include "bar.h"

class Bar;

class Foo 
{
public:
    Foo();
    ~Foo();
    void DoSomething();

private:
    //  声明一个类ClxImplement的指针，不需要知道类ClxImplement的定义
    Bar *m_pImpl;
};
