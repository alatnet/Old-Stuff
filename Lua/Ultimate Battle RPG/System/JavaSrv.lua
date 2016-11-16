JavaSrv = {
  CONNECTING = 0,
  CONNECTED = 1,
  WAITING = 2,
  WORKING = 3,
  HOSTING = 4,
  CLIENT = 5,
  DISCONNECTED = -1,
  FULL = -2,
  SERVER_SHUTDOWN = -3,
  SERVER_ERROR = -4,
  CMD = {
    getList = 1,
    newGame = 2,
    removeGame = 3,
    connectGame = 4,
    disconnectGame = 5,
    close = 6
  }
}

function JavaSrv.COFUNC(SOCK,name)
  local BUFF = nil
  local command,arg1,arg2,arg3
  local ret
  local STATE = JavaSrv.WAITING
  
  --[[ funcs start ]]--
  local getList = function ()
    SOCK:send("getLIST\n")
    
    local BUFFSTR = ""
    local WAIT = 0
    local WAITLIM = 30
    
    while true do
      BUFF = SOCK:recv()
      System.sleep(1)

      if BUFF == nil or BUFF == "" or string.len(BUFF) == 0 then
        BUFF = ""
        WAIT = WAIT + 1
      elseif BUFF == "ArrayName" then
        SOCK:send(arg1 .. "\n")
        WAIT = 0
      else
        BUFFSTR = BUFFSTR .. BUFF
        WAIT = 0
      end

      if WAIT == WAITLIM then
        break
      end
      
      coroutine.yield(JavaSrv.WORKING)
    end
    
    --[[ loadstring(str) returns func/nil,nil/err ]]--
    
    local func, err = loadfile("JavaSrv.cache")
    if func then
      os.remove("JavaSrv.cache")
      func = nil
      err = nil
    end
    
    local Cache = io.open("JavaSrv.cache","w")
    Cache:write(BUFFSTR)
    Cache:flush()
    Cache:close()
    
    func, err = loadfile("JavaSrv.cache")
    if func then
      func()
    else
      error(err,1)
    end
  end
  
  local newGame = function ()
    SOCK:send("newGAME\n")
    local WAIT = 0
    local WAITLIM = 30
    
    while true do
      BUFF = SOCK:recv()
      System.sleep(1)
    
      if BUFF == nil or BUFF == "" or string.len(BUFF) == 0 then
        BUFF = ""
        WAIT = WAIT + 1
      elseif BUFF == "REQUEST_TITLE" then
        SOCK:send(arg1 .. "\n")
        WAIT = 0
      elseif BUFF == "REQUEST_DETAILS" then
        SOCK:send(arg2 .. "\n")
        WAIT = 0
      elseif BUFF == "REQUEST_PORT" then
        SOCK:send(arg3 .. "\n")
        WAIT = 0
      elseif BUFF == "GAME_OK" then
        STATE = JavaSrv.HOSTING
        coroutine.yield(JavaSrv.HOSTING)
        break
      end
    
      if WAIT == WAITLIM then
        break
      end
    
      coroutine.yield(JavaSrv.WORKING)
    end
  end
  
  local removeGame = function ()
    SOCK:send("removeGAME\n")
    local WAIT = 0
    local WAITLIM = 30
    
    while true do
      BUFF = SOCK:recv()
      System.sleep(1)
    
      if BUFF == nil or BUFF == "" or string.len(BUFF) == 0 then
        BUFF = ""
        WAIT = WAIT + 1
      elseif BUFF == "GAME_OK" then
        STATE = JavaSrv.WAITING
        coroutine.yield(JavaSrv.WAITING)
        break
      end
    
      if WAIT == WAITLIM then
        break
      end
    
      coroutine.yield(JavaSrv.WORKING)
    end
  end

  local connectGame = function ()
    SOCK:send("connectGAME\n")
    local WAIT = 0
    local WAITLIM = 30
    
    while true do
      BUFF = SOCK:recv()
      System.sleep(1)
    
      if BUFF == nil or BUFF == "" or string.len(BUFF) == 0 then
        BUFF = ""
        WAIT = WAIT + 1
      elseif BUFF == "REQUEST_HOST" then
        SOCK:send(arg1 .. "\n")
        WAIT = 0
      elseif BUFF == "CONNECTION_OK" then
        STATE = JavaSrv.CLIENT
        coroutine.yield(JavaSrv.CLIENT)
        break
      elseif BUFF == "CONNECTION_FAIL" then
        coroutine.yield(JavaSrv.FULL)
        break
      end
    
      if WAIT == WAITLIM then
        break
      end
    
      coroutine.yield(JavaSrv.CONNECTING)
    end
  end
  
  local disconnectGame = function ()
    SOCK:send("disconnectGAME\n")
    local WAIT = 0
    local WAITLIM = 30
    
    while true do
      BUFF = SOCK:recv()
      System.sleep(1)
    
      if BUFF == nil or BUFF == "" or string.len(BUFF) == 0 then
        BUFF = ""
        WAIT = WAIT + 1
      elseif BUFF == "REQUEST_HOST" then
        SOCK:send(arg1 .. "\n")
        WAIT = 0
      elseif BUFF == "DISCONNECTED" then
        STATE = JavaSrv.WAITING
        coroutine.yield(JavaSrv.WAITING)
        break
      end
    
      if WAIT == WAITLIM then
        break
      end
    
      coroutine.yield(JavaSrv.WORKING)
    end
  end
  --[[ funcs end ]]--
  
  while not SOCK:isConnected() do
    coroutine.yield(JavaSrv.CONNECTING)
    System.sleep(1)
  end

  while SOCK:isConnected() do
    BUFF = SOCK:recv()
    System.sleep(1)
    if BUFF == nil then
      BUFF = ""
    end
    
    if string.find(BUFF, "OK") then
      coroutine.yield(JavaSrv.CONNECTING)
    elseif string.find(BUFF, "REQUEST_NAME") then
      SOCK:send(name .. "\n")
      coroutine.yield(JavaSrv.CONNECTING)
    elseif string.find(BUFF, "CONNECTED") then
      coroutine.yield(JavaSrv.CONNECTED)
      break
    elseif string.find(BUFF, "FULL") then
      coroutine.yield(JavaSrv.FULL)
      ret = JavaSrv.SERVER_FULL
      SOCK:close()
      break
    elseif string.find(BUFF, "SERVER_SHUTDOWN") then
      coroutine.yield(JavaSrv.SERVER_SHUTDOWN)
      ret = JavaSrv.SERVER_SHUTDOWN
      SOCK:close()
      break
    elseif string.find(BUFF, "SERVER_ERROR") then
      coroutine.yield(JavaSrv.SERVER_ERROR)
      ret = JavaSrv.SERVER_ERROR
      SOCK:close()
      break
    else
      coroutine.yield(JavaSrv.CONNECTING)
    end
  end
  
  while SOCK:isConnected() do
    BUFF = SOCK:recv()
    System.sleep(1)
    
    if BUFF == nil then
      BUFF = ""
    end

    if string.find(BUFF, "SERVER_SHUTDOWN") then
      coroutine.yield(JavaSrv.SERVER_SHUTDOWN)
      ret = JavaSrv.SERVER_SHUTDOWN
      break
    elseif string.find(BUFF, "SERVER_ERROR") then
      coroutine.yield(JavaSrv.SERVER_ERROR)
      ret = JavaSrv.SERVER_ERROR
      break
    end
    
    --command,arg1,arg2,arg3 = coroutine.yield(JavaSrv.WAITING)
    command,arg1,arg2,arg3 = coroutine.yield(STATE)
    
    if command == JavaSrv.CMD.getList then
      getList()
    elseif command == JavaSrv.CMD.newGame then
      if STATE == JavaSrv.WAITING then
        newGame()
      end
    elseif command == JavaSrv.CMD.removeGame then
      if STATE == JavaSrv.HOSTING then
        removeGame()
      end
    elseif command == JavaSrv.CMD.connectGame then
      if STATE == JavaSrv.WAITING then
        connectGame()
      end
    elseif command == JavaSrv.CMD.disconnectGame then
      if STATE == JavaSrv.CLIENT then
        disconnectGame()
      end
    elseif command == JavaSrv.CMD.close then
      SOCK:send("LEAVE\n")
      --coroutine.yield(JavaSrv.DISCONNECTED)
      ret = JavaSrv.DISCONNECTED
      break
    end
  end

  SOCK:close()

  return ret
