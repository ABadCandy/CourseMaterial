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
	int i; 
	double x, pi, sum = 0.0;
	step = 1.0/(double) num_steps;
	
	omp_set_num_threads(NUM_THREADS);
	#pragma omp parallel for reduction(+:sum) private (x)
	for(i=0; i < num_steps; i++)
	{
		x = (i+0.5)*step; 
		sum += 4.0/(1.0+x*x);
	}
	
	pi = sum * step;
	printf("Computed pi = %.16f\n",pi);
}
