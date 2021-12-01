#include <iostream>
#include <vector>

using namespace std;

#include "1.cpp"


int twoSumTest(vector<int>& nums, int target, vector<int>& fd_gt, Solution&sol){
    vector<int> fd = sol.twoSum(nums, target);
    return fd_gt==fd;
}

int f(){
    int target = 9;
    vector<int> nums {2,7,11,15};
    vector<int> fd_gt{0,1};
    Solution sol;
    ;
    return twoSumTest(nums, target, fd_gt, sol);
}

int f2(){
    int target = 6;
    vector<int> nums {3,2,4};
    vector<int> fd_gt{1,2};

    Solution sol;
    vector<int> fd = sol.twoSum(nums, target);
    return fd_gt==fd;
}

int f3(){
    int target = 6;
    vector<int> nums {3,3};
    vector<int> fd_gt{0,1};

    Solution sol;
    vector<int> fd = sol.twoSum(nums, target);
    return fd_gt==fd;
}


int main(int argc,char**argv){
    int ret = f();
    ret&=f2();
    ret&=f3();

    cout<<ret<<endl;
    // assertVector();
}



void assertVector(){
    vector<int> a{3,4,5};
    vector<int> b{3,4,5};
    cout<< (a==b) << endl;
    cout<< (a==vector<int>{3,4,5}) << endl;
    int arr[] = {3,4,5};
    // cout<< (a==(vector<int>)arr) << endl;
}