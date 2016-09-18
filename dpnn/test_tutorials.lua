-- i just clone the dpnn to this repositorys: /home/hxw/torch_learning/dpnn/init.lua
-- and not install it to my machine 
local dpnn_path = '/home/hxw/torch_learning/?/init.lua' 
-- add dpnn to package.path variables 
package.path = package.path .. ";" .. dpnn_path 

require 'nn' 
dpnn = require 'dpnn'
print(dpnn)

-- ArgMax module 
-- run the tests on dpnn the particular ArgMax module 
dpnn.test('ArgMax')
-- declare a ArgMax module 
model = nn.ArgMax(1, 1, false) -- not asLong 
print(model)
