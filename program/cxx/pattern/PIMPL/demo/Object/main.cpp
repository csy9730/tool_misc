#include "fooBase.h"
#include "fooFactory.h"

int main(){
    FooBase * p = get_Foo();
    p->DoSomething();
    return 0;
}