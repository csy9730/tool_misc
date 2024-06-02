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


#### tagged union
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

#### Policy-based Programming

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
