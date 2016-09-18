local dpnn_path = '/home/hxw/torch_learning/?/init.lua' 

package.path = package.path .. ";" .. dpnn_path 

require 'nn' 

dpnn = require 'dpnn'
print(dpnn)
