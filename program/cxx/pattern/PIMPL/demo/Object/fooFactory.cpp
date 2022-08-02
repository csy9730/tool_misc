#include "fooFactory.h"
#include "foo.h"


FooBase* get_Foo(){
    return new Foo();
}