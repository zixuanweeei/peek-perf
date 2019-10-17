#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <immintrin.h>

#define ALIGNMENT 16
#define MAX_LEN (16 * 10000)
#define RAND_RANGE 2
#define RAND() (float)rand() / (float)(RAND_MAX) * RAND_RANGE

int main(int argv, char** argc) {
  float vecA[16];
  float vecB[16];
  float vecC[16];
  for (int i = 0; i < 16; ++i) {
    vecA[i] = RAND();
    vecB[i] = RAND();
    vecC[i] = RAND();
  }

  __m512 _a;
  __m512 _b;
  __m512 _c;
  
  _a = _mm512_load_ps(vecA);
  _b = _mm512_load_ps(vecB);
  _c = _mm512_load_ps(vecC);

  __m512* _ret;
  int ret = posix_memalign(&_ret, ALIGNMENT, MAX_LEN * sizeof(float));
  if (ret != 0) {
    printf("Memory alignment failed. Exists.");
    return 0;
  }
  
  __m512 _tmp;
  _ret[0] = _mm512_add_ps(_a, _b);
  for (int i = 1; i < 10000; ++i) {
    _tmp = _mm512_add_ps(_a, _b);
    _tmp = _mm512_mul_ps(_tmp, _c);
    _ret[i] = _mm512_add_ps(_ret[i - 1], _tmp);
  }

  free(_ret);
  return 0;
}