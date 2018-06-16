/******************************************************************************
* FILE: pi_work_sharing.c
* parallel code, using work sharing for structure
******************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#define NUM_THREADS 4 
static int num_steps = 100000; 
double step;

int main () 
{
	int i,id; 
	double x, pi, sum[NUM_THREADS];
	step = 1.0/(double) num_steps;
	
	omp_set_num_threads(NUM_THREADS);

	#pragma omp parallel private(id)
	{
		id = omp_get_thread_num(); 
		sum[id] = 0;
		
	#pragma omp for private(x)
		for(i=0; i< num_steps; i++)
		{
			x = (i+0.5)*step; 
			sum[id] += 4.0/(1.0+x*x);
		}
	}
	for(i=0, pi=0.0;i<NUM_THREADS;i++)
		pi += sum[i] * step;

	printf("Computed pi = %.16f\n",pi);
}
