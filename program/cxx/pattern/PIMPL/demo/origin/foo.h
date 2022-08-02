#include "bar.h"

class Foo 
{
public:
    Foo();
    ~Foo();

    void DoSomething();

private:
    Bar m_bar;
};