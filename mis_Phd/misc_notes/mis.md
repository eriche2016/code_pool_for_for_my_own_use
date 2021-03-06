# Notes on Installation of Softwares 

## show package path installed in torch
In order to show the package where you store by using `luarocks install pack_name` command,  using:  
`luarocks show pack_name`

## install command without root priviledge
I donot have superuser priviledge on this sever, but this doesnot put restrictions on installing commandfor my own use.
ex, i want to instatll rar command, but i donnot have permission to use command like apt-get install rar, so
(1)i need to download the command files from website: 
http://www.rarlab.com/download.htm
then i put this file on folder: 
/home/hxw/Public/command_hxw/
then i untar the file:
(2) tar xzf rarlinux-x64-5.3.0.tar.gz

(3) then:
   cd rar 
   modify the makefile as: 

      PREFIX=/home/hxw/Public/command_hxw

      install:
        mkdir -p $(PREFIX)/bin
        mkdir -p $(PREFIX)/lib
        cp rar unrar $(PREFIX)/bin
        cp rarfiles.lst /home/hxw/Public/command_hxw/etc
        cp default.sfx $(PREFIX)/lib
  then make etc folder in /home/hxw/Public/command_hxw/etc
  and redirects to dir which makefile sites. 

(4) then run command:
    make install 

(5) then add  ~/.bashrc with the line: 

    export PATH=/home/hxw/Public/command_hxw/bin:$PATH 

(6) then 
    source .bashrc

now feel free to use your rar command 


##install opencv without root privilege##
1. download the latest version of opencv, ie `3.1.0`.
```
git clone https://github.com/opencv/opencv
```
2. cd to `opencv`.
```
cd opencv
```
3. mkdir `release`:
```
mkdir release
cd release 
```

3. cmake  
```
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/home/hxw/software/opencv -D BUILD_PYTHON_SUPPORT=ON -D PYTHON_EXECUTABLE=/usr/local/lib/python2.7 -D PYTHONINTERP_FOUND=1 ..
```

### Possible Issue and Solution:
When install ippicv_2020_lnx_intel64_20191018_general.tgz, it will fails, we can download: 

```
https://raw.githubusercontent.com/opencv/opencv_3rdparty/a56b6ac6f030c312b2dce17430eef13aed9af274/ippicv/ippicv_2020_lnx_intel64_20191018_general.tgz
```
Then: 
```
mv ippicv_2020_lnx_intel64_20191018_general.tgz 7421de0095c7a39162ae13a6098782f9-ippicv_2020_lnx_intel64_20191018_general.tgz
mv 7421de0095c7a39162ae13a6098782f9-ippicv_2020_lnx_intel64_20191018_general.tgz /home/ps/Public/opencv/.cache/ippicv/
```

4. make step:
```
make -j8 
 # -j8 runs 8 jobs in parallel.
 # Change 8 to number of hardware threads available.
```
5. make install step:
```make install```
6. modify .bashrc 
```
vim ~/.bashrc
```
add two lines at the end of the file:
```
# opencv 3 
export LD_LIBRARY_PATH=/home/hxw/software/opencv/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/home/hxw/software/opencv/lib/pkgconfig:$PKG_CONFIG_PATH
```
7. source it.
```
source ~/.bashrc
```

* check wether opencv is installed in a machine
```shell
pkg-config --modversion opencv 
```

### for opencv4 
```
ln -s /usr/local/include/opencv4/opencv2 /usr/local/include/opencv2
```
### Install matlab in ubuntu###
1. install matlab  
2. open matlab in ubuntu terminal    
opt1: `matlab`, will open matlab gui   
opt2: `matlab -nojvm`, cannot plot  
opt3: `matlab -nodesktop`, will send plot if necessary 

### How to run matlab script without invoking the matlab interative mode###
It seems that there is not one. All we can do is the following:  
```bash
matlab -nojvm -nosplash -r "myscript; exit"
```
or   
```bash
matlab -nodesktop -nosplash -nodisplay -r "run ./myscript.m ; quit;"
```

