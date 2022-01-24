#include <iostream>
#include <cmath>
using namespace std;
#define N 8
int sum=0;
int a[N+1]; //a为层数到列数的映射关系
void  dfs(int ceng)
{
    if(ceng==N+1)
    {
        for(int i=1;i<ceng;i++)  //这里的比较很巧妙,比如层数是4,这里就是1,2和1比,3和2和1比,4和3和2和1比;这样就保证了任意两层都比较过了
            for(int j=1;j<i;j++)
                if(a[j]==a[i]||abs(i-j)==abs(a[i]-a[j]))
                   return;
        sum++;
        return; //注意这里两种情况都要return; 不然会卡死在这个递归里
    }
    for(int i=1;i<=N;i++)
    {
        a[ceng]=i;
        dfs(ceng+1);
    }
    return;
}
int main()
{
    dfs(1); //从第一层开始放
    cout<<sum;
    return 0;
}