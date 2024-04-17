
#include <cstdint>
#include <stdexcept>
#include <iostream>

//------------------------------------------------------------------------------
// The kernel
//------------------------------------------------------------------------------
__global__
void transform(uint32_t *output, const uint32_t *input, uint32_t size) {
  uint32_t idx = threadIdx.x + blockDim.x * blockIdx.x;
  if(idx >= size)
    return;

  output[idx] = input[idx] + 1;
}

//------------------------------------------------------------------------------
// Start the show
//------------------------------------------------------------------------------
int main(int argc, char **argv) {
  const uint32_t size = 5;
  const uint32_t memsize = size*4;
  uint32_t input[] = { 1, 2, 3, 4, 5 };
  uint32_t output[size];

  uint32_t *d_input;
  uint32_t *d_output;

  //----------------------------------------------------------------------------
  // Allocate memory
  //----------------------------------------------------------------------------
  auto status = cudaMalloc(&d_input, memsize);
  if(status != cudaSuccess)
    throw std::runtime_error("Unable to allocate GPU memory for input data");

  status = cudaMalloc(&d_output, memsize);
  if(status != cudaSuccess) {
   cudaFree(d_input);
   throw std::runtime_error("Unable to allocate GPU memory for output data");
  }

  //----------------------------------------------------------------------------
  // Do memory copies and run the kernel
  //----------------------------------------------------------------------------
  cudaMemcpy(d_input, (void*)input, memsize, cudaMemcpyHostToDevice);

  uint32_t blocks = size/1024 + 1;
  transform<<<blocks, 1024>>>(d_output, d_input, size);

  cudaMemcpy((void*)output, d_output, memsize, cudaMemcpyDeviceToHost);

  cudaFree(d_input);
  cudaFree(d_output);

  //----------------------------------------------------------------------------
  // Print the input and the output
  //----------------------------------------------------------------------------
  std::cout << "Input: ";
  for(auto a: input)
    std::cout << a << ", ";
  std::cout << std::endl;

  std::cout << "Output: ";
  for(auto a: output)
    std::cout << a << ", ";
  std::cout << std::endl;

  return 0;
}
