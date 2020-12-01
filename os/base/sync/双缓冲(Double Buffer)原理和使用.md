# 双缓冲(Double Buffer)原理和使用

**原文出自：http://blog.csdn.net/xiaohui_hubei/article/details/16319249**

**一、双缓冲作用**

​     

​     双缓冲甚至是多缓冲，在许多情况下都很有用。一般需要使用双缓冲区的地方都是由于“生产者”和“消费者”供需不一致所造成的。这样的情况在很多地方后可能会发生，使用 多缓冲可以很好的解决。我举几个常见的例子：



​     **例 1**. 在网络传输过程中数据的接收，有时可能数据来的太快来不及接收导致数据丢失。这是由于“发送者”和“接收者”速度不一致所致，在他们之间安排一个或多个缓冲区 来存放来不及接收的数据，让速度较慢的“接收者”可以慢慢地取完数据不至于丢失。



​      **例2.** 再如，计算机中的三级缓存结构：外存（硬盘）、内存、高速缓存（介于CPU和内存之间，可能由多级）。从左到右他们的存储容量不断减小，但速度不断提升，当然价格也是 越来越贵。作为“生产者”的 CPU 处理速度很快，而内存存取速度相对CPU较慢，如果直接在内存中存取数据，他们的速度不一致会导致 CPU  能力下降。因此在他们之间又增加的 高速缓存来作为缓冲区平衡二者速度上的差异。



​      **例3**. 在图形图像显示过程中，计算机从显示缓冲区取数据然后显示，很多图形的操作都很复杂需要大量的计算，很难访问一次显示缓冲区就能写入待显示的完整图形数据，通常需要 多次访问显示缓冲区，每次访问时写入最新计算的图形数据。而这样造成的后果是一个需要复杂计算的图形，你看到的效果可能是一部分一部分地显示出来的，造成很大的闪烁不连贯。 而使用双缓冲，可以使你先将计算的中间结果存放在另一个缓冲区中，但全部的计算结束，该缓冲区已经存储了完整的图形之后，再将该缓冲区的图形数据一次性复制到显示缓冲区。



​      例1 中使用双缓冲是为了防止数据丢失，例2 中使用双缓冲是为了提高 CPU 的处理效率，而例3使用双缓冲是为了防止显示图形时的闪烁延迟等不良体验。



**二、双缓冲原理**



​     这里，主要以双缓冲在图形图像显示中的应用做说明。  

​     

​    上面例3中提到了双缓冲的主要原理，这里通过一个图再次理解一下：

