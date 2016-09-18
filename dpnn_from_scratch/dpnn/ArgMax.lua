------------------------------------------------------------------------
--[[ ArgMax ]]--
-- Returns the index of the maxima for dimension dim.
-- Cannot backpropagate through this module.
-- Created for use with ReinforceCategorical.
------------------------------------------------------------------------
local ArgMax, parent = torch.class("nn.ArgMax", "nn.Module")

function ArgMax:__init(dim, nInputDim, asLong)
   parent.__init(self)
   self.dim = dim or 1
   self.nInputDim = nInputDim or 9999
   -- by default, self.asLong is true 
   self.asLong = (asLong == nil) and true or asLong
   if self.asLong then
      self.output = torch.LongTensor()
   end
end

function ArgMax:updateOutput(input)
   self._value = self._value or input.new()
   self._indices = self._indices or
      (torch.type(input) == 'torch.CudaTensor' and torch.CudaTensor() or torch.LongTensor())
   -- if input:dim() > self.nInputDim, then dim =self.dim + 1, otherwise, dim = self.dim 
   local dim = (input:dim() > self.nInputDim) and (self.dim + 1) or self.dim
   
   -- torch.max([resval, resind,]x[,dim]): performs max operation to input tensor x along dim 
   -- store the value to self._value, corresponds indices to self._indices
   torch.max(self._value, self._indices, input, dim)
   
   if input:dim() > 1 then
      local idx = self._indices:select(dim, 1)
      self.output:resize(idx:size()):copy(idx)
   else
      self.output:resize(self._indices:size()):copy(self._indices)
   end

   return self.output
end

function ArgMax:updateGradInput(input, gradOutput)
   -- cannot backprop from an index so just return a dummy zero tensor
   self.gradInput:resizeAs(input):zero()
   return self.gradInput
end

function ArgMax:type(type)
   -- torch.max expects a LongTensor as indices, whereas cutorch.max expects a CudaTensor.
   if type == 'torch.CudaTensor' then
      parent.type(self, type)
   else
      -- self._indices must be a LongTensor. Setting it to nil temporarily avoids
      -- unnecessary memory allocations.
      local indices
      indices, self._indices = self._indices, nil
      -- convert the parent of the model to type `type` 
      parent.type(self, type)
      self._indices = indices and indices:long() or nil
   end

   if self.asLong then
      self.output = torch.LongTensor()
   end

   return self
end
