# TX2 环境配置: PyTorch + Spconv + Openpc_det 

## NOTES when installing pytorch and openpc_det on TX2

### Update Python3.5 to Python3.6 in ubuntu 
```
sudo add-apt-repository ppa:deadsnakes/ppa 
sudo apt-get update 
sudo apt-get install python3.6 
sudo ln -s /usr/bin/python3.6 /usr/bin/python3
```
### for numpy 
```
sudo apt-get install python3.6-dev 
pip3 install numpy 
```

### Install PyTorch1.3 from source 
```
git clone https://github.com/pytorch/pytorch.git 
cd pytorch 
git checkout v1.3.0 
# we can install the depdencies in requirements.txt one by one as needed. 
# pip3 install -r requirements.txt
git submodule update --init --recursive
```

Turn on to max mode
```
echo -e "TX2 Performance Mode On"
sudo nvpmodel -m 0
sudo jetson_clocks.sh
```

#### Important  NOTES 
Apply following changes before continue
CmakeLists.txt : Change NCCL to 'Off' on line 142
setup.py: Add ```cmake_cache_vars['USE_NCCL'] = False``` below line 394. 
Now Install with  
``` 
sudo python3 setup.py develop
```

[NOTE1]: Everytime restart building, must delete the build file

[NOTE2]: possible problem during compiling 
pains when building process reaches 82% 

```
nvidia-tegra tx2 gcc: internal compiler error: Killed (program cc1plus)
```

一般为 out of memory, 建立临时缓冲(1G)去来解决:

```
sudo dd if=/dev/zero of=/swapfile bs=64M count=16
sudo mkswap /swapfile 
chmod 0600 /swapfile
sudo swapon /swapfile
```
Then recompile it 

After completed, we can delete the swapfle using the following command(Currently I donot delete it since I have enough storage): 
```
sudo swapoff -a
sudo rm -rf /swapfile
vim /etc/fstab
# comment swapfile line 
```

### Install torchvision 
```
cd ~/thirdparty 
git clone https://github.com/pytorch/vision 
mv vision torchvision 
cd torchvision 
git checkout v0.4.0 
sudo python3 setup.py install  
```


### Install numba 
NOTE: 
```
llvm version: 8.0 
llvmlite: 0.32.0 
numba: must be 0.48.0 (pip3 install numba==0.48.0)
```


### Install spconv 
#### STEP 1: clone 
```
cd hf3d_helper/  
git clone https://github.com/traveller59/spconv.git --recursive 
cd spconv 
``` 
#### STEP 2: install boost 
```
sudo apt-get install libboost-all-dev 
```
#### STEP 3: make sure cmake version > 3.13.2, otherwise re-install it 
```
cmaker --version 
```
#### STEP 4: modify setup.py 
```
vim setup.py 
```
[Mod1] Since I install PyTorch (version: 1.3.0a0+de394b6) from source, we should overite pytorch vision
otherwise it can not parse it. 

After line 24, adding
``` 
PYTORCH_VERSION='1.3.0' 
```
[Mod2] Now we should not setup pytorch. Just comment out requirements (after ```packages = find_packages(exclude=('tools', 'tools.*')```.  
```
# setup_requires = ['torch>=1.3.0'], 
```
[Mod3] It cannot find cmake_cuda_compiler, adding line: 

```cmake_args += ['-DCMAKE_CUDA_COMPILER=/usr/local/cuda/bin/nvcc']```

just before: 

```subprocess.check_call(['cmake', ext.sourcedir] + cmake_args, cwd=self.build_temp, env=env)```

#### STEP 5: building it

```
sudo python setup.py bdist_wheel 
```

#### STEP 6: install the wheel 

```
cd dist/ 
pip3 install spconv-1.2.1-cp36-cp36m-linux_aarch64.whl  
```
 

### misc: 
If storage is not enough, then we can delelte the Trash. Also note that delete the hidden trash may also give us much free space: 

```
rm -rf ~/.local/share/Trash/*  
```

check free space 

```
df -lh 
```

### Install scikit-image 
Must first install python-skimage 

```
sudo apt-get install python-skimage 
pip3 install scikit-image 
```

### After all the above is completed, now we can install Hongfeng_Lidar_Det-main 
```
cd ~/Hongfeng_Lidar_Det-main 
python setup.py develop 
```

