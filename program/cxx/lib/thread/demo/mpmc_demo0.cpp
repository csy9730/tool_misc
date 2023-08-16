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
const int TOTAL_TEST_NUMBER = 100;

std::list<int> arr;

void print_buffer(void)
{
    cout << "queue[" << arr.size() << "] :";
    for (auto i : arr)
    {
        cout<<std::setw(3) << i << " ";
    }
    cout << "\n";
}

void producer()
{
    while (true)
    {
        std::unique_lock<std::mutex> lock(mtx);
        if (id >= TOTAL_TEST_NUMBER)
        {
            break;
        }
        oneFinished.wait(lock, []() {return arr.size() < MAX_QUEUE_LENGTH; });
        cout << "producer is producer " << id << "\n";
        arr.push_back(id++);
        print_buffer();
        oneFinished.notify_all();
    }
}

void consumer()
{
    while (true)
    {
        std::unique_lock<std::mutex> lock(mtx);
        if (id >= TOTAL_TEST_NUMBER && arr.empty())
        {
            break;
        }
        oneFinished.wait(lock, []() { return arr.size() > 0; });
        cout << "consumer is consumer " << arr.front() << "\n";
        arr.pop_front();
        print_buffer();
        oneFinished.notify_all();
    }
}

int main(int argc, char *argv[])
{
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