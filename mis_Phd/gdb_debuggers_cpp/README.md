### debuge cpp source code with gdb debugger 

0. tell the compiler to compile the cpp code with symbolic debugging information included. g++ with `-g` switch.  
```
g++ -g test_gdb.cpp -o test_gdb
```
or compile c code with command below
```
gcc -g test_gdb1.c -o test_gdb1
```
1. starting the gdb debugger. Note here that enter `help` in gdb prompt and get more information, enter `quit` to 
   quit the debugger. Note that during debugging,  there may be some error called `Import Error: No module name libstdcxx`(Ubuntu 14.04), we should add it to the python path when we activate gdb. Command below:
```
python sys.path.append("/usr/share/gcc-4.8/python");
```

```
jack@ubuntu14.04:~/visual_concepts_image_caption/temp$ gdb test_gdb
GNU gdb (Ubuntu 7.7.1-0ubuntu5~14.04.2) 7.7.1
Copyright (C) 2014 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
<http://www.gnu.org/software/gdb/documentation/>.
For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from test_gdb...done.
(gdb) python sys.path.append("/usr/share/gcc-4.8/python");
(gdb)
```
2. debugging your code.

   ```
   (gdb) python sys.path.append("/usr/share/gcc-4.8/python");
(gdb) list main
5       {
6           return a + b;
7       }
8
9       int  main(int argc, char *argv[])
10      {
11          /*
12          cout << "number of args: argc = " << argc << endl;
13
14          for (int i = 0; i < argc; ++i)
(gdb) b main
Breakpoint 1 at 0x4006f9: file test_gdb.cpp, line 23.
(gdb) r
Starting program: /home/hxw/visual_concepts_image_caption/temp/test_gdb

Breakpoint 1, main (argc=1, argv=0x7fffffffe068)
    at test_gdb.cpp:23
23          };
(gdb) next
29          };
(gdb) next
33          };
(gdb) next
35          for (i = 0; i < 10; i++)
(gdb) i b
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x00000000004006f9 in main(int, char**) at test_gdb.cpp:23
        breakpoint already hit 1 time
(gdb) list 14
9       int  main(int argc, char *argv[])
10      {
11          /*
12          cout << "number of args: argc = " << argc << endl;
13
14          for (int i = 0; i < argc; ++i)
15          {
16              cout << "arg-" << i << ": " << argv[i] << "\n";
17          }
18          */
(gdb) list 28
23          };
24          int i;
25
26          int array1[10] =
27          {
28           48, 56, 77, 33, 33, 11, 226, 544, 78, 90
29          };
30          int array2[10] =
31          {
32           85, 99, 66, 0x199, 393, 11, 1, 2, 3, 4
(gdb) list 35
30          int array2[10] =
31          {
32           85, 99, 66, 0x199, 393, 11, 1, 2, 3, 4
33          };
34
35          for (i = 0; i < 10; i++)
36          {
37              sum[i] = add(array1[i], array2[i]);
38          }
39          return 0;
(gdb) next
37              sum[i] = add(array1[i], array2[i]);
(gdb) p i
$1 = 0
(gdb) next
35          for (i = 0; i < 10; i++)
(gdb) p sum[0]
$2 = 133
(gdb) clear main
Deleted breakpoint 1
(gdb) i b
No breakpoints or watchpoints.
(gdb) b main
Breakpoint 2 at 0x4006f9: file test_gdb.cpp, line 23.
(gdb) next
37              sum[i] = add(array1[i], array2[i]);
(gdb) display i
1: i = 1
(gdb) next
35          for (i = 0; i < 10; i++)
1: i = 1
(gdb) display
1: i = 1
(gdb) next
37              sum[i] = add(array1[i], array2[i]);
1: i = 2
(gdb) next
35          for (i = 0; i < 10; i++)
1: i = 2
(gdb) next
37              sum[i] = add(array1[i], array2[i]);
1: i = 3
(gdb) cont
Continuing.
[Inferior 1 (process 12186) exited normally]
(gdb) q

   ```



  
  
  
