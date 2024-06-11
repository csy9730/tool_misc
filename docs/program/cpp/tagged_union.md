# tagged union

如何实现多态？

- vtable
- union
  - no tagged union 无标签共用体
  - tagged union 标签共用体
    - tagged union  
    - std::variant
    - rust niche 
- void *
  - void *
  - std::any

- tagged union  缺点，类型标签会占用内存，破坏内存对齐。
- niche 见缝插针，把类型标签藏到非法值或对齐位. 

### untagged union
c 的联合就是无标签联合。为了描类型，引入了有标签联合。

``` cpp
union X {
   int a,
   float b
}
```

### tagged union

Using untagged unions needs a lot of boilerplate to use safely and it's easy to mess up and cause undefined behavior


A pure untagged union does no type checking so you can interpret it's contents as type A when it is type B. In most languages this is undefined behavior.


To fix this issue, developers need to tag the union manually, usually you'd use something like this:

``` cpp
union X {
   int a,
   float b
}

enum XType {
    Float = 1,
    Int = 2,
}

struct TaggedX {
    XType type,
    X value
}
```

2
``` cpp
switch x.type {
    case XType.Float:{
        float value = x.value.b;
        // do something with float
    }case XType.Int:{
        int value = x.value.a;
        // do something with int
    }
}
```
#### toy variant

``` cpp
template<typename A, typename B>
class UnionMix{
	union Un{
		A a;
		B b;
	}un;
	uint8_t tag;
	template<typename T>
	T& convertTo(){
		return *((T*)&un);
	}
};

struct Visitor{
	void operator()(Foo& ths){
		
	}
};

```
#### variant origin
```cpp
class Value { // two alternative representations represented as a union
private:
    enum class Tag { number, text };
    Tag type; // discriminant

    union { // representation (note: anonymous union)
        int i;
        string s; // string has default constructor, copy operations, and destructor
    };
public:
    struct Bad_entry { }; // used for exceptions

    ~Value();
    Value& operator=(const Value&);   // necessary because of the string variant
    Value(const Value&);
    // ...
    int number() const;
    string text() const;

    void set_number(int n);
    void set_text(const string&);
    // ...
};

int Value::number() const
{
    if (type != Tag::number) throw Bad_entry{};
    return i;
}

string Value::text() const
{
    if (type != Tag::text) throw Bad_entry{};
    return s;
}

void Value::set_number(int n)
{
    if (type == Tag::text) {
        s.~string();      // explicitly destroy string
        type = Tag::number;
    }
    i = n;
}

void Value::set_text(const string& ss)
{
    if (type == Tag::text)
        s = ss;
    else {
        new(&s) string{ss};   // placement new: explicitly construct string
        type = Tag::text;
    }
}

Value& Value::operator=(const Value& e)   // necessary because of the string variant
{
    if (type == Tag::text && e.type == Tag::text) {
        s = e.s;    // usual string assignment
        return *this;
    }

    if (type == Tag::text) s.~string(); // explicit destroy

    switch (e.type) {
    case Tag::number:
        i = e.i;
        break;
    case Tag::text:
        new(&s) string(e.s);   // placement new: explicit construct
    }

    type = e.type;
    return *this;
}

Value::~Value()
{
    if (type == Tag::text) s.~string(); // explicit destroy
}
```

[https://github.com/isocpp/CppCoreGuidelines/blob/master/CppCoreGuidelines.md#c181-avoid-naked-unions](https://github.com/isocpp/CppCoreGuidelines/blob/master/CppCoreGuidelines.md#c181-avoid-naked-unions)



### std::variant

cpp17标准库引入了 std::variant。


#### Policy-based Programming

基于 variant 的访问器发展的扩展访问器。

``` cpp
struct InkPen {
    void Write() {
        this->WriteImplementation();
    }

    void WriteImplementation() {
        std::cout << "Writing using a inkpen" << std::endl;
    }
};

struct BoldPen {
    void Write() {
        std::cout << "Writing using a boldpen" << std::endl;
    }
};

template<class PenPolicy>
class Writer : private PenPolicy {
public:
    void StartWriting() {
        PenPolicy::Write();
    }
};

void test_policy_1() {
    Writer<InkPen> writer;
    writer.StartWriting();
    Writer<BoldPen> writer1;
    writer1.StartWriting();
}
```
