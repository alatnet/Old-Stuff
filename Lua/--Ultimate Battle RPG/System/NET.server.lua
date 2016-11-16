NET.server = {}

function NET.server.NewCO()
  return coroutine.create(
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

      --local server_list_error_log = io.open("ServerList_error.txt","w")
      local line = 1
      local time_out_timer = Timer.new()
      local curr_time_out_pos = 0
      local time_out_sec = 8
      local ONE_SECOND = 1000

      while socket:isConnected() do
        buffer = socket:recv()
        if string.len(buffer) > 0 then
         --server_list_error_log:write(line .. ": " .. buffer)
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

      --server_list_error_log:close()

      -- temporary file for server list?
      --[[
      lst = io.tmpfile()
      lst:write(total)
      lst:flush()
      ]]--

      local func, err = loadfile("ServerList.lst")
      if func then
        os.remove("ServerList.lst")
        func = nil
        err = nil
      end

      local ServerList = io.open("ServerList.lst","w")
      ServerList:write(total)
      ServerList:flush()
      ServerList:close()

      func, err = loadfile("ServerList.lst")
      if not func then
        NET.error.str = err
        NET.error.display = true
        collectgarbage()
        coroutine.yield(-1)
      else
        --dofile "ServerList.lst"
        func()
        load_server_list()
        table.insert (NET.servers.sel, {name="Back",IP="0.0.0.0",port=-1,num_ppl=-1,max_ppl=-1,num_games=-1})
        collectgarbage()
        coroutine.yield(0)
      end
    end
  )
end

function NET.server.new()
  local c = setmetatable(
    {
      CO = NET.server.NewCO()
    },
    {
      __index = NET.server
    }
  )

  return c
end                

function NET.server:update(restart)
  restart = restart or false
  local bool_status = true
  local int_ret = nil

  if coroutine.status (self.CO) == "dead" and restart then
    self.CO = self.NewCO()
  end

  local bool_status,int_ret = coroutine.resume(self.CO)

  if coroutine.status (self.CO) == "dead" and restart then
    self.CO = self.NewCO()
    bool_status,ret = coroutine.resume(self.CO)
  end
  
  return int_ret
end
