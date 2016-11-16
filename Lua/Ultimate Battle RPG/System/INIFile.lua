--[[
local startIndex, endIndex = string.find(str, "\r\n\r\n")

string.sub(str, i,i2)
]]--

INIFileEntry = {}

function INIFileEntry:toString()
  return self.name .. "=" .. self.val
end

function INIFileEntry.new(name,val)
  local c = setmetatable(
    {
      name = name,
      val = val
    },
    {
      __index = INIFileEntry,
      __tostring = INIFileEntry["toString"]
    }
  )

  return c
end

function INIFileEntry:getName()
  return self.name
end

function INIFileEntry:getVal()
  return self.val
end

function INIFileEntry:setVal(val)
  if type(val) == "string" then
    self.val = val
  else
    error("bad argument #1: (string expected, got " .. type(val) .. ")",2)
  end
end

------------------------------
INIFileGroup = {}

function INIFileGroup:toString()
  local ret = "\[" .. self.name .. "\]\n"
  
  for i=1,table.getn(self.entries) do
    ret = ret .. tostring(self.entries[i]) .. "\n"
  end
  
  --[[
  for name,val in pairs(self.entries) do
    if val ~= nil then
      ret = ret .. name .. "=" .. val  .. "\n"
    end
  end
  ]]--
  
  return ret
end

function INIFileGroup.new(name)
  local c = setmetatable(
    {
      name = name,
      entries = {}
    },
    {
      __index = INIFileGroup,
      __tostring = INIFileGroup["toString"]
    }
  )

  return c
end

function INIFileGroup:getName()
  return self.name
end

function INIFileGroup:setName(name)
  if type(name) == "string" then
    self.name = name
  else
    error("bad argument #1: (string expected, got " .. type(name) .. ")",2)
  end
end

function INIFileGroup:size()
  return table.getn(self.entries)
end

function INIFileGroup:getEntry(e)
  if type(e) == "string" then
    return self.entries[e]
  else
    error("bad argument #1: (string expected, got " .. type(e) .. ")",2)
  end
end

function INIFileGroup:setEntry(e,val)
  if type(e) == "string" then
    --self.entries[e] = val
    self.entries[e]:setVal(val)
  else
    error("bad argument #1: (string expected, got " .. type(e) .. ")",2)
  end
end

function INIFileGroup:addEntry(name,val)
  --self.entries[name] = val
  table.add(self.entries,INIFileEntry.new(name,val))
end

function INIFileGroup:removeEntry(e)
  if type(e) == "string" then
    table.remove(self.entries,e)
  else
    error("bad argument #1: (string expected, got " .. type(e) .. ")",2)
  end
end

------------------------------
INIFile = {}

function INIFile.new(path)
  local c = setmetatable(
    {
      path = path,
      file = nil,
      groups = {}
    },
    {
      __index = INIFile
    }
  )

  return c
end

function INIFile:read()
  self.file = io.open(self.path,"r+")
  
end

function INIFile:write()
  self.file = io.open(self.path,"w+")
end

function INIFile:getEntry(g,e)
  if type(g) == "string" then
    if type(e) == "string" then
      return self.groups[g]:getEntry(e)
    else
      error("bad argument #2: (string expected, got " .. type(e) .. ")",2)
    end
  else
    error("bad argument #1: (string expected, got " .. type(g) .. ")",2)
  end
end

function INIFile:getGroup(g)
  return self.groups[g]
end

function INIFileGroup:addGroup(name)
  --self.groups[name] = INIFileGroup.new(name)
  table.add(self.groups,INIFileGroup.new(name))
end

function INIFileGroup:removeGroup(g)
  if type(g) == "string" then
    local Index = 0

    for i=1,table.getn(self.groups) do
      if self.groups[i]:getName() == g then
        Index = i
        break
      end
    end

    if Index ~= 0 then
      table.remove(self.groups,Index)
    else
      error("Cannot find group \'" .. g .. "\'",2)
    end
  else
    error("bad argument #1: (string expected, got " .. type(g) .. ")",2)
  end
end