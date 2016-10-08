require 'nn'
local Toc, parent = torch.class('nn.Toc', 'nn.Module')

function Toc:__init(name, comment)
   parent.__init(self)
   self.name = name or 'default'
   self.comment = comment or ''
end

function Toc:updateOutput(input)
   print("Toc '"..self.name.."' ("..self.comment..") : "..tic_modules[self.name]:time()['real']*1000 .. "ms")
   self.output = input
   return self.output
end

function Toc:updateGradInput(input, gradOutput) 
   self.gradInput = gradOutput
   return self.gradInput
end
