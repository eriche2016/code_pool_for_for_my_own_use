### the code comes from [nn](https://github.com/torch/nn)

##implement a new layer of your own in torch##
When try to implement a new layer, you should keep the following in mind: 
* forward and backward methods (in the parent nn.Module class) already call the other
methods below, so don’t override them directly.
* override the `updateOutput` method to implement the forward pass, to compute `z` from `x`
* override the `updateGradInput` method to implement part of the backward pass, to compute
the derivative of the loss wrt your layer’s inputs ( `∂loss/∂x`), in terms of the derivative of the
loss wrt your layer’s outputs (`∂loss/∂z`).
* override the `accGradParameters` method for the other part of the backward pass if your
layer has parameters, to compute the gradient of the loss wrt your layer’s parameters


