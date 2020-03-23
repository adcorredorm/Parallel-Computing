#include <stdlib.h>
#include <stdio.h>
#include <png.h>
#include "image_load.h"

void process_png_file() {
  for(int y = 0; y < height; y++) {
    png_bytep row = row_pointers[y];
    for(int x = 0; x < width; x++) {
      png_bytep px = &(row[x * 4]);
      int sum = px[0] + px[1] + px[2];
      px[0] = (int) sum / 3;
      px[1] = px[0];
      px[2] = px[0];
      // Do something awesome for each pixel here...
      // printf("%4d, %4d = RGBA(%3d, %3d, %3d, %3d)\n", x, y, px[0], px[1], px[2], px[3]);
    }
  }
}

int main(int argc, char *argv[]) {
  if(argc != 3) abort();

  read_png_file(argv[1]);
  process_png_file();
  write_png_file(argv[2]);

  return 0;
}