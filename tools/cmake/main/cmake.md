# CMAKE



## misc

变量



``` cmake
list(APPEND SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/src/a.cpp) # 设置列表变量
```



``` cmake
file(GLOB IMG_INSTALL          ${PROJECT_SOURCE_DIR}/img/*.*)
install(TARGETS  hello  DESTINATION  ${PROJECT_BINARY_DIR}/Bin)
# install(FILES   ${RES_INSTALL} ${IMG_INSTALL} DESTINATION  ${PROJECT_BINARY_DIR}/Bin/)
install(DIRECTORY    ${PROJECT_SOURCE_DIR}/res/ DESTINATION  ${PROJECT_BINARY_DIR}/Bin/res)
```


``` bash
git clone https://www.github.com/abc/def
cd def_build
cmake ../def


```