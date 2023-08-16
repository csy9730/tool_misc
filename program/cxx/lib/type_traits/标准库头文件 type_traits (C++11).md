# 标准库头文件 <type_traits> (C++11)

这个头文件是[元编程](https://runebook.dev/zh/docs/cpp/meta)库的一部分。

| Classes                                                      |                                                              |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Helper Classes                                               |                                                              |
| [integral_constantbool_constant](https://runebook.dev/zh/docs/cpp/types/integral_constant)(C++11)(C++17) | 指定类型和指定值的编译时常数。 (class template)              |
| `true_type`                                                  | `std::integral_constant`                                     |
| `false_type`                                                 | `std::integral_constant`                                     |
| 主要类型类别                                                 |                                                              |
| [is_void](https://runebook.dev/zh/docs/cpp/types/is_void)(C++11) | 检查类型是否为 `void` (class template)                       |
| [is_null_pointer](https://runebook.dev/zh/docs/cpp/types/is_null_pointer)(C++14) | 检查类型是否为 `std::nullptr_t` (class template)             |
| [is_integral](https://runebook.dev/zh/docs/cpp/types/is_integral)(C++11) | 检查一个类型是否为积分类型 (class template)                  |
| [is_floating_point](https://runebook.dev/zh/docs/cpp/types/is_floating_point)(C++11) | 检查一个类型是否是浮点类型。 (class template)                |
| [is_array](https://runebook.dev/zh/docs/cpp/types/is_array)(C++11) | 检查一个类型是否是数组类型 (class template)                  |
| [is_enum](https://runebook.dev/zh/docs/cpp/types/is_enum)(C++11) | 检查一个类型是否是枚举类型。 (class template)                |
| [is_union](https://runebook.dev/zh/docs/cpp/types/is_union)(C++11) | 检查一个类型是否是联合类型 (class template)                  |
| [is_class](https://runebook.dev/zh/docs/cpp/types/is_class)(C++11) | 检查一个类型是否为非union类类型 (class template)             |
| [is_function](https://runebook.dev/zh/docs/cpp/types/is_function)(C++11) | 检查一个类型是否是函数类型 (class template)                  |
| [is_pointer](https://runebook.dev/zh/docs/cpp/types/is_pointer)(C++11) | 检查一个类型是否是指针类型。 (class template)                |
| [is_lvalue_reference](https://runebook.dev/zh/docs/cpp/types/is_lvalue_reference)(C++11) | 检查一个类型是否为*lvalue reference* (class template)        |
| [is_rvalue_reference](https://runebook.dev/zh/docs/cpp/types/is_rvalue_reference)(C++11) | 检查一个类型是否为*rvalue reference* (class template)        |
| [is_member_object_pointer](https://runebook.dev/zh/docs/cpp/types/is_member_object_pointer)(C++11) | 检查类型是否是指向非静态成员对象的指针。 (class template)    |
| [is_member_function_pointer](https://runebook.dev/zh/docs/cpp/types/is_member_function_pointer)(C++11) | 检查类型是否是指向非静态成员函数的指针。 (class template)    |
| 复合型类别                                                   |                                                              |
| [is_fundamental](https://runebook.dev/zh/docs/cpp/types/is_fundamental)(C++11) | 检查一个类型是否为基本类型 (class template)                  |
| [is_arithmetic](https://runebook.dev/zh/docs/cpp/types/is_arithmetic)(C++11) | 检查一个类型是否是算术类型。 (class template)                |
| [is_scalar](https://runebook.dev/zh/docs/cpp/types/is_scalar)(C++11) | 检查一个类型是否是标量类型 (class template)                  |
| [is_object](https://runebook.dev/zh/docs/cpp/types/is_object)(C++11) | 检查一个类型是否是对象类型 (class template)                  |
| [is_compound](https://runebook.dev/zh/docs/cpp/types/is_compound)(C++11) | 检查一个类型是否为复合类型 (class template)                  |
| [is_reference](https://runebook.dev/zh/docs/cpp/types/is_reference)(C++11) | 检查一个类型是否是*lvalue reference*or*rvalue reference* (class template) |
| [is_member_pointer](https://runebook.dev/zh/docs/cpp/types/is_member_pointer)(C++11) | 检查类型是否是指向非静态成员函数或对象的指针。 (class template) |
| Type properties                                              |                                                              |
| [is_const](https://runebook.dev/zh/docs/cpp/types/is_const)(C++11) | 检查类型是否是const-qualified (class template)               |
| [is_volatile](https://runebook.dev/zh/docs/cpp/types/is_volatile)(C++11) | 检查类型是否为volatile-qualified类型。 (class template)      |
| [is_trivial](https://runebook.dev/zh/docs/cpp/types/is_trivial)(C++11) | 检查一个类型是否微不足道 (class template)                    |
| [is_trivially_copyable](https://runebook.dev/zh/docs/cpp/types/is_trivially_copyable)(C++11) | 检查一个类型是否可以简单地复制。 (class template)            |
| [is_standard_layout](https://runebook.dev/zh/docs/cpp/types/is_standard_layout)(C++11) | 检查类型是否为[标准布局](https://runebook.dev/zh/docs/cpp/language/data_members#Standard_layout)类型 (class template) |
| [is_pod](https://runebook.dev/zh/docs/cpp/types/is_pod)（C ++ 11）（C ++ 20中不推荐使用） | 检查一个类型是否是旧数据(POD)类型。 (class template)         |
| [is_literal_type](https://runebook.dev/zh/docs/cpp/types/is_literal_type)（C ++ 11）（在C ++ 17中弃用）（在C ++ 20中删除） | 检查一个类型是否为文字类型 (class template)                  |
| [has_unique_object_representations](https://runebook.dev/zh/docs/cpp/types/has_unique_object_representations)(C++17) | 检查类型对象表示中的每一个位是否对其值有贡献。 (class template) |
| [is_empty](https://runebook.dev/zh/docs/cpp/types/is_empty)(C++11) | 检查一个类型是否是类(但不是联合)类型,并且没有非静态数据成员。 (class template) |
| [is_polymorphic](https://runebook.dev/zh/docs/cpp/types/is_polymorphic)(C++11) | 检查一个类型是否是多态类类型。 (class template)              |
| [is_abstract](https://runebook.dev/zh/docs/cpp/types/is_abstract)(C++11) | 检查一个类型是否是抽象类类型。 (class template)              |
| [is_final](https://runebook.dev/zh/docs/cpp/types/is_final)(C++14) | 检查一个类型是否是最终类类型 (class template)                |
| [is_aggregate](https://runebook.dev/zh/docs/cpp/types/is_aggregate)(C++17) | 检查一个类型是否是集合类型 (class template)                  |
| [is_signed](https://runebook.dev/zh/docs/cpp/types/is_signed)(C++11) | 检查一个类型是否是有符号的算术类型。 (class template)        |
| [is_unsigned](https://runebook.dev/zh/docs/cpp/types/is_unsigned)(C++11) | 检查一个类型是否是无符号算术类型。 (class template)          |
| [is_bounded_array](https://runebook.dev/zh/docs/cpp/types/is_bounded_array)(C++20) | 检查一个类型是否是已知边界的数组类型。 (class template)      |
| [is_unbounded_array](https://runebook.dev/zh/docs/cpp/types/is_unbounded_array)(C++20) | 检查一个类型是否是未知边界的数组类型。 (class template)      |
| [is_scoped_enum](https://runebook.dev/zh/docs/cpp/types/is_scoped_enum)(C++23) | 检查一个类型是否是一个范围化的枚举类型 (class template)      |

| Supported operations                                         |                                                              |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [is_constructibleis_trivially_constructibleis_nothrow_constructible](https://runebook.dev/zh/docs/cpp/types/is_constructible)(C++11)(C++11)(C++11) | 检查一个类型是否有特定参数的构造函数。 (class template)      |
| [is_default_constructibleis_trivially_default_constructibleis_nothrow_default_constructible](https://runebook.dev/zh/docs/cpp/types/is_default_constructible)(C++11)(C++11)(C++11) | 检查一个类型是否有默认构造函数 (class template)              |
| [is_copy_constructibleis_trivially_copy_constructibleis_nothrow_copy_constructible](https://runebook.dev/zh/docs/cpp/types/is_copy_constructible)(C++11)(C++11)(C++11) | 检查一个类型是否有复制构造函数 (class template)              |
| [is_move_constructibleis_trivially_move_constructibleis_nothrow_move_constructible](https://runebook.dev/zh/docs/cpp/types/is_move_constructible)(C++11)(C++11)(C++11) | 检查是否能从r值引用中构造出一个类型。 (class template)       |
| [is_assignableis_trivially_assignableis_nothrow_assignable](https://runebook.dev/zh/docs/cpp/types/is_assignable)(C++11)(C++11)(C++11) | 检查一个类型是否有一个特定参数的赋值操作符。 (class template) |
| [is_copy_assignableis_trivially_copy_assignableis_nothrow_copy_assignable](https://runebook.dev/zh/docs/cpp/types/is_copy_assignable)(C++11)(C++11)(C++11) | 检查一个类型是否有复制赋值操作符 (class template)            |
| [is_move_assignableis_trivially_move_assignableis_nothrow_move_assignable](https://runebook.dev/zh/docs/cpp/types/is_move_assignable)(C++11)(C++11)(C++11) | 检查一个类型是否有移动赋值操作符 (class template)            |
| [is_destructibleis_trivially_destructibleis_nothrow_destructible](https://runebook.dev/zh/docs/cpp/types/is_destructible)(C++11)(C++11)(C++11) | 检查一个类型是否有一个非删除的析构器。 (class template)      |
| [has_virtual_destructor](https://runebook.dev/zh/docs/cpp/types/has_virtual_destructor)(C++11) | 检查一个类型是否有虚拟析构器。 (class template)              |
| [is_swappable_withis_swappableis_nothrow_swappable_withis_nothrow_swappable](https://runebook.dev/zh/docs/cpp/types/is_swappable)(C++17)(C++17)(C++17)(C++17) | 检查一个类型的对象是否可以和相同或不同类型的对象交换。 (class template) |

| Property queries                                             |                                                       |
| ------------------------------------------------------------ | ----------------------------------------------------- |
| [alignment_of](https://runebook.dev/zh/docs/cpp/types/alignment_of)(C++11) | 获得该类型的对齐要求 (class template)                 |
| [rank](https://runebook.dev/zh/docs/cpp/types/rank)(C++11)   | 获取一个数组类型的维数。 (class template)             |
| [extent](https://runebook.dev/zh/docs/cpp/types/extent)(C++11) | 获取一个数组类型在指定维度上的大小。 (class template) |

| Type relationships                                           |                                                              |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [is_same](https://runebook.dev/zh/docs/cpp/types/is_same)(C++11) | 检查两个类型是否相同 (class template)                        |
| [is_base_of](https://runebook.dev/zh/docs/cpp/types/is_base_of)(C++11) | 检查一个类型是否从其他类型派生出来。 (class template)        |
| [is_convertibleis_nothrow_convertible](https://runebook.dev/zh/docs/cpp/types/is_convertible)(C++11)(C++20) | 检查一个类型是否可以转换为另一个类型。 (class template)      |
| [is_layout_compatible](https://runebook.dev/zh/docs/cpp/types/is_layout_compatible)(C++20) | 检查两种类型是否[*布局兼容*](https://runebook.dev/zh/docs/cpp/language/data_members#Standard_layout) (class template) |
| [is_pointer_interconvertible_base_of](https://runebook.dev/zh/docs/cpp/types/is_pointer_interconvertible_base_of)(C++20) | 检查一个类型是否为*pointer-interconvertible*（初始）另一种类型的基础 (class template) |
| [is_invocableis_invocable_ris_nothrow_invocableis_nothrow_invocable_r](https://runebook.dev/zh/docs/cpp/types/is_invocable)(C++17) | 检查是否可以使用给定的参数类型 `std::invoke` 类型（就像通过std :: invoke一样） (class template) |
| Const-volatility specifiers                                  |                                                              |
| [remove_cvremove_constremove_volatile](https://runebook.dev/zh/docs/cpp/types/remove_cv)(C++11)(C++11)(C++11) | 从给定类型中删除 `const` 或/和 `volatile` 说明符 (class template) |
| [add_cvadd_constadd_volatile](https://runebook.dev/zh/docs/cpp/types/add_cv)(C++11)(C++11)(C++11) | 将 `const` 或/和 `volatile` 说明符添加到给定类型 (class template) |
| References                                                   |                                                              |
| [remove_reference](https://runebook.dev/zh/docs/cpp/types/remove_reference)(C++11) | 从给定类型中删除一个引用 (class template)                    |
| [add_lvalue_referenceadd_rvalue_reference](https://runebook.dev/zh/docs/cpp/types/add_reference)(C++11)(C++11) | adds a*lvalue*or*rvalue*对给定类型的引用 (class template)    |
| Pointers                                                     |                                                              |
| [remove_pointer](https://runebook.dev/zh/docs/cpp/types/remove_pointer)(C++11) | 从给定类型中删除一个指针 (class template)                    |
| [add_pointer](https://runebook.dev/zh/docs/cpp/types/add_pointer)(C++11) | 添加一个指向给定类型的指针 (class template)                  |
| Sign modifiers                                               |                                                              |
| [make_signed](https://runebook.dev/zh/docs/cpp/types/make_signed)(C++11) | 使给定的积分类型有符号 (class template)                      |
| [make_unsigned](https://runebook.dev/zh/docs/cpp/types/make_unsigned)(C++11) | 使给定的积分类型为无符号 (class template)                    |
| Arrays                                                       |                                                              |
| [remove_extent](https://runebook.dev/zh/docs/cpp/types/remove_extent)(C++11) | 从给定的数组类型中删除一个范围 (class template)              |
| [remove_all_extents](https://runebook.dev/zh/docs/cpp/types/remove_all_extents)(C++11) | 从给定的数组类型中删除所有的extents。 (class template)       |
| Miscellaneous transformations                                |                                                              |
| [aligned_storage](https://runebook.dev/zh/docs/cpp/types/aligned_storage)(C++11)（在 C++23 中已弃用） | 定义了适合作为给定大小类型的非初始化存储的类型。 (class template) |
| [aligned_union](https://runebook.dev/zh/docs/cpp/types/aligned_union)(C++11)（在 C++23 中已弃用） | 定义了适合作为所有给定类型的非初始化存储使用的类型。 (class template) |
| [decay](https://runebook.dev/zh/docs/cpp/types/decay)(C++11) | 应用类型转换,就像通过值传递一个函数参数一样 (class template) |
| [remove_cvref](https://runebook.dev/zh/docs/cpp/types/remove_cvref)(C++20) | 结合 `std::remove_cv` 和 `std::remove_reference` (class template) |
| [enable_if](https://runebook.dev/zh/docs/cpp/types/enable_if)(C++11) | 有条件地从重载决议[中删除](https://runebook.dev/zh/docs/cpp/language/sfinae)函数重载或模板特化 (class template) |
| [conditional](https://runebook.dev/zh/docs/cpp/types/conditional)(C++11) | 根据编译时的布尔值选择一种或另一种类型。 (class template)    |
| [common_type](https://runebook.dev/zh/docs/cpp/types/common_type)(C++11) | 确定一组类型的共同类型。 (class template)                    |
| [common_referencebasic_common_reference](https://runebook.dev/zh/docs/cpp/types/common_reference)(C++20) | 确定一组类型的共同引用类型。 (class template)                |
| [underlying_type](https://runebook.dev/zh/docs/cpp/types/underlying_type)(C++11) | 获取给定枚举类型的底层整数类型。 (class template)            |
| [result_ofinvoke_result](https://runebook.dev/zh/docs/cpp/types/result_of)（C ++ 11）（在C ++ 20中删除）（C ++ 17） | 推导出调用具有一组参数的可调用对象的结果类型。 (class template) |
| [void_t](https://runebook.dev/zh/docs/cpp/types/void_t)(C++17) | 虚空变量别名模板 (alias template)                            |
| [type_identity](https://runebook.dev/zh/docs/cpp/types/type_identity)(C++20) | 返回类型参数不变 (class template)                            |
| 对性状的操作                                                 |                                                              |
| [conjunction](https://runebook.dev/zh/docs/cpp/types/conjunction)(C++17) | 变分逻辑和元函数 (class template)                            |
| [disjunction](https://runebook.dev/zh/docs/cpp/types/disjunction)(C++17) | 变分逻辑OR元函数 (class template)                            |
| [negation](https://runebook.dev/zh/docs/cpp/types/negation)(C++17) | 逻辑非元函数 (class template)                                |
| Functions                                                    |                                                              |
| Member relationships                                         |                                                              |
| [is_pointer_interconvertible_with_class](https://runebook.dev/zh/docs/cpp/types/is_pointer_interconvertible_with_class)(C++20) | 检查一个类型的对象是否可以与该类型的指定子对象进行指针互换。 (function template) |
| [is_corresponding_member](https://runebook.dev/zh/docs/cpp/types/is_corresponding_member)(C++20) | 检查两个指定的成员是否在两个指定类型的共同初始子序列中相互对应。 (function template) |
| 恒定的评估环境                                               |                                                              |
| [is_constant_evaluated](https://runebook.dev/zh/docs/cpp/types/is_constant_evaluated)(C++20) | 检测调用是否发生在恒定评估的上下文中。 (function)            |

------

© cppreference.com
Licensed under the Creative Commons Attribution-ShareAlike Unported License v3.0.
https://en.cppreference.com/w/cpp/header/type_traits