# [Intel Thread Building Blocks (TBB) 入门篇](https://www.cnblogs.com/ybqjymy/p/13679446.html)

一、什么是TBB

​    TBB(Thread Building Blocks)是英特尔发布的一个库，全称为 Threading Building Blocks。TBB 获得过 17 届 Jolt Productivity Awards，是一套 C++ 模板库，和直接利用 OS API 写程序的 raw thread 比，在并行编程方面提供了适当的抽象，当然还包括更多其他内容，比如 task 概念，常用算法的成熟实现，自动负载均衡特 性还有不绑定 CPU 数量的灵活的可扩展性等等。STL 之父，Alexander Stepanov 对此评价不错，他说“Threading Building Blocks… could become a basis for the concurrency dimension of the C++ standard library”。其他 TBB 的早期用户，包括 Autodesk，Sun，Red Hat, Turbo Linux 等亦然。现在 O’Reilly 已经出版了一本 Intel Threading Building Blocks: Outfitting C++ for Multi-core Processor Parallelism。

二、为什么要TBB

​    在多核的平台上开发并行化的程序，必须合理地利用系统的资源 - 如与内核数目相匹配的线程，内存的合理访问次序，最大化重用缓存。有时候用户使用(系统)低级的应用接口创建、管理线程，很难保证是否程序处于最佳状态。 

​    而 Intel Thread Building Blocks (TBB) 很好地解决了上述问题： 
 1）TBB提供C++模版库，用户不必关注线程，而专注任务本身。 
 2）抽象层仅需很少的接口代码，性能上毫不逊色。 
 3）灵活地适合不同的多核平台。 
 4）线程库的接口适合于跨平台的移植(Linux, Windows, Mac) 
 5）支持的C++编译器 – Microsoft, GNU and Intel  

三、TBB库包含的内容

​    TBB包含了 Algorithms、Containers、Memory Allocation、Synchronization、Timing、Task Scheduling这六个模块。TBB的结构：

