function requireC(file)
  local path = {
    file,
    file .. ".lua",
    file .. ".lc",
    "./" .. file,
    "./" .. file .. ".lua",
    "./" .. file .. ".lc"
  }
  
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
        if Value then
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

  for i=1,table.getn(path) do
    local result,err = loadfile(path[i])
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
  
  local error_txt = {}
  
  table.insert(error_txt,"module \'" .. file .. "\' not found:")
  table.insert(error_txt,"    no field package.preload\[\'" .. file .. "\'\]")
  for i=1,table.getn(path) do
    table.insert(error_txt,"    no file \'" .. path[i] .. "\'")
  end
  table.insert(error_txt,"Check stderr.txt to see what might have gone wrong in loading the lua file.")

  file = io.open("stderr.txt","w")
  file:write(table.concat (error_txt,"\n") .. "\n\n--Loading Errors--\n" .. table.concat (error_txt2,"\n") .. "\n\n--Runtime Errors--" .. table.concat (error_txt3,"\n"))
  file:flush()
  file:close()

  error (table.concat (error_txt,"\n"),2)
end