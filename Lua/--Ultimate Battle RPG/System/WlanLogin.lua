requireC (Global.system.dir.main .. "AnimatedSprite.lc")
requireC (Global.system.dir.main .. "FPSCounter.lua")
requireC (Global.system.dir.main .. "Petals.lua")
requireC (Global.system.dir.main .. "colors.lua")
requireC (Global.system.dir.main .. "Ctrl.lc")
requireC (Global.system.dir.main .. "MsgBox.lc")
requireC (Global.system.dir.main .. "Mouse.lua")
requireC (Global.system.dir.main .. "extraFuncs.lua")

function WlanLogin(Username,Password)
  --[[ Variables ]]--
  local msg_switch_off = MsgBox.new("A connection error has occurred.\nThe WLAN switch is not turned on. ",MsgBox.BACK)
  --local msg_init = MsgBox.new("Connecting to the access point.\nPlease wait...\n\nConnection Name  " .. Global.wlan.configs[Global.wlan.useConfig])
  local msg_gettingIP = MsgBox.new("Obtainin IP address.\nPlease wait... ",MsgBox.CANCEL)
  local msg_IPTimeout = MsgBox.new("A connection error has occurred. \nThe attempt to obtain the IP address timed out. ",MsgBox.BACK)
  local msg_unk_error = MsgBox.new("An unknown error has occurred. ",MsgBox.BACK)
  local msg_connecting = MsgBox.new("Connecting to main server.\nPlease wait... ",MsgBox.CANCEL)
  local msg_working = MsgBox.new("Communicating with main server.\nPlease wait... ",MsgBox.CANCEL)
  local msg_loginOK = MsgBox.new("Successfully Logged in!",MsgBox.CONTINUE)
  local msg_NoUsername = MsgBox.new("Error! No username supplied. ",MsgBox.BACK)
  local msg_NoPassword = MsgBox.new("Error! No password supplied. ",MsgBox.BACK)
  local msg_IncorrectUsrPass = MsgBox.new("Error!  Username and/or Password is incorrect. ",MsgBox.BACK)
  local msg_Cancelling = MsgBox.new("Cancelling.\nPlease wait... ")
  local bool_status,int_ret,ret
  local CANCEL = false
  --local timer = Timer.new()
  --local timeout_length = 5
  --local curr_timeout = 0
  local timeout = {
    val = 5,
    curr = 0,
    timer = Timer.new()
  }
  
  local msg_init_state = {
    MsgBox.new("Connecting to the access point. \nPlease wait...\n\nConnection Name:  " .. Global.wlan.configs[Global.wlan.useConfig] .. "\nConnection State:\n  Shutdowned.\n  0 ",MsgBox.CANCEL),
    MsgBox.new("Connecting to the access point. \nPlease wait...\n\nConnection Name:  " .. Global.wlan.configs[Global.wlan.useConfig] .. "\nConnection State:\n  Initilizing.\n  1 ",MsgBox.CANCEL),
    MsgBox.new("Connecting to the access point. \nPlease wait...\n\nConnection Name:  " .. Global.wlan.configs[Global.wlan.useConfig] .. "\nConnection State:\n  Searching for Access Point.\n  2 ",MsgBox.CANCEL),
    MsgBox.new("Connecting to the access point. \nPlease wait...\n\nConnection Name:  " .. Global.wlan.configs[Global.wlan.useConfig] .. "\nConnection State:\n  Access Point Found!\n  Connecting to Access Point.\n  3 ",MsgBox.CANCEL),
    MsgBox.new("Connecting to the access point. \nPlease wait...\n\nConnection Name:  " .. Global.wlan.configs[Global.wlan.useConfig] .. "\nConnection State:\n  Connected to Access Point!\n 4 ",MsgBox.CANCEL)
  }


  --[[ coroutine ]]--
  local CO = coroutine.create(
    function (Usr,Pass)
      local CANCEL = false
      local recv1,recv2 = "",""
      
      local socket, err = Socket.connect(Global.wlan.database, 80, false)
            
      if err ~= 119 then
        error("Socket Error!  Error Code: " .. err,1)
        Wlan.term()
      end
      
      while not socket:isConnected() and not CANCEL do
        recv1,recv2,CANCEL = coroutine.yield(99)
      end
      
      if not CANCEL then
        local bytesSent
        bytesSent = socket:send("GET " .. Global.wlan.php_pages.path .. Global.wlan.php_pages.login .. "?usr=" .. Usr .. "&pass=" .. Pass .. " HTTP/1.0\r\n")
        bytesSent = socket:send("host: " .. Global.wlan.database .. "\r\n\r\n")
      end
      
      local recieved = ""
      local buffer = ""
      local timeout = {
        val = 5,
        curr = 0,
        timer = Timer.new()
      }
      
      while socket:isConnected() and not CANCEL do
        buffer = socket:recv()
        System.sleep(1)
        if string.len(buffer) > 0 then
          recieved = recieved .. buffer
          timeout.curr = 0
        end

        if timeout.timer:start() >= 1000 then
          timeout.timer:reset()
          timeout.curr = timeout.curr + 1
        end

        if timeout.curr >= timeout.val then
          break
        end
        recv1,recv2,CANCEL = coroutine.yield(98)
      end
      socket:close()
      
      if not CANCEL then
        local total = Global.wlan.strip_header(recieved)
  
        if total == "1" then --Error! No username supplied.
          coroutine.yield(-2)
        elseif total == "2" then --Error! No password supplied.
          coroutine.yield(-3)
        elseif total == "-1" then --Error! Username and/or Password is incorrect.
          coroutine.yield(-1)
        else
          local func, err = loadstring(total)
          if func then
            func()
            if type(Global.data.user) == "table" then
              coroutine.yield(0)
            else
              coroutine.yield(-4)
            end
          else
            coroutine.yield(-4)
          end
        end
      else
        return
      end
    end
  )
  
  --[[ functions ]]--
  --[[
  local Cancelling_func = function ()
    Global.draw.s()
    msg_Cancelling:Draw(((screen:width()/2)-(msg_Cancelling:width()/2)),((screen:height()/2)-(msg_Cancelling:height()/2)))
    Global.draw.e()
    Wlan.term()
  end
  ]]--
  
  local CheckWlanSwitch = function ()
    if Wlan.getSwitchState() == 0 then
      Wlan.term()
      while not Ctrl:Circle1() do
        Global.draw.s()
        msg_switch_off:Draw(((screen:width()/2)-(msg_switch_off:width()/2)),((screen:height()/2)-(msg_switch_off:height()/2)))
        Global.draw.e()
      end
      return -1
    end
  end
  
  local CheckCANCEL = function (CO,Username,Password)
    if Ctrl:Circle1() then
      CANCEL = true
      
      if CO ~= nil then
        local bool_status,int_ret,ret = coroutine.resume(CO,Username,Password,true)
        Global.draw.s()
        msg_Cancelling:Draw(((screen:width()/2)-(msg_Cancelling:width()/2)),((screen:height()/2)-(msg_Cancelling:height()/2)))
        Global.draw.e()
        while bool_status do
          Global.draw.s()
          msg_Cancelling:Draw(((screen:width()/2)-(msg_Cancelling:width()/2)),((screen:height()/2)-(msg_Cancelling:height()/2)))
          Global.draw.e()
          bool_status,int_ret,ret = coroutine.resume(CO,Username,Password,true)
        end
      end

      Wlan.term()
      local ConState,ConErr = Wlan.getConnectionState()
