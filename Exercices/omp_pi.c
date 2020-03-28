#include <stdio.h>
#include "omp.h"

#define THREADS 16
#define CICLES 1e09

void main(){
   double pi = 0.0;
   int it = CICLES;
   #pragma omp parallel for reduction(+:pi) num_threads(THREADS)
   for(int i = 0; i < it; i++){
       pi = pi + (double)(4.0 / (2*i+1));
       i++;
       pi = pi - (double)(4.0 / (2*i+1));
   }
   printf("Pi: %0.20f\n", pi);
}