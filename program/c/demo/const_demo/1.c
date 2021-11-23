void main(){
    int a=1;
    int* p = &a;
    int* const p2 = &a;
    const int*  p3 = &a;
    const int* const p4 = &a;

    int* p12 = p2;  // ok
    int* const p21 = p;  // ok

    // int* p13 = p3; // error
    int* p13 = (int*)p3; // ok

    // int* p14 = p4; // error
    int* p14 = (int*)p4; // ok

    // int* const p23 = p3; // error
    int* const p23 = (int*)p3; // ok

    // int* const p24 = p4; // error
    int* const p24 = (int*)p4; // ok

    const int* p31 = p; // ok
    const int* p32 = p2; // ok
    const int* p34 = p4; // ok
    const int* const p43 = p3; // ok
}

// 可以发现： const int*类型指针可以装int类型。
// int*不可以装 const int类型
// const 修饰符，反而具有更强的推广性，这有些违反直觉。