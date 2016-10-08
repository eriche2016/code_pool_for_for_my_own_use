##Notes on torch7 stuff##
There are two complicated methods of `torch.Tensor`, one is `scatter` method, and the other is `gather`
### [Tensor] scatter(dim, index, src|val) ###
Writes all values from tensor `src` or the scalar `val` into `self` at the specified indices. The indices are specified
with respect to the given dimension, `dim`, in the manner described in [gather](#torch.Tensor.gather). Note that, as
for gather, the values of index must be between 1 and `self:size(dim)` inclusive and all values in a row along the
specified dimension must be unique.

```lua
x = torch.rand(2, 5)
> x
 0.3227  0.4294  0.8476  0.9414  0.1159
 0.7338  0.5185  0.2947  0.0578  0.1273
[torch.DoubleTensor of size 2x5]

y = torch.zeros(3, 5):scatter(1, torch.LongTensor{{1, 2, 3, 1, 1}, {3, 1, 1, 2, 3}}, x)
> y
 0.3227  0.5185  0.2947  0.9414  0.1159
 0.0000  0.4294  0.0000  0.0578  0.0000
 0.7338  0.0000  0.8476  0.0000  0.1273
[torch.DoubleTensor of size 3x5]

z = torch.zeros(2, 4):scatter(2, torch.LongTensor{{3}, {4}}, 1.23)
> z
 0.0000  0.0000  1.2300  0.0000
 0.0000  0.0000  0.0000  1.2300
[torch.DoubleTensor of size 2x4]

```
illustration below
```
> x

 0.3227  0.4294  0.8476  0.9414  0.1159
 0.7338  0.5185  0.2947  0.0578  0.1273
[torch.DoubleTensor of size 2x5]


> y
  1           2          3       1       1
  3           1          1       2       3
 0.3227(1)  0.5185(*)  0.2947  0.9414  0.1159
 0.0000     0.4294(2)  0.0000  0.0578  0.0000
 0.7338(3)  0.0000     0.8476  0.0000  0.1273
[torch.DoubleTensor of size 3x5]
```

```
z = torch.zeros(2, 4):scatter(2, torch.LongTensor{{3}, {4}}, 1.23)
3rd ->  0.0000  0.0000  1.2300  0.0000  
4th ->  0.0000  0.0000  0.0000  1.2300
[torch.DoubleTensor of size 2x4]
```
