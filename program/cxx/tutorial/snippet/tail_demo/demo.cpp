#include <iostream>
#include <type_traits>


// 尾置返回类型
template<typename T, typename U>
auto add(T a, U b) -> decltype(a + b) {
    return (a+b);
}

// template<typename T, typename U>
// a & b 未定义
// decltype(a+b) add2(T a, U b) {
//     return a+b;
// }


template<typename T, typename U>
decltype(std::declval<T>() + std::declval<U>()) add2(T a, U b) {
    return a+b;
}

void tail_return_demo(){
    add<uint32_t, int>(3U, -2);
    add2<uint16_t, int8_t>(3U, -2);
    add2<uint16_t, double>(3U, -2.3);
}
int main(int argc, char** argv){
    std::cout<<"hello world"<<std::endl;
    
    tail_return_demo();
    return 0;
}