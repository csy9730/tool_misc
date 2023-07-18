#include <iostream>
#include <thread>
#include <string>

using namespace std;

void thread_one()
{
    for(int i=0;i<10;i++){
        // puts(atof)
        // puts("hello");
        cout<<"first "<< i<<endl;
        this_thread::sleep_for(std::chrono::milliseconds(100));
    }
}

void thread_two(int num, string& str)
{
    cout << "num:" << num << ",name:" << str << endl;
    this_thread::sleep_for(std::chrono::milliseconds(100));
    for(int i=0; i<10; i++){
        cout << "second " << i<< endl;
        this_thread::sleep_for(std::chrono::milliseconds(100));
    }
}


int demo(){
    thread tt(thread_one);
    tt.join();
    string str = "luckin";
    thread yy(thread_two, 88, ref(str));   //这里要注意是以引用的方式调用参数
    yy.detach();

    system("pause");
}

int demo2(){
    thread tt(thread_one);
    string str = "luckin";
    thread yy(thread_two, 88, ref(str));   //这里要注意是以引用的方式调用参数

    tt.join();
    // yy.detach();
    system("pause");
}

int main(int argc, char* argv[])
{
    demo2();
    return 0;
}