-- ref: https://gist.github.com/MihailJP/3931841

-- Shallow- and deep-copy of table in Lua
function clone (t) -- deep-copy a table
    if type(t) ~= "table" then return t end
    local meta = getmetatable(t)
    local target = {}
    for k, v in pairs(t) do
        if type(v) == "table" then  
            target[k] = clone(v) -- recursively 
        else
            target[k] = v
        end
    end
    setmetatable(target, meta)
    return target
end

function copy (t) -- shallow-copy a table
    if type(t) ~= "table" then return t end
    local meta = getmetatable(t)
    local target = {}
    for k, v in pairs(t) do target[k] = v end -- shallow copy: copy depth are 1 
    setmetatable(target, meta)
    return target
end
