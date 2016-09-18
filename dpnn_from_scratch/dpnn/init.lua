require 'torch'
require 'nn'
-- require 'nnx'  -- currently not use 
local _ = require 'moses' 

-- create global dpnn table 
dpnn = {} 
dpnn.version = 2 

unpack = unpack or table.unpack -- lua 5.2 compat 

-- for testing:
-- currently, this is different from the original repository:
-- https://github.com/Element-Research/dpnn/blob/master/init.lua#L13, because we will not install this repository 
-- to my machine, but just use it as local tools 
require 'dpnn.test.test'


-- modules
require 'dpnn.ArgMax'

return dpnn
