#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <cuda_runtime.h>
#include <assert.h>

#define PGMHeaderSize           0x40

inline bool loadPPM(const char *file, unsigned char **data, unsigned int *w, unsigned int *h, unsigned int *channels)
{
    FILE *fp = NULL;

    fp = fopen(file, "rb");
         if (!fp) {
              fprintf(stderr, "__LoadPPM() : unable to open file\n" );
                return false;
         }

    // check header
    char header[PGMHeaderSize];

    if (fgets(header, PGMHeaderSize, fp) == NULL)
    {
        fprintf(stderr,"__LoadPPM() : reading PGM header returned NULL\n" );
        return false;
    }

    if (strncmp(header, "P5", 2) == 0)
    {
        *channels = 1;
    }
    else if (strncmp(header, "P6", 2) == 0)
    {
        *channels = 3;
    }
    else
    {
        fprintf(stderr,"__LoadPPM() : File is not a PPM or PGM image\n" );
        *channels = 0;
        return false;
    }

    // parse header, read maxval, width and height
    unsigned int width = 0;
    unsigned int height = 0;
    unsigned int maxval = 0;
    unsigned int i = 0;

    while (i < 3)
    {
        if (fgets(header, PGMHeaderSize, fp) == NULL)
        {
            fprintf(stderr,"__LoadPPM() : reading PGM header returned NULL\n" );
            return false;
        }

        if (header[0] == '#')
        {
            continue;
        }

        if (i == 0)
        {
            i += sscanf(header, "%u %u %u", &width, &height, &maxval);
        }
        else if (i == 1)
        {
            i += sscanf(header, "%u %u", &height, &maxval);
        }
        else if (i == 2)
        {
            i += sscanf(header, "%u", &maxval);
        }
    }

    // check if given handle for the data is initialized
    if (NULL != *data)
    {
        if (*w != width || *h != height)
        {
            fprintf(stderr, "__LoadPPM() : Invalid image dimensions.\n" );
        }
    }
    else
    {
        *data = (unsigned char *) malloc(sizeof(unsigned char) * width * height * *channels);
        if (!data) {
         fprintf(stderr, "Unable to allocate hostmemory\n");
         return false;
        }
        *w = width;
        *h = height;
    }

    // read and close file
    if (fread(*data, sizeof(unsigned char), width * height * *channels, fp) == 0)
    {
        fprintf(stderr, "__LoadPPM() : read data returned error.\n" );
        fclose(fp);
        return false;
    }

    fclose(fp);

    return true;
}

inline bool savePPM(const char *file, unsigned char *data, unsigned int w, unsigned int h, unsigned int channels)
{
    assert(NULL != data);
    assert(w > 0);
    assert(h > 0);

    std::fstream fh(file, std::fstream::out | std::fstream::binary);

    if (fh.bad())
    {
        fprintf(stderr, "__savePPM() : Opening file failed.\n" );
        return false;
    }

    if (channels == 1)
    {
        fh << "P5\n";
    }
    else if (channels == 3)
    {
        fh << "P6\n";
    }
    else
    {
        fprintf(stderr, "__savePPM() : Invalid number of channels.\n" );
        return false;
    }

    fh << w << "\n" << h << "\n" << 0xff << std::endl;

    for (unsigned int i = 0; (i < (w*h*channels)) && fh.good(); ++i)
    {
        fh << data[i];
    }

    fh.flush();

    if (fh.bad())
    {
        fprintf(stderr,"__savePPM() : Writing data failed.\n" );
        return false;
    }

    fh.close();

    return true;
}

#define TILE      16
int kernel_size;
unsigned char *data=NULL, *d_input=NULL, *d_output=NULL;
unsigned int w ,h ,channels;


