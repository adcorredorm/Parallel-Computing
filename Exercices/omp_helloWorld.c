#include <stdio.h>
#include "omp.h"

void main(){
    #pragma omp parallel num_threads(10)
    {
        int id = omp_get_thread_num();
        printf("Hello (%d) ", id);
        printf("World (%d)\n", id);
    }
}