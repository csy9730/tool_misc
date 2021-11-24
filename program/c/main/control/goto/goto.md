# goto

## demo
``` cpp
#include <iostream.h>
#include <iostream.h>
//主函数
int main()
{
   int i = 1;
   int sum = 0;
loop:
   if( i<=100 )
   {
    sum += i;
    i++;
    goto loop;
   }
   cout<<"求从1到100的和："<<sum<<endl;
   return 0;
}
```

goto   c语言 错误： 跳转至标号 [-fpermissive]  后置