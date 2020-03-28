#include <stdlib.h>
#include <stdio.h>
#include <png.h>
#include "image_load.h"

#define max(a,b) ((a) > (b) ? (a) : (b))
#define min(a,b) ((a) < (b) ? (a) : (b))

int kernel_size, padding, **kernel;

void create_kernel(){
  kernel = malloc( kernel_size * sizeof(int *));
  if(kernel == NULL) return;
  for(int i = 0; i < kernel_size; i++){
    kernel[i] = malloc( kernel_size * sizeof(int));
    if(kernel[i] == NULL) return;
    for(int j = 0; j < kernel_size; j++) kernel[i][j] = 1;
  }
  padding = kernel_size / 2;
}

void calculate(int x, int y){
  png_bytep px, current_px;
  int sum_r = 0, sum_g = 0, sum_b = 0, pixels = 0;
  int init_i = max(0, y - padding), end_i = min(height - 1, y + padding);
  int init_j = max(0, x - padding), end_j = min(width - 1, x + padding);
  
  for(int i = init_i; i <= end_i; i++){
    for(int j = init_j; j <= end_j; j++){
      current_px = &(row_pointers[i][j*4]);
      sum_r = sum_r + current_px[0];
      sum_g = sum_g + current_px[1];
      sum_b = sum_b + current_px[2];
      pixels += 1;
    }
  }

  px = &(row_pointers[y][x*4]);
    
  px[0] = sum_r /pixels;
  px[1] = sum_g /pixels;
  px[2] = sum_b /pixels;

}

void process_png_file() {
  for(int y = 0; y < height; y++) {
    for(int x = 0; x < width; x++) {
      calculate(x, y);
    }
  }
  printf("Finished\n");
}

int main(int argc, char *argv[]) {
  if(argc != 3) abort();

  read_png_file(argv[1]);
  kernel_size = 15;
  create_kernel();
  process_png_file();
  write_png_file(argv[2]);

  for(int i = 0; i < kernel_size; i++){
    free(kernel[i]);
  }
  free(kernel);

  return 0;
}