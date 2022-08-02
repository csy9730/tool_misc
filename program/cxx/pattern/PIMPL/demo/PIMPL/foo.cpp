#include "foo.h"

Foo::Foo()
{
    m_pImpl = new Foo;
}
Foo::~Foo()
{
    if (m_pImpl)
        delete m_pImpl;
}
void Foo::DoSomething()
{
    m_pImpl->DoSomething();
}


FooWrap::FooWrap()
{
    
}

FooWrap::~FooWrap()
{

}
