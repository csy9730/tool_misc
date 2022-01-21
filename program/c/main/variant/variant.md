# variant



|              | type                                                  | sizeof    | key     | address          | value                     |
| ------------ | ----------------------------------------------------- | --------- | ------- | ---------------- | ------------------------- |
| 整数         | int                                                   | 4         | d       | &d               | d                         |
| 指针         | int*                                                  |           | ptr     | &ptr             | ptr                       |
|              | int                                                   | 4         |         | _, ptr           | `*ptr`                    |
| 万能指针     | void*                                                 |           |         |                  |                           |
| 数组         | int[M]                                                | 4M        | arr     | &arr             | arr                       |
|              | int                                                   | 4         |         | arr+i            | `*arr,arr[i]`             |
| 字符数组     | char arr[M]                                           | M         | arr     |                  |                           |
| 字符串       | `char *arr[M]="abc"`                                  | P         | arr     | &arr             | arr                       |
|              |                                                       |           |         | arr              | *arr                      |
| 二维数组     | `int arr[M][N]`                                       | 4MN       | arr     | &arr,            | arr                       |
|              | `int [N]`                                             | 4N        |         | arr,             | `*arr`                    |
|              | int                                                   | 4         |         | `*arr`           | `arr[i][j],*(*(arr+i)+j)` |
| 指针数组     | `int *PtrArr[M]`                                      | MP        | PtrArr  | &PtrArr,         | PtrArr                    |
|              | `int *`                                               | P         |         | PtrArr           | PtrArr[0]                 |
|              | int                                                   | 4         |         | PtrArr[0]        | `PtrArr[1][0],*ptrArr[1]` |
| 字符串数组   | `char *str[M]`                                        | MP        |         |                  |                           |
| 数组指针     | `int (*arrPtr)[M]`                                    | P         | arrPtr  | &arrPtr          | arrPtr                    |
|              | `int [M]`                                             | 4M        |         | arrPtr           | *arrPtr                   |
|              | `int`                                                 | 4         |         | \*arrPtr         | `**arrPtr, (*arrPtr)[0]`  |
| 指针指针     | `int **PtrPtr`                                        |           | PtrPtr  | &PtrPtr          | PtrPtr                    |
|              | `int *`                                               | P         |         | _, PtrPtr        | \*PtrPtr                  |
|              | `int `                                                | 4         |         | _, *PtrPtr       | \*\*PtrPtr                |
| 指针函数     | `char * str_cat (char * , char *)`                    |           | str_cat |                  |                           |
| 函数指针     | `void (*ptr)(void)`                                   | P         | ptr     | &ptr             | ptr                       |
|              | `ptr();*ptr()`                                        |           |         | ptr              | \*ptr                     |
| 成员函数指针 | `bool (Person::*func)(int height)=&Person::testFunc;` | P         | func    | &func            | func                      |
|              | `Person person1;(person1.*func)(10);`                 |           |         | func             | \*func                    |
| 成员指针     | `std::string Person::*str = &Person::name;`           | P         | str     | &str             | str                       |
|              | `person1.*str;person2->*func`;                        |           |         | str              | \*str                     |
| 结构         | `A a=A();`                                            | sizeof(A) | a       | &A               | A                         |
|              | int                                                   | 4         |         | (int\*)&A        | `*(int*)&A`               |
|              | void*                                                 | P         |         | (void\*\*)&A     | `*(void**)&A`             |
|              | void*[M]                                              |           |         | `(void***)&A`    | `*((void***)&A)`          |
|              | void*                                                 |           |         | `*((void***)&A)` | `**((void***)&A)`         |



数组和指针的区别：

- 指针有不同的地址和指向，数组的地址和指向是同一个，（对数组做取地址运算和没做一样）。
- 函数参数不支持数组，会转换成对应的指针，擦除数组长度信息。
- 数组运算可以转换成指针运算：`arr[i] // *(arr+i`)





二维数组`int arr[M][N]`本质是一维数组，虽然在编译时像指针指针一样支持二重指向运算`**ptr`，但这是编译器提供的假象，手动转换成指针指针类型之后（擦除原有的类型信息），就会发现执行二重指向运算`**((int**)arr)`，程序会崩溃。



| 虚函数个数 | 函数表大小      |
| ---------- | --------------- |
| 1          | 32              |
| 2          | 32              |
| 3          | 48              |
| 4          | 48              |
| 5          | 64              |
| 6          | 64              |
| 7          | 80              |
| k          | 16+16*ceil(k/2) |
|            |                 |