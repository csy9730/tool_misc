# bitfield

位域，属于c语言的不可移植特性。

可以声明一种特殊的类数据成员，称为位域，来保存特定的位数。当程序需要将二进制数据传递给另一程序或硬件设备的时候，通常使用位域。位域在内存中的布局是机器相关的。

``` cpp
typedef unsigned int Bit;
class File {
Bit mode: 2;
Bit modified: 1;
Bit prot_owner: 3;
Bit prot_group: 3;
Bit prot_world: 3;
// ...
};
```


``` cpp
enum { READ = 01, WRITE = 02 }; // File modes
int main() {
File myFile;
myFile.mode |= READ; // set the READ bit
if (myFile.mode & READ) // if the READ bit is on
cout << "myFile.mode READ is set\n";
}
```