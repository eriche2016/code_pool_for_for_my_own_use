
### Install using conda (see https://pytorch.org) 
```
conda install pytorch torchvision -c pytorch
```





### install pytorch from source

#### step 1: install anaconda (reconmand to choose python3 when run the shell script)
[optional] we can update our conda by runing command below
```
 conda update -n base conda
```

#### step 2: Install optional dependencies

On Linux
```bash
export CMAKE_PREFIX_PATH=[anaconda root directory]
```

#### step 3: Install basic dependencies
```bash
conda install numpy pyyaml mkl mkl-include setuptools cmake cffi typing
conda install -c intel mkl-dnn
```
#### step 4: Add LAPACK support for the GPU
```bash 
conda install -c pytorch magma-cuda80 # or magma-cuda75 if CUDA 7.5
```

#### step 5: Install PyTorch
get from source 
```
git clone --recursive https://github.com/pytorch/pytorch
cd pytorch 
```

On Linux
suggested choice(reference [see here](https://github.com/pytorch/pytorch/blob/master/CONTRIBUTING.md)):

```bash 
python setup.py install
```
or 
```bash
python setup.py build develop
```
This is especially useful if you are only changing Python files.
This mode will symlink the python files from the current local source tree into the python install.
Hence, if you modify a python file, you do not need to reinstall pytorch again and again.

choice 2: 

```bash
python setup.py install --user
```

### install pytorch1.0 without disturbing the previous installed pytorch0.4 
In order to use the latest pytorch, I install it using conda. 
#### create new environment using conda 
```bash 
conda create --name pytorch1_2 python=3.6 
```
#### save environments for pytroch1_2 
```bash 
cd /home/hxw/anaconda3/envs/pytorch1_2
mkdir -p ./etc/conda/activate.d
mkdir -p ./etc/conda/deactivate.d
vim ./etc/conda/activate.d/env_vars.sh
vim ./etc/conda/deactivate.d/env_vars.sh
```
#### Edit ./etc/conda/activate.d/env_vars.sh as follows:
```sh 
#!/bin/bash

# for cuda 9.2  
export LD_LIBRARY_PATH=/usr/local/cuda-9.2/lib64:$LD_LIBRARY_PATH 
export PATH=/usr/local/cuda-9.2/bin:$PATH

# may change it later 
# cudnn 
# export CUDNN_LIB_DIR=/home/hxw/Public/cudnn_v6/cuda/lib64  
# export CUDNN_INCLUDE_DIR=/home/hxw/Public/cudnn_v6/cuda/include 
# export LD_LIBRARY_PATH=/home/hxw/Public/cudnn_v6/cuda/lib64:$LD_LIBRARY_PATH

```
#### Edit ./etc/conda/deactivate.d/env_vars.sh as follows:
```sh 
#!/bin/bash 

unset LD_LIBRARY_PATH
unset PATH
``` 
#### testing it 
When you run ```source activate pytorch1_2```, the environment variables LD_LIBRARY_PATH and PATH are set to the values you wrote into the file. When you run ```source deactivate```, those variables are erased. We can also run ``nvcc --version`` to see cuda version (9.2 now)

#### install pytroch1.2 
```
source activate pytorch1_2 
conda install pytorch torchvision cudatoolkit=9.2 -c pytorch
```
[ref 1: conda environments setting](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#macos-and-linux)

[ref 2: conda cheetsheet](https://docs.conda.io/projects/conda/en/4.6.0/_downloads/52a95608c49671267e40c689e0bc00ca/conda-cheatsheet.pdf)

#### compile code from pointnet2
Recently I tried to compile code from [PointNet2](https://github.com/erikwijmans/Pointnet2_PyTorch) using the following command:
```
python setup.py build_ext --inplace
```
However, I failed with the following error message outputed by the system(I have checked my conda environment using gcc --version, and it says I am using gcc 4.9): 
```
[[B^[[B^[[B^[[B^[[B^[[B/usr/lib/gcc/x86_64-linux-gnu/5/include/avx512fintrin.h(9220): error: argument of type "const void *" is incompatible with
parameter of type "const float *"

/usr/lib/gcc/x86_64-linux-gnu/5/include/avx512fintrin.h(9231): error: argument of type "const void *" is incompatible with parameter of type "const
 float *"

/usr/lib/gcc/x86_64-linux-gnu/5/include/avx512fintrin.h(9244): error: argument of type "const void *" is incompatible with parameter of type "const
 double *"

/usr/lib/gcc/x86_64-linux-gnu/5/include/avx512fintrin.h(9255): error: argument of type "const void *" is incompatible with parameter of type "const
 double *"

/usr/lib/gcc/x86_64-linux-gnu/5/include/avx512fintrin.h(9268): error: argument of type "const void *" is incompatible with parameter of type "const
 float *"

/usr/lib/gcc/x86_64-linux-gnu/5/include/avx512fintrin.h(9279): error: argument of type "const void *" is incompatible with parameter of type "const
 float *"

/usr/lib/gcc/x86_64-linux-gnu/5/include/avx512fintrin.h(9292): error: argument of type "const void *" is incompatible with parameter of type "const
 double *"

```
It can be seen that actuallly it is using gcc-5, However, gcc-5 cannot compile the code according to the information from PointNet2. So 
I again tried to remove gcc-5 from my system using the following command:
```
sudo update-alternatives --remove gcc /usr/bin/gcc-5
```
and now I compiled the code, it works!!!. 

##### Another solution 
since I use anconda environment, I can create a envrionments using votenet using command below
```
conda env create -f votenet.yaml
```
and it will create a envrionment for me named votenet, and then I can perform experiments under this environment by activating it. 

