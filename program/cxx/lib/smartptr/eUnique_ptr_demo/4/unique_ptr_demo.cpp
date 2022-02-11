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

int main()
{
  auto a = foo()->a;
  cout << a << endl;

  return 0;
}