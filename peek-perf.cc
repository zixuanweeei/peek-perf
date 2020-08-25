/*******************************************************************************
 * Copyright 2020 zixuanweeei
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 ******************************************************************************/

#include <chrono>
#include <iostream>
#include <mutex>
#include <thread>
#include <vector>

#include <pthread.h>

void registers_task() {
  float a[16];
  float b[16];
  for (int i = 0; i < 16; ++i) {
    a[i] = rand() % 10 / 5;
    b[i] = rand() % 10 / 5;
  }
  int end = 0;

  asm volatile("  vmovups %1, %%zmm0 \n\t"
               "  vmovups %2, %%zmm1 \n\t"
               "  vmovups %1, %%zmm11 \n\t"
               "  vmovups %2, %%zmm12 \n\t"
               "  mov $4294967295, %%rax \n\t"
               ".LOOP: \n\t"
               "  vfmadd132ps %%zmm0, %%zmm0, %%zmm1 \n\t"
               "  vfmadd132ps %%zmm1, %%zmm1, %%zmm2 \n\t"
               "  vfmadd132ps %%zmm2, %%zmm2, %%zmm3 \n\t"
               "  vfmadd132ps %%zmm3, %%zmm3, %%zmm4 \n\t"
               "  vfmadd132ps %%zmm4, %%zmm4, %%zmm5 \n\t"
               "  vfmadd132ps %%zmm5, %%zmm5, %%zmm6 \n\t"
               "  vfmadd132ps %%zmm6, %%zmm6, %%zmm7 \n\t"
               "  vfmadd132ps %%zmm7, %%zmm7, %%zmm8 \n\t"
               "  vfmadd132ps %%zmm8, %%zmm8, %%zmm9 \n\t"
               "  vfmadd132ps %%zmm9, %%zmm9, %%zmm10 \n\t"
               "  vfmadd132ps %%zmm11, %%zmm11, %%zmm12 \n\t"
               "  vfmadd132ps %%zmm12, %%zmm12, %%zmm13 \n\t"
               "  vfmadd132ps %%zmm13, %%zmm13, %%zmm14 \n\t"
               "  vfmadd132ps %%zmm14, %%zmm14, %%zmm15 \n\t"
               "  vfmadd132ps %%zmm15, %%zmm15, %%zmm16 \n\t"
               "  vfmadd132ps %%zmm16, %%zmm16, %%zmm17 \n\t"
               "  vfmadd132ps %%zmm17, %%zmm17, %%zmm18 \n\t"
               "  vfmadd132ps %%zmm18, %%zmm18, %%zmm19 \n\t"
               "  vfmadd132ps %%zmm19, %%zmm19, %%zmm20 \n\t"
               "  vfmadd132ps %%zmm20, %%zmm20, %%zmm21 \n\t"
               "  sub $0x1, %%rax \n\t"
               "  jne .LOOP \n\t"
               "  movw $0x0F, %0"
               : "=m"(end)
               : "m"(a), "m"(b));
}

int main(int argv, char **argc) {
  int num_cores = 1;
  bool set_affinity = true;
  if (argv == 1) {
    std::cout << "Using 1 core by default. If you would like to use multiple cores, please run \n"
              << "$ ./peek-perf $(num_cores) [set_affinity]" << std::endl;
  } else if (argv == 2) {
    num_cores = std::atoi(argc[1]);
  } else if (argv == 3) {
    num_cores = std::atoi(argc[1]);
    set_affinity = false;
  } else {
    std::cout << "Usage: "
              << "$ ./peek-perf $(num_cores)" << std::endl;
  }

  int total_threads = std::thread::hardware_concurrency();
  int estim_cores = total_threads / 4;
  std::cout << "Got " << total_threads << " hardware concurrency. Assume that we have "
            << estim_cores << " cores/socket." << std::endl;

  std::vector<std::thread> threads(num_cores);
  std::mutex iomutex;
  auto begin = std::chrono::high_resolution_clock::now();
  for (int i = 0; i < num_cores; ++i) {
    threads[i] = std::thread([&, i] {
      registers_task();
      std::lock_guard<std::mutex> iolock(iomutex);
      std::cout << "Thread #" << i << ": on CPU " << sched_getcpu() << " ended." << std::endl;
    });

    if (set_affinity) {
      cpu_set_t cpuset;
      CPU_ZERO(&cpuset);
      CPU_SET(i, &cpuset);
      int status = pthread_setaffinity_np(threads[i].native_handle(), sizeof(cpu_set_t), &cpuset);
      if (status != 0)
        std::cerr << "Error calling pthread_setaffinity_np: " << status << std::endl;
    }
  }

  for (auto &t : threads) {
    t.join();
  }

  auto end = std::chrono::high_resolution_clock::now();
  auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end - begin);
  double gflops = 4294967295 * 160.0 * 2.0 * 2.0 / duration.count() * 1.0e-6 * num_cores;
  std::cout << "Cost " << duration.count() << " ms, "
            << "GFlops: " << gflops << std::endl;

  return 0;
}