![img](https://img-blog.csdn.net/20150327164225068?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQva2V6dW5oYWk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

1、通用的并行算法 
   1） 循环的并行： 
    ① parallel_for

​    parallel_for是在一个值域执行并行迭代操作的模板函数（如对数组求和），

​      ![img](https://img-blog.csdn.net/20150327165420252?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQva2V6dW5oYWk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

parallel_for(range, body, partitioner)提供了并行迭代的泛型形式。它表示在区域的每个值，并行执行body。partitioner选项指定了分割策略。Range类型必须符合Range概念模型。body必须符合下表的要求：

​        ![img](https://img-blog.csdn.net/20150327165542433?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQva2V6dW5oYWk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

例子：



```
 1 #include <iostream>
 2 #include <vector>
 3 #include <tbb/tbb.h>
 4 #include <tbb/blocked_range.h>
 5 #include <tbb/parallel_for.h>
 6  
 7 using namespace std;
 8 using namespace tbb;
 9  
10 typedef vector<int>::iterator IntVecIt;
11  
12 struct body
13 {
14    void operator()(const blocked_range<IntVecIt>&r)const
15    {
16       for(auto i = r.begin(); i!=r.end(); i++)
17  
18         cout<<*i<<' ';
19    }
20 };
21  
22 int main()
23 {
24    vector<int> vec;
25    for(int i=0; i<10; i++)
26       vec.push_back(i);
27  
28    parallel_for(blocked_range< IntVecIt>(vec.begin(), vec.end())
29       , body());
30    return 0;
31 }
```



​    ②parallel_reduce

​    parallel_reduce模板在一个区域迭代，将由各个任务计算得到的部分结果合并，得到最终结果。parallel_reduce对区域（range）类型的要求与parallel_for一样。body类型需要分割构造函数以及一个join方法。body的分割构造函数拷贝运行循环体需要的只读数据，并分配并归操作中初始化并归变量的标志元素。join方法会组合并归操作中各任务的结果。

![img](https://img-blog.csdn.net/20150327165830320?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQva2V6dW5oYWk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

parallel_reduce使用分割构造函数来为每个线程生成一个或多个body的拷贝。当它拷贝body的时候，也许body的operator()或者join（）正在并发运行。要确保这种并发运行下的安全。典型应用中，这种安全要求不会消耗你太多的精力。 



```
 1 #include <iostream>
 2 #include <tbb/parallel_reduce.h>
 3 #include <tbb/blocked_range.h>
 4 #include <vector> 
 5  
 6 using namespace std;
 7 using namespace tbb;
 8  
 9 int main()
10 {
11    vector<int> vec;
12    for(int i=0; i<100; i++)
13       vec.push_back(i);
14  
15 int result = parallel_reduce(blocked_range<vector<int>::iterator>(vec.begin(), vec.end()),
16       0,[](const blocked_range<vector<int>::iterator>& r, int init)->int{
17  
18         for(auto a = r.begin(); a!=r.end(); a++)
19            init+=*a;
20         return init;
21       },
22  
23       [](int x, int y)->int{
24         return x+y;
25       }
26       );
27       cout<<"result:"<<result<<endl;
28    return 0;
29  
30 }
```



​    ③parallel_scan 

​    并行计算前束（prefix）的函数模板。即输入一个数组，生成一个数组，其中每个元素的值都是原数组中在此元素之前的元素的某个运算符的结果的累积。比如求和：
   输入：[2, 8,  9, -4,  1, 3, -2,  7]
   生成：[0, 2, 10, 19,  15, 16, 19, 17]

![img](https://img-blog.csdn.net/20150327170146534?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQva2V6dW5oYWk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

 例子：



```
 1 #include <tbb/parallel_scan.h>
 2 #include <tbb/blocked_range.h>
 3 #include <iostream>
 4 using namespace tbb;
 5 using namespace std; 
 6  
 7 template<typename T>
 8 class Body
 9 {
10    T _sum;
11    T* const _y;
12    const T* const _x;
13 public:
14    Body(T y[], const T x[]):_sum(0), _x(x), _y(y){}
15    T get_sum() const 
16    {
17       return _sum;
18    }
19  
20    template<typename Tag>
21    void operator()(const blocked_range<int>& r, Tag)
22    {
23       T temp = _sum;
24       for(int i = r.begin(); i< r.end(); i++)
25       {
26         temp+=_x[i];
27         if(Tag::is_final_scan())
28            _y[i] = temp;
29       }
30  
31       _sum = temp;
32    }
33  
34    Body(Body&b, split):_x(b._x), _y(b._y), _sum(0){}
35    void reverse_join(Body& a)
36    {
37      _sum+=a._sum;
38    }
39    void assign(Body& b)
40    {
41       _sum = b._sum;
42    }
43  
44 };
45  
46 int main()
47 {
48    int x[10] = {0,1,2,3,4,5,6,7,8,9};
49    int y[10];
50    Body<int> body(y,x);
51    parallel_scan(blocked_range<int>(0, 10), body);
52    cout<<"sum:"<<body.get_sum()<<endl;
53    return 0;
54 }
```



　　④parallel_do 
　　并行处理工作项的模板函数。

![img](https://img-blog.csdn.net/20150327170642407?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQva2V6dW5oYWk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

​    如果所有来自输入流的元素不能随机访问，那么parallel_do中的并行就不具备可扩展性。为达到可扩展性，可按如下方式之一处理：

![img](https://img-blog.csdn.net/20150327170747366?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQva2V6dW5oYWk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

   为了提高速度，B::operator()的粒度至少要约10万个时钟周期。否则，parallel_do的内在开销就会影响有效工作。算法可以传递一个task_group_context对象，这样它的任务可以在此组内执行。默认情况下，算法在它自己的有界组中执行。

   例子：



```
 1 #include <tbb/parallel_do.h>
 2 #include <iostream>
 3 #include <vector>
 4 using namespace std;
 5 using namespace tbb; 
 6  
 7 struct t_test
 8 {
 9        string msg;
10        int ref;
11        void operator()()const
12        {
13            cout<<msg<<endl;
14        }
15 };
16  
17 template <typename T>
18 struct body_test
19 {
20        void operator()(T* t, parallel_do_feeder<T*>& feeder) const
21        {
22               (*t)();
23               if(t->ref == 0)
24               {
25                    t->msg = "added msg";
26                    feeder.add(t);
27                    t->ref++;
28               }
29        }
30 };    
31  
32 int main()
33 {
34        t_test *pt = new t_test;
35        pt->ref = 0;
36        pt->msg = "original msg";
37  
38        vector<t_test*> vec;
39        vec.push_back(pt);
40        parallel_do(vec.begin(), vec.end(), body_test<t_test>());
41        delete pt;
42        return 0;
43 }
```



　　2）流的并行算法 

   ① pipeline

​    其定义：



```
 1 class pipeline
 2 {
 3 public:
 4     pipeline();
 5     ~pipeline();
 6     void add_filter( filter& f );
 7     void run( size_t max_number_of_live_tokens
 8         [,task_group_context& group] );
 9     void clear();
10 };
```



可按以下步骤使用pipeline类：
    1、从filter继承类f，f的构造函数传递给基类filter的构造函数一个参数，来指定它的模式
    2、重载虚方法filter::operator()来实现过滤器对元素处理，并返回一个将被下一个过滤器处理的元素指针。如果流里没有其他的要处理的元素，返回空值。最后一个过滤器的返回值将被忽略。
    3、生成pipeline类的实例
    4、生成过滤器f的实例，并将它们按先后顺序加给pipeline。一个过滤器的实例一次只能加给一个pipeline。同一时间，一个过滤器禁止成为多个pipeline的成员。
    5、调用pipeline::run方法。参数max_number_of_live_tokens指定了能并发运行的阶段数量上限。较高的值会以更多的内存消耗为代价来增加并发性。 

　　 ② 过滤器基类 filter 



```
 1 class filter
 2 {
 3 public:
 4 　　enum mode
 5 　　{
 6 　　　　parallel = implementation-defined,
 7 　　　　serial_in_order = implementation-defined,
 8 　　　　serial_out_of_order =implementation-defined
 9 　　};
10 　　bool is_serial() const;
11 　　bool is_ordered() const;
12 　　virtual void* operator()( void* item ) = 0;
13 　　virtual void finalize( void* item ) {}
14 　　virtual ~filter();
15 protected:
16 　　filter( mode );
17 };
```



 ![img](https://img-blog.csdn.net/20150327171415086?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQva2V6dW5oYWk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
    由于parallel过滤器支持并行加速，所以推荐使用。如果必须使用serial过滤器，那么serial_out_of_order类型的过滤器是优先考虑的，因为他在处理顺序上的约束较少。

　　③ 线程绑定过滤器thread_bound_filter



```
 1 classthread_bound_filter: public filter
 2 {
 3 protected:
 4 　　thread_bound_filter(mode filter_mode);
 5 public:
 6 　　enum result_type
 7 　　{
 8 　　　　success,
 9 　　　　item_not_available,
10 　　　　end_of_stream
11 　　};
12 　　result_type try_process_item();
13 　　result_type process_item();
14 };
```



管道中过滤器的抽象基类，线程必须显式为其提供服务。当一个过滤器必须由某个指定线程执行的时候会派上用场。服务于thread_bound_filter的线程不能是调用pipeline::run()的线程。例如：



```
 1 #include<iostream>
 2  
 3 #include <tbb/pipeline.h>
 4  
 5 #include<tbb/compat/thread>
 6  
 7 #include<tbb/task_scheduler_init.h>
 8  
 9 using namespacestd;
10 using namespacetbb;
11 char input[] ="abcdefg\n";
12  
13 classinputfilter:public filter
14 {
15        char *_ptr;
16 public:
17        void *operator()(void *)
18        {
19               if(*_ptr)
20               {
21                      cout<<"input:"<<*_ptr<<endl;
22                      return _ptr++;
23               }
24               else   return 0;
25  
26        }
27        inputfilter():filter(serial_in_order),_ptr(input){}
28 };
29  
30 classoutputfilter: public thread_bound_filter
31 {
32 public:
33        void *operator()(void *item)
34        {
35               cout<<*(char*)item;
36               return 0;
37        }
38        outputfilter():thread_bound_filter(serial_in_order){}
39 }; 
40  
41 voidrun_pipeline(pipeline *p)
42 {
43     p->run(8);
44 } 
45  
46 int main()
47 {
48        inputfilter inf;
49        outputfilter ouf;
50        pipeline p;
51        p.add_filter(inf);
52        p.add_filter(ouf);
53         //由于主线程服务于继承自thread_bound_filter的outputfilter，所以pipeline要运行在另一个单独的线程
54        thread t(run_pipeline, &p);
55        while(ouf.process_item()!=thread_bound_filter::end_of_stream)
56               continue;
57        t.join();
58        return 0;
59 }
```



​    ⑤ parallel_pipeline

​     函数parallel_pipeline提供了一种强类型的面向lambda的方式来建立并运行管道。parallel_while – 用于非结构化的流或堆 

   pipeline - 对流水线的每一阶段并行，有效使用缓存 
    3）并行排序 
    parallel_sort – 并行快速排序，调用了parallel_for 

2)任务调度者 
管理线程池，及隐藏本地线程复杂度 
并行算法的实现由任务调度者的接口完成 
任务调度者的设计考虑到本地线程的并行所引起的性能问题 

3)并行容器 
concurrent_hash_map 
concurrent_vector 
concurrent_queue 

4)同步原语 
atomic 
mutex 
spin_mutex – 适合于较小的敏感区域 
queuing_mutex – 线程按次序等待(获得)一个锁 
spin_rw_mutex 
queuing_rw_mutex 
说明：使用read-writer mutex允许对多线程开放”读”操作 


5)高性能的内存申请 
使用TBB的allocator 代替 C语言的 malloc/realloc/free 调用 
使用TBB的allocator 代替 C++语言的 new/delete 操作 