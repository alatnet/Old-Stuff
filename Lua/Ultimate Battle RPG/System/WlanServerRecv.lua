requireC (Global.system.dir.main .. "AnimatedSprite.lua")
requireC (Global.system.dir.main .. "FPSCounter.lua")
requireC (Global.system.dir.main .. "Petals.lua")
requireC (Global.system.dir.main .. "colors.lua")
requireC (Global.system.dir.main .. "Ctrl.lua")
requireC (Global.system.dir.main .. "MsgBox.lua")
requireC (Global.system.dir.main .. "Mouse.lua")
requireC (Global.system.dir.main .. "extraFuncs.lua")

function WlanServers()
  local msg_switch_off = MsgBox.new("A connection error has occurred.\nThe WLAN switch is not turned on.",MsgBox.BACK)
  local msg_connecting = MsgBox.new("Connecting to main server.\nPlease wait...",MsgBox.CANCEL)
  local msg_working = MsgBox.new("Communicating with main server.\nPlease wait...",MsgBox.CANCEL)
  --local msg_recieving = MsgBox.new("Recieving list of servers\nPlease wait...",MsgBox.CANCEL)
  local msg_Cancelling = MsgBox.new("Cancelling.\nPlease wait...")
  local bool_status,int_ret,ret
  local CANCEL = false

  --[[ coroutine ]]--
  local CO = coroutine.create(
    function ()
      local socket, err = Socket.connect(Global.wlan.database, 80)
      
      if err ~= 119 then
        error("Socket Error!  Error Code: " .. err,1)
      end
      
      while not socket:isConnected() do
        coroutine.yield(99)
      end

      local bytesSent
      bytesSent = socket:send("GET " .. Global.wlan.php_pages.path .. Global.wlan.php_pages.servers .. " HTTP/1.0\r\n")
      bytesSent = socket:send("host: " .. Global.wlan.database .. "\r\n\r\n")

      local total = ""
      local recieved = ""
      local buffer = ""
      local timeout = {
        val = 5,
        curr = 0,
        timer = Timer.new()
      }
      local timer = Timer.new()
      local timeout = 5
      local curr_timeout = 0
      
      while socket:isConnected() do
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
        coroutine.yield(98)
      end
      socket:close()

      total = Global.wlan.strip_header(header)

      if string.len(total) > 0 then
        local func, err = loadstring(total)
        if func then
          func()
          if type(Global.data.servers) == "table" then
            coroutine.yield(0) -- Recieved list of servers
          else
            coroutine.yield(-1,total) -- Error Recieving list of servers
          end
        else
          coroutine.yield(-1,total) -- Error Recieving list of servers
        end
      end
    end
  )
  
  local Cancelling_func = function ()
    Global.draw.s()
    msg_Cancelling:Draw(((screen:width()/2)-(msg_Cancelling:width()/2)),((screen:height()/2)-(msg_Cancelling:height()/2)))
    Global.draw.e()
    Wlan.term()
  end

  if Wlan.getSwitchState() == 0 then
    while not Ctrl:Circle1() do
      Global.draw.s()
      msg_switch_off:Draw(((screen:width()/2)-(msg_switch_off:width()/2)),((screen:height()/2)-(msg_switch_off:height()/2)))
      Global.draw.e()
    end
    return -1
  end
  
  
  while not CANCEL do
    if Wlan.getSwitchState() == 0 then
      Wlan.term()
      while not Ctrl:Circle1() do
        Global.draw.s()
        msg_switch_off:Draw(((screen:width()/2)-(msg_switch_off:width()/2)),((screen:height()/2)-(msg_switch_off:height()/2)))
        Global.draw.e()
      end
      return -1
    end

    if Ctrl:Circle1() then
      CANCEL = true
      Cancelling_func()
      return -1
    end

    --bool_status,int_ret,ret = coroutine.resume(CO)
    bool_status,int_ret,ret = coroutine.resume(CO,Username,Password)

    Global.draw.s()
    if int_ret == 99 then --Connection
      msg_connecting:Draw(((screen:width()/2)-(msg_connecting:width()/2)),((screen:height()/2)-(msg_connecting:height()/2)))
    elseif int_ret == 98 then --Communicating
      msg_working:Draw(((screen:width()/2)-(msg_working:width()/2)),((screen:height()/2)-(msg_working:height()/2)))
    end
    Global.draw.e()
    
    if int_ret ~= 99 or int_ret ~= 98 then
      if int_ret == 0 then
      elseif int_ret == -1 then
      end
    end
  end
end