#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

#define N (1<<24)

int main()
{
    int i, block;
    double *a, *b, *c;
    struct timeval start;
    struct timeval end;
    double elapsedTime;
    double sum_cpu = 0.0f;
    double sum_gpu = 0.0f;

    a = (double *)malloc(sizeof(double) * N);
    b = (double *)malloc(sizeof(double) * N);
    c = (double *)malloc(sizeof(double) * N);

    // init a and b
    for (i=0; i<N; i++)
    {
        a[i] = (double)rand()/RAND_MAX;
        b[i] = (double)rand()/RAND_MAX;

        sum_cpu += a[i] * b[i];
    } 

    // timer begin
    gettimeofday(&start, NULL);
    // Step 1: component multiply
#pragma acc kernels 
#pragma acc loop independent
    for (i=0; i<N; i++)
    {
        c[i] = a[i] * b[i];
    }

    // Step 2: reduction
#pragma acc kernels 
    for (i=0; i<N; i++)
    {
        sum_gpu += c[i];
    }
    gettimeofday(&end, NULL);
    elapsedTime  = (end.tv_sec - start.tv_sec) * 1000.0;    // sec to ms
    elapsedTime += (end.tv_usec - start.tv_usec) / 1000.0;  // us  to ms

    printf("the result on GPU is %f\n", sum_gpu);
    printf("the result on CPU is %f\n", sum_cpu);
    printf("the elapsedTime is %f ms\n", elapsedTime);

    free(a);
    free(b);
    free(c);

    return 0;
}
