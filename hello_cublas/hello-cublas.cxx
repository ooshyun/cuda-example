
#include <iostream>
#include <cstdlib>
#include <cuda_runtime.h>
#include <cublas_v2.h>

//------------------------------------------------------------------------------
// Print matrix
//------------------------------------------------------------------------------
void print_matrix(const double *M, int rows, int cols) {
  for(int i = 0; i < rows; ++i) {
    for(int j = 0; j < cols; ++j)
      std::cout << M[j*rows + i] << " ";
    std::cout << std::endl;
  }
  std::cout << std::endl;
}

//------------------------------------------------------------------------------
// Start the show
//------------------------------------------------------------------------------
int main(int argc, char **argv) {
  int rowsA = 2;
  int colsA = 3;
  int rowsB = 3;
  int colsB = 2;

  //----------------------------------------------------------------------------
  // Allocate and initialize the memory
  //----------------------------------------------------------------------------
  double A[] = {
    1, 4,
    2, 5,
    3, 6
  };

  double B[] = {
    7,  9, 11,
    8, 10, 12
  };

  double C[4];

  double *dA, *dB, *dC;
  cudaMalloc(&dA, rowsA * colsA * sizeof(double));
  cudaMalloc(&dB, rowsB * colsB * sizeof(double));
  cudaMalloc(&dC, rowsA * colsB * sizeof(double));

  cudaMemcpy(dA, A, rowsA * colsA * sizeof(double), cudaMemcpyHostToDevice);
  cudaMemcpy(dB, B, rowsB * colsB * sizeof(double), cudaMemcpyHostToDevice);

  //----------------------------------------------------------------------------
  // Perform the multiplication and copy the result
  //----------------------------------------------------------------------------
  cublasHandle_t handle;
  cublasCreate(&handle);
  const double alpha = 1;
  const double beta = 0;
  cublasDgemm(handle, CUBLAS_OP_N, CUBLAS_OP_N, rowsA, colsB, colsA,
              &alpha, dA, rowsA, dB, rowsB,
              &beta,  dC, rowsA);

  cublasDestroy(handle);

  cudaMemcpy(C, dC, rowsA * colsB * sizeof(double), cudaMemcpyDeviceToHost);

  //----------------------------------------------------------------------------
  // Print the result
  //----------------------------------------------------------------------------
  std::cout << "A =" << std::endl;
  print_matrix(A, rowsA, colsA);
  std::cout << "B =" << std::endl;
  print_matrix(B, rowsB, colsB);
  std::cout << "A*B =" << std::endl;
  print_matrix(C, rowsA, colsB);

  //----------------------------------------------------------------------------
  // Free the memory
  //----------------------------------------------------------------------------
  cudaFree(dA);
  cudaFree(dB);
  cudaFree(dC);

  return 0;
}
