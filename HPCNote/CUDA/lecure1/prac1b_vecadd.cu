//
// include files
//

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

#include <helper_cuda.h>


//
// kernel routine
// modify my_first_kernel function to vector add.
// computes the vector addition of A and B into C. The 3 vectors have the same number of elements numElements.
//

__global__ void my_first_kernel(const float *A, const float *B, float *C, int numElements)
{
  int tid = threadIdx.x + blockDim.x*blockIdx.x;

  if (tid < numElements)
  {
      C[tid] = A[tid] + B[tid];
  }
}


//
// main code
//

int main(int argc, const char **argv)
{
  float *h_A, *h_B, *h_C, *d_A, *d_B, *d_C;
  int   nblocks, nthreads, nsize, n; 

  // initialise card

  findCudaDevice(argc, argv);

  // set number of blocks, and threads per block

  nblocks  = 2;
  nthreads = 8;
  nsize    = nblocks*nthreads ;

  // allocate host memory for array

  h_A = (float *)malloc(nsize*sizeof(float));
  h_B = (float *)malloc(nsize*sizeof(float));
  h_C = (float *)malloc(nsize*sizeof(float));
  
  // initialize the host input vectors

  for (int i = 0; i < nsize; ++i)
  {
      h_A[i] = rand()/(float)RAND_MAX;
      h_B[i] = rand()/(float)RAND_MAX;
  }
  
  // allocate device memory for array

  checkCudaErrors(cudaMalloc((void **)&d_A, nsize*sizeof(float)));
  checkCudaErrors(cudaMalloc((void **)&d_B, nsize*sizeof(float)));
  checkCudaErrors(cudaMalloc((void **)&d_C, nsize*sizeof(float)));

  // copy the host input vectors A and B in host memory to the device input vectors in
  // device memory

  checkCudaErrors( cudaMemcpy(d_A, h_A, nsize*sizeof(float), cudaMemcpyHostToDevice) );
  checkCudaErrors( cudaMemcpy(d_B, h_B, nsize*sizeof(float), cudaMemcpyHostToDevice) );
  
  // execute kernel
  
  my_first_kernel<<<nblocks,nthreads>>>(d_A, d_B, d_C, nsize);
  getLastCudaError("my_first_kernel execution failed\n");

  // copy back results and print them out

  checkCudaErrors( cudaMemcpy(h_C, d_C, nsize*sizeof(float), cudaMemcpyDeviceToHost) );

  for (n=0; n<nsize; n++) 
  {
      printf(" %f + %f = %f \n",h_A[n],h_B[n],h_C[n]);
	  if (fabs(h_A[n] + h_B[n] - h_C[n]) > 1e-5)
      {
          fprintf(stderr, "Result verification failed at element %d!\n", n);
          exit(EXIT_FAILURE);
      }
  }
  // free memory 

  checkCudaErrors(cudaFree(d_A));
  checkCudaErrors(cudaFree(d_B));
  checkCudaErrors(cudaFree(d_C));
  free(h_A);
  free(h_B);
  free(h_C);

  // CUDA exit -- needed to flush printf write buffer

  cudaDeviceReset();

  return 0;
}
