#include <iostream>
#include <functional>
#include <future>
#include <thread>
#include <chrono>
#include <cstdlib>
// -std=c++11

void threadCompute0(int* res)
{
    std::this_thread::sleep_for(std::chrono::seconds(1));
    *res = 100;
}

int demo_base()
{
    int res;
    std::thread th1(threadCompute0, &res);
    th1.join();
    std::cout << res << std::endl;
    return 0;
}


void thread_comute(std::promise<int>& promiseObj) {
    std::this_thread::sleep_for(std::chrono::seconds(1));
    promiseObj.set_value(100); //
    // std::this_thread::sleep_for(std::chrono::seconds(1));
    // promiseObj.set_value(200); //
    
    // std::cout<<("thread finished") <<std::endl;
}

int future_demo() {
    std::promise<int> promiseObj;
    std::future<int> futureObj = promiseObj.get_future();
    std::thread t(&thread_comute, std::ref(promiseObj)); 
    // std::ref 
    std::cout << futureObj.get() << std::endl; // blocked
    // std::cout << futureObj.get() << std::endl; // terminate
    t.join();
    return 0;
}

int main() {
    return future_demo();
}