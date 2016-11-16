socket = nil
err = nil

function ServerTest()
  screen:clear(Color.new(0,0,0))
  screen:print(2,2,"Initilizing Wlan...",Color.new(255,255,255))
  screen:flip()
  screen.waitVblankStart()

  Wlan.init()
  Wlan.useConnectionConfig(2)

  local IP = Wlan.getIPAddress()

  while true do
    screen:clear(Color.new(0,0,0))
    screen:print(2,2,"Retreving IP address",Color.new(255,255,255))
    screen:flip()
    screen.waitVblankStart()
    System.sleep(100)
    IP = Wlan.getIPAddress()
    if IP ~= nil then break end
    if Controls.read():start() then
      Wlan.term()
      return -1
    end
  end

  --socket, err = Socket.connect("192.168.1.100", 5555)
  socket, err = Socket.connect("10.185.193.171", 5555)

  while not socket:isConnected() do
    screen:clear(Color.new(0,0,0))
    screen:print(2,2,"Connecting...",Color.new(255,255,255))
    screen:print(2,10,"PSP IP:" .. IP,Color.new(255,255,255))
    screen:flip()
    screen.waitVblankStart()
    System.sleep(100)
    if Controls.read():start() then
      socket:close()
      Wlan.term()
      return -1
    end
  end

  local status_str = ""
  local status,status1,status2,status3,status4,status5 = false,false,false,false,false,false
  local FILE1 = io.open("debug1.txt","w")
  local FILE2 = io.open("debug2.txt","w")
  local FILE3 = io.open("debug3.txt","w")
  local BREAKOUT = false


  local time = nil
  local dateFields = nil
  local hour = nil
  local min = nil
  local sec = nil
  local timeStr = ""

  --bytesSent = socket:send("alatnet\n")

  while not Controls.read():start() and socket:isConnected() and not BREAKOUT do
    time = os.time()
    dateFields = os.date("*t", time)

    hour = dateFields.hour
    min = dateFields.min
    sec = dateFields.sec
    
    timeStr = "[" .. hour .. ":" .. min .. ":" .. sec .. "] - "

    buffer = socket:recv()
    System.sleep(1)

    if buffer == nil then
      buffer = ""
    end

    status,status1,status2,status3,status4,status5 = false,false,false,false,false,false

    if string.find(buffer, "OK") then
      status1 = true
      status = true
    end
    if string.find(buffer, "REQUEST_NAME") then
      bytesSent = socket:send("alatnet\n")
      status2 = true
      status = true
    end
    if string.find(buffer, "FULL") then
      status3 = true
      status = true
    end
    if string.find(buffer, "SERVER_SHUTDOWN") then
      status4 = true
      status = true
    end
    if string.find(buffer, "SERVER_ERROR") then
      status5 = true
      status = true
    end
    
    status_str = ""

    if not status then
      status_str = status_str .. "Waiting for server..."
    end
    if status1 then
      status_str = status_str .. "   Server is not full."
    end
    if status3 then
      status_str = status_str .. "   Server is full."
      BREAKOUT = true
    end
    if status2 then
      status_str = status_str .. "   REQUEST_NAME Recieved!  Sent Reply!"
    end
    if status4 then
      status_str = status_str .. "   SERVER_SHUTDOWN Recieved!"
      BREAKOUT = true
    end
    if status5 then
      status_str = status_str .. "   SERVER_ERROR Recieved!"
      BREAKOUT = true
    end

    screen:clear(Color.new(0,0,0))
    screen:print(2,2,tostring(status) .. "  " .. tostring(status1) .. "  " .. tostring(status2) .. "  " .. tostring(status3) .. "  " .. tostring(status4) .. "  " .. tostring(status5),Color.new(255,255,255))
    screen:print(2,10,status_str,Color.new(255,255,255))
    screen:print(2,10,buffer,Color.new(255,255,255))
    screen:flip()
    screen.waitVblankStart()

    FILE1:write(timeStr .. tostring(status) .. "  " .. tostring(status1) .. "  " .. tostring(status2) .. "  " .. tostring(status3) .. "  " .. tostring(status4) .. "  " .. tostring(status5) .. "\n")
    FILE2:write(timeStr .. status_str .. "\n")
    FILE3:write(timeStr .. buffer .. "\n")

    --System.sleep(25)
  end
  
  bytesSent = socket:send("LEAVE\n")

  FILE1:close()
  FILE2:close()
  FILE3:close()

  socket:close()
  Wlan.term()

end

if ServerTest() == -1 then
  while not Controls.read():start() do
    screen:clear(Color.new(0,0,0))
    screen:print(2,2,"Initilization of Wlan failed!",Color.new(255,255,255))
    screen:print(2,10,"Press start to exit.",Color.new(255,255,255))
    screen:flip()
    screen.waitVblankStart()
  end
end