# [How to use vector::push_back()` with a struct?](https://stackoverflow.com/questions/5289597/how-to-use-vectorpush-back-with-a-struct)

[Ask Question](https://stackoverflow.com/questions/ask)

Asked 10 years, 9 months ago

Active [4 months ago](https://stackoverflow.com/questions/5289597/how-to-use-vectorpush-back-with-a-struct?lastactivity)

Viewed 87k times

44

How can I `push_back` a `struct` into a vector?

```cpp
struct point {
    int x;
    int y;
};

std::vector<point> a;

a.push_back( ??? );
```

[c++](https://stackoverflow.com/questions/tagged/c%2b%2b)[vector](https://stackoverflow.com/questions/tagged/vector)

[Share](https://stackoverflow.com/q/5289597)

[Improve this question](https://stackoverflow.com/posts/5289597/edit)

Follow

[edited May 15 '18 at 12:50](https://stackoverflow.com/posts/5289597/revisions)

![img](https://www.gravatar.com/avatar/bd4c9461f2d17a884fba66eeed20e320?s=64&d=identicon&r=PG)

Micha Wiedenmann

**18.4k**2020 gold badges8686 silver badges131131 bronze badges

asked Mar 13 '11 at 13:20

![img](https://i.stack.imgur.com/v5HaT.png?s=64&g=1)

XCS

**25k**2424 gold badges8989 silver badges143143 bronze badges

[Add a comment](https://stackoverflow.com/questions/5289597/how-to-use-vectorpush-back-with-a-struct#)

## 5 Answers

[Active](https://stackoverflow.com/questions/5289597/how-to-use-vectorpush-back-with-a-struct?answertab=active#tab-top)[Oldest](https://stackoverflow.com/questions/5289597/how-to-use-vectorpush-back-with-a-struct?answertab=oldest#tab-top)[Votes](https://stackoverflow.com/questions/5289597/how-to-use-vectorpush-back-with-a-struct?answertab=votes#tab-top)

50

```cpp
point mypoint = {0, 1};
a.push_back(mypoint);
```

Or if you're allowed, give `point` a constructor, so that you can use a temporary:

```cpp
a.push_back(point(0,1));
```

Some people will object if you put a constructor in a class declared with `struct`, and it makes it non-POD, and maybe you aren't in control of the definition of `point`. So this option might not be available to you. However, you can write a function which provides the same convenience:

```cpp
point make_point(int x, int y) {
    point mypoint = {x, y};
    return mypoint;
}

a.push_back(make_point(0, 1));
```