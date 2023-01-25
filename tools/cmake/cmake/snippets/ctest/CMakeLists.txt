

add_executable(test_example test.cpp)
# target_link_libraries(test_example example_lib)
enable_testing()
add_test(test_  test_example)
add_test(test_2  test_example  arg2)
# add_test(NAME test_example1 COMMAND test_example --arg1=a --arg2=b)
# add_test(NAME test_example2 COMMAND test_example --arg1=c --arg2=d)
