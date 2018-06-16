#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

#define N (1<<24)
#define blocksize 1024
#define blocknumb (N/blocksize)

#define checkCudaAPIErrors(F) if ((F) != cudaSuccess) \
{ printf("Error at line %d in file %s: %s\n", __LINE__, __FILE__, cudaGetErrorString(cudaGetLastError())); exit(-1); }

__global__ void vecDot(double *a, double *b, double *sub_sum)
{
    int gid = blockDim.x * blockIdx.x + threadIdx.x;
    __shared__ double component[blocksize];

    component[threadIdx.x] = a[gid] * b[gid];

    __syncthreads();
    for (int i=(blocksize>>1); i>0; i=(i>>1))
    {
        if (threadIdx.x < i)
            component[threadIdx.x] += component[threadIdx.x + i];
        __syncthreads();
    }

    if (threadIdx.x == 0)
    {
        sub_sum[blockIdx.x] = component[0];
    }
}


int main()
{
    int i, device = 0;
    double *h_a, *h_b, *h_c;
    double *d_a, *d_b, *d_c;
    double *h_subSum;
    double *d_subSum;

    struct timeval start;
    struct timeval end;
    double elapsedTime;
    double sum_cpu = 0.0;
    double sum_gpu = 0.0;
    cudaDeviceProp prop;

    h_a = (double *)malloc(sizeof(double) * N);
    h_b = (double *)malloc(sizeof(double) * N);
    h_c = (double *)malloc(sizeof(double) * N);
    h_subSum = (double *)malloc(sizeof(double) * blocknumb);


    // init a and b
    for (i=0; i<N; i++)
    {
        h_a[i] = (double)rand()/RAND_MAX;
        h_b[i] = (double)rand()/RAND_MAX;
        h_c[i] = h_a[i] * h_b[i];

        sum_cpu += h_c[i];
    } 

    cudaSetDevice(device);
    cudaGetDeviceProperties(&prop, device);
    printf("Using gpu %d: %s\n", device, prop.name);

    // timer begin
    gettimeofday(&start, NULL);

    cudaMalloc((void**)&d_a, sizeof(double) * N);
    cudaMalloc((void**)&d_b, sizeof(double) * N);
    cudaMalloc((void**)&d_c, sizeof(double) * N);
    cudaMalloc((void**)&d_subSum, sizeof(double) * blocknumb);

    checkCudaAPIErrors(cudaMemcpy(d_a, h_a, sizeof(double) * N, cudaMemcpyHostToDevice));
    checkCudaAPIErrors(cudaMemcpy(d_b, h_b, sizeof(double) * N, cudaMemcpyHostToDevice));

    vecDot<<<blocknumb, blocksize>>>(d_a, d_b, d_subSum);
    checkCudaAPIErrors(cudaMemcpy(h_subSum, d_subSum, sizeof(double) * blocknumb, cudaMemcpyDeviceToHost));

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);
    cudaFree(d_subSum);
    
    for (i=0; i<blocknumb; i++)
    {
        sum_gpu += h_subSum[i];
    }
    // timer end 
    gettimeofday(&end, NULL);

    elapsedTime  = (end.tv_sec - start.tv_sec) * 1000.0;    // sec to ms
    elapsedTime += (end.tv_usec - start.tv_usec) / 1000.0;  // us  to ms

    printf("the result on GPU is %lf\n", sum_gpu);
    printf("the result on CPU is %lf\n", sum_cpu);
    printf("the elapsedTime is %f ms\n", elapsedTime);

    free(h_a);
    free(h_b);
    free(h_c);
    free(h_subSum);

    return 0;
}
