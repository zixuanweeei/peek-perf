#===============================================================================
# Copyright 2020 zixuanweeei
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#===============================================================================

cmake_minimum_required(VERSION 3.9)
message(STATUS "cmake version: ${CMAKE_VERSION}")

set(PEEK_PERF_PROJECT "peek-perf")
set(PEEK_PERF_NAME "peek-perf")
set(PEEK_PERF_VERSION 0.0.0)

project(${PEEK_PERF_PROJECT} VERSION "${PEEK_PERF_VERSION}" LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)

add_executable(peek-perf peek-perf.cc)
add_executable(single_thread single_thread.c)

target_link_libraries(peek-perf PRIVATE Threads::Threads)
