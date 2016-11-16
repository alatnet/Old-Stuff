if Global.system.dir.main == nil then
  requireC("TimeoutTimer.lua")
else
  requireC(Global.system.dir.main .. "TimeoutTimer.lua")
end

PJS = {
  ARG_SEP = "\t\t\t",
  STATUS = {
    --to be implemented in the server
    -- SERVER_SHUTDOWN = -,
    -- SERVER_ERROR = -,
    GAMECONERR = -9,
    TO_GConnect = -7,
    TO_GCreate = -6,
    TO = -5,
    SOCKERR = -4,
    FULL = -3,
    CLOSED = -2,
    DISCONNECTED = -1,
    CONNECTING = 0,
    WAITING = 1,
    WORKING = 2,
    LIST = 3,
    HOST = 4,
    CLIENT = 5
  },
  CMD = {
    CANCEL = -3,
    SET_TIMEOUT = -2,
    CLOSE = -1,
    -----------
    WAIT = 0,
    LISTGAMES = 1,
    NEWGAME = 2,
    DELETEGAME = 3,
    CONNECTGAME = 4,
    DISCONNECTGAME = 5
  }
}

function PJS.CoroutineFunc(host,port,usrname,usrmd5id,timeoutLimit)
  --[[ Variables Start ]]--
  local SOCK,ERR = nil,nil
  local BUFF = ""
  local timeout = TimeoutTimer.new(timeoutLimit or 30)
  local Host = false
  local Client = false
  local CMD = {
    CANCEL = false
    CLOSE = false,
    LISTGAMES = false,
    NEWGAME = false,
    DELETEGAME = false,
    CONNECTGAME = false,
    DISCONNECTGAME = false,
    args = nil
  }

  local function CMD.checkCommands(cmd,args)
    CMD.CANCEL = false
    CMD.CLOSE = false
    CMD.LISTGAMES = false
    CMD.NEWGAME = false
    CMD.DELETEGAME = false
    CMD.CONNECTGAME = false
    CMD.DISCONNECTGAME = false
    CMD.PING = false
    CMD.args = nil

    if cmd == PJS.CMD.CANCEL then
      CMD.CANCEL = true
    elseif cmd == PJS.CMD.SET_TIMEOUT then
      timeout:setTimeout(args)
      timeoutLimit = args
    elseif cmd == PJS.CMD.CLOSE then
      CMD.CLOSE = true
    elseif cmd == PJS.CMD.LISTGAMES then
      CMD.LISTGAMES = true
    elseif cmd == PJS.CMD.NEWGAME then
      CMD.NEWGAME = true
    elseif cmd == PJS.CMD.DELETEGAME then
      CMD.DELETEGAME = true
    elseif cmd == PJS.CMD.CONNECTGAME then
      CMD.CONNECTGAME = true
    elseif cmd == PJS.CMD.DISCONNECTGAME then
      CMD.DISCONNECTGAME = true
    end

    CMD.args = args
  end
  --[[ Variables End ]]--

  --coroutine.yield(status,socketConnected,serverConnected,gamelist)
  coroutine.yield(PJS.STAUS.DISCONNECTED,false,false)

  --[[ Create the socket ]]--
  -------------------------------------------------------------------
  SOCK,ERR = Socket.connect(host,port)
  if ERR ~= 119 then
    return PJS.STATUS.SOCKERR,ERR
  end
  -------------------------------------------------------------------

  --[[ Connect to the server ]]--
  -------------------------------------------------------------------
  while not timeout:start() and not SOCK:isConnected() do
    CMD.checkCommands(coroutine.yield(PJS.STAUS.CONNECTING,false,false))
    if CMD.CLOSE then
      SOCK:close()
      return PJS.STAUS.CLOSED,false,false
    end
    System.sleep(1)
  end
  -------------------------------------------------------------------

  --[[ Timeout Check ]]--
  -------------------------------------------------------------------
  if timeout:isTimedOut() then
    SOCK:close()
    return PJS.STATUS.TO,false,false
  end

  timeout:reset()

  CMD.checkCommands(coroutine.yield(PJS.STAUS.CONNECTING,true,false))
  if CMD.CLOSE then
    SOCK:close()
    return PJS.STAUS.CLOSED,false,false
  end
  -------------------------------------------------------------------

  --[[ Check to see if the server isnt full and register with it ]]--
  -------------------------------------------------------------------
  while not timeout:start() and SOCK:isConnected() do
    BUFF = SOCK:recv()
    System.sleep(1)

    if BUFF == nil then
      BUFF = ""
    end

    if string.find(BUFF, "CONNECTION_OK") then
      SOCK:send("USER" .. PJS.ARG_SEP .. usrname .. PJS.ARG_SEP .. usrmd5id .. "\n")
      timeout:reset()
    elseif string.find(BUFF, "INFO_RECIEVED") then
      break
    elseif string.find(BUFF, "SERVERFULL") then
      SOCK:close()
      return PJS.STATUS.FULL,false,false
    end --elseif string.find(BUFF, "") then

    CMD.checkCommands(coroutine.yield(PJS.STAUS.CONNECTING,true,false))
    if CMD.CLOSE then
      SOCK:close()
      return PJS.STAUS.CLOSED,false,false
    end
  end
  -------------------------------------------------------------------

  --[[ Timeout Check ]]--
  -------------------------------------------------------------------
  if timeout:isTimedOut() then
    SOCK:close()
    return PJS.STATUS.TO,false,false
  end

  timeout:reset()
  
  CMD.checkCommands(coroutine.yield(PJS.STAUS.WAITING,true,true))
  if CMD.CLOSE then
    SOCK:send("LEAVE\n")
    SOCK:close()
    return PJS.STAUS.CLOSED,false,false
  end
  -------------------------------------------------------------------

  --[[ Communication between the server ]]--
  -------------------------------------------------------------------
  while SOCK:isConnected() do
    BUFF = SOCK:recv()
    System.sleep(1)
    
    if BUFF == nil then
      BUFF = ""
    end
    
    if string.find(BUFF, "GAME_DELETED") then
      Client = false
    end

    if not Host and not Client then
      CMD.checkCommands(coroutine.yield(PJS.STAUS.WAITING,true,true))
    elseif Host then
      CMD.checkCommands(coroutine.yield(PJS.STAUS.HOST,true,true))
    elseif Client then
      CMD.checkCommands(coroutine.yield(PJS.STAUS.CLIENT,true,true))
    end

    if CMD.CLOSE then  -- Disconnect from the server and close the socket.
      SOCK:send("LEAVE\n")
      SOCK:close()
      return PJS.STAUS.CLOSED,false,false
    elseif CMD.LISTGAMES then  -- Get a list of current games from the server.
      SOCK:send("LISTGAMES\n")
      timeout:reset()
      local recvLst = ""
      local cancel = false
      while not timeout:start() do
        BUFF = SOCK:recv()
        System.sleep(1)
        if BUFF == nil or BUFF == "" or string.len(BUFF) == 0 then
          BUFF = ""
        else
          recvLst = recvLst .. BUFF
          timeout:reset()
        end
        CMD.checkCommands(coroutine.yield(PJS.STAUS.WORKING,true,true))
        if CMD.CANCEL then
          cancel = true
          break
        end
      end
      
      if not cancel then
        local func,err = loadstring(recvLst)
        if func then
          coroutine.yield(PJS.STAUS.LIST,true,true,func())
        else
          error(err,1)
        end
      end
    elseif CMD.NEWGAME then  -- Create a game.  (Returns GAME_CREATED)  SYNTAX: NEWGAME port miscData name
      SOCK:send("DELETEGAME\n")
      SOCK:send("NEWGAME" .. PJS.ARG_SEP .. CMD.args[2] .. PJS.ARG_SEP .. CMD.args[3] .. PJS.ARG_SEP .. CMD.args[1] .. "\n")
      timeout:reset()
      local cancel = false
      while not timeout:start() do
        BUFF = SOCK:recv()
        System.sleep(1)
        if BUFF == nil or BUFF == "" or string.len(BUFF) == 0 then
          BUFF = ""
        elseif string.find(BUFF,"GAME_CREATED") then
          CMD.checkCommands(coroutine.yield(PJS.STAUS.HOST,true,true))
          Host = true
          break
        end
        coroutine.yield(PJS.STAUS.WORKING,true,true)
      end

      if timeout:isTimedOut() then
        coroutine.yield(PJS.STAUS.TO_GCreate,true,true)
      end
    elseif CMD.DELETEGAME then  -- Delete game created on the server.
      if Host then
        SOCK:send("DELETEGAME\n")
        Host = false
      end
    elseif CMD.CONNECTGAME then  -- Connect to a game.  (Returns GAME_CONNECTED if connected or GAME_CON_ERROR if connection failed)  SYNTAX: CONNECTGAME md5id
      SOCK:send("CONNECTGAME" .. PJS.ARG_SEP .. CMD.args .. "\n")
      timeout:reset()
      local cancel = false
      while not timeout:start() do
        BUFF = SOCK:recv()
        System.sleep(1)
        if BUFF == nil or BUFF == "" or string.len(BUFF) == 0 then
          BUFF = ""
        elseif string.find(BUFF,"GAME_CONNECTED") then
          coroutine.yield(PJS.STAUS.CLIENT,true,true)
          Client = true
          break
        elseif string.find(BUFF,"GAME_CON_ERROR") then
          coroutine.yield(PJS.STATUS.GAMECONERR,true,true)
          break
        end
        CMD.checkCommands(coroutine.yield(PJS.STAUS.WORKING,true,true))
        if CMD.CANCEL then
          cancel = true
          SOCK:send("DISCONNECTGAME\n")
          break
        end
      end

      if timeout:isTimedOut() then
        SOCK:send("DISCONNECTGAME\n")
        coroutine.yield(PJS.STAUS.TO_GConnect,true,true)
      end
    elseif CMD.DISCONNECTGAME then
      if Client then
        SOCK:send("DISCONNECTGAME\n")
        Client = false
      end
    end
  end
  -------------------------------------------------------------------
