### install matlab2017b on ubuntu 16.04 lts (remote installing on ubuntu server via mobaxterm)

#### step 1: download matlab2017b via [here](http://software.hust.edu.cn/download/matlab.html). Recomanding downloading matlab from the official website(https://ww2.mathworks.cn/login?uri=%2Fmwaccount%2F)

#### step 2: Install xterm via command 
```bash
sudo apt-get install xterm
```

#### step 3: now installing matlab 
```bash
mkdir /mnt/matlab # move matlab_R2017b_glnxa64.zip  to this directory 
mv $PATH_TO_MATLAB.zip ./
cd /mnt/matlab
unzip matlab_R2017b_glnxa64.zip 
sudo ./install 
```
#### step 4: Now it will ***pop out*** an GUI, which you can installing it by following the commands given out. 
#### step 5: Finally, It requires you to activate it by using your name and password, and you also need to input your login name on the server to make sure that only you can use the installed matlab. 

#### (optional) step 5: For other users on this server that wants to use the installed matlab, you can go to /usr/local/MATLAB/R2017b/bin, and run command to activate the matlab by using your own name and password for matlab official website:
```bash
 sh activate_matlab.sh
```


