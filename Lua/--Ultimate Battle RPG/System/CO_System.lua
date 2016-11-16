CO_System = {}

function CO_System.new()
  local c = setmetatable(
    {
      CO = {}
    },
    {
      __index = CO_System
    }
  )

  return c
end

function CO_System:add(co,name)
  self.CO[name]=co
end

function CO_System:kill(name)
  self.CO[name]=nil
  collectgarbage()
end

function CO_System:status(name)
  return corutine.status(self.CO[name])
end

function CO_System:Update()
  for Key, Value in pairs(self.CO) do
    if self.CO[Key] ~= nil then
      if corutine.status(self.CO[Key]) ~= "dead" then
        corutine.resume(self.CO[Key])
      end
    end
  end
end