end

function PJS.connect(host,port,usr_name,usr_md5id,timeoutLimit)
  local c = setmetatable(
    {
      host = host or "",
      port = port or 0,
      gamelist = nil,
      CO = coroutine.wrap(PJS.CoroutineFunc),
      timeoutLimit = timeoutLimit or 30,
      cmd = PJS.CMD.WAIT,
      args = nil,
      game = {
        sock = nil,
        ip = "",
        port = 0
      },
      usr = {
        name = usr_name or "",
        md5id = usr_md5id or ""
      },
      status = {
        sockConnected = false,
        serverConnected = false,
        co = PJS.STATUS.DISCONNECTED,
        sockErr = nil
      }
    },
    {
      __index = PJS
    }
  )
  
  c.CO(host,port,usr_name,usr_md5id,timeoutLimit)

  return c
end

function PJS:isConnected()
  return self.status.sockConnected and self.status.serverConnected and (self.status.co ~= PJS.STATUS.DISCONNECTED) and (self.status.co ~= PJS.STATUS.CLOSED) and (self.status.co ~= PJS.STATUS.FULL) and (self.status.co ~= PJS.STATUS.TO) and (self.status.co ~= PJS.STATUS.SOCKERR)
end

function PJS:status()
  return self.status.co,self.status.sockConnected,self.status.serverConnected,self.status.sockErr