end

function JavaSrv.new(host,port,name)
  local c = setmetatable(
    {
      CO = coroutine.wrap(JavaSrv.COFUNC),
      STATUS = JavaSrv.DISCONNECTED,
      HOST = host,
      PORT = port,
      NAME = name,
      SOCK = nil,
      TIME = {
        day = 0,
        hour = 0,
        min = 0,
        sec = 0,
        timer = Timer.new()
      }
    },
    {
      __index = JavaSrv
    }
  )

  local err
  c.SOCK,err = Socket.connect(host, port)

  if err then
    error("Socket Error!  Error Code: " .. err,2)
  end

  c.STATUS = c.CO(c.SOCK,name)

  return c
end

function JavaSrv:update()
  if coroutine.status (self.CO) ~= "dead" then
    self.STATUS = self.CO()
  end

  if self.TIME.timer:start() >= 1000 then
    self.TIME.timer:reset()
    self.TIME.sec = self.TIME.sec + 1
  end

  if self.TIME.sec >= 60 then
    self.TIME.sec = 0
    self.TIME.min = self.TIME.min + 1
  end

  if self.TIME.min >= 60 then
    self.TIME.min = 0
    self.TIME.hour = self.TIME.hour + 1
  end
  
  if self.TIME.hour >= 24 then
    self.TIME.hour = 0
    self.TIME.day = self.TIME.day + 1
  end