__global__ void box_filter(const unsigned char *in, unsigned char *out, const unsigned int w, const unsigned int h, int kernel_size, const int block){
    //Indexes
    const int R = (kernel_size - 1)/2;
    const int x = blockIdx.x * TILE + threadIdx.x - R;       // x image index
    const int y = blockIdx.y * TILE + threadIdx.y - R;       // y image index
    const int d = (y * w + x) * 3 ;                          // red pixel index
    //shared mem
    
    __shared__ float shMem[30][30][3];
    if(x<0 || y<0 || x>=w || y>=h) {            
        shMem[threadIdx.x][threadIdx.y][0] = 0;
        shMem[threadIdx.x][threadIdx.y][1] = 0;
        shMem[threadIdx.x][threadIdx.y][2] = 0;
        return; 
    }
    shMem[threadIdx.x][threadIdx.y][0] = in[d];
    shMem[threadIdx.x][threadIdx.y][1] = in[d+1];
    shMem[threadIdx.x][threadIdx.y][2] = in[d+2];
    
    __syncthreads();

    if ((threadIdx.x >= R) && (threadIdx.x < (block-R)) && (threadIdx.y >= R) && (threadIdx.y < (block-R))) {
        float red = 0;
        float green = 0;
        float blue = 0;
        for(int dx=-R; dx<=R; dx++) {
            for(int dy=-R; dy<=R; dy++) {
                red += shMem[threadIdx.x+dx][threadIdx.y+dy][0];
                green += shMem[threadIdx.x+dx][threadIdx.y+dy][1];
                blue += shMem[threadIdx.x+dx][threadIdx.y+dy][2];
            }
        }
    out[d] = red / (kernel_size * kernel_size);
    out[d+1] = green / (kernel_size * kernel_size);
    out[d+2] = blue / (kernel_size * kernel_size);
    
    }
}


#define checkCudaErrors(err) __checkCudaErrors (err, __FILE__, __LINE__)

inline void __checkCudaErrors(cudaError err, const char *file, const int line)
{
    if (cudaSuccess != err)
    {
        fprintf(stderr, "%s(%i) : CUDA Runtime API error %d: %s.\n",
                file, line, (int)err, cudaGetErrorString(err));
        exit(EXIT_FAILURE);
    }
}

void procces_image(){
    const int R = (kernel_size - 1)/2;
    const int block = TILE+(2*R);

    size_t size = w*h*channels * sizeof(unsigned char);

    // Device Malloc
    checkCudaErrors(cudaMalloc((void **)&d_input, size));
    checkCudaErrors(cudaMalloc((void **)&d_output, size));

    // Copy to device
    checkCudaErrors(cudaMemcpy(d_input, data, size, cudaMemcpyHostToDevice));

    int GRID_W = w/TILE +1;
    int GRID_H = h/TILE +1;
    dim3 threadsPerBlock(block, block);
    dim3 blocksPerGrid(GRID_W,GRID_H);
    

    // Launch Kernel
    printf("CUDA kernel launch with [%d %d] blocks of [%d %d] threads\n", blocksPerGrid.x, blocksPerGrid.y, threadsPerBlock.x, threadsPerBlock.y);
    box_filter<<<blocksPerGrid, threadsPerBlock>>>(d_input, d_output, w, h, kernel_size, block);
   
    checkCudaErrors(cudaGetLastError());

    // Copy data from device to host
    checkCudaErrors(cudaMemcpy(data, d_output, size, cudaMemcpyDeviceToHost));

}

int main(int argc, char *argv[]){
    if(argc != 4) abort();
    kernel_size = atoi(argv[3]);
    struct timeval tval_before, tval_after, tval_result;

    if(! loadPPM(argv[1], &data, &w, &h, &channels)){
        fprintf(stderr, "Failed to open File\n");
        exit(EXIT_FAILURE);
    }

    gettimeofday(&tval_before, NULL);

    procces_image();

    gettimeofday(&tval_after, NULL);

    // Save Picture
    if (!savePPM(argv[2], data, w,  h,  channels)){
        fprintf(stderr, "Failed to save File\n");
        exit(EXIT_FAILURE);
    }

    // Free memory
    checkCudaErrors(cudaFree(d_input));
    checkCudaErrors(cudaFree(d_output));
    free(data);

    timersub(&tval_after,&tval_before,&tval_result);
    printf("-\tTime elapsed: %ld.%06lds\t-\n",  (long int)tval_result.tv_sec, (long int)tval_result.tv_usec);
//    printf("%ld.%06ld;",  (long int)tval_result.tv_sec, (long int)tval_result.tv_usec);
}