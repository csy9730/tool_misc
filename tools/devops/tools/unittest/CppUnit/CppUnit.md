# cppunit

[http://cppunit.sourceforge.net/doc/cvs/cppunit_cookbook.html](http://cppunit.sourceforge.net/doc/cvs/cppunit_cookbook.html)

## Simple Test Case

You want to know whether your code is working.

How do you do it?

There are many ways. Stepping through a debugger or littering your code with stream output calls are two of the simpler ways, but they both have drawbacks. Stepping through your code is a good idea, but it is not automatic. You have to do it every time you make changes. Streaming out text is also fine, but it makes code ugly and it generates far more information than you need most of the time.

Tests in CppUnit can be run automatically. They are easy to set up and once you have written them, they are always there to help you keep confidence in the quality of your code.

To make a simple test, here is what you do:

Subclass the [TestCase ](http://cppunit.sourceforge.net/doc/cvs/cppunit_cookbook.html)class. Override the method [runTest()](http://cppunit.sourceforge.net/doc/cvs/cppunit_cookbook.html). When you want to check a value, call [CPPUNIT_ASSERT(bool) ](http://cppunit.sourceforge.net/doc/cvs/group___assertions.html#ga0)and pass in an expression that is true if the test succeeds.

For example, to test the equality comparison for a Complex number class, write:



``` cpp
class ComplexNumberTest : public CppUnit::TestCase { 
public: 
  ComplexNumberTest( std::string name ) : CppUnit::TestCase( name ) {}
  
  void runTest() {
    CPPUNIT_ASSERT( Complex (10, 1) == Complex (10, 1) );
    CPPUNIT_ASSERT( !(Complex (1, 1) == Complex (2, 2)) );
  }
};
```

That was a very simple test. Ordinarily, you'll have many little test cases that you'll want to run on the same set of objects. To do this, use a fixture.