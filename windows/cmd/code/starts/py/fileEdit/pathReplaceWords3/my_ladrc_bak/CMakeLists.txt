project(pAdrc)

cmake_minimum_required(VERSION 2.8)

include_directories(include)
include_directories(tests/include)
file(GLOB adrc_INC "include/*.h")
file(GLOB adrc_SRC "src/*.cpp")
#  KalmanFilter/Kalman.cpp
add_library(adrc_eigen3  ${adrc_SRC} ${adrc_INC}  )
set (EXTRA_LIBS ${EXTRA_LIBS}   adrc_eigen3)
add_executable(adrc_demos    tests/src/zal_linear_adrc_test.cpp  tests/include/zal_linear_adrc_test.h )
add_dependencies(adrc_demos   ${EXTRA_LIBS}  )
target_link_libraries (adrc_demos  ${EXTRA_LIBS})
