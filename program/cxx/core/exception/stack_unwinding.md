# Stack Unwinding

#### stack winding
When program run, each function (data, registers, program counter, etc) is mapped onto the stack as it is called. Because the function calls other functions, they too are mapped onto the stack. This is stack winding. Unwinding is the removal of the functions from the stack in the reverse order.

#### Stack Unwinding
Stack Unwinding is the process of removing function entries from function call stack at run time. The local objects are destroyed in reverse order in which they were constructed. 

Stack Unwinding is generally related to Exception Handling. In C++, when an exception occurs, the function call stack is linearly searched for the exception handler, and all the entries before the function with exception handler are removed from the function call stack. So, exception handling involves Stack Unwinding if an exception is not handled in the same function (where it is thrown). Basically, Stack unwinding is a process of calling the destructors (whenever an exception is thrown) for all the automatic objects constructed at run time. 


``` cpp
// CPP Program to demonstrate Stack Unwinding
#include <iostream>
using namespace std;
  
// A sample function f1() that throws an int exception
void f1() throw(int)
{
    cout << "\n f1() Start ";
    throw 100;
    cout << "\n f1() End ";
}
  
// Another sample function f2() that calls f1()
void f2() throw(int)
{
    cout << "\n f2() Start ";
    f1();
    cout << "\n f2() End ";
}
  
// Another sample function f3() that calls f2() and handles
// exception thrown by f1()
void f3()
{
    cout << "\n f3() Start ";
    try {
        f2();
    }
    catch (int i) {
        cout << "\n Caught Exception: " << i;
    }
    cout << "\n f3() End";
}
  
// Driver Code
int main()
{
    f3();
  
    getchar();
    return 0;
}
```

Output
```
 f3() Start 
 f2() Start 
 f1() Start 
 Caught Exception: 100
 f3() End
 ```
 
 
 
 When f1() throws exception, its entry is removed from the function call stack, because f1() doesn’t contain exception handler for the thrown exception, then next entry in call stack is looked for exception handler.
The next entry is f2(). Since f2() also doesn’t have a handler, its entry is also removed from the function call stack.
The next entry in the function call stack is f3(). Since f3() contains an exception handler, the catch block inside f3() is executed, and finally, the code after the catch block is executed.
 Note that the following lines inside f1() and f2() are not executed at all. 

 cout<<"\n f1() End ";  // inside f1()

 cout<<"\n f2() End ";  // inside f2()
If there were some local class objects inside f1() and f2(), destructors for those local objects would have been called in the Stack Unwinding process.

Note: Stack Unwinding also happens in Java when exception is not handled in same function. 