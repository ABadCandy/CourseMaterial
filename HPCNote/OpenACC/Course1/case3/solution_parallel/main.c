#include <stdio.h>
#include <stdlib.h>
#define N   (1<<20)

int main() {
    int i;
    int a[N] = {0}; 

    a[0] = 1;

    printf("a[0] = %d\n", a[0]);

#pragma acc data copy(a[0:N])
    {
#pragma acc parallel loop
        for (i=0; i<N; i++)
        {
            a[i] = a[i]+1;
        }
#pragma acc parallel loop
        for (i=0; i<N; i++)
        {
            a[i] = a[i]+1;
        }
    }

    printf("a[0] = %d\n", a[0]);
    return 0;
}