#ifndef IMAGE_LOAD
#define IMAGE_LOAD

int width, height;
png_byte color_type;
png_byte bit_depth;
png_bytep *row_pointers;

void read_png_file(char *filename);
void write_png_file(char *filename);


#endif