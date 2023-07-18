# std :: string_view到底比const std :: string＆快多少？

std::string_view只是（char * begin，char * end）对的抽象。在制作std::string不必要的副本时使用它。

## 1

std::string_view 在某些情况下更快。

首先，std::string const&要求数据位于std::string而不是原始C数组中，而不是char const*C API返回的数据，std::vector<char>由反序列化引擎生成的数据，等等。避免的格式转换避免了复制字节，并且（如果字符串长于特定std::string实现的SBO¹ ）避免了内存分配。

``` cpp
void foo( std::string_view bob ) {
  std::cout << bob << "\n";
}
int main(int argc, char const*const* argv) {
  foo( "This is a string long enough to avoid the std::string SBO" );
  if (argc > 1)
    foo( argv[1] );
}
```

在这种string_view情况下，不会进行任何分配，但是如果使用fooa std::string const&而不是astring_view。

第二个很大的原因是它允许使用子字符串而不使用副本。假设您正在解析2 GB的json字符串（！）²。如果将其解析为std::string，则每个这样的解析节点将在其中存储节点名称或值的副本原始数据从2 gb字符串到本地节点。

相反，如果将其解析为std::string_view，则节点将引用原始数据。这样可以节省数百万的分配，并且在解析过程中可以减少一半的内存需求。

您可以获得的加速速度简直是荒谬的。

这是一个极端的情况，但是其他“获取子字符串并使用它”情况也可以产生不错的加速 string_view。

决定的重要部分是您因使用而损失了什么 std::string_view。数量不多，但确实如此。

您将丢失隐式空终止，仅此而已。因此，如果将相同的字符串传递给3个函数，而所有这些函数都需要一个空终止符，std::string则明智的做法是将其转换为一次。因此，如果已知您的代码需要空终止符，并且您不希望从C样式的源缓冲区等提供的字符串，则可以使用std::string const&。否则采取行动std::string_view。

如果std::string_view有一个标志说明它是否为null终止（或更奇特的东西），它将删除使用的最后一个原因std::string const&。

在某些情况下，对a std::string采取不采取行动const&是最优的std::string_view。如果您需要在调用后无限期拥有该字符串的副本，则按值取值是有效的。您要么处于SBO情况（没有分配，仅复制几个字符），要么就可以将堆分配的缓冲区移动到local std::string。具有两个重载，std::string&&并且std::string_view可能更快，但是只有一点点，这将导致适度的代码膨胀（这可能会浪费您所有的速度提升）。



## 2

string_view改善性能的一种方法是，它允许轻松删除前缀和后缀。在幕后，string_view可以仅将前缀大小添加到指向某个字符串缓冲区的指针，或者从字节计数器中减去后缀大小，这通常很快。另一方面，当您执行诸如substr之类的操作时，std :: string必须复制其字节（通过这种方式，您将获得拥有其缓冲区的新字符串，但在许多情况下，您只想获取原始字符串的一部分而不进行复制）。例：

```cpp
std::string str{"foobar"};
auto bar = str.substr(3);
assert(bar == "bar");
```

使用std :: string_view：

```cpp
std::string str{"foobar"};
std::string_view bar{str.c_str(), str.size()};
bar.remove_prefix(3);
assert(bar == "bar");
```

### 更新：

我写了一个非常简单的基准来添加一些实数。我使用了很棒的[Google基准测试库](https://github.com/google/benchmark)。基准功能包括：

```cpp
string remove_prefix(const string &str) {
  return str.substr(3);
}
string_view remove_prefix(string_view str) {
  str.remove_prefix(3);
  return str;
}
static void BM_remove_prefix_string(benchmark::State& state) {                
  std::string example{"asfaghdfgsghasfasg3423rfgasdg"};
  while (state.KeepRunning()) {
    auto res = remove_prefix(example);
    // auto res = remove_prefix(string_view(example)); for string_view
    if (res != "aghdfgsghasfasg3423rfgasdg") {
      throw std::runtime_error("bad op");
    }
  }
}
// BM_remove_prefix_string_view is similar, I skipped it to keep the post short
```

### 结果

（x86_64 linux，gcc 6.2，“ `-O3 -DNDEBUG`”）：

```cpp
Benchmark                             Time           CPU Iterations
-------------------------------------------------------------------
BM_remove_prefix_string              90 ns         90 ns    7740626
BM_remove_prefix_string_view          6 ns          6 ns  120468514
```

— [帕维尔·达维多夫（Pavel Davydov）](https://stackoverflow.com/users/2037422/pavel-davydov)