require 'nn'
require 'nngraph'

function make_unit(inputSize, outputSize) 
    local x1 = nn.Identity()() 
    local x2 = nn.Identity()()
    
    local y1 = nn.Linear(inputSize, outputSize, false)(x1) 
    local y2 = nn.Linear(inputSize, outputSize, false)(x2) 
    
    inputs, outputs = {x1, x2}, {y1, y2} 

    return nn.gModule(inputs, outputs)

end 

model1 = make_unit(10, 10) -- nn.gModule
print(model1)  -- s will be nn.gModule 

x1 = nn.Identity()() 
x2 = nn.Identity()() 

-- (1) test 1 
model2 = make_unit(10, 10)({x1, x2})
print(model2) -- nngraph.Node
module2 = nn.gModule({x1, x2}, {model2}) 
x1_val = torch.rand(10) 
x2_val = torch.rand(10):zero()
out1 = module2:forward({x1_val, x2_val})

-- (2) test 2 
function make_unit_wrapper(inputSize, outputSize) 
    local x3 = nn.Identity()() 
    local x4 = nn.Identity()()
    local y3_and_y4 = make_unit(inputSize, outputSize)({x3, x4}) 
    -- split method is very impotant, here
    local y3, y4 = y3_and_y4:split(2) 
    return nn.gModule({x3, x4}, {y3, y4, y5}) 
end 

local x3 = nn.Identity()()
local x4 = nn.Identity()() 
model3 = make_unit_wrapper(10, 10)({x3, x4})
print(model3) -- nngraph.Node
module3 = nn.gModule({x3, x4}, {model3}) 
x3_val = torch.rand(10):zero() 
x4_val = torch.rand(10)
out2 = module2:forward({x3_val, x4_val})
