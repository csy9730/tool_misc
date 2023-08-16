#include <iostream>
#include <thread>
#include <condition_variable>
#include <list>
#include <iomanip>
using namespace std;

std::mutex mtx;
std::condition_variable oneFinished;


const int MAX_QUEUE_LENGTH = 10;
int id = 1;
const int TOTAL_TEST_NUMBER = 30;

template<typename T>
class list_lock{
public:
    std::list<T> data;
    std::mutex mtx;
    std::condition_variable oneFinished;
    void push_back(T&& _Val){ 
        data.push_back(_Val);
    };
    void push_back(const T& _Val) { data.push_back(_Val);};
    void pop_front() noexcept{
        data.pop_front();
    }
    std::chrono::steady_clock::time_point  tic;
    double get_current_rel_time() { 
        auto toc = chrono::steady_clock::now();
        std::chrono::duration<double> elapsed = toc - tic;
        return elapsed.count() ;
        // return 0;
        // chrono::duration_cast<std::chrono::milliseconds>(tic.time_since_epoch()).count();
    };// return chrono::steady_clock::now() - tic;
};

list_lock<int> arrLock;

std::list<int> arr;

void print_buffer(void)
{
    cout << "queue[" << arrLock.data.size() << "] :";
    for (auto i : arrLock.data)
    {
        cout<<std::setw(3) << i << " ";
    }
    cout << "\n";
}

void producer()
{
    while (true)
    {
        this_thread::sleep_for(std::chrono::milliseconds(100));
        {
            std::unique_lock<std::mutex> lock(arrLock.mtx);
            if (id >= TOTAL_TEST_NUMBER)
            {
                break;
            }
            
            arrLock.oneFinished.wait(lock, []() {return arrLock.data.size() < MAX_QUEUE_LENGTH; });
            cout << arrLock.get_current_rel_time() << ":"  << this_thread::get_id()<< " producer is producer " << id << "\n";
            arrLock.push_back(id++);
            print_buffer();
            arrLock.oneFinished.notify_all();   
        }     
    }
}

void consumer()
{
    // thread_local int cnt = 0;
    int cnt = 0;
    while (true)
    {
        {
            std::unique_lock<std::mutex> lock(arrLock.mtx);
            if (id >= TOTAL_TEST_NUMBER && arr.empty())
            {
                break;
            }
            
            arrLock.oneFinished.wait(lock, [&cnt]() { 
                if ( arrLock.data.size() == 0) cnt++;
                return arrLock.data.size() > 0; });
            if (cnt){ 
                cout<<"require lock but empty "<<cnt<<";";
                cnt = 0;
            }
            cout << arrLock.get_current_rel_time() << ":" << this_thread::get_id()<< " consumer is consumer " << arrLock.data.front() << "\n";
            arrLock.pop_front();
            print_buffer();
            arrLock.oneFinished.notify_all();
        }
        this_thread::sleep_for(std::chrono::milliseconds(50));
    }
}

void time_since_epoch_demo(){
    auto tic= chrono::steady_clock::now();
    auto toc= chrono::steady_clock::now();
    auto ff = toc - tic;
    // auto elapsed = chrono::duration_cast<std::chrono::microseconds>(tic.time_since_epoch());
    // std::cout << elapsed.count() << " 小时" << std::endl;
    // std::cout << tic.time_since_epoch().count() << " 毫秒"<< std::endl;
    // std::chrono::microseconds  tc = chrono::duration_cast<std::chrono::microseconds> (chrono::steady_clock::now() - tic);
}
void time_since_epoch_demo2(){
    chrono::time_point<chrono::steady_clock> start = chrono::steady_clock::now();
    {   
        std::this_thread::sleep_for(std::chrono::seconds(2));
    }
    chrono::time_point<chrono::steady_clock> end = chrono::steady_clock::now();

    std::chrono::duration<double> elapsed = end - start;
}


int main(int argc, char *argv[])
{
    arrLock.tic =chrono::steady_clock::now();
    
    std::thread c1(consumer);
    std::thread c2(consumer);
    std::thread p1(producer);
    std::thread p2(producer);

    c1.join();
    c2.join();
    p1.join();
    p2.join();

    return 0;
}