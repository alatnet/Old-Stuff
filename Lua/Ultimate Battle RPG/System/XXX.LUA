Wlan.init()

screen:clear(Color.new(0,0,0))

do
  Wlan.useConnectionConfig(2,true)
  
  local state,err = Wlan.getConnectionState()
  
  while state ~= 4 and err == nil do
    screen:clear()
    screen.print(2,2,"connecting to access point")
    screen.flip()
    state,err = Wlan.getConnectionState()
  end
  
  if err then
    error("Wlan Error!  Error: " .. err,1)
  end
  
  while Wlan.getIPAddress() == nil do
    screen:clear()
    screen.print(2,2,"getting ip")
    screen.flip()
  end
end

do
  local socket, err = Socket.connect("www.fanfiction.net", 80, false)
        
  if err ~= 119 then
    Wlan.term()
    error("Socket Error!  Error Code: " .. err,1)
  end
  
  while not socket:isConnected() do
    screen:clear()
    screen.print(2,2,"connecting to site")
    screen.flip()
  end
  
  local bytesSent = socket:send("GET /u/237185/ HTTP/1.0\r\n")
  bytesSent = socket:send("host: www.fanfiction.net\r\n\r\n")
  
  local recieved = ""
  local buffer = ""
  local timeout = {
    val = 5,
    curr = 0,
    timer = Timer.new()
  }
  
  local FILE_1 = io.open("buff1.txt")
  local FILE_2 = io.open("buff2.txt")
  
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
  end
  socket:close()
end
