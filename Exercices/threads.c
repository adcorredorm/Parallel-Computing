#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <fcntl.h>
#include <unistd.h>

#define THREADS 16
#define CICLES 1000000000

struct{
    double *acumulated;
    int init;
    int end;
}typedef params;


double *calc_pi(params *args){

    double *piTotal = args->acumulated;
    int init = args->init;
    int end = args->end;
    int i = init;
    do{
        *piTotal = *piTotal + (double)(4.0 / (2*i+1));
        i++;
        *piTotal = *piTotal - (double)(4.0 / (2*i+1));
        i++;
    }while(i < end);
}

int main(){
  params args[THREADS];
  pthread_t thread[THREADS];
  double total[THREADS];

  int ok, init = 0;
  int step = (int) CICLES / THREADS;
  for(int i = 0; i < THREADS; i++){
    total[i] = 0;
    args[i].acumulated = &total[i];
    args[i].init = init;
    args[i].end = init + step;
    init += step;
    ok = pthread_create(&thread[i], NULL, (void *)calc_pi, &args[i]);
    if(ok < 0){
      perror("Error creating threads");
      exit(-1);
    }
  }

  double pi = 0.0;
  for(int i = 0; i < THREADS; i++){
    ok = pthread_join(thread[i], NULL);
    if(ok < 0){
      perror("Error joining threads");
      exit(-1);
    }
    pi += total[i];
  }

  printf("%0.20f\n", pi);

  return 0;
}