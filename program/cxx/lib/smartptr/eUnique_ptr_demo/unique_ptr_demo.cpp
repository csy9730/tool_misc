#include <iostream>
#include <memory>

using namespace std;

typedef class Ccc{
  public:
  int a;
  int b;
  Ccc(int a, int b){
     this->a = a;
     this->b = b;
    cout<<"init\n";
  }
  ~ Ccc(){
    cout<<"deinit\n";
  }
}Ccc;

typedef  Ccc TYP;
unique_ptr<TYP> foo()
{
  unique_ptr<TYP> p(new TYP(15, 3));

  return p;                   // 1
  //return move( p );         // 2
}

int fooDemo(){
  cout<<"before demo\n";

  // unique_ptr<TYP> p = demo();
  
  unique_ptr<TYP> p = foo();
  cout << (*p).a << endl;
  cout<<"after demo\n";
  return 0;
}

void* foo2()
{
  unique_ptr<TYP> p(new TYP(15, 3));

  return p.get();                 // 1
  //return move( p );         // 2
}

int fooDemo2()
{
  TYP* p = (TYP*) foo2();
  cout << (*p).a << endl;
  return 0;
}


int main(){
  return fooDemo();
}