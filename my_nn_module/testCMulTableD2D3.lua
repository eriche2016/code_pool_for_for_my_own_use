require('nn')
require('CMulTableD2D3')

local mytester = torch.Tester() 

local jac 
local sjac 

local precision = 1e-5 
local expprecison = 1e-4 

local nntest = torch.TestSuite()

function nntest.CMulTableD2D3()
	-- set up data
	local input1 = torch.randn(2,3)
	local input2 = torch.randn(2,4,3)

	-- test forward
	local module = nn.CMulTableD2D3()
	local expected = torch.zeros(2,4,3):copy(input2)

	local T = input2:size(2)
	for t = 1, T do
		expected:narrow(2, t, 1):cmul(input1)
	end

	local output = module:forward({input1, input2})

	mytester:assertTensorEq(expected, output, 0.000001, 'BilinearD3 forward error')

	-- for testing grads
	local input2 = torch.randn(2, 2, 12)
	local module2 = nn.Sequential()
	module2:add(nn.SplitTable(1))
	module2:add(nn.ParallelTable():add(nn.Linear(12, 3)):add(nn.View(2, 4, 3)))
	module2:add(nn.CMulTableD2D3())
	-- module2:add(nn.View(-1))
	-- module2:add(nn.Linear(24,1))
    local err = jac.testJacobian(module2, input2) 
    mytester:assertlt(err, precision, 'error on state ')

    -- local err = jac.testJacobianParameters(module2, input2, module2:get(3).weight, module2:get(3).gradWeight)
    -- mytester:assertlt(err, precision, 'error on weight ')

    -- local err = jac.testJacobianParameters(module2, input2, module2:get(3).bias, module2:get(3).gradBias)
    -- mytester:assertlt(err, precision, 'error on bias ')

    print('test CMulTableD2D3 done')

end

mytester:add(nntest)
jac = nn.Jacobian
sjac = nn.SparseJacobian
mytester:run()
