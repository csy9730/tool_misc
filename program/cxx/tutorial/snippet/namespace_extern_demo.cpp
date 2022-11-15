#include <iostream>


// declare 
namespace ns1
{
    extern int var;
}

namespace ns1
{
    namespace ns2
    {
        extern int var;
    }
}

extern int var;

int main(int argc, char** argv){
    std::cout<<"1:" << var <<std::endl;
    std::cout<<"2:" << ns1::var  <<std::endl;
    std::cout<<"3:" << ns1::ns2::var  <<std::endl;
    return 0;
}

// definition
int var = 4;
namespace ns1
{
    int var = 1;

    namespace ns2
    {
    int var = 2;
    }
}