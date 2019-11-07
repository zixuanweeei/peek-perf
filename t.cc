// Reference: https://zhuanlan.zhihu.com/p/57470627
#include <iostream>
#include <chrono>
#include <thread>
#include <sys/types.h>
#include <sys/sysinfo.h>
#include <unistd.h>

#include <sched.h>
#include <ctype.h>
#include <pthread.h>

void do_cpu_stress(int num_cores) {
  int created_process = 0;
  while (created_process < num_cores - 1) {
    int pid = fork();
    if (pid == 0)
      break;
    else
      created_process++;
  }
  int core_id = (created_process > num_cores / 2 - 1) ?
      (created_process + num_cores) : created_process;
  cpu_set_t mask;
  CPU_ZERO(&mask);
  CPU_SET(core_id, &mask);
  if (sched_setaffinity(0, sizeof(mask), &mask) == -1)
    std::cout << "WARNING: Could not set CPU affinity, continuing...";
  else
    std::cout << "Bind process #" << created_process << " to CPU #" << core_id << std::endl;

  int vid = -1;
  //* === expensive operation
  asm volatile (
    "  mov $0xF0000000, %%rax \n\t"
    ".LOOP: \n\t"
    "  vfmadd132ps %%zmm0, %%zmm0, %%zmm1 \n\t"
    "  vfmadd132ps %%zmm1, %%zmm1, %%zmm2 \n\t"
    "  vfmadd132ps %%zmm2, %%zmm2, %%zmm3 \n\t"
    "  vfmadd132ps %%zmm3, %%zmm3, %%zmm4 \n\t"
    "  vfmadd132ps %%zmm4, %%zmm4, %%zmm5 \n\t"
    "  vfmadd132ps %%zmm5, %%zmm5, %%zmm6 \n\t"
    "  vfmadd132ps %%zmm7, %%zmm7, %%zmm8 \n\t"
    "  vfmadd132ps %%zmm8, %%zmm8, %%zmm9 \n\t"
    "  vfmadd132ps %%zmm9, %%zmm9, %%zmm10 \n\t"
    "  vfmadd132ps %%zmm11, %%zmm11, %%zmm12 \n\t"
    "  vfmadd132ps %%zmm12, %%zmm12, %%zmm13 \n\t"
    "  vfmadd132ps %%zmm13, %%zmm13, %%zmm14 \n\t"
    "  vfmadd132ps %%zmm14, %%zmm14, %%zmm15 \n\t"
    "  vfmadd132ps %%zmm15, %%zmm15, %%zmm16 \n\t"
    "  vfmadd132ps %%zmm17, %%zmm17, %%zmm18 \n\t"
    "  vfmadd132ps %%zmm18, %%zmm18, %%zmm19 \n\t"
    "  vfmadd132ps %%zmm19, %%zmm19, %%zmm20 \n\t"
    "  vfmadd132ps %%zmm20, %%zmm20, %%zmm21 \n\t"
    "  sub $0x1, %%rax \n\t"
    "  jne .LOOP \n\t"
    "  movl %1, %0"
    : "=r" (vid) : "m" (core_id)
  );
  std::cout << "Process #" << vid << " ended.\n";
}

int main(int argv, char **argc) {
  int num_cores = std::thread::hardware_concurrency() / 2;
  std::cout << "This device has " << num_cores << " cores.\n";
  do_cpu_stress(num_cores);

  return 0;
}