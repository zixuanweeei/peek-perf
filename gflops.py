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

import multiprocessing as mlp
import argparse
import subprocess
import time


def add_parser():
  parser = argparse.ArgumentParser(description="Execute command on multiple cores.",
                                   formatter_class=argparse.ArgumentDefaultsHelpFormatter)
  parser.add_argument("--command_str", "-s", type=str,
                      help="Shell command.")
  parser.add_argument("--num_cores", "-n", type=int, default=1,
                      help="Controls how many cores the command executes on.")
  parser.add_argument("--use_kernel", "-k", default=False, action="store_true",
                      help="Whether to use kernel.")
  return parser


def func(command):
  out = subprocess.Popen([command], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
  stdout, stderr = out.communicate()
  return stdout, stderr


if __name__ == "__main__":
  parser = add_parser()
  args = parser.parse_args()

  for i in range(2):
    pool = mlp.Pool()
    results = [pool.apply_async(func, args=(args.command_str, )) for _ in range(args.num_cores)]

    pool.close()
    pool.join()

  pool = mlp.Pool()
  start = time.time()
  results = [pool.apply_async(func, args=(args.command_str, )) for _ in range(args.num_cores)]

  pool.close()
  pool.join()
  end = time.time()

  # for result in results:
  #    print(result.get())
  gflops = 4294967295 * 160 * 2. * 2 / (end - start) * args.num_cores * 1.e-9
  print("Cost: {:.3f}s, GFlops: {:.3f}".format(end - start, gflops))
