#include <stdio.h>
#include "omp.h"

#define THREADS 16
#define CICLES 1e09

void main(){
    double pi_sub[THREADS];
    #pragma omp parallel num_threads(THREADS)
    {
        int id = omp_get_thread_num();
        int init = id * CICLES/THREADS;
        int end = (id + 1) * CICLES/THREADS;
        int i = init;
        do{
            pi_sub[id] += (double)(4.0 / (2*i+1));
            i++;
            pi_sub[id] -= (double)(4.0 / (2*i+1));
            i++;
        }while(i < end);
    }
    double pi = 0.0;
    for(int i = 0; i < THREADS; i++){
        pi += pi_sub[i];
    }
    printf("Pi: %0.20f\n", pi);
}