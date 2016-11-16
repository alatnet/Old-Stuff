--*************************************************************************************************
-- Angelic Layer MMO (ALMMO) Lua Game
-- Coded by by alatnet
--*************************************************************************************************

--[[
function send_login()
  local socket, err = Socket.connect(NET.databases.login, 80)
  while not socket:isConnected() do
    screen.waitVblankStart()
  end

  local bytesSent
  if NET.auto_login.val then
    bytesSent = socket:send("GET /ALMMO/php/psp/login.php?usr=" .. NET.auto_login.username .. "&pass=" .. NET.auto_login.password .. " HTTP/1.0\r\n")
  else
    bytesSent = socket:send("GET /ALMMO/php/psp/login.php?usr=" .. NET.username .. "&pass=" .. NET.password .. " HTTP/1.0\r\n")
  end
  
  bytesSent = socket:send("host: " .. NET.databases.login .. "\r\n\r\n")
  
  local total = ""
  local header = ""
  while true do
    buffer = socket:recv()
    if string.len(buffer) > 0 then
      header = header .. buffer
      startIndex, endIndex = string.find(header, "\r\n\r\n")
      if endIndex then
        total = string.sub(header, endIndex+1)
        break
      end
    end
    screen.waitVblankStart()
--    if start1() then
--      socket:close()
--      return
--    end
  end

  if total == "0" then --Login OK!
    socket:close()
    return 0
  elseif total == "1" then --Error! No username supplied.
    NET.error.str = "Error! No username supplied."
    NET.error.display = true
    socket:close()
    return -1
  elseif total == "2" then --Error! No password supplied.
    NET.error.str = "Error! No password supplied."
    NET.error.display = true
    socket:close()
    return -1
  elseif total == "-1" then
    NET.error.str = "Error!  Username and/or Password is incorrect."
    NET.error.display = true
    socket:close()
    return -1
  else
    NET.error.str = total
    NET.error.display = true
    socket:close()
    return -1
  end
end

function retrieve_server_list()
  local socket, err = Socket.connect(NET.databases.serverlist, 80)
  while not socket:isConnected() do
    screen.waitVblankStart()
  end

  local bytesSent
  bytesSent = socket:send("GET /ALMMO/php/psp/serverlist.php HTTP/1.0\r\n")
  bytesSent = socket:send("host: " .. NET.databases.serverlist .. "\r\n\r\n")
  local total = ""
  local header = ""
  while true do
    buffer = socket:recv()
    if string.len(buffer) > 0 then
      header = header .. buffer
      startIndex, endIndex = string.find(header, "\r\n\r\n")
      if endIndex then
        total = string.sub(header, endIndex+1)
      end
    end
    screen.waitVblankStart()
  end
  local ServerList = io.open("ServerList.lst","w")
  ServerList:write(total)
  ServerList:close()
  dofile "ServerList.lst"
  load_server_list()     
  table.insert (NET.servers.sel, {name="Back",IP="0.0.0.0",port=-1,num_ppl=-1,max_ppl=-1,num_games=-1})
end
]]--

function display_net_error(xpos,ypos,img)
  img = img or screen
  if NET.error.display then
    img:print(xpos,ypos,NET.error.str,red)
  end
end


--[[ COROUTINES ]]--
--[[
function create_send_login_co()
  local co = coroutine.create(
    function ()
      local socket, err = Socket.connect(NET.databases.login, 80)
      while not socket:isConnected() do
        screen.waitVblankStart()
        coroutine.yield(99)
      end
    
      local bytesSent
      if NET.auto_login.val then
        bytesSent = socket:send("GET /ALMMO/php/psp/login.php?usr=" .. NET.auto_login.username .. "&pass=" .. NET.auto_login.password .. " HTTP/1.0\r\n")
      else
        bytesSent = socket:send("GET /ALMMO/php/psp/login.php?usr=" .. NET.username .. "&pass=" .. NET.password .. " HTTP/1.0\r\n")
      end
      
      bytesSent = socket:send("host: " .. NET.databases.login .. "\r\n\r\n")
      
      local total = ""
      local header = ""
      local startIndex = nil
      local endIndex = nil

      while socket:isConnected() do
        buffer = socket:recv()
        if string.len(buffer) > 0 then
          header = header .. buffer
          startIndex, endIndex = string.find(header, "\r\n\r\n")
          if endIndex then
            total = string.sub(header, endIndex+1)
            break
          end
        end
        screen.waitVblankStart()
        coroutine.yield(99)
      end
    
      if total == "0" then --Login OK!
        socket:close()
        coroutine.yield(0)
      elseif total == "1" then --Error! No username supplied.
        NET.error.str = "Error! No username supplied."
        NET.error.display = true
        socket:close()
        coroutine.yield(-1)
      elseif total == "2" then --Error! No password supplied.
        NET.error.str = "Error! No password supplied."
        NET.error.display = true
        socket:close()
        coroutine.yield(-1)
      elseif total == "-1" then
        NET.error.str = "Error!  Username and/or Password is incorrect."
        NET.error.display = true
        socket:close()
        coroutine.yield(-1)
      else
        NET.error.str = total
        NET.error.display = true
        socket:close()
        coroutine.yield(-1)
      end
    end
  )
  
  return co
end

function send_login_co_reset_check(co)
  if coroutine.status (co) == "dead" then
    co = create_send_login_co()
  end

  return co
end
]]--

function create_retrieve_server_list_co()
  local co = coroutine.create(
    function ()
      local socket, err = Socket.connect(NET.databases.serverlist, 80)
      while not socket:isConnected() do
        screen.waitVblankStart()
        coroutine.yield(99)
      end
    
      local bytesSent
      bytesSent = socket:send("GET /ALMMO/php/psp/serverlist.php HTTP/1.0\r\n")
      bytesSent = socket:send("host: " .. NET.databases.serverlist .. "\r\n\r\n")
      local total = ""
      local header = ""
      local startIndex = nil
      local endIndex = nil

      local server_list_error_log = io.open("ServerList_error.txt","w")
      local line = 1
      local time_out_timer = Timer.new()
      local curr_time_out_pos = 0
      local time_out_sec = 8
      local ONE_SECOND = 1000

      while socket:isConnected() do
        buffer = socket:recv()
        if string.len(buffer) > 0 then
          server_list_error_log:write(line .. ": " .. buffer)
          line = line + 1

          header = header .. buffer
          startIndex, endIndex = string.find(header, "\r\n\r\n")
          if endIndex then
            total = string.sub(header, endIndex+1)
          end
        end
        --if line == 28 then break end
        
        if time_out_timer:time() >= ONE_SECOND then
          time_out_timer:reset()
          time_out_timer:start()
          curr_time_out_pos = curr_time_out_pos + 1
        end
        
        if curr_time_out_pos == time_out_sec then break end

        screen.waitVblankStart()
        coroutine.yield(99)
      end
      
      server_list_error_log:close()

      local ServerList = io.open("ServerList.lst","w")
      ServerList:write(total)
      ServerList:close()
      
      local func, err = loadfile("ServerList.lst")
      if not func then
        NET.error.str = err
        NET.error.display = true
        coroutine.yield(-1)
      else
        dofile "ServerList.lst"
        load_server_list()
        table.insert (NET.servers.sel, {name="Back",IP="0.0.0.0",port=-1,num_ppl=-1,max_ppl=-1,num_games=-1})
        coroutine.yield(0)
      end
    end
  )

  return co
end

function retrieve_server_list_co_reset_check(co)
  if coroutine.status (co) == "dead" then
    co = create_retrieve_server_list_co()
  end

  return co
end