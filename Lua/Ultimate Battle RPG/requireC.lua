function requireC(file,reload)
  --[[
  local TMP_LOADED
  local TMP_LUA_PATH

  if string.find(_VERSION, "Lua 5.1") then
    TMP_LOADED = _G["package"]["loaded"]
    TMP_LUA_PATH = _G["package"]["path"]
  else
    TMP_LOADED = _G["_LOADED"]
    TMP_LUA_PATH = _G["LUA_PATH"]
  end
  ]]--
  
  if reload == nil then
    reload = false
  elseif reload == false then
    reload = false
  else
    reload = true
  end

  local path = {
    file,
    file .. ".lua",
    file .. ".lc",
    "./" .. file,
    "./" .. file .. ".lua",
    "./" .. file .. ".lc"
  }

  local si = nil
  local ei = nil
  
  for i=string.len(file),1,-1 do
    if string.sub(file,i,i) == "." then
      ei = i-1
    end
    if string.sub(file,i,i) == "/" then
      si = i+1
      break
    end
  end
  
  if si == nil then
    si = 1
  end
  if ei == nil then
    ei = string.len(file)
  end

  _REQUIREDNAME = string.sub(file,si,ei)
  
  local txt = ""

  if type(LUA_PATH) == "string" then
    for i=1,string.len(LUA_PATH) do
      if string.sub(LUA_PATH,i,i) == ";" then
        table.insert(path,txt)
        txt = ""
      elseif string.sub(LUA_PATH,i,i) == "?" then
        txt = txt .. file
      else
        txt = txt .. string.sub(LUA_PATH,i,i)
      end
    end
  end

  if _LOADED ~= nil then
    for Key, Value in pairs(_LOADED) do
      if Key == file then
        if Value and not reload then
          return true
        end
      end
    end
  else
    _LOADED = {}
  end

  _LOADED[file] = false
  
  local error_txt2 = {}
  local error_txt3 = {}
  local result,err

  for i=1,table.getn(path) do
    result,err = loadfile(path[i])
    if type(err) ~= "nil" then
      table.insert(error_txt2,"loadfile(): "..err)
    end
    if result then
      result,err = pcall(result)
      if type(err) ~= "nil" then
        table.insert(error_txt3,"pcall(): " .. err)
      end
      if result then
        _LOADED[file] = true
        return true
      end
    end
  end
  
  --[[
  if string.find(_VERSION, "Lua 5.1") then
    _G["package"]["loaded"] = TMP_LOADED
    _G["package"]["path"] = TMP_LUA_PATH
  else
    _G["_LOADED"] = TMP_LOADED
    _G["LUA_PATH"] = TMP_LUA_PATH
  end
  ]]--
  
  local error_txt = {}
  
  table.insert(error_txt,"module \'" .. file .. "\' not found:")
  table.insert(error_txt,"    no field package.preload\[\'" .. file .. "\'\]")
  for i=1,table.getn(path) do
    table.insert(error_txt,"    no file \'" .. path[i] .. "\'")
  end
  table.insert(error_txt,"Check stderr.txt to see what might have gone wrong in loading or running the lua file.")

  file = io.open("stderr.txt","w")
  file:write(table.concat (error_txt,"\n") .. "\n\n--Loading Errors--\n" .. table.concat (error_txt2,"\n") .. "\n\n--Runtime Errors--\n" .. table.concat (error_txt3,"\n"))
  file:flush()
  file:close()

  error (table.concat (error_txt,"\n"),2)
end