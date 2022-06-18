# c++ extra qualification
运行代码时候遇到了如下错误：

extra qualification ‘Complex::’ on member ‘Complex’
其代码如下：
``` cpp
Complex::Complex(double r)
{
		m_real = r;
		m_imag = 0.0;
}
```
Extra qualification error是使用版本4以上的GCC/G++编译C＋＋程序时经常出现的错误。

这是语句中多引用了类的名称--把函数前面：：的类名称去掉即可，如下：
``` cpp
Complex(double r)
{
	m_real = r;
	m_imag = 0.0;
}
```