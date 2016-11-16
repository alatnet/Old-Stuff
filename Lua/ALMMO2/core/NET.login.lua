NET.login = {}

function NET.login.NewCO()
  return coroutine.create(
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
        collectgarbage()
        coroutine.yield(0)
      elseif total == "1" then --Error! No username supplied.
        NET.error.str = "Error! No username supplied."
        NET.error.display = true
        socket:close()
        collectgarbage()
        coroutine.yield(-1)
      elseif total == "2" then --Error! No password supplied.
        NET.error.str = "Error! No password supplied."
        NET.error.display = true
        socket:close()
        collectgarbage()
        coroutine.yield(-1)
      elseif total == "-1" then
        NET.error.str = "Error!  Username and/or Password is incorrect."
        NET.error.display = true
        socket:close()
        collectgarbage()
        coroutine.yield(-1)
      else
        NET.error.str = total
        NET.error.display = true
        socket:close()
        collectgarbage()
        coroutine.yield(-1)
      end
    end
  )
end

function NET.login.new()
  local c = setmetatable(
    {
      CO = NET.login.NewCO()
    },
    {
      __index = NET.login
    }
  )

  return c
end                

function NET.login:update(restart)
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