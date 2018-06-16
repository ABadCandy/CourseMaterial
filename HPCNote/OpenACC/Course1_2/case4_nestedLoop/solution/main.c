#include <stdio.h>
#include <stdlib.h>
#define M   (1<<8)
#define N   (1<<8)

int main() {

    int i, j, s;
    float *restrict x = (float*)malloc(M*N*sizeof(float));

#pragma acc parallel loop copy(x[0:M*N])
    for (j=0; j<N; j++)
    {
        int indexBegin = j*M;

#pragma acc loop
        for (i=0; i<M; i++)
        {
            x[i + indexBegin] = 1.0;
        }
    }

    printf("x[0] = %f, x[last] = %f\n", x[0], x[M*N-1]);

    free(x);

    return 0;
}
