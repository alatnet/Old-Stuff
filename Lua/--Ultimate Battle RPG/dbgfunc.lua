function SaveEnvironment2File()
  local __G = io.open("_G.txt","w")
  local __LOADED = io.open("_LOADED.txt","w")
  
  local txt = ""

  for Key, Value in pairs(_G) do
    if type(Value) == "string" then txt = Value else txt = type(Value) end
    __G:write(Key .. " = " .. txt .. "\n")
  end
  if _LOADED ~= nil then
    for Key, Value in pairs(_LOADED) do
      if type(Value) == "string" then txt = Value else txt = type(Value) end
      __LOADED:write(Key .. " = " .. txt .. "\n")
    end
  end

  __G:flush()
  __LOADED:flush()

  __G:close()
  __LOADED:close()
end