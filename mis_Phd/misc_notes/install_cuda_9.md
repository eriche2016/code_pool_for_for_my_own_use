### download run file

website: https://developer.nvidia.com/cuda-90-download-archive?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1604&target_type=runfilelocal
Note:  Installer Type: runfile (local), because this version will allow us not to override the previous installed cuda 8.0, for example. 

### steps 
copy cuda_9.0.176_384.81_linux.run to ```/mnt/software```
and run commands:
```
sudo chmod +x cuda_9.0.176_384.81_linux.run
./cuda_9.0.176_384.81_linux.run 
```
then it will pop out license, press q to exist, and choose the options like below: 
```
1.1. License


1.1.1. License Grant

Do you accept the previously read EULA?
accept/decline/quit: accept

Install NVIDIA Accelerated Graphics Driver for Linux-x86_64 384.81?
(y)es/(n)o/(q)uit: n

Install the CUDA 9.0 Toolkit?
(y)es/(n)o/(q)uit: y

Enter Toolkit Location
 [ default is /usr/local/cuda-9.0 ]: y

Toolkit location must be an absolute path.
Enter Toolkit Location
 [ default is /usr/local/cuda-9.0 ]:

/usr/local/cuda-9.0 is not writable.
Do you wish to run the installation with 'sudo'?
(y)es/(n)o: sudo
Do you wish to run the installation with 'sudo'?
(y)es/(n)o: yes

Please enter your password:
Do you want to install a symbolic link at /usr/local/cuda?
(y)es/(n)o/(q)uit: n

Install the CUDA 9.0 Samples?
(y)es/(n)o/(q)uit: n

Installing the CUDA Toolkit in /usr/local/cuda-9.0 ...
Installing the CUDA Toolkit in /usr/local/cuda-9.0 ...
q
===========
= Summary =
===========

Driver:   Not Selected
Toolkit:  Installed in /usr/local/cuda-9.0
Samples:  Not Selected

Please make sure that
 -   PATH includes /usr/local/cuda-9.0/bin
 -   LD_LIBRARY_PATH includes /usr/local/cuda-9.0/lib64, or, add /usr/local/cuda-9.0/lib64 to /etc/ld.so.conf and run ldconfig as root

To uninstall the CUDA Toolkit, run the uninstall script in /usr/local/cuda-9.0/bin

Please see CUDA_Installation_Guide_Linux.pdf in /usr/local/cuda-9.0/doc/pdf for detailed information on setting up CUDA.

***WARNING: Incomplete installation! This installation did not install the CUDA Driver. A driver of version at least 384.00 is required for CUDA 9.0 functionality to work.
To install the driver using this installer, run the following command, replacing <CudaInstaller> with the name of this run file:
    sudo <CudaInstaller>.run -silent -driver

Logfile is /tmp/cuda_install_19659.log

```

Thus, it needs the cuda driver to be installed, thus we install with
```
sudo ./cuda_9.0.176_384.81_linux.run  -silent -driver
```
