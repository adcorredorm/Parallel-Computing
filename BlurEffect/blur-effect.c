#include <stdlib.h>
#include <stdio.h>
#include <png.h>
#include <sys/time.h>
#include <pthread.h>
#include <mpi.h>

#define max(a,b) ((a) > (b) ? (a) : (b))
#define min(a,b) ((a) < (b) ? (a) : (b))

int kernel_size, padding, **kernel, threads, bash;
int width, height;
png_byte color_type;
png_byte bit_depth;
png_bytep *row_pointers;

void read_png_file(char *filename) {
  FILE *fp = fopen(filename, "rb");

  png_structp png = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
  if(!png) abort();

  png_infop info = png_create_info_struct(png);
  if(!info) abort();

  if(setjmp(png_jmpbuf(png))) abort();

  png_init_io(png, fp);

  png_read_info(png, info);

  width      = png_get_image_width(png, info);
  height     = png_get_image_height(png, info);
  color_type = png_get_color_type(png, info);
  bit_depth  = png_get_bit_depth(png, info);

  // Read any color_type into 8bit depth, RGBA format.
  // See http://www.libpng.org/pub/png/libpng-manual.txt

  if(bit_depth == 16)
    png_set_strip_16(png);

  if(color_type == PNG_COLOR_TYPE_PALETTE)
    png_set_palette_to_rgb(png);

  // PNG_COLOR_TYPE_GRAY_ALPHA is always 8 or 16bit depth.
  if(color_type == PNG_COLOR_TYPE_GRAY && bit_depth < 8)
    png_set_expand_gray_1_2_4_to_8(png);

  if(png_get_valid(png, info, PNG_INFO_tRNS))
    png_set_tRNS_to_alpha(png);

  // These color_type don't have an alpha channel then fill it with 0xff.
  if(color_type == PNG_COLOR_TYPE_RGB ||
     color_type == PNG_COLOR_TYPE_GRAY ||
     color_type == PNG_COLOR_TYPE_PALETTE)
    png_set_filler(png, 0xFF, PNG_FILLER_AFTER);

  if(color_type == PNG_COLOR_TYPE_GRAY ||
     color_type == PNG_COLOR_TYPE_GRAY_ALPHA)
    png_set_gray_to_rgb(png);

  png_read_update_info(png, info);

  if (row_pointers) abort();

  row_pointers = (png_bytep*)malloc(sizeof(png_bytep) * height);
  for(int y = 0; y < height; y++) {
    row_pointers[y] = (png_byte*)malloc(png_get_rowbytes(png,info));
  }

  png_read_image(png, row_pointers);

  fclose(fp);

  png_destroy_read_struct(&png, &info, NULL);
}

void write_png_file(char *filename) {
  int y;

  FILE *fp = fopen(filename, "wb");
  if(!fp) abort();

  png_structp png = png_create_write_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
  if (!png) abort();

  png_infop info = png_create_info_struct(png);
  if (!info) abort();

  if (setjmp(png_jmpbuf(png))) abort();

  png_init_io(png, fp);

  // Output is 8bit depth, RGBA format.
  png_set_IHDR(
    png,
    info,
    width, height,
    8,
    PNG_COLOR_TYPE_RGBA,
    PNG_INTERLACE_NONE,
    PNG_COMPRESSION_TYPE_DEFAULT,
    PNG_FILTER_TYPE_DEFAULT
  );
  png_write_info(png, info);

  // To remove the alpha channel for PNG_COLOR_TYPE_RGB format,
  // Use png_set_filler().
  //png_set_filler(png, 0, PNG_FILLER_AFTER);

  if (!row_pointers) abort();

  png_write_image(png, row_pointers);
  png_write_end(png, NULL);

  for(int y = 0; y < height; y++) {
    free(row_pointers[y]);
  }
  free(row_pointers);

  fclose(fp);

  png_destroy_write_struct(&png, &info);
}

void create_kernel(){
  kernel = malloc( kernel_size * sizeof(int *));
  if(kernel == NULL) return;
  for(int i = 0; i < kernel_size; i++){
    kernel[i] = malloc( kernel_size * sizeof(int));
    if(kernel[i] == NULL) return;
    for(int j = 0; j < kernel_size; j++) kernel[i][j] = 1;
  }
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

void process_png_file(int thread_id) {
  //printf("hilo %d\t", thread_id);
  int init = thread_id * bash;
  int end = init + bash;
  for(int y = init; y < min(height, end); y++) {
    for(int x = 0; x < width; x++) {
      calculate(x, y);
    }
  }
}

void start_process_png_file(){
  pthread_t thread[threads];
  int ids[threads], ok;
  bash = height / threads;
  for(int i = 0; i < threads; i++){
    ids[i] = i;
    ok = pthread_create(&thread[i], NULL, (void *)process_png_file, (void *)&ids[i]);
    if(ok < 0){
      perror("Error creating threads");
      exit(-1);
    }
  }

  for(int i = 0; i < threads; i++){
    ok = pthread_join(thread[i], NULL);
    if(ok < 0){
      perror("Error joining threads");
      exit(-1);
    }
  }
}

int main(int argc, char *argv[]) {
  if(argc != 5) abort();
  int iam, tasks;

  MPI_Init(&argc, &argv);
  MPI_Comm_size(MPI_COMM_WORLD, &tasks);
  MPI_Comm_rank(MPI_COMM_WORLD, &iam);

  kernel_size = atoi(argv[3]);
  threads = atoi(argv[4]);
  padding = kernel_size / 2;
  //create_kernel();

  struct timeval tval_before, tval_after, tval_result;

  if(iam == 0){
    gettimeofday(&tval_before, NULL);
    read_png_file(argv[1]);
    bash = height / tasks;
  }

  process_png_file(iam);
  MPI_Barrier(MPI_COMM_WORLD);

  if(iam == 0){
    write_png_file(argv[2]);

    gettimeofday(&tval_after, NULL);
    timersub(&tval_after,&tval_before,&tval_result);
    printf("-\tTime elapsed with %d threads: %ld.%06lds\t-\n", threads, (long int)tval_result.tv_sec, (long int)tval_result.tv_usec);
  }
  
  MPI_Finalize();
  return 0;
}