![img](https://img-blog.csdn.net/20131114201352765)

![img]()

​     图 1  双缓冲示意图



​     **注意**，显示缓冲区是和显示器一起的，显示器只负责从显示缓冲区取数据显示。我们通常所说的在显示器上画一条直线，其实就是往该显示缓冲区中写入数据。 显示器通过不断的刷新（从显示缓冲区取数据），从而使显示缓冲区中数据的改变及时的反映到显示器上。



​     这也是显示复杂图形时造成闪烁的原因，比如你现在要显示从屏幕中心向外发射的一簇射线，你开始编写代码用一个循环从0度开始到360度，每隔一定角度画一条从圆 心开始向外的直线。你每次画线其实是往显示缓冲区写入数据，如果你还没有画完，显示器就从显示缓冲区取数据显示图形，此时你看到的是一个不完整的图形，然后你 继续画线，等到显示器再次取显示缓冲区数据显示时，图形比上次完整了一些，依次下去直到显示完整的图形。你看到图形不是一次性完整地显示出来，而是每次显示一部分，从而造成闪烁。



​     原理懂了，看下 demo 就知道怎么用了。下面先介绍 Win32 API 和 C# 中如何使用双缓冲，其他环境下由于没有用到所以没写，等用到了再在下面补充，不过其他环境下 过程也基本相似。



**三、双缓冲使用 （Win32 版本）**

​    

[cpp]

 

view plain

 

copy





1. **LRESULT** CALLBACK WndProc(**HWND** hWnd, **UINT** message, **WPARAM** wParam, **LPARAM** lParam)  
2. {  
3. ​    **HDC** hDC, hDCMem;  
4. ​    **HBITMAP** hBmpMem, hPreBmp;  
5. ​    **switch** (message)  
6. ​    {  
7. ​    **case** WM_PAINT:  
8. ​        hDC = BeginPaint(hWnd, &ps);  
9. ​          
10. ​        /* 创建双缓冲区 */  
11. ​        // 创建与当前DC兼容的内存DC  
12. ​        hDCMem = CreateCompatibleDC(hDC);         
13. ​        // 创建一块指定大小的位图  
14. ​        hBmpMem = CreateCompatibleBitmap(hDC, rect.right, rect.bottom);       
15. ​        // 将该位图选入到内存DC中，默认是全黑色的  
16. ​        hPreBmp = SelectObject(hDCMem, hMemBmp);      
17. ​          
18. ​        /* 在双缓冲中绘图 */  
19. ​        // 加载背景位图  
20. ​        hBkBmp = LoadBitmap(hInst, MAKEINTRESOURCE(IDB_BITMAP1));     
21. ​        hBrush = CreatePatternBrush(hBkBmp);  
22. ​        GetClientRect(hWnd, &rect);  
23. ​        FillRect(hDCMem, &rect, hBrush);  
24. ​        DeleteObject(hBrush);  
25. ​          
26. ​        /* 将双缓冲区图像复制到显示缓冲区 */  
27. ​        BitBlt(hDC, 0, 0, rect.right, rect.bottom, hDCMem, 0, 0, SRCCOPY);  
28. ​          
29. ​        /* 释放资源 */  
30. ​        SelectObject(hDCMem, hPreBmp);  
31. ​        DeleteObject(hMemBmp);  
32. ​        DeleteDC(hDCMem);  
33. ​        EndPaint(hWnd, &ps);  
34. ​        **break**;  
35. ​    }  
36. }  

```cpp
LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)



{



	HDC hDC, hDCMem;



	HBITMAP hBmpMem, hPreBmp;



	switch (message)



	{



	case WM_PAINT:



		hDC = BeginPaint(hWnd, &ps);



		



		/* 创建双缓冲区 */



		// 创建与当前DC兼容的内存DC



		hDCMem = CreateCompatibleDC(hDC);		



		// 创建一块指定大小的位图



		hBmpMem = CreateCompatibleBitmap(hDC, rect.right, rect.bottom);		



		// 将该位图选入到内存DC中，默认是全黑色的



		hPreBmp = SelectObject(hDCMem, hMemBmp);	



		



		/* 在双缓冲中绘图 */



		// 加载背景位图



		hBkBmp = LoadBitmap(hInst, MAKEINTRESOURCE(IDB_BITMAP1));	



		hBrush = CreatePatternBrush(hBkBmp);



		GetClientRect(hWnd, &rect);



		FillRect(hDCMem, &rect, hBrush);



		DeleteObject(hBrush);



		



		/* 将双缓冲区图像复制到显示缓冲区 */



		BitBlt(hDC, 0, 0, rect.right, rect.bottom, hDCMem, 0, 0, SRCCOPY);



		



		/* 释放资源 */



		SelectObject(hDCMem, hPreBmp);



		DeleteObject(hMemBmp);



		DeleteDC(hDCMem);



		EndPaint(hWnd, &ps);



		break;



	}



}
```

​    使用 Win32 版本时注意释放资源，释放顺序与创建顺序相反。我在使用过程中不小心遗漏了一句上面的 "DeleteObject(hMemBmp);"导致图形显示一段时间后就卡死了， 查看内存使用发现内存随时间推移飙升，加上上面这句代码后，就没这个问题了。这也再次提醒我们释放资源是多么重要，成对编程的习惯是多么重要。



![img](https://img-blog.csdn.net/20131114201358500)

![img]()

图 2  处理几次 WM_PAINT 消息后内存变化图



​     在使用过程中，如果想更新使用双缓冲区显示的区域，可以使用 InvalidateRect(hWnd, &rect,  FALSE); ，这里要注意第三个参数一定要设置成 FALSE ，第三个参数表示更新第二个 参数指定的区域时是否擦除背景，因为使用双缓冲技术时是直接复制整个缓冲区数据到显示缓冲区，因此无论原有缓冲区里面有什么都会被覆盖，因此第三个参数设置成  FALSE 有 助于提高新能。更主要的原因是，如果先擦除原有缓冲区，会导致中间有一瞬间显示缓冲区被清空（显示为默认背景色），然后等到复制了双缓冲区的数据后再显示新的图像，这将导致闪烁！ 这与使用双缓冲的本意相违背，所以要注意这一点。



**四、双缓冲使用 （C# 版本）**



[csharp]

 

view plain

 

copy





1. **public** **void** Show(System.Windows.Forms.Control control)  
2. {  
3. ​    Graphics gc = control.CreateGraphics();  
4. ​    // 创建缓冲图形上下文 （类似 Win32 中的CreateCompatibleDC）  
5. ​    BufferedGraphicsContext dc = **new** BufferedGraphicsContext();   
6. ​    // 创建指定大小缓冲区 （类似 Win32 中的 CreateCompatibleBitmap）  
7. ​    BufferedGraphics backBuffer = dc.Allocate(gc, **new** Rectangle(**new** Point(0, 0), control.Size));       
8. ​              
9. ​    /* 像使用一般的 Graphics 一样绘图 */  
10. ​    Pen pen = **new** Pen(Color.Gray);  
11. ​    **foreach** (Step s **in** m_steps)  
12. ​    {  
13. ​        gc.DrawLine(pen, s.Start, s.End);  
14. ​    }  
15. ​      
16. ​    // 将双缓冲区中的图形渲染到指定画布上 （类似 Win32 中的）BitBlt  
17. ​    backBuffer.Render(control.CreateGraphics());     
18. }  

```csharp
public void Show(System.Windows.Forms.Control control)



{



    Graphics gc = control.CreateGraphics();



    // 创建缓冲图形上下文 （类似 Win32 中的CreateCompatibleDC）



    BufferedGraphicsContext dc = new BufferedGraphicsContext(); 



    // 创建指定大小缓冲区 （类似 Win32 中的 CreateCompatibleBitmap）



    BufferedGraphics backBuffer = dc.Allocate(gc, new Rectangle(new Point(0, 0), control.Size));     



            



    /* 像使用一般的 Graphics 一样绘图 */



    Pen pen = new Pen(Color.Gray);



    foreach (Step s in m_steps)



    {



        gc.DrawLine(pen, s.Start, s.End);



    }



    



    // 将双缓冲区中的图形渲染到指定画布上 （类似 Win32 中的）BitBlt



    backBuffer.Render(control.CreateGraphics());   



}
```

其他版本后续用到时再补充。





**参考资料：**



文中用到的 Win32 API 在MSDN中的说明：

[CreateCompatibleDC](http://msdn.microsoft.com/en-us/library/windows/desktop/dd183489(v=vs.85).aspx)

[CreateCompatibleBitmap](http://msdn.microsoft.com/en-us/library/windows/desktop/dd183488(v=vs.85).aspx) 

[BitBlt](http://msdn.microsoft.com/en-us/library/windows/desktop/dd183370(v=vs.85).aspx)



C# 中使用double buffer 

<http://msdn.microsoft.com/en-us/library/ms229622(v=vs.110).aspx>