#include<iostream>
#include<complex>
using namespace std;
int main()
{
    complex<double>z(2, 3);
    complex<double>z1;
    complex<double>z2(z);
    cout << z << endl;
    cout << z1 << endl;
    cout << z2 << endl;
    z.real(22);
    z.imag(33);//修改z的实部和虚部的值
    cout << z << endl;
    complex<double>a, b, c;
    cout << "请输入三个复数：";
    cout << "b=" << b << endl;
    cout << "c=" << c << endl;
    return 0;
}
