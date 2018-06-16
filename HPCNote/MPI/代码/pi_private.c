/******************************************************************************
* FILE: pi_work_sharing.c
* parallel code, using private and critical
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
	double x, sum, pi = 0.0;
	step = 1.0/(double) num_steps;
	
	omp_set_num_threads(NUM_THREADS);
	#pragma omp parallel private (id,i,x, sum)
	{
		id = omp_get_thread_num();
		for(i=id,sum=0.0; i < num_steps; i = i+NUM_THREADS)
		{
			x = (i+0.5)*step; 
			sum += 4.0/(1.0+x*x);
		}
		
		#pragma omp critical
			pi += sum * step;
	}
	
	printf("Computed pi = %.16f\n",pi);
}
