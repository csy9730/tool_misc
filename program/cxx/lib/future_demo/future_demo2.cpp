#include <iostream>
#include <functional>
#include <future>
#include <thread>
#include <chrono>
#include <cstdlib>


void thread_comute2(std::promise<int>& promiseObj) {
    std::this_thread::sleep_for(std::chrono::seconds(1));
    promiseObj.set_value(50); //
}

void thread_comute(std::promise<int>& promiseObj) {
    std::promise<int> promiseObj2;
    std::future<int> futureObj = promiseObj2.get_future();
    std::thread t(&thread_comute2, std::ref(promiseObj2)); 

    std::this_thread::sleep_for(std::chrono::seconds(1));
    promiseObj.set_value(100 + futureObj.get()); //
    t.join(); // important
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