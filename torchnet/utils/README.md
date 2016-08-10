###Shallow copy v.s Deep copy of the table
(1) [function utils.table.copy](https://github.com/eriche2016/code_pool_for_for_my_own_use/blob/master/torchnet/utils/table.lua#L27) just shallow copy a table to another table. Below is an example:
```
/_  __/__  ________/ /   |  Scientific computing for Lua.
  / / / _ \/ __/ __/ _ \  |  Type ? for help
 /_/  \___/_/  \__/_//_/  |  https://github.com/torch
                          |  http://torch.ch

th> torchnet_utils = require 'torchnet.utils'
                                                                      [0.0118s]
th> t = {a = 1, b={c = 2}}
                                                                      [0.0001s]
th> t_copy_s = torchnet_utils.table.copy(t)
                                                                      [0.0001s]
th> t_copy_s
{
  a : 1
  b :
    {
      c : 2
    }
}
                                                                      [0.0001s]
th> t_copy_s.b.c = 10
                                                                      [0.0000s]
th> t
{
  a : 1
  b :
    {
      c : 10
    }
}
                                                                      [0.0001s]
th>

```
