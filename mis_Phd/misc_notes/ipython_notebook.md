When I run ```ipython notebook```, I cannot load the environments for openpc_det. 
So I modified the json file for the kernel, and it works fine. 
```
locate locate kernel.json

```
output: 
```

```
modify the path 
```
vim /home/ps/anaconda3/pkgs/ipykernel-5.3.2-py38h5ca1d4c_0/share/jupyter/kernels/python3/kernel.json
# change kernel path from ```/opt/anaconda1anaconda2anaconda3/bin/python``` to ```/home/ps/anaconda3/envs/openpc_det/bin/python```
```

then 
```
ipython notebook 
```
we can use torch in ipython notebook now. 
