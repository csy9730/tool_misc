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

unique_ptr<TYP> demo()
{
  unique_ptr<TYP> p = foo();
  cout << (*p).a << endl;
  return p;
}

int main()
{
  cout<<"before demo\n";
  demo();
  // unique_ptr<TYP> p = demo();
  cout<<"after demo\n";
  return 0;
}
/*
before demo
init
15
deinit
after demo
*/