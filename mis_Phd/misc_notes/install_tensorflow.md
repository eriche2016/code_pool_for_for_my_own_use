
### install anaconda
### create a conda environment named tensorflow to run a version of Python
```
 conda create -n tensorflow python=3.4
```
 
### donwload tf binary (offline, gpu version) 
 ```
 https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.4.0-cp34-cp34m-linux_x86_64.whl
 ```
### activate conda 
 Activate the conda environment by issuing the following command:
 ```
  source activate tensorflow
 ```
  
 #### now install it. 
 pip install ./Ananaconda_Pytorch_Related/tensorflow_gpu-1.4.0-cp34-cp34m-linux_x86_64.whl

### install tensorflow-gpu on environment python3.6.1 + cuda8.0 + cudnn6 with one command 
```
pip install https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.3.0-cp36-cp36m-linux_x86_64.whl
```
## Last update. 
### install tensorflow-gpu with python 3.6.4 + cuda8.0 + cudnn7  
```
 step 1: download tensofrlow gpu, which only support cudnn6.0 
 https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.3.0-cp36-cp36m-linux_x86_64.whl 
 
 # step 2: since we installed cudnn7, we have to create soft symbol link to cudnn6.0
 ln -s libcudnn.so.7.1.1  libcudnn.so.6
 # step 3: install it 
  pip install tensorflow_gpu-1.3.0-cp36-cp36m-linux_x86_64.whl
 
```
