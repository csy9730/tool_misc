#include <iostream>
#include <vector>

using namespace std;

struct Student
{
    string name;
    int age;

    Student(string &&n, int a)
        : name(std::move(n)), age(a)
    {
        cout << "\tconstruct()" << age << endl;
    }

    Student(const Student &s)
        : name(std::move(s.name)), age(s.age)
    {
        cout << "\tcopy construct()" << age << endl;
        ;
    }

    Student(Student &&s) // noexcept
        : name(std::move(s.name)), age(s.age)
    {
        cout << "\tmove construct()" << age << endl;
    }

    Student &operator=(const Student &s);
};


class noncopyable
{
private:
    noncopyable(const noncopyable&) = delete;
    void operator=(const noncopyable&) = delete;
 
protected:
    noncopyable() = default;
    ~noncopyable() = default;
};

struct Student2
{
    string name;
    int age;

    Student2(string &&n, int a)
        : name(n), age(a)
    {
        cout << "\tconstruct()" << age << endl;
    }

    
    Student2(const Student2 &s)
        : name(s.name), age(s.age)
    {
        cout << "\tcopy construct()" << age << endl;
        ;
    }
    Student2 &operator=(const Student2 &s);
    
};


void demo(){
    vector<Student> classes_one;
    vector<Student> classes_two;
    vector<Student> classes_three;
    vector<Student> classes_four;

    // classes_two.reserve(8);

    cout << "push_back:" << endl;
    Student s1 = Student("xiaohong", 20);
    classes_two.push_back(s1);

    cout << "push_back2:" << endl;
    Student s2 = Student("xiaohong", 21);
    classes_two.push_back(s2);

    cout << "emplace_back:" << endl;
    classes_one.emplace_back("xiaohong", 22);

    cout << "move push_back:" << endl;
    classes_two.push_back(Student("xiaogang", 23));

    cout << "move push_back2:" << endl;
    Student s = Student("xiaohong", 24);
    classes_two.push_back(std::move(s));
}

void demo2()
{
    vector<Student2> classes2_four;

    // classes2_four.reserve(8);

    cout << "push_back no move:" << endl;
    Student2 s3 = Student2("xiaohong", 25);
    classes2_four.push_back(s3);

    cout << "push_back no move:" << endl;
    Student2 s4 = Student2("xiaohong", 26);
    classes2_four.push_back(s4);
}

int main()
{
    demo();
    demo2();
    return 0;
}