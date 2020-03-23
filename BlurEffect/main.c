#include <stdlib.h>
#include <stdio.h>
#include <png.h>
#include "image_load.h"

int kernel_size, **kernel;

void create_kernel(){
  kernel = malloc( kernel_size * sizeof(int *));
  if(kernel == NULL) return;
  for(int i = 0; i < kernel_size; i++){
    kernel[i] = malloc( kernel_size * sizeof(int));
    if(kernel[i] == NULL) return;
    for(int j = 0; j < kernel_size; j++) kernel[i][j] = 1;
  }
}

png_bytep calculate(int x, int y){
  int sum_r = 0, sum_g = 0, sum_b = 0;
  png_bytep px, current_px;
  for(int i = y-(kernel_size/2); i < y+(kernel_size/2); i++){
    for(int j = x-(kernel_size/2); j < x+(kernel_size/2); j++){
      current_px = &(row_pointers[i][j*4]);
      sum_r = sum_r + current_px[0];
      sum_g = sum_g + current_px[1];
      sum_b = sum_b + current_px[2];
    }
  }

  px = &(row_pointers[y][x*4]);
    
  px[0] = sum_r /(kernel_size*kernel_size);
  px[1] = sum_g /(kernel_size*kernel_size);
  px[2] = sum_b /(kernel_size*kernel_size);

}

void process_png_file() {
  for(int y = kernel_size; y < height-kernel_size; y++) {
    for(int x = kernel_size; x < width-kernel_size; x++) {
      calculate(x, y);
    }
  }
  printf("Finished\n");
}

int main(int argc, char *argv[]) {
  if(argc != 3) abort();

  read_png_file(argv[1]);
  kernel_size = 20;
  create_kernel();
  process_png_file();
  write_png_file(argv[2]);

  for(int i = 0; i < kernel_size; i++){
    free(kernel[i]);
  }
  free(kernel);

  return 0;
}