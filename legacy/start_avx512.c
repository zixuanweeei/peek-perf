#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <immintrin.h>

#define ALIGNMENT 16
#define SSE_LEN 1000
#define MAX_LEN (16 * SSE_LEN)
#define RAND_RANGE 2.0
#define RAND() (float)rand() / (float)(RAND_MAX) * RAND_RANGE

int main(int argv, char** argc) {
  printf("sizeof(__m512) = %d\n", sizeof(__m512));
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

  float* _ret_s;
  int ret = posix_memalign((void**)&_ret_s, ALIGNMENT, MAX_LEN * sizeof(float));
  if (ret != 0 || _ret_s == NULL) {
    printf("Memory alignment failed. Exists.");
    return 0;
  }

  __m512* _ret = (__m512*)_ret_s;
  __m512 _tmp;
  printf("LOOP start...\n");
  for (int stress = 0; stress < 1000000; ++stress) {
    _a = _mm512_load_ps(vecA);
    _b = _mm512_load_ps(vecB);
    _c = _mm512_load_ps(vecC);
    _ret[0] = _mm512_add_ps(_a, _b);
    for (int i = 1; i < SSE_LEN; ++i) {
      _tmp = _mm512_add_ps(_a, _b);
      _c = _mm512_mul_ps(_tmp, _c);
      _ret[i] = _mm512_add_ps(_ret[i - 1], _c);
      _b = _mm512_add_ps(_ret[i], _ret[i - 1]);
    }
  }
  printf("LOOP end...\n");

  free(_ret_s);
  return 0;
}