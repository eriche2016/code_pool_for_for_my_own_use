####################### 
## Install using conda (see https://pytorch.org) 
#######################
conda install pytorch torchvision -c pytorch






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