--      local timer = Timer.new()
      while ConState ~= 0 do
        Global.draw.s()
        msg_Cancelling:Draw(((screen:width()/2)-(msg_Cancelling:width()/2)),((screen:height()/2)-(msg_Cancelling:height()/2)))
        Global.draw.e()
--        if timer:start() >= 200 then
--            timer:reset()
            ConState,ConErr = Wlan.getConnectionState()
--        end
      end
      return -1
    end
    return 0
  end
  
  --[[ Main routine ]]--
  --[[ check to see if the wlan switch is on ]]--
  if CheckWlanSwitch() == -1 then
    return -1
  end

  --[[ initilization of wlan ]]--
  Global.draw.s()
  --msg_init:Draw(((screen:width()/2)-(msg_init:width()/2)),((screen:height()/2)-(msg_init:height()/2)))
  msg_init_state[2]:Draw(((screen:width()/2)-(msg_init_state[2]:width()/2)),((screen:height()/2)-(msg_init_state[2]:height()/2)))
  Global.draw.e()

  Wlan.init()
  Wlan.useConnectionConfig(Global.wlan.useConfig + Global.wlan.offset,1)
  local ConState,ConErr = Wlan.getConnectionState()
--  local ConStateTimer = Timer.new()
  while ConState ~= 4 and ConErr == nil do
    if CheckWlanSwitch() == -1 then
      return -1
    end
    Global.draw.s()
    msg_init_state[ConState+1]:Draw(((screen:width()/2)-(msg_init_state[ConState+1]:width()/2)),((screen:height()/2)-(msg_init_state[ConState+1]:height()/2)))
    Global.draw.e()
--    if ConStateTimer:start() >= 200 then
--      ConStateTimer:reset()
      ConState,ConErr = Wlan.getConnectionState()
