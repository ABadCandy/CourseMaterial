#include <stdio.h>
#include <stdlib.h>
// #ifdef  _OPENACC
// #include <openacc.h>
// #endif  
#define N   (1<<10)


#pragma acc routine vector
//#pragma acc routine seq
float foo(int i)
{
    float c = .0f;
#pragma acc loop vector reduction(+:c)
    for (int j=0; j<128; j++)
        c += 1.0f/(i+j+1.0e-6);
    return c;
}

int main() {

    int i;
    float * v = (float*)malloc(N*sizeof(float));

#pragma acc parallel 
#pragma acc loop gang
    for (i=0; i<N; i++)
    {
        v[i] = foo(i);
    }

    printf("v[0] = %f, v[last] = %f\n", v[0], v[N-1]);

    free(v);

    return 0;
}
