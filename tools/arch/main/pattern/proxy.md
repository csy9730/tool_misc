# proxy


proxy 和 hook和装饰器的区别。

装饰器不改变功能，只是增加前置处理和后置处理。proxy和hook会直接改变行为。

proxy 是主动使用，hook是偷梁换柱。

## proxy

``` python
class Base:
	def __init__():
		pass
	def run(self):
		pass
		
class B(Base):
	def __init__():
		pass
	def run(self):
		print("run")
		
class B_proxy(Base):
	def __init__():
		pass
	def run(self):
		print("B_proxy run")		
		
def main():
	b = B()
	b.run() 
	
	b2 = B_proxy()
	b2.run()


```

## hook

hook 是在 保持main函数不变的情况，更改目标类的执行代理函数。
在测试场景中，这非常常见。

考虑到，主体和目标之间有多层调用，只要找到一个中间环节，替换实现，就能实现偷梁换柱。

系统框架提供了hook机制，就可以利用提供hook点。

hook机制都是系统/框架提供的？