###shadowsocks端口被占用问题
今天重启电脑，发现shadowsocks报出exception， 即端口被占用问题。不管上网的端口号是多少（我的是13039）， 网上搜说是
1080端口被占用问题(shadowsocks本地端口号是1028)。 于是执行如下指令解决问题：   
cmd 打开终端：
```
>> netstat -ano|findstr 1080  
```
找到占用1080端口号的进程PID 2940  
然后kill掉，即解决了问题：  
```
>> taskkill -f /pid 2940  
```
成功: 已终止 PID 为 2940 的进程  
然后重新连接shadowsocks， 即可解决了问题。  

### tutorials on git command 
see [tutorials](http://rogerdudler.github.io/git-guide/)

###避免使用windows的编辑工具写Linux的shell脚本
之所以要这样做， 是因为在windows下编辑脚本文件，上传到linux机器上后，运行时经常碰到这样的错误：XXXX: line xxx: syntax error: unexpected end of file (XXXX是执行的文件名，xxx是出错行数：文件行尾）
出现这种错误的原因是：DOS下文件和Linux下文件格式差异问题导致的。
DOS下的文本文件是以\r\n作为换行标志的，表示成十六进制就是0D 0A。而Linux下的文本文件是以\n作为换行标志的，表示成十六进制就是0A。
DOS格式的文本文件在Linux下，用vi -b方式打开文件，会发现，每行的末尾会带有^M（\r）字符。用vi直接打开文件，在状态位置显示"XXXX" [converted][dos] 8L, 72C，表示是一个dos文件格式，有8行72个字符。解决的方案是： 
```
vi XXXX
:set fileformat=unix
:wq   存盘退出
```
当然，要从根本上解决这个问题，要求我们坚持Linux的编辑工具编写shell脚本。 


## 清理电脑C盘推荐软件
Dism++软件


## 挂载优盘到Unix上去目录/home/hxw/mnt 
```shell
sudo mount /dev/ssd1 /home/hxw/mnt 
```
或者协调挂载
```shell
sudo umount /home/hxw/mnt 
```
###

### Install on ubuntu from .tar.gz2 
STEP 1: Download: 
In 
```
https://launchpad.net/ubuntu/+source/orocos-bfl/0.8.0-5build1
```
Download: 
```
orocos-bfl_0.8.0.orig.tar.bz2
```
STEP 2: extact 

STEP 3: Install 
```
./configure 
make 
sudo make install
```
Then it is done. 

### catkin_make for ROS tutorials (~/overlay_ws)
ERROR:
libapr-1.so.0: undefined reference to `uuid_generate@UUID_1.0
Solution: 
```
cp /usr/lib/x86_64-linux-gnu/libuuid.so /home/ps/anaconda3/lib/
```

### Install tensort 

Conda Env: openpc_det
Env: Python3.7.9 + cuda10.2 + cudnn7.6 

STEP 1: install pycuda: 
```
pip install pycuda
```
STEP 2: Download (file: TensorRT-7.0.0.11.Ubuntu-16.04.x86_64-gnu.cuda-10.2.cudnn7.6.tar.gz) and install tensorrt: 
```
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/ps/Public/TensorRT-7.0.0.11/lib
cd python 
pip install tensorrt-7.0.0.11-cp37-none-linux_x86_64.whl
```

Note that we have to add 

```
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/ps/Public/TensorRT-7.0.0.11/lib
```

into ```~/.bashrc``` file  

Conda env: Adas_Lan_Obj_TrafficLgt 

Env: Python3.8.10 + cuda10.2 + cudnn8.2.0 

STEP 1: install cudnn(file: cudnn-10.2-linux-x64-v8.2.0.53.tgz)

ref: https://zongxp.blog.csdn.net/article/details/86098833?utm_medium=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7EBlogCommendFromMachineLearnPai2%7Edefault-1.control&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7EBlogCommendFromMachineLearnPai2%7Edefault-1.control

STEP 2: install pycuda: 
```
pip install `pycuda<2021.1`
```
STEP 3: Download (file: TensorRT-8.0.1.6.Linux.x86_64-gnu.cuda-10.2.cudnn8.2.tar.gz) and install tensorrt: 
``` 
tar xzvf TensorRT-8.0.1.6.Linux.x86_64-gnu.cuda-10.2.cudnn8.2.tar.gz
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/ps/Public/TensorRT-8.0.1.6/lib
cd python 
pip install tensorrt-8.0.1.6-cp39-none-linux_x86_64.whl
```

Note tensorrt7.0 does not contain `.whl` file for python3.8 

STEP 4: Install torch2trt 
```
git clone https://github.com/NVIDIA-AI-IOT/torch2trt
cd torch2trt
python setup.py install
```

Make sure to set the LD_LIBRARY_PATH correctly in .bashrc: 
```
vim ~/.bashrc 
# add the following line in .bashrc 
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/ps/Public/TensorRT-8.0.1.6/lib
```
if not set it, command ```import torch2trt``` will give errors like 
```
ImportError: libnvinfer.so.8: cannot open shared object file: No such file or directory 
```
actually libnvinfer.so.8 sites at folder: TensorRT-8.0.1.6/lib

Also note that please donot delete previous line in ```~/.bashrc```: ```export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/ps/Public/TensorRT-7.0.0.11/lib```, since 
in conda environment ```openpc_det```, the project depends on it. 

***Bad news***
cannot use tensorrt8.0 with torch2trt, see details in [here](https://github.com/NVIDIA-AI-IOT/torch2trt/issues/557)

So we will downgrade it to tensorrt7.2 since it has ```.whl``` file for python3.8 

Env: Python3.8.10 + cuda10.2 + cudnn8.2.0 

[Done] STEP 1: install cudnn(file: cudnn-10.2-linux-x64-v8.2.0.53.tgz)

ref: https://zongxp.blog.csdn.net/article/details/86098833?utm_medium=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7EBlogCommendFromMachineLearnPai2%7Edefault-1.control&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7EBlogCommendFromMachineLearnPai2%7Edefault-1.control

[Done] STEP 2: install pycuda: 
```
pip install `pycuda<2021.1`
```
STEP 3: Download (file: TensorRT-7.2.2.3.Ubuntu-16.04.x86_64-gnu.cuda-10.2.cudnn8.0.tar.gz) and install tensorrt: 
``` 
tar xzvf TensorRT-7.2.2.3.Ubuntu-16.04.x86_64-gnu.cuda-10.2.cudnn8.0.tar.gz
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/ps/Public/TensorRT-7.2.2.3/lib
cd python 
# uninstall tensort 8.0  
pip uninstall tensorrt
pip install tensorrt-7.2.2.3-cp38-none-linux_x86_64.whl
```

Note tensorrt7.2 **contains** `.whl` file for python3.8 

STEP 4: Install torch2trt 
```
git clone https://github.com/NVIDIA-AI-IOT/torch2trt
cd torch2trt
python setup.py install
```

Make sure to set the LD_LIBRARY_PATH correctly in .bashrc: 
```
vim ~/.bashrc 
# add the following line in .bashrc 
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/ps/Public/TensorRT-7.2.2.3/lib
```

Also note that please donot delete previous line in ```~/.bashrc```: ```export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/ps/Public/TensorRT-7.0.0.11/lib```, since 
in conda environment ```openpc_det```, the project depends on it. 


### Install labelme
When I install Label me using command below 
```
pip install labelme 
```
*NOTE: we may also need to install [zlib-1.2.9.tar.gz](https://www.zlib.net/fossils/) using command below
```
tar xvf zlib-1.2.9.tar.gz
cd zlib-1.2.9/
./configure
make
sudo make install
```
activate it, 
```
labelme 
```
Then it will output error messages relating to qt like 
```
could not load Qt platform plugin xcb even though it was found
QObject::moveToThread: Current thread is not the object's thread . Cannot move to target thread
```
I searched and found the following [solutions](https://forum.qt.io/topic/119109/using-pyqt5-with-opencv-python-cv2-causes-error-could-not-load-qt-platform-plugin-xcb-even-though-it-was-found/9), which solve the issue. 
```
pip install opencv-python-headless
```

### misc 
When I reopen the computer, the resolution of this computer are very
low, e.g., the fonts of  the computer are versy  blurring and enlarged. 
(I guess the software has been updated)
In  case I  come across the problem  in the future, the following solutions
can be applied. 
STEP 1: 
press CTRL + ALT F1  to enter tty
STEP 2: 
sudo service lightdm stop 
STEP 3, check whether nouveau has been stoped, no output means stoped,
otherwise, stop it:
lsmodd  |  grep  nouveaau  
STEP 4: 
sudo ./cuda_10.2.89_440.33.01_linux.run 
accept -> Then uncheck all the other options except driver  -> Install it

### ROS + CV2 + CV_Bridge on Ubuntu 16.04 
NOTE 1 On CV2: 解决Anaconda 与 ROS 冲突
删除 anaconda envs 环境变量中的 ros 相关路径
```
import sys
ros_cv2_path = '/opt/ros/kinetic/lib/python2.7/dist-packages'
if ros_cv2_path in sys.path: sys.path.remove(ros_cv2_path)
```
注：此方法单次有效，即每次执行 import cv2之前，都要先执行此操作

NOTE 2 On CV_Bridge: 
```

mkdir catkin_workspace
cd catkin_workspace
catkin init
# Instruct catkin to set cmake variables
 catkin config -DPYTHON_EXECUTABLE=/home/ps/anaconda3/envs/openpc_det/bin/python3.7 -DPYTHON_INCLUDE_DIR=/home/ps/anaconda3/envs/openpc_det/include/python3.7m -DPYTHON_LIBRARY=/home/ps/anaconda3/envs/openpc_det/lib/libpython3.7m.so
# Instruct catkin to install built packages into install place. It is $CATKIN_WORKSPACE/install folder
catkin config --install
# Clone cv_bridge src
git clone https://github.com/ros-perception/vision_opencv.git src/vision_opencv
# Find version of cv_bridge in your repository
apt-cache show ros-kinetic-cv-bridge | grep Version
    Version: 1.12.8-0xenial-20180416-143935-0800
# Checkout right version in git repo. In our case it is 1.12.8
cd src/vision_opencv/
git checkout 1.12.8
cd ../../
# run the following command, otherwise it will complain ```Could not find the following Boost libraries: boost python3
cd /usr/lib/x86_64-linux-gnu
# create symbolic link (I only have libboost_python-py35.so on my machine.)
sudo ln -s libboost_python-py35.so libboost_python3.so
sudo ln -s libboost_python-py35.a libboost_python3.a 
cd /home/ps/hxw_projects/Hongfeng_LaneDet/ros_cv_bridge_helper/catkin_workspace 
# flag should be set, otherwise it will cause errors 
catkin build cv_bridge  -DCMAKE_BUILD_TYPE=Release -DSETUPTOOLS_DEB_LAYOUT=OFF
# Now we can extend the environment variables and use it in other working space 
# Extend environment with new package
source install/setup.bash --extend
# test it 
python
>>> import cv_bridge
>>> cv_bridge.__path__

```


### Install TF for python3 on Ubuntu 16.04
Note: activate openpc_det environment which uses python3 
``` 
git clone https://github.com/ros/geometry (branch: noetic-devel) 
git clone https://github.com/ros/geometry2 (branch: noetic-devel)
```
STEP 1: must use c++11 to build it, otherwise cannot pass. 
To avoid adding building option in every file just open: 
```
sudo vim /opt/ros/kinetic/share/catkin/cmake/toplevel.cmake
```
adding the following line: 
```
set(CMAKE_CXX_FLAGS "-std=c++11 ${CMAKE_CXX_FLAGS}")
```
after line: 
```
set(CATKIN_TOPLEVEL TRUE)
```
STEP 2: Modify geometry2/tf2/CMakeLists.txt, at the end of the file, replace 
```
catkin_add_gtest(test_transform_datatypes test/test_transform_datatypes.cpp)
target_link_libraries(test_transform_datatypes tf2  ${console_bridge_LIBRARIES})
add_dependencies(test_transform_datatypes ${catkin_EXPORTED_TARGETS})
```
with 
```
catkin_add_gtest(test_transform_datatypes2 test/test_transform_datatypes.cpp)
target_link_libraries(test_transform_datatypes2 tf2  ${console_bridge_LIBRARIES})
add_dependencies(test_transform_datatypes2 ${catkin_EXPORTED_TARGETS})
```
STEP 3: Building for python3, and cmake it 

```
export ROS_PYTHON_VERSION=3
catkin_make
```


### Building [livox ros driver](https://github.com/Livox-SDK/livox_ros_driver) 

STEP 1: Livox-SDK

STEP 2: Install livox ros diver 
issue: 
```
 No rule to make target '/usr/lib/x86_64-linux-gnu/libproj.so', needed by '/home/ps/hxw_projects/ZGongProject/ws_livox/devel/lib/livox_ros_driver/livox_ros_driver_node'.
```
solution: 
```
sudo ln -s  /usr/lib/x86_64-linux-gnu/libproj.so.9 /usr/lib/x86_64-linux-gnu/libproj.so 
```

If there doest exist ```libproj.so.9``` in  ```/usr/lib/x86_64-linux-gnu/```, just 
install with ```sudo apt-get install libproj-dev```
Then remove devel/ and build/ and then ```catkin_make``` again


### Install Ceres

STEP 1: 
It requires Eighen 3.3 or later. However my computer has Eighen 3.2. 
So we will first need to remove Eighen 3.2 and then install Eighen 3.3. 
```
locate eigen3 
sudo rm -rf /usr/include/eigen3 /usr/lib/cmake/eigen3 /usr/share/doc/libeigen3-dev /usr/share/pkgconfig/eigen3.pc /var/lib/dpkg/info/libeigen3-dev.list /var/lib/dpkg/info/libeigen3-dev.md5sums ***
```

build it 
```
unzip eigen-3.3.9.zip
cd eigen-3.3.9 
mkdir build
cd build
cmake ..
make
sudo make install
sudo ldconfig -v
```

apt-get安装eigen3的路径为 /usr/include/eigen3 ，这里也保持一直；此外，需使用下面命令将Eigen映射到 /usr/include 路径下，因为在很多程序中include时经常使用#include <Eigen/Dense>而不是使用#include <eigen3/Eigen/Dense>，不映射的话一些程序在编译时会因找不到Eigen/Dense而报错。
```
sudo cp -r /usr/local/include/eigen3 /usr/include/eigen3 
sudo ln -s /usr/include/eigen3/Eigen /usr/include/Eigen
```
STEP 3: Install Ceres 

```
tar zxf ceres-solver-2.0.0.tar.gz
mkdir ceres-bin
cd ceres-bin/
cmake ../ceres-solver-2.0.0 
make -j3 
sudo make install 
```

### Building Eigen by specifying the installing dir  

On my machine I have installled Eigen3.3.8 in the /usr/ folder, However, there is a project which requires a lower version of Eigen to Build. 
So I download the Eigen3.2 and install it in the local dir by
```

mkdir build 
mkdir install # where to install 
cd build 
cmake ..
DESTDIR=../install/ make install # now it has been installed in ../install/ 
```
When use it to build other project, set to path in **terminal**:
```

```

### Closing firewall on my computer when connecting lidar 

```
sudo systemctl stop firewalld.service 
```


### Run command in bash file 
```
A; B # run A and then B regardless of sucess of A 
A && B Run if and only if A successed 
A || B # run B if and only if A failed 
A & run A in background 
```

### No inputting password for sudo command 
Use the NOPASSWD directive in your ```/etc/sudoers``` file 
If your user name is ```user```, and your host is called ```host```, then you can add these lines to ```/etc/sudoers```:

```
user host = (root) NOPASSWD: /sbin/shutdown 
```

This will allow the user ```user``` to run command ```shutdown``` on host without entering password, and all other sudoed commands will still require a password. 



### rosbag里面包含多个点云话题，bag_to_pcd失效（无法指定话题）
命令：
```
  rosrun pcl_ros bag_to_pcd my_data.bag /livox/A data/
```
主要原因是bag_to_pcd会将所有bag中pointcloud2格式的点云切割出来，而不管指定话题是哪一个。
错误信息在[这里](https://github.com/ros-perception/perception_pcl/pull/215)。
为了解决上述问题，有如下两种解决方案：
方法1： 安装jarvisschultz:melodic-devel分支
方法2：写一个python 脚本，订阅点云话题，在回调函数中保存点云。