end

function PJS:update()
  local ret1,ret2
  if coroutine.status(self.CO) ~= "dead" then
    self.status.co,ret1,self.status.serverConnected,ret2 = self.CO(self.cmd,self.args)
    if type(ret1) == "boolean" then
      self.status.sockConnected = ret1
    end
    
    if self.status.co == PJS.STATUS.LIST then
      self.gamelist = ret2
    elseif self.status.co == PJS.STATUS.HOST then
      if self.game.sock == nil then
        self.game.sock = Socket.createServerSocket(self.game.port)
      end
    elseif self.status.co == PJS.STATUS.CLIENT then
      if self.game.sock == nil then
        self.game.sock = Socket.connect(self.game.ip,self.game.port)
      end
    elseif self.status.co == PJS.STATUS.SOCKERR then
      self.status.sockErr = ret1
    end
  end

  self.cmd = PJS.CMD.WAIT
  self.args = nil
end

function PJS:updateList()
  self.cmd = PJS.CMD.LISTGAMES
end

function PJS:getList()
  return self.gamelist
end

function PJS:newGame(title,port,miscData)
  local strMiscData = "{}"
  
  if type(miscData) == "string" then
    strMiscData = miscData
  elseif type(miscData) == "table" then
    strMiscData = "{"
    for key,val in pairs(miscData) do
      strMiscData = strMiscData .. key .. "=" .. val .. ","
    end
    strMiscData = strMiscData .. "}"
  end

  self.cmd = PJS.CMD.NEWGAME
  self.args = {title,port,strMiscData}
  self.game.port = port
end

function PJS:removeGame()
  self.cmd = PJS.CMD.DELETEGAME
  self.game.port = 0
  self.game.sock:close()
  self.game.sock = nil
end

function PJS:connectGame(md5ID)
  self.cmd = PJS.CMD.CONNECTGAME
  self.args = md5ID
  
  for i=1,table.getn(self.gamelist) do
    if self.gamelist[i].ID == md5ID then
      self.game.ip = self.gamelist[i].IP
      self.game.port = self.gamelist[i].Port
      break
    end
  end
end

function PJS:disconnectGame()
  self.cmd = PJS.CMD.DISCONNECTGAME
  self.game.ip = ""
  self.game.port = 0
  self.game.sock:close()
  self.game.sock = nil
end

function PJS:cancel()
  self.cmd = PJS.CMD.CANCEL
end

function PJS:setTimeout(timeout)
  self.cmd = PJS.CMD.SET_TIMEOUT
  self.args = timeout or 30
end

function PJS:gameSocket()
  return self.game.sock
end

function PJS:close()
  self.cmd = PJS.CMD.CLOSE
end

function PJS:reconnect()
  if coroutine.status(self.CO) == "dead" then
    self.CO = coroutine.wrap(PJS.CoroutineFunc)
    self.status.co,self.status.sockConnected,self.status.serverConnected = self.CO(self.host,self.port,self.usr.name,self.usr.md5id,self.timeoutLimit)
  end
end