#include <stdio.h>
#include <stdlib.h>
#define N   (1<<10)

int main() {

    int i;
    float *x = (float*)malloc(N*sizeof(float));
    float *y = (float*)malloc(N*sizeof(float));

#pragma acc kernels
    for (i=0; i<N; i++)
    {
        x[i] = 1.0;
        y[i] = x[i];
    }

    printf("x[0] = %f, y[0] = %f\n", x[0], y[0]);

    free(x);
    free(y);

    return 0;
}
