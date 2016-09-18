local _ = require 'moses' 
require 'torch'

local dpnntest = torch.TestSuite() 
local dpnnbigtest = torch.TestSuite()
local precision = 1e-5
local mytester 

function dpnntest.ArgMax() 
    local inputSize = 5
    local batchSize = 3 
    local input = torch.randn(batchSize, inputSize) 
    local gradOutput = torch.randn(batchSize):long() 
    -- dim = 1, nInputDim = 1, allow batch mode 
    -- max along dim 
    local am = nn.ArgMax(1, 1) 
    local output = am:forward(input) 
    local gradInput = am:backward(input, gradOutput) 
    local val, idx = torch.max(input, 2) 

    mytester:assertTensorEq(idx:select(2, 1), output, 0.000001, "ArgNax output asLong err") 
    mytester:assertTensorEq(gradInput, input:clone():zero(), 0.000001, "ArgMax gradInput asLong err") 
    local am = nn.ArgMax(1, 1, false) 
    local output = am:forward(input) 
    local gradInput = am:backward(input, gradOutput) 
    local val, idx = torch.max(input, 2) 

     mytester:assertTensorEq(idx:select(2, 1):double(), output, 0.000001, "ArgNax output asLong err") 
    mytester:assertTensorEq(gradInput, input:clone():zero(), 0.000001, "ArgMax gradInput asLong err") 
end 

function dpnn.test(tests) 
    mytester = torch.Tester() 
    mytester:add(dpnntest)
    math.randomseed(os.time()) 
    mytester:run(tests) 
end

function dpnn.bigtest(tests) 
    mytester = torch.Tester() 
    mytester:add(dpnnbigtest) 
    math.randomseed(os.time()) 
    mytester:run(tests) 
end