end

function JavaSrv:status()
  return self.STATUS,coroutine.status(self.CO)
end

function JavaSrv:isConnected()
  return (self.STATUS > 0),self.SOCK:isConnected()
end

function JavaSrv:time()
  local ret = self.TIME.day .. ":" .. self.TIME.hour .. ":"
  
  if self.TIME.min < 10 then
    ret = ret .. "0" .. self.TIME.min .. ":"
  else
    ret = ret .. self.TIME.min .. ":"
  end
  
  if self.TIME.sec < 10 then
    ret = ret .. "0" .. self.TIME.sec
  else
    ret = ret .. self.TIME.sec
  end
  
  return ret
end

function JavaSrv:getList(arrayname)
  if self.STATUS == JavaSrv.WAITING then
    self.STATUS = self.CO(JavaSrv.CMD.getList,arrayname)
  end
end

function JavaSrv:newGame(title,details,port)
  if self.STATUS == JavaSrv.WAITING then
    self.STATUS = self.CO(JavaSrv.CMD.newGame,title,details,port)
    return Socket.createServerSocket(port)
  end

  return nil
end

function JavaSrv:removeGame()
  if self.STATUS == JavaSrv.WAITING then
    self.STATUS = self.CO(JavaSrv.CMD.removeGame)
  end
end

function JavaSrv:connectGame(host)
  if self.STATUS == JavaSrv.WAITING then
    self.STATUS = self.CO(JavaSrv.CMD.connectGame,host)
  end
end

function JavaSrv:disconnectGame(host)
  if self.STATUS == JavaSrv.WAITING then
    self.STATUS = self.CO(JavaSrv.CMD.disconnectGame,host)
  end
end

--[[
function JavaSrv:reconnect()
  self.CO = nil
  collectgarbage()
  self.CO = 
  self.STATUS = coroutine.resume(self.CO,self.HOST,self.PORT,self.NAME)
end
]]--

function JavaSrv:close()
  if self.STATUS == JavaSrv.WAITING then
    self.STATUS = self.CO(JavaSrv.CMD.close)
    self.CO = nil
    self.SOCK = nil
  end
end