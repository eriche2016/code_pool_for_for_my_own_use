local autograd = require 'autograd'
 
-- just define the loss functions
local mse = function(input, target)
   local buffer = input-target
   return torch.sum( torch.cmul(buffer, buffer) ) / (input:dim() == 2 and input:size(1)*input:size(2) or input:size(1))
end

-- Create an autograd criterion using the loss function above.
local autoMseCriterion = autograd.nn.AutoCriterion('AutoMSE')(mse)  
print(autoMseCriterion)

print('testing mse using autograd')

local targets = torch.rand(4, 5)
local preds = torch.rand(4, 5) 

autoMseCriterion:forward(preds, targets)
autoMseCriterion:backward(preds, targets)
