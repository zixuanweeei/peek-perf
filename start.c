#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <immintrin.h>

#define ALIGNMENT 16
#define MAX_LEN (16 * 100)
#define RAND_RANGE 2.0
#define RAND() (float)rand() / (float)(RAND_MAX) * RAND_RANGE

int main(int argv, char** argc) {
#ifdef _DEBUG
  printf("sizeof(__m512) = %d\n", sizeof(__m512));
#endif
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

  __m512 _tmp;
#ifdef _DEBUG
  printf("LOOP start...\n");
#endif
    for (int i = 1; i < 50000000; ++i) {
      _tmp = _mm512_add_ps(_a, _b);
      _c = _mm512_mul_ps(_tmp, _c);
      _b = _mm512_add_ps(_c, _b);
    }
#ifdef _DEBUG
  printf("LOOP end...\n");
#endif

  return 0;
}
