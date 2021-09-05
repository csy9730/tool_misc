# 基于生产者和消费者的双缓冲区demo



分类专栏： [知识综合](https://blog.csdn.net/yzhang6_10/category_6101992.html) 文章标签： [双缓冲区](https://so.csdn.net/so/search/s.do?q=双缓冲区&t=blog&o=vip&s=&l=&f=&viparticle=) [C++实现](https://www.csdn.net/gather_2c/NtjaggxsNjM4Ni1ibG9n.html) [生产者-消费者](https://so.csdn.net/so/search/s.do?q=生产者-消费者&t=blog&o=vip&s=&l=&f=&viparticle=) [双缓冲状态](https://so.csdn.net/so/search/s.do?q=双缓冲状态&t=blog&o=vip&s=&l=&f=&viparticle=)

版权

# **双缓冲区**

今天看大规模分布式存储系统，看到双缓冲这一部分内容，加之之前项目中应用到双缓冲思想，故总结双缓冲知识如下，其中程序是参考stackoverflow的，具体网址找不到了，故未标注在参看文献中。

- **简介**
  **双缓冲区广泛应用于生产者/消费者模型**。它是**两个缓冲区**。这两个缓冲区，总是**一个用于生产者，另一个用于消费者**。当**两个缓冲区都操作完，再进行一次切换**，先前被生产者写入的被消费者读取，先前消费者读取的转为生产者写入。**为了做到不冲突，给每个缓冲区分配一把互斥锁**。生产者或者消费者如果要操作某个缓冲区，必须先拥有对应的互斥锁。
  双缓冲区包括如下几种状态：

  > 1）**双缓冲区都在使用的状态（并发读写）**。大多数情况下，生产者和消费者都处于并发读写状态。假设生产者写入A，消费者读取B。在此状态下，生产者拥有锁La，消费者拥有锁Lb。由于两个缓冲区都处于独占状态，故每次读写缓冲区中的元素都不需要再进行加锁、解锁操作。
  > 2）**单个缓冲区空闲状态**。由于两个并发实体的速度会有差异，必然会出现一个缓冲区已经操作完，而另一个尚未操作完。假设生产者快于消费者，此时，当生产者把A写满时，生产者要先释放La（表示它已经不再操作A），然后尝试获取Lb。由于B还没有读空，Lb还被消费者持有，所以生产者进入等待状态。
  > 3）**缓冲区切换**。过了一段时间，消费者B也把B读完。此时，消费者也先释放Lb，然后尝试获取La。由于La刚才已经被生产者释放，所以消费者能立即拥有La并开始读取A的数据。而由于Lb被消费者释放，所以刚才等待的生产者会苏醒过来并拥有Lb，然后生产者继续往B写入数据。

- **C++实现**

  ``` cpp
  // 此程序参看stackoverflow中的相关程序，具体记不清楚了~
  
  #include <iostream>
  
  
  #include <boost/thread.hpp>
  
  
  #include <boost/interprocess/sync/interprocess_semaphore.hpp>
  
  using namespace boost::interprocess;
  using namespace std;
  
  const int size = 5;
  struct Data_buff
  {
      Data_buff(): putSemaphore(2), getSemaphore(0), getMutex(1)
      {
          put  = buf1;
          nput = buf2;
          get  = 0;
      }
  
      int buf1[size];
      int buf2[size];
  
      int *put;
      int *nput;
      int *get;
  
      interprocess_semaphore putSemaphore,    // 是否可以进行数据的添加
                             getSemaphore,    // 是否可以进行数据的读取
                             getMutex;        // 是否可以进行指针的更改
  };
  struct MutexBuf
  {
      boost::mutex dataMutex;                  // 数据访问的互斥变量
      boost::condition_variable_any putCond;   // 是否可以进行数据添加，如果没有缓冲区则不能，添加完一个缓冲区的数据，但是read没有释放get
      boost::condition_variable_any getCond;   // 是否可以进行数据读取，如果get为0，则不能
  
      int buf1[size];
      int buf2[size];
  
      int *put;
      int *nput;
      int *get;
  
      MutexBuf()
      {
          put  = buf1;
          nput = buf2;
          get  = 0;
      }
  };
  int putcount = 0;
  int getcount = 0;
  Data_buff buf;
  MutexBuf mutexBuf;
  // 产生线程
  void MutexPut()
  {
      while (true)
      {
          cout << "产生线程" << endl;
          for (int i = 0; i < size; ++i)
              mutexBuf.put[i] = putcount + i;
          putcount += size;
          {
              boost::mutex::scoped_lock lock(mutexBuf.dataMutex);
              // 如果表征不能在缓冲区中添加数据：添加完一个缓冲区中的数据，但是get没有释放掉，则不能添加
              while (mutexBuf.get)
                  mutexBuf.putCond.wait(mutexBuf.dataMutex);
              mutexBuf.get = mutexBuf.put;
              mutexBuf.put = mutexBuf.nput;
              // 通知读者，可以进行数据的操作
              mutexBuf.getCond.notify_one();
          }
      }
  }
  // 读取线程
  void MutexRead()
  {
      while (true)
      {
          cout << "读取线程" << endl;
          {
              boost::mutex::scoped_lock lock(mutexBuf.dataMutex);
              // 判断是否可以进行数据读
              while (!mutexBuf.get)
                  mutexBuf.getCond.wait(mutexBuf.dataMutex);
          }
          cout << "addr = " << mutexBuf.get << endl;
          for (int i = 0; i < size; ++i)
              cout << "value = " << mutexBuf.get[i] << ",";
          cout << endl;
          getcount += size;
          {
              boost::mutex::scoped_lock lock(mutexBuf.dataMutex);
              // 释放get的读操作区域
              mutexBuf.nput = mutexBuf.get;
              mutexBuf.get  = 0;
              mutexBuf.putCond.notify_one();
          }
      }
  }
  int main(int argc, char *argv[])
  {
      boost::thread_group gr;
      gr.create_thread(MutexPut);
      for (int i = 0; i < size; ++i)
      {
          cout << "buf1["<< i << "] = " << mutexBuf.buf1[i] << ",";
      }
      cout << endl;
      for (int i = 0; i < size; ++i)
      {
          cout<< "buf2["<< i << "] = " << mutexBuf.buf2[i] << ",";
      }
      cout << endl;
      gr.create_thread(MutexRead);
      gr.join_all();
      return 0;
  };
  ```

- **参考文献**
  大规模分布式存储系统原理解析与架构实战——杨传辉