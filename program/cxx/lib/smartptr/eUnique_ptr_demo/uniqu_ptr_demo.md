# ss

## demo
``` c++
int main(){
  unique_ptr<TYP> p = foo();
  cout << p->a << endl;
  return 0;
}
```
## demo2
支持 在函数内返回 智能指针。
## demo4
注意p是本体，如果没有保存p，则目标会被释放。
``` cpp
int main()
{
  auto a = foo()->a;
  cout << a << endl; // error
}
```
