# Lambda expressions (since C++11)

 

[C++](https://en.cppreference.com/w/cpp)

 

[C++ language](https://en.cppreference.com/w/cpp/language)

 

[Functions](https://en.cppreference.com/w/cpp/language/functions)

 

Constructs a [closure](https://en.wikipedia.org/wiki/Closure_(computer_science)): an unnamed function object capable of capturing variables in scope.

### Syntax

|                                                              |      |                             |
| ------------------------------------------------------------ | ---- | --------------------------- |
| `**[**` *captures* `**]**` `**(**` *params* `**)**` *lambda-specifiers* *requires*(optional) `**{**` *body* `**}**` | (1)  |                             |
|                                                              |      |                             |
| `**[**` *captures* `**]**` `**{**` *body* `**}**`            | (2)  | (until C++23)               |
|                                                              |      |                             |
| `**[**` *captures* `**]**` *lambda-specifiers* `**{**` *body* `**}**` | (2)  | (since C++23)               |
|                                                              |      |                             |
| `**[**` *captures* `**]**` *<tparams>* *requires*(optional) `**(**` *params* `**)**` *lambda-specifiers* *requires*(optional) `**{**` *body* `**}**` | (3)  | (since C++20)               |
|                                                              |      |                             |
| `**[**` *captures* `**]**` *<tparams>* *requires*(optional) `**{**` *body* `**}**` | (4)  | (since C++20) (until C++23) |
|                                                              |      |                             |
| `**[**` *captures* `**]**` *<tparams>* *requires*(optional) *lambda-specifiers* `**{**` *body* `**}**` | (4)  | (since C++23)               |
|                                                              |      |                             |

1) Full declaration.

2) Omitted parameter list: function takes no arguments, as if the parameter list were `**()**`.

3) Same as 1), but specifies a generic lambda and explicitly provides a list of template parameters.

4) Same as 2), but specifies a generic lambda and explicitly provides a list of template parameters.

### Explanation

