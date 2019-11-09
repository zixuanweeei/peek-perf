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