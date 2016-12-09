-- CMultableD2D3: Broadcasted mul between a 2D-Tensor and a 3D-Tensor
local CMulTableD2D3, parent = torch.class('nn.CMulTableD2D3', 'nn.Module')

function CMulTableD2D3:__init()
	parent.__init(self)
	self.gradInput = {}
end

function CMulTableD2D3:updateOutput(input)
	-- input[1]: sProj [n x Dh]
	-- input[2]: xProj [n x T x Dh]
	assert(type(input) == 'table' and #input == 2)
	local sProj, xProj = unpack(input)
	assert(sProj:dim() == 2 and xProj:dim() == 3)

	self.output:resizeAs(xProj)
	self.output:copy(xProj)
	local T = xProj:size(2)
	for t = 1, T do
		self.output:narrow(2, t, 1):cmul(sProj)
	end
	return self.output
end

function CMulTableD2D3:updateGradInput(input, gradOutput)
	-- gradOutput: [n x T x Dh]
	assert(gradOutput:dim() == 3)

	local sProj, xProj = unpack(input)
	for i = 1, #input do  -- {ds, dx}
		self.gradInput[i] = self.gradInput[i] or input[i].new()
		self.gradInput[i]:resizeAs(input[i])
	end
	
	grad_s, grad_x = unpack(self.gradInput)
	grad_s:fill(0)
	grad_x:fill(0)
	
	local T = xProj:size(2)
	for t = 1, T do
		local temp1 = gradOutput:narrow(2, t, 1):clone() 
		grad_s:add(temp1:cmul(xProj:narrow(2, t, 1)))
		local temp2 = gradOutput:narrow(2, t, 1):clone()
		grad_x:narrow(2, t, 1):copy(temp2:cmul(sProj))
	end
	return self.gradInput
end
