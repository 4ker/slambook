cmake_minimum_required( VERSION 2.8 )
project( geometry )

# 添加Eigen头文件
include_directories( "/usr/include/eigen3" )

include_directories(/Users/zxtang/dev/libs/eigen-eigen-5a0156e40feb)

add_executable( eigenGeometry eigenGeometry.cpp )
