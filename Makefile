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

CFLAGS = -pthread
CC = gcc
CPP = g++

all: single_thread peek-perf

single_thread: single_thread.c
	$(CC) single_thread.c -o single_thread
peek-perf: peek-perf.cc
	$(CPP) peek-perf.cc $(CFLAGS) -o peek-perf

clean:
	rm -rf single_thread single_thread.out single_thread.o \
	    peek-perf peek-perf.out peek-perf.o