| *captures*             | -    | a comma-separated list of zero or more [captures](https://en.cppreference.com/w/cpp/language/lambda#Lambda_capture), optionally beginning with a *capture-default*.See [below](https://en.cppreference.com/w/cpp/language/lambda#Lambda_capture) for the detailed description of captures.A lambda expression can use a variable without capturing it if the variableis a non-local variable or has static or thread local [storage duration](https://en.cppreference.com/w/cpp/language/storage_duration) (in which case the variable cannot be captured), oris a reference that has been initialized with a [constant expression](https://en.cppreference.com/w/cpp/language/constant_expression#Constant_expression).A lambda expression can read the value of a variable without capturing it if the variablehas const non-volatile integral or enumeration type and has been initialized with a [constant expression](https://en.cppreference.com/w/cpp/language/constant_expression#Constant_expression), oris `constexpr` and has no mutable members. |
| ---------------------- | ---- | ------------------------------------------------------------ |
| *<tparams>*            | -    | a template parameter list (in angle brackets), used to provide names to the template parameters of a generic lambda (see `ClosureType::operator()` below). Like in a [template declaration](https://en.cppreference.com/w/cpp/language/templates), the template parameter list may be followed by an optional requires-clause, which specifies the [constraints](https://en.cppreference.com/w/cpp/language/constraints) on the template arguments.The template parameter list cannot be empty (`<>` is not allowed). |
| *params*               | -    | The list of parameters, as in [named functions](https://en.cppreference.com/w/cpp/language/function). |
| *lambda-specifiers*    | -    | consists of *specifiers*, *exception*, *attr* and *trailing-return-type* in order, every component is optional |
| *specifiers*           | -    | Optional sequence of specifiers. If not provided, the objects captured by copy are const in the lambda body. The following specifiers are allowed:`**mutable**`: allows *body* to modify the objects captured by copy, and to call their non-const member functions`**constexpr**`: explicitly specifies that the function call operator or any given operator template specialization is a [constexpr](https://en.cppreference.com/w/cpp/language/constexpr) function. When this specifier is not present, the function call operator or any given operator template specialization will be `constexpr` anyway, if it happens to satisfy all constexpr function requirements(since C++17)`**consteval**`: specifies that the function call operator or any given operator template specialization is an [immediate function](https://en.cppreference.com/w/cpp/language/consteval). `consteval` and `constexpr` cannot be used at the same time.(since C++20) |
| *exception*            | -    | provides the [dynamic exception specification](https://en.cppreference.com/w/cpp/language/except_spec) or (until C++20) the [noexcept specifier](https://en.cppreference.com/w/cpp/language/noexcept_spec) for `operator()` of the closure type |
| *attr*                 | -    | provides the [attribute specification](https://en.cppreference.com/w/cpp/language/attributes) for the type of the function call operator or operator template of the closure type. Any attribute so specified does not appertain to the function call operator or operator template itself, but its type. (For example, the `[[noreturn]]` attribute cannot be used.) |
| *trailing-return-type* | -    | `**->**` *ret*, where *ret* specifies the return type. If *trailing-return-type* is not present, the return type of the closure's `operator()` is [deduced](https://en.cppreference.com/w/cpp/language/template_argument_deduction) from [return](https://en.cppreference.com/w/cpp/language/return) statements as if for a function whose [return type is declared auto](https://en.cppreference.com/w/cpp/language/function#Return_type_deduction). |
| *requires*             | -    | (since C++20) adds [constraints](https://en.cppreference.com/w/cpp/language/constraints) to `operator()` of the closure type |
| *body*                 | -    | Function body                                                |

| If [`auto`](https://en.cppreference.com/w/cpp/language/auto) is used as a type of a parameter or an explicit template parameter list is provided (since C++20), the lambda is a *generic lambda*. | (since C++14) |
| ------------------------------------------------------------ | ------------- |
|                                                              |               |

The lambda expression is a prvalue expression of unique unnamed non-union non-aggregate class type, known as *closure type*, which is declared (for the purposes of [ADL](https://en.cppreference.com/w/cpp/language/adl)) in the smallest block scope, class scope, or namespace scope that contains the lambda expression. The closure type has the following members:

## ClosureType::operator()(*params*)

| ret operator()(params) const { body }                        |      | (the keyword mutable was not used)                           |
| ------------------------------------------------------------ | ---- | ------------------------------------------------------------ |
| ret operator()(params) { body }                              |      | (the keyword mutable was used)                               |
| template<template-params> ret operator()(params) const { body } |      | (since C++14) (generic lambda)                               |
| template<template-params> ret operator()(params) { body }    |      | (since C++14) (generic lambda, the keyword mutable was used) |
|                                                              |      |                                                              |

Executes the body of the lambda-expression, when invoked. When accessing a variable, accesses its captured copy (for the entities captured by copy), or the original object (for the entities captured by reference). Unless the keyword mutable was used in the lambda-expression, the function-call operator or operator template is const-qualified and the objects that were captured by copy are non-modifiable from inside this operator(). The function-call operator or operator template is never volatile-qualified and never virtual.

| The function-call operator or any given operator template specialization is always `constexpr` if it satisfies the requirements of a [constexpr function](https://en.cppreference.com/w/cpp/language/constexpr). It is also constexpr if the keyword constexpr was used in the lambda declaration. | (since C++17) |
| ------------------------------------------------------------ | ------------- |
|                                                              |               |

| The function-call operator or any given operator template specialization is an [immediate function](https://en.cppreference.com/w/cpp/language/consteval) if the keyword `consteval` was used in the lambda expression. | (since C++20) |
| ------------------------------------------------------------ | ------------- |
|                                                              |               |

| For every parameter in *params* whose type is specified as `auto`, an invented template parameter is added to *template-params*, in order of appearance. The invented template parameter may be a [parameter pack](https://en.cppreference.com/w/cpp/language/parameter_pack) if the corresponding function member of *params* is a function parameter pack.`// generic lambda, operator() is a template with two parameters auto glambda = [](auto a, auto&& b) { return a < b; }; bool b = glambda(3, 3.14); // ok   // generic lambda, operator() is a template with one parameter auto vglambda = [](auto printer) {     return [=](auto&&... ts) // generic lambda, ts is a parameter pack     {          printer(std::forward<decltype(ts)>(ts)...);         return [=] { printer(ts...); }; // nullary lambda (takes no parameters)     }; }; auto p = vglambda([](auto v1, auto v2, auto v3) { std::cout << v1 << v2 << v3; }); auto q = p(1, 'a', 3.14); // outputs 1a3.14 q();                      // outputs 1a3.14``ClosureType`'s `operator()` cannot be explicitly instantiated or explicitly specialized. | (since C++14) |
| ------------------------------------------------------------ | ------------- |
|                                                              |               |

| If the lambda definition uses an explicit template parameter list, that template parameter list is used with `operator()`. For every parameter in *params* whose type is specified as `auto`, an additional invented template parameter is appended to the end of that template parameter list:`// generic lambda, operator() is a template with two parameters auto glambda = []<class T>(T a, auto&& b) { return a < b; };   // generic lambda, operator() is a template with one parameter pack auto f = []<typename ...Ts>(Ts&& ...ts) {    return foo(std::forward<Ts>(ts)...); };` | (since C++20) |
| ------------------------------------------------------------ | ------------- |
|                                                              |               |

the exception specification *exception* on the lambda-expression applies to the function-call operator or operator template.

For the purpose of [name lookup](https://en.cppreference.com/w/cpp/language/lookup), determining the type and value of the [this pointer](https://en.cppreference.com/w/cpp/language/this) and for accessing non-static class members, the body of the closure type's function call operator or operator template is considered in the context of the lambda-expression.

```
struct X {
    int x, y;
    int operator()(int);
    void f()
    {
        // the context of the following lambda is the member function X::f
        [=]()->int
        {
            return operator()(this->x + y); // X::operator()(this->x + (*this).y)
                                            // this has type X*
        };
    }
};
```

`ClosureType`'s `operator()` cannot be named in a [friend](https://en.cppreference.com/w/cpp/language/friend) declaration.

### Dangling references

If a non-reference entity is captured by reference, implicitly or explicitly, and the function call operator or a specialization of the function call operator template of the closure object is invoked after the entity's lifetime has ended, undefined behavior occurs. The C++ closures do not extend the lifetimes of objects captured by reference.

Same applies to the lifetime of the current *this object captured via `this`.

## ClosureType::operator *ret*(*)(*params*)()

| capture-less non-generic lambda                              |      |                             |
| ------------------------------------------------------------ | ---- | --------------------------- |
| using F = ret(*)(params); operator F() const noexcept;       |      | (until C++17)               |
| using F = ret(*)(params); constexpr operator F() const noexcept; |      | (since C++17)               |
| capture-less generic lambda                                  |      |                             |
| template<template-params> using fptr_t = */\*see below\*/*; template<template-params> operator fptr_t<template-params>() const noexcept; |      | (since C++14) (until C++17) |
| template<template-params> using fptr_t = */\*see below\*/*; template<template-params> constexpr operator fptr_t<template-params>() const noexcept; |      | (since C++17)               |
|                                                              |      |                             |

This [user-defined conversion function](https://en.cppreference.com/w/cpp/language/cast_operator) is only defined if the capture list of the lambda-expression is empty. It is a public, constexpr, (since C++17) non-virtual, non-explicit, const noexcept member function of the closure object.

| This function is an [immediate function](https://en.cppreference.com/w/cpp/language/consteval) if the function call operator (or specialization, for generic lambdas) is an immediate function. | (since C++20) |
| ------------------------------------------------------------ | ------------- |
|                                                              |               |

| A generic captureless lambda has a user-defined conversion function template with the same invented template parameter list as the function-call operator template. If the return type is empty or auto, it is obtained by return type deduction on the function template specialization, which, in turn, is obtained by [template argument deduction](https://en.cppreference.com/w/cpp/language/template_argument_deduction) for conversion function templates.`void f1(int (*)(int)) {} void f2(char (*)(int)) {} void h(int (*)(int)) {} // #1 void h(char (*)(int)) {} // #2 auto glambda = [](auto a) { return a; }; f1(glambda); // ok f2(glambda); // error: not convertible h(glambda); // ok: calls #1 since #2 is not convertible   int& (*fpi)(int*) = [](auto* a)->auto& { return *a; }; // ok` | (since C++14) |
| ------------------------------------------------------------ | ------------- |
|                                                              |               |

The value returned by this conversion function is a pointer to a function with C++ [language linkage](https://en.cppreference.com/w/cpp/language/language_linkage) that, when invoked, has the same effect as invoking the closure object's function call operator directly.

| This function is constexpr if the function call operator (or specialization, for generic lambdas) is constexpr.`auto Fwd= [](int(*fp)(int), auto a){return fp(a);}; auto C=[](auto a){return a;}; static_assert(Fwd(C,3)==3);//OK   auto NC=[](auto a){static int s; return a;}; static_assert(Fwd(NC,3)==3); // error: no specialization can be constexpr because of static s`If the closure object's `operator()` has a non-throwing exception specification, then the pointer returned by this function has the type pointer to noexcept function. | (since C++17) |
| ------------------------------------------------------------ | ------------- |
|                                                              |               |

## ClosureType::ClosureType()

| ClosureType() = default;                   |      | (since C++20) (only if no captures are specified) |
| ------------------------------------------ | ---- | ------------------------------------------------- |
| ClosureType(const ClosureType&) = default; |      |                                                   |
| ClosureType(ClosureType&&) = default;      |      |                                                   |
|                                            |      |                                                   |

| Closure types are not [*DefaultConstructible*](https://en.cppreference.com/w/cpp/named_req/DefaultConstructible). Closure types have no default constructor. | (until C++20) |
| ------------------------------------------------------------ | ------------- |
| If no *captures* are specified, the closure type has a defaulted default constructor. Otherwise, it has no default constructor (this includes the case when there is a *capture-default*, even if it does not actually capture anything). | (since C++20) |

The copy constructor and the move constructor are declared as defaulted and may be implicitly-defined according to the usual rules for [copy constructors](https://en.cppreference.com/w/cpp/language/copy_constructor) and [move constructors](https://en.cppreference.com/w/cpp/language/move_constructor).

## ClosureType::operator=(const ClosureType&)

| ClosureType& operator=(const ClosureType&) = delete;         |      | (until C++20)                                     |
| ------------------------------------------------------------ | ---- | ------------------------------------------------- |
| ClosureType& operator=(const ClosureType&) = default; ClosureType& operator=(ClosureType&&) = default; |      | (since C++20) (only if no captures are specified) |
| ClosureType& operator=(const ClosureType&) = delete;         |      | (since C++20) (otherwise)                         |
|                                                              |      |                                                   |

| The copy assignment operator is defined as deleted (and the move assignment operator is not declared). Closure types are not [*CopyAssignable*](https://en.cppreference.com/w/cpp/named_req/CopyAssignable). | (until C++20) |
| ------------------------------------------------------------ | ------------- |
| If no *captures* are specified, the closure type has a defaulted copy assignment operator and a defaulted move assignment operator. Otherwise, it has a deleted copy assignment operator (this includes the case when there is a *capture-default*, even if it does not actually capture anything). | (since C++20) |

## ClosureType::~ClosureType()

| ~ClosureType() = default; |      |      |
| ------------------------- | ---- | ---- |
|                           |      |      |

The destructor is implicitly-declared.

## ClosureType::*Captures*

| T1 a; T2 b; ... |      |      |
| --------------- | ---- | ---- |
|                 |      |      |

If the lambda-expression captures anything by copy (either implicitly with capture clause `**[=]**` or explicitly with a capture that does not include the character &, e.g. `**[a, b, c]**`), the closure type includes unnamed non-static data members, declared in unspecified order, that hold copies of all entities that were so captured.

Those data members that correspond to captures without initializers are [direct-initialized](https://en.cppreference.com/w/cpp/language/direct_initialization) when the lambda-expression is evaluated. Those that correspond to captures with initializers are initialized as the initializer requires (could be copy- or direct-initialization). If an array is captured, array elements are direct-initialized in increasing index order. The order in which the data members are initialized is the order in which they are declared (which is unspecified).

The type of each data member is the type of the corresponding captured entity, except if the entity has reference type (in that case, references to functions are captured as lvalue references to the referenced functions, and references to objects are captured as copies of the referenced objects).

For the entities that are captured by reference (with the default capture `**[&]**` or when using the character &, e.g. `**[&a, &b, &c]**`), it is unspecified if additional data members are declared in the closure type, but any such additional members must satisfy [*LiteralType*](https://en.cppreference.com/w/cpp/named_req/LiteralType) (since C++17).

| Lambda-expressions are not allowed in [unevaluated expressions](https://en.cppreference.com/w/cpp/language/expressions#Unevaluated_expressions), [template arguments](https://en.cppreference.com/w/cpp/language/template_parameters), [alias declarations](https://en.cppreference.com/w/cpp/language/type_alias), [typedef declarations](https://en.cppreference.com/w/cpp/language/typedef), and anywhere in a function (or function template) declaration except the function body and the function's [default arguments](https://en.cppreference.com/w/cpp/language/default_arguments).This section is incomplete Reason: elaborate what was changed since c++20 | (until C++20) |
| ------------------------------------------------------------ | ------------- |
|                                                              |               |

### Lambda capture

The *captures* is a comma-separated list of zero or more *captures*, optionally beginning with the *capture-default*. The capture list defines the outside variables that are accessible from within the lambda function body. The only capture defaults are

- `**&** `(implicitly capture the used automatic variables by reference) and
- `**=** `(implicitly capture the used automatic variables by copy).

The current object (*this) can be implicitly captured if either capture default is present. If implicitly captured, it is always captured by reference, even if the capture default is `=`. The implicit capture of *this when the capture default is `=` is deprecated. (since C++20)

The syntax of an individual capture in *captures* is

|                                              |      |               |
| -------------------------------------------- | ---- | ------------- |
| *identifier*                                 | (1)  |               |
|                                              |      |               |
| *identifier* `**...**`                       | (2)  |               |
|                                              |      |               |
| *identifier* *initializer*                   | (3)  | (since C++14) |
|                                              |      |               |
| `**&**` *identifier*                         | (4)  |               |
|                                              |      |               |
| `**&**` *identifier* `**...**`               | (5)  |               |
|                                              |      |               |
| `**&**` *identifier* *initializer*           | (6)  | (since C++14) |
|                                              |      |               |
| `**this**`                                   | (7)  |               |
|                                              |      |               |
| `*****` `**this**`                           | (8)  | (since C++17) |
|                                              |      |               |
| `**...**` *identifier* *initializer*         | (9)  | (since C++20) |
|                                              |      |               |
| `**&**` `**...**` *identifier* *initializer* | (10) | (since C++20) |
|                                              |      |               |

1) simple by-copy capture

2) simple by-copy capture that is a [pack expansion](https://en.cppreference.com/w/cpp/language/parameter_pack)

3) by-copy capture with an [initializer](https://en.cppreference.com/w/cpp/language/initialization)

4) simple by-reference capture

5) simple by-reference capture that is a [pack expansion](https://en.cppreference.com/w/cpp/language/parameter_pack)

6) by-reference capture with an initializer

7) simple by-reference capture of the current object

8) simple by-copy capture of the current object

9) by-copy capture with an initializer that is a pack expansion

10) by-reference capture with an initializer that is a pack expansion

If the capture-default is `&`, subsequent simple captures must not begin with `&`.

```
struct S2 { void f(int i); };
void S2::f(int i)
{
    [&]{};          // OK: by-reference capture default
    [&, i]{};       // OK: by-reference capture, except i is captured by copy
    [&, &i] {};     // Error: by-reference capture when by-reference is the default
    [&, this] {};   // OK, equivalent to [&]
    [&, this, i]{}; // OK, equivalent to [&, i]
}
```

If the capture-default is `=`, subsequent simple captures must begin with `&` or be `*this` (since C++17) or `this` (since C++20).

```
struct S2 { void f(int i); };
void S2::f(int i)
{
    [=]{};          // OK: by-copy capture default
    [=, &i]{};      // OK: by-copy capture, except i is captured by reference
    [=, *this]{};   // until C++17: Error: invalid syntax
                    // since c++17: OK: captures the enclosing S2 by copy
    [=, this] {};   // until C++20: Error: this when = is the default
                    // since C++20: OK, same as [=]
}
```

Any capture may appear only once:

```
struct S2 { void f(int i); };
void S2::f(int i)
{
    [i, i] {};        // Error: i repeated
    [this, *this] {}; // Error: "this" repeated (C++17)
}
```

Only lambda-expressions defined at block scope or in a [default member initializer](https://en.cppreference.com/w/cpp/language/data_members#Member_initialization) may have a capture-default or captures without initializers. For such lambda-expression, the *reaching scope* is defined as the set of enclosing scopes up to and including the innermost enclosing function (and its parameters). This includes nested block scopes and the scopes of enclosing lambdas if this lambda is nested.

The *identifier* in any capture without an initializer (other than the `this`-capture) is looked up using usual [unqualified name lookup](https://en.cppreference.com/w/cpp/language/lookup) in the *reaching scope* of the lambda. The result of the lookup must be a [variable](https://en.cppreference.com/w/cpp/language/object) with automatic storage duration declared in the reaching scope, or a [structured binding](https://en.cppreference.com/w/cpp/language/structured_binding) whose corresponding variable satisfies such requirements (since C++20). The entity is *explicitly captured*.

| A capture with an initializer acts as if it declares and explicitly captures a variable declared with type [`auto`](https://en.cppreference.com/w/cpp/language/auto), whose declarative region is the body of the lambda expression (that is, it is not in scope within its initializer), except that:if the capture is by-copy, the non-static data member of the closure object is another way to refer to that auto variable.if the capture is by-reference, the reference variable's lifetime ends when the lifetime of the closure object endsThis is used to capture move-only types with a capture such as x = std::move(x).This also makes it possible to capture by const reference, with &cr = [std::as_const](http://en.cppreference.com/w/cpp/utility/as_const)(x) or similar.`int x = 4; auto y = [&r = x, x = x + 1]()->int     {         r += 2;         return x * x;     }(); // updates ::x to 6 and initializes y to 25.` | (since C++14) |
| ------------------------------------------------------------ | ------------- |
|                                                              |               |

If a capture list has a capture-default and does not explicitly capture the enclosing object (as `this` or `*this`), or an automatic variable that is [odr-usable](https://en.cppreference.com/w/cpp/language/definition#ODR-use) in the lambda body, or a [structured binding](https://en.cppreference.com/w/cpp/language/structured_binding) whose corresponding variable has atomic storage duration (since C++20), it captures it *implicitly* if

- the body of the lambda [odr-uses](https://en.cppreference.com/w/cpp/language/definition#ODR-use) the entity

| or the entity is named in a potentially-evaluated expression within an expression that depends on a generic lambda parameter (until C++17) (including when the implicit this-> is added before a use of non-static class member). For this purpose, the operand of [`typeid`](https://en.cppreference.com/w/cpp/language/typeid) is always considered potentially-evaluated. Entities might be implicitly captured even if they are only named within a [discarded statement](https://en.cppreference.com/w/cpp/language/if#Constexpr_if). (since C++17)`void f(int, const int (&)[2] = {}) {} // #1 void f(const int&, const int (&)[1]) {} // #2 void test() {     const int x = 17;     auto g0 = [](auto a) { f(x); }; // ok: calls #1, does not capture x     auto g1 = [=](auto a) { f(x); }; // does not capture x in C++14, captures x in C++17                                      // the capture can be optimized away     auto g2 = [=](auto a) {             int selector[sizeof(a) == 1 ? 1 : 2] = {};             f(x, selector); // ok: is a dependent expression, so captures x     };     auto g3 = [=](auto a) {       typeid(a + x);  // captures x regardless of whether a + x is an unevaluated operand     }; }` | (since C++14) |
| ------------------------------------------------------------ | ------------- |
|                                                              |               |

If the body of a lambda [odr-uses](https://en.cppreference.com/w/cpp/language/definition#ODR-use) an entity captured by copy, the member of the closure type is accessed. If it is not odr-using the entity, the access is to the original object:

```
void f(const int*);
void g()
{
    const int N = 10;
    [=]{ 
        int arr[N]; // not an odr-use: refers to g's const int N
        f(&N); // odr-use: causes N to be captured (by copy)
               // &N is the address of the closure object's member N, not g's N
    }();
}
```

If a lambda odr-uses a reference that is captured by reference, it is using the object referred-to by the original reference, not the captured reference itself:

Run this code

```
#include <iostream>
 
auto make_function(int& x) {
  return [&]{ std::cout << x << '\n'; };
}
 
int main() {
  int i = 3;
  auto f = make_function(i); // the use of x in f binds directly to i
  i = 5;
  f(); // OK; prints 5
}
```

Within the body of a lambda with capture default `=`, the type of any capturable entity is as if it were captured (and thus const-qualification is often added if the lambda is not `mutable`), even though the entity is in an unevaluated operand and not captured (e.g. in [`decltype`](https://en.cppreference.com/w/cpp/language/decltype)):

```
void f3() {
    float x, &r = x;
    [=]
    { // x and r are not captured (appearance in a decltype operand is not an odr-use)
        decltype(x) y1; // y1 has type float
        decltype((x)) y2 = y1; // y2 has type float const& because this lambda
                               // is not mutable and x is an lvalue
        decltype(r) r1 = y1;   // r1 has type float& (transformation not considered)
        decltype((r)) r2 = y2; // r2 has type float const&
    };
}
```

Any entity captured by a lambda (implicitly or explicitly) is odr-used by the lambda-expression (therefore, implicit capture by a nested lambda triggers implicit capture in the enclosing lambda).

All implicitly-captured variables must be declared within the *reaching scope* of the lambda.

If a lambda captures the enclosing object (as `this` or `*this`), either the nearest enclosing function must be a non-static member function or the lambda must be in a [default member initializer](https://en.cppreference.com/w/cpp/language/data_members#Member_initialization):

```
struct s2 {
  double ohseven = .007;
  auto f() { // nearest enclosing function for the following two lambdas
    return [this] { // capture the enclosing s2 by reference
      return [*this] { // capture the enclosing s2 by copy (C++17)
          return ohseven; // OK
       }
     }();
  }
  auto g() {
     return []{ // capture nothing
         return [*this]{}; // error: *this not captured by outer lambda-expression
      }();
   }
};
```

If a lambda expression (or an instantiation of a generic lambda's function call operator) (since C++14) ODR-uses *this or any variable with automatic storage duration, it must be captured by the lambda expression.

```
void f1(int i)
{
    int const N = 20;
    auto m1 = [=] {
            int const M = 30;
            auto m2 = [i] {
                    int x[N][M]; // N and M are not odr-used 
                                 // (ok that they are not captured)
                    x[0][0] = i; // i is explicitly captured by m2
                                 // and implicitly captured by m1
            };
    };
 
    struct s1 // local class within f1()
    {
        int f;
        void work(int n) // non-static member function
        {
            int m = n * n;
            int j = 40;
            auto m3 = [this, m] {
                auto m4 = [&, j] { // error: j is not captured by m3
                        int x = n; // error: n is implicitly captured by m4
                                   // but not captured by m3
                        x += m;    // ok: m is implicitly captured by m4
                                   // and explicitly captured by m3
                        x += i;    // error: i is outside of the reaching scope
                                   // (which ends at work())
                        x += f;    // ok: this is captured implicitly by m4
                                   // and explicitly captured by m3
                };
            };
        }
    };
}
```

Class members cannot be captured explicitly by a capture without initializer (as mentioned above, only [variables](https://en.cppreference.com/w/cpp/language/object) are permitted in the capture list):

```
class S {
  int x = 0;
  void f() {
    int i = 0;
//  auto l1 = [i, x]{ use(i, x); };    // error: x is not a variable
    auto l2 = [i, x=x]{ use(i, x); };  // OK, copy capture
    i = 1; x = 1; l2(); // calls use(0,0)
    auto l3 = [i, &x=x]{ use(i, x); }; // OK, reference capture
    i = 2; x = 2; l3(); // calls use(1,2)
  }
};
```

When a lambda captures a member using implicit by-copy capture, it does not make a copy of that member variable: the use of a member variable `m` is treated as an expression (*this).m, and *this is always implicitly captured by reference:

```
class S {
  int x = 0;
  void f() {
    int i = 0;
    auto l1 = [=]{ use(i, x); }; // captures a copy of i and a copy of the this pointer
    i = 1; x = 1; l1(); // calls use(0,1), as if i by copy and x by reference
    auto l2 = [i, this]{ use(i, x); }; // same as above, made explicit
    i = 2; x = 2; l2(); // calls use(1,2), as if i by copy and x by reference
    auto l3 = [&]{ use(i, x); }; // captures i by reference and a copy of the this pointer
    i = 3; x = 2; l3(); // calls use(3,2), as if i and x are both by reference
    auto l4 = [i, *this]{ use(i, x); }; // makes a copy of *this, including a copy of x
    i = 4; x = 4; l4(); // calls use(3,2), as if i and x are both by copy
  }
};
```

If a lambda-expression appears in a [default argument](https://en.cppreference.com/w/cpp/language/default_arguments), it cannot explicitly or implicitly capture anything.

Members of [anonymous unions](https://en.cppreference.com/w/cpp/language/union) members cannot be captured. [Bit-fields](https://en.cppreference.com/w/cpp/language/bit_field) can only captured by copy.

If a nested lambda `m2` captures something that is also captured by the immediately enclosing lambda `m1`, then `m2`'s capture is transformed as follows:

- if the enclosing lambda `m1` captures by copy, `m2` is capturing the non-static member of `m1`'s closure type, not the original variable or *this; if `m1` is not mutable, the non-static data member is considered to be const-qualified.
- if the enclosing lambda `m1` captures by reference, `m2` is capturing the original variable or *this.

Run this code

```
#include <iostream>
 
int main()
{
    int a = 1, b = 1, c = 1;
 
    auto m1 = [a, &b, &c]() mutable {
        auto m2 = [a, b, &c]() mutable {
            std::cout << a << b << c << '\n';
            a = 4; b = 4; c = 4;
        };
        a = 3; b = 3; c = 3;
        m2();
    };
 
    a = 2; b = 2; c = 2;
 
    m1();                             // calls m2() and prints 123
    std::cout << a << b << c << '\n'; // prints 234
}
```

### Example

This example shows how to pass a lambda to a generic algorithm and how objects resulting from a lambda declaration can be stored in [std::function](https://en.cppreference.com/w/cpp/utility/functional/function) objects.

Run this code

```
#include <vector>
#include <iostream>
#include <algorithm>
#include <functional>
 
int main()
{
    std::vector<int> c = {1, 2, 3, 4, 5, 6, 7};
    int x = 5;
    c.erase(std::remove_if(c.begin(), c.end(), [x](int n) { return n < x; }), c.end());
 
    std::cout << "c: ";
    std::for_each(c.begin(), c.end(), [](int i){ std::cout << i << ' '; });
    std::cout << '\n';
 
    // the type of a closure cannot be named, but can be inferred with auto
    // since C++14, lambda could own default arguments
    auto func1 = [](int i = 6) { return i + 4; };
    std::cout << "func1: " << func1() << '\n';
 
    // like all callable objects, closures can be captured in std::function
    // (this may incur unnecessary overhead)
    std::function<int(int)> func2 = [](int i) { return i + 4; };
    std::cout << "func2: " << func2(6) << '\n';
 
    std::cout << "Emulate `recursive lambda` calls:\nFibonacci numbers: ";
    auto nth_fibonacci = [](int n) {
        std::function<int(int,int,int)> fib = [&](int a, int b, int n) {
            return n ? fib(a + b, a, n - 1) : b;
        };
        return fib(1, 0, n);
    };
    for (int i{1}; i != 9; ++i) { std::cout << nth_fibonacci(i) << ", "; }
 
    std::cout << "\nAlternative approach to lambda recursion:\nFibonacci numbers: ";
    auto nth_fibonacci2 = [](int n) {
        auto fib = [](auto self, int a, int b, int n) -> int {
            return n ? self(self, a + b, a, n - 1) : b;
        };
        return fib(fib, 1, 0, n);
    };
    for (int i{1}; i != 9; ++i) { std::cout << nth_fibonacci2(i) << ", "; }
}
```

Output:

```
c: 5 6 7
func1: 10
func2: 10
Emulate `recursive lambda` calls:
Fibonacci numbers: 1, 1, 2, 3, 5, 8, 13, 21,
Alternative approach to lambda recursion:
Fibonacci numbers: 1, 1, 2, 3, 5, 8, 13, 21,
```

### Defect reports

The following behavior-changing defect reports were applied retroactively to previously published C++ standards.

| DR                                                | Applied to | Behavior as published                                        | Correct behavior                                |
| ------------------------------------------------- | ---------- | ------------------------------------------------------------ | ----------------------------------------------- |
| [CWG 974](https://wg21.cmeerw.net/cwg/issue974)   | C++11      | default argument was not allowed in parameter list of a lambda expression | allowed                                         |
| [CWG 975](https://wg21.cmeerw.net/cwg/issue975)   | C++11      | the return type of closure's `operator()` was only deduced if lambda body contains a single return | deduced as if for C++14 auto-returning function |
| [CWG 1249](https://wg21.cmeerw.net/cwg/issue1249) | C++11      | it is not clear that whether the captured member of the enclosing non-mutable lambda is considered `const` or not | considered `const`                              |
| [CWG 1722](https://wg21.cmeerw.net/cwg/issue1722) | C++11      | the conversion function for captureless lambdas had unspecified exception specification | conversion function is noexcept                 |
| [CWG 1891](https://wg21.cmeerw.net/cwg/issue1891) | C++11      | closure had a deleted default ctor and implicit copy/move ctors | no default and defaulted copy/move              |

### See also

| [`auto` specifier ](https://en.cppreference.com/w/cpp/language/auto)(C++11) | specifies a type deduced from an expression                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [function](https://en.cppreference.com/w/cpp/utility/functional/function)(C++11) | wraps callable object of any copy constructible type with specified function call signature (class template) |
| [move_only_function](https://en.cppreference.com/w/cpp/utility/functional/move_only_function)(C++23) | wraps callable object of any type with specified function call signature |