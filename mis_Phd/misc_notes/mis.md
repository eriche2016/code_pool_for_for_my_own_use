# Notes on knowledge on computer stuff
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

# catkin_make for ROS tutorials (~/overlay_ws)
ERROR:
libapr-1.so.0: undefined reference to `uuid_generate@UUID_1.0
Solution: 
```
cp /usr/lib/x86_64-linux-gnu/libuuid.so /home/ps/anaconda3/lib/
```