--    end
    if ConErr ~= nil and ConState == 0 then
      CANCEL = true
      break
    end
    
    if CheckCANCEL() == -1 then
      return -1
    end

    --[[
    if Ctrl:Circle1() then
      CANCEL = true
      Wlan.term()
      ConState,ConErr = Wlan.getConnectionState()
      while ConState ~= 0 do
        Global.draw.s()
        msg_Cancelling:Draw(((screen:width()/2)-(msg_Cancelling:width()/2)),((screen:height()/2)-(msg_Cancelling:height()/2)))
        Global.draw.e()
        ConState,ConErr = Wlan.getConnectionState()
      end
      return -1
    end
    ]]--
  end

  --[[ wait 5 seconds to obtain IP address ]]--
  while not CANCEL do
    if CheckWlanSwitch() == -1 then
      return -1
    end

    if timeout.timer:start() >= 1000 then
      timeout.timer:reset()
      timeout.curr = timeout.curr + 1
      if timeout.curr == timeout.val then
        Wlan.term()
        while not Ctrl:Circle1() do
          Global.draw.s()
          msg_IPTimeout:Draw(((screen:width()/2)-(msg_IPTimeout:width()/2)),((screen:height()/2)-(msg_IPTimeout:height()/2)))
          Global.draw.e()
        end
        return -1
      end
    end
    
    Global.draw.s()
    msg_gettingIP:Draw(((screen:width()/2)-(msg_gettingIP:width()/2)),((screen:height()/2)-(msg_gettingIP:height()/2)))
    Global.draw.e()
    
    if CheckCANCEL() == -1 then
      return -1
    end

    --[[
    if Ctrl:Circle1() then
      CANCEL = true
      Cancelling_func()
      return -1
    end
    ]]--

    if Wlan.getIPAddress() ~= nil then
      break
    end
  end
  
  --local DBGFILE = io.open("WlanLoginDBG.txt","w+")
  
  --[[ run connection coroutine ]]--
  while not CANCEL do
    if CheckWlanSwitch() == -1 then
      return -1
    end

    if CheckCANCEL(CO,Username,Password) == -1 then
      return -1
    end

    --[[
    if Ctrl:Circle1() then
      CANCEL = true
      Cancelling_func()
      bool_status,int_ret,ret = coroutine.resume(CO,Username,Password,true)
      while bool_status do
        Global.draw.s()
        msg_Cancelling:Draw(((screen:width()/2)-(msg_Cancelling:width()/2)),((screen:height()/2)-(msg_Cancelling:height()/2)))
        Global.draw.e()
        bool_status,int_ret,ret = coroutine.resume(CO,Username,Password,true)
      end
      return -1
    end
    ]]--

    --bool_status,int_ret,ret = coroutine.resume(CO)
    bool_status,int_ret,ret = coroutine.resume(CO,Username,Password,false)

    --DBGFILE:write("bool: " .. tostring(bool_status) .. "   ret1: " .. tostring(int_ret) .. "   ret2: " .. tostring(ret) .. "\n")

    Global.draw.s()
    if int_ret == 99 then --Connection
      msg_connecting:Draw(((screen:width()/2)-(msg_connecting:width()/2)),((screen:height()/2)-(msg_connecting:height()/2)))
    elseif int_ret == 98 then --Communicating
      msg_working:Draw(((screen:width()/2)-(msg_working:width()/2)),((screen:height()/2)-(msg_working:height()/2)))
    end
    Global.draw.e()

    if int_ret ~= 99 and int_ret ~= 98 then
      if int_ret == 0 then --Login OK
        Global.sfx.system.logon:play()
        while not Ctrl:Circle1() do
          Global.draw.s()
          msg_loginOK:Draw(((screen:width()/2)-(msg_loginOK:width()/2)),((screen:height()/2)-(msg_loginOK:height()/2)))
          Global.draw.e()
        end
        --DBGFILE:write("LOGIN OK")
        --DBGFILE:close()
        return 0
      elseif int_ret == -1 then --Error! Username and/or Password is incorrect.
        while not Ctrl:Circle1() do
          Global.draw.s()
          msg_IncorrectUsrPass:Draw(((screen:width()/2)-(msg_IncorrectUsrPass:width()/2)),((screen:height()/2)-(msg_IncorrectUsrPass:height()/2)))
          Global.draw.e()
        end
        Wlan.term()
        --DBGFILE:write("USER/PASS INCORRECT")
        --DBGFILE:close()
        return -1
      elseif int_ret == -2 then --Error! No username supplied.
        while not Ctrl:Circle1() do
          Global.draw.s()
          msg_NoUsername:Draw(((screen:width()/2)-(msg_NoUsername:width()/2)),((screen:height()/2)-(msg_NoUsername:height()/2)))
          Global.draw.e()
        end
        Wlan.term()
        --DBGFILE:write("NO USER")
        --DBGFILE:close()
        return -1
      elseif int_ret == -3 then --Error! No password supplied.
        while not Ctrl:Circle1() do
          Global.draw.s()
          msg_NoPassword:Draw(((screen:width()/2)-(msg_NoPassword:width()/2)),((screen:height()/2)-(msg_NoPassword:height()/2)))
          Global.draw.e()
        end
        Wlan.term()
        --DBGFILE:write("NO PASS")
        --DBGFILE:close()
        return -1
      else --Misc Error   if int_ret == -4 then
        while not Ctrl:Circle1() do
          Global.draw.s()
          msg_unk_error:Draw(((screen:width()/2)-(msg_unk_error:width()/2)),((screen:height()/2)-(msg_unk_error:height()/2)))
          Global.draw.e()
        end
        Wlan.term()
        --DBGFILE:write("MISC")
        --DBGFILE:close()
        return -1
      end
    end
  end
  
  if ConErr ~= nil and CANCEL then
    while not Ctrl:Circle1() do
      Global.draw.s()
      msg_unk_error:Draw(((screen:width()/2)-(msg_unk_error:width()/2)),((screen:height()/2)-(msg_unk_error:height()/2)))
      Global.draw.e()
    end
  end
end