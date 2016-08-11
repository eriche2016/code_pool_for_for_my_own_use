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
opt3: `matlab -nodestop`, will send plot if necessary

