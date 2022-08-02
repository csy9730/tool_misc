// foo.h
#include "fooBase.h"
#include "bar.h"

class Foo:public FooBase
{
public:
    Foo();
    ~Foo();
    void DoSomething(){
        m_bar.DoSomething();
    };
private:
    Bar m_bar;
};