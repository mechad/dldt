
## Build on Linux\* Systems

The software was validated on:
- Ubuntu\* 16.04 with default GCC\* 5.4.0
- CentOS\* 7.4 with default GCC\* 4.8.5
- [Intel® Graphics Compute Runtime for OpenCL™ Driver package 18.28.11080](https://github.com/intel/compute-runtime/releases/tag/18.28.11080).

### Software Requirements
- [CMake\*](https://cmake.org/download/) 3.9 or higher
- GCC\* 4.8 or higher to build the Inference Engine
- Python 2.7 or higher for Inference Engine Python API wrapper

### Build Steps

1. Clone the R5 release source code
    ```sh
    git clone -b 2018_R5 https://github.com/opencv/dldt.git
    ```
2. Install build dependencies using the `install_dependencies.sh` script in the folder `inference-engine`.
3. Go to project root directory `dldt`.
4. Build the project using the shell script as super user or change it as you like
    ```sh
    sudo ./build.sh
    ```
5. Note: only CPU plugin is built by the script
