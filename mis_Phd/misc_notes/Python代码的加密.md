**Q**: 如果项目代码大部分是Python语言编写的时候，如何实现交付产品内的源代码加密功能？

**A**: 其实有很多方法。 列举如下：
#### 方法1: 使用 Cython工具
Cython主要是将.py/.pyx 编译为 .c 文件，再将 .c 文件编译为 .so(Unix) 或 .pyd(Windows), 这样我们发布过程中只需要发布编译后的.so或.pyd（注：难以破解）就可以了，而不用将python源代码公布出去。
值得一提的是，Cython的另外一个好处是能够带来代码性能的提升。

**Demo**

- STEP 1： 新建`my_test`文件夹，并在`my_test`文件夹下编写python文件(`my_test.py`)：
```
#!/usr/bin/env python
# encoding: utf-8

def print_hello(user_name):
    print("Hello, {0}".format(user_name))
```
- STEP 2： 在my_test文件夹同级目录下编写`setup.py`文件： 
```
#!/usr/bin/env python
# encoding: utf-8

from distutils.core import setup
from Cython.Build import cythonize

setup(name="Hello World APP",
    ext_modules = cythonize("my_test/my_test.py")
```
- STEP 3:便于生成.so文件，命令如下：
```
python setup.py build_ext 
```
- STEP 4: 找到`build/lib.linux-x86_64-3.8/my_test.cpython-38-x86_64-linux-gnu.so`，就是我们所需要的.so文件。
这样我们可以直接删除掉源代码，保留这个`.so`就可以再当前编译环境下不需要python源代码就可以运行项目程序了。

[参考自zhihu文档：如何保护你的 Python 代码 （一）](https://zhuanlan.zhihu.com/p/54296517)

#### 方法2: 使用 pyinstaller 打包
缺点：pyinstaller会将所有依赖都打包进去，一般来说，打包后获得的文件体积太大。

#### 方法3: 使用域天加密狗
这是最近使用的加密办法，该款加密狗京东或者淘宝可以搜到。 
主要有两种方案，即1）d8加密，需要将python程序移植到d8开发语言（加密狗作者开发？有点坑），并通过编译将该部分代码写入到加密狗里面，实现调用，优点是安全性更高；
2）y8，该方法本质就是在python代码埋入查找加密狗是否存在的代码，如果存在，就正常运行，否则就中断。**然而该方案对于python程度来说并不能实现加密功能，
要实现加密功能，需要和方法1配合使用**。 



注意：在Linux系统下运行加密狗，要找到加密狗，需要开启权限，方法如下：
STEP 1:创建文件`sudo gedit /etc/udev/rules.d/Syu3.rules`, 添加如下：
```
SUBSYSTEM=="input", GROUP="input", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="3689", ATTRS{idProduct}=="8762", MODE:="666", GROUP="plugdev"
KERNEL=="hidraw*", ATTRS{idVendor}=="3689", ATTRS{idProduct}=="8762", MODE="0666", GROUP="plugdev"
 ```
保存文件。

STEP 2: 拔掉加密狗, 执行如下命令：
```
sudo udevadm control --reload-rules  
```
插上加密狗，然后运行即可找到加密狗。











