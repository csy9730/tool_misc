# 测试gcc是否支持c11，c14，c17


`gcc --version` 查看版本，

通过尝试编译的方法，测试是否支持c11.
``` bash
echo "void main(){};">a.c
gcc a.c  --std=c14
gcc a.c  --std=c11
gcc a.c --std=c99
```