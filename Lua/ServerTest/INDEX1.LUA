requireC("JavaSrv.lc",true)
requireC("FPSCounter.lua")
requireC("loader_icon.lc")

function ServerTest(Srv,FPS,LI)
  local STATUS1,STATUS2

  while true do
    Srv:update()
    STATUS1,STATUS2 = Srv:status()

    screen:clear(Color.new(0,0,0))      
    screen:print(2,26,"FPS: " .. FPS:update(),Color.new(255,255,255))
    screen:print(2,34,LI:update(),Color.new(255,255,255))

    if STATUS1 == JavaSrv.CONNECTING then
      screen:print(2,2,"Connecting... (1)",Color.new(255,255,255))
      screen:print(2,10,"Status2: " .. tostring(STATUS2) .. " (1)",Color.new(255,255,255))
      screen:print(2,18,"PSP IP: " .. Wlan.getIPAddress() .. " (1)",Color.new(255,255,255))
    elseif STATUS1 == JavaSrv.CONNECTED then
      screen:print(2,2,"Connected! (1)",Color.new(255,255,255))
      screen:print(2,10,"Status2: " .. tostring(STATUS2) .. " (1)",Color.new(255,255,255))
      screen:print(2,18,"PSP IP: " .. Wlan.getIPAddress() .. " (1)",Color.new(255,255,255))
      screen:flip()
      screen.waitVblankStart()
      break
    elseif STATUS1 == JavaSrv.SERVER_FULL then
      screen:print(2,2,"Full! (1)",Color.new(255,255,255))
      screen:print(2,10,"Status2: " .. tostring(STATUS2) .. " (1)",Color.new(255,255,255))
      screen:print(2,18,"PSP IP: " .. Wlan.getIPAddress() .. " (1)",Color.new(255,255,255))
      screen:flip()
      screen.waitVblankStart()
      return
    elseif STATUS1 == JavaSrv.SERVER_SHUTDOWN then
      screen:print(2,2,"Shutdown! (1)",Color.new(255,255,255))
      screen:print(2,10,"Status2: " .. tostring(STATUS2) .. " (1)",Color.new(255,255,255))
      screen:print(2,18,"PSP IP: " .. Wlan.getIPAddress() .. " (1)",Color.new(255,255,255))
      screen:flip()
      screen.waitVblankStart()
      return
    elseif STATUS1 == JavaSrv.SERVER_ERROR then
      screen:print(2,2,"Error! (1)",Color.new(255,255,255))
      screen:print(2,10,"Status2: " .. tostring(STATUS2) .. " (1)",Color.new(255,255,255))
      screen:print(2,18,"PSP IP: " .. Wlan.getIPAddress() .. " (1)",Color.new(255,255,255))
      screen:flip()
      screen.waitVblankStart()
      return
    elseif STATUS1 == JavaSrv.DISCONNECTED then
      screen:print(2,2,"Disconnected! (1)",Color.new(255,255,255))
      screen:print(2,10,"Status2: " .. tostring(STATUS2) .. " (1)",Color.new(255,255,255))
      screen:print(2,18,"PSP IP: " .. Wlan.getIPAddress() .. " (1)",Color.new(255,255,255))
      screen:flip()
      screen.waitVblankStart()
      return
    elseif STATUS1 == JavaSrv.SOCKET_ERROR then
      screen:print(2,2,"Socket Error! (1)",Color.new(255,255,255))
      screen:print(2,10,"Status2: " .. tostring(STATUS2) .. " (1)",Color.new(255,255,255))
      screen:print(2,18,"PSP IP: " .. Wlan.getIPAddress() .. " (1)",Color.new(255,255,255))
      screen:flip()
      screen.waitVblankStart()
      return
    else
      screen:print(2,2,"Status1: " .. STATUS1 .. " (1)",Color.new(255,255,255))
      screen:print(2,10,"Status2: " .. tostring(STATUS2) .. " (1)",Color.new(255,255,255))
      screen:print(2,18,"PSP IP: " .. Wlan.getIPAddress() .. " (1)",Color.new(255,255,255))
    end

    screen:flip()
    screen.waitVblankStart()

    if Controls.read():start() then
      Srv:close()
      return
    end
  end

  while true do
    Srv:update()
    STATUS1,STATUS2 = Srv:status()

    screen:clear(Color.new(0,0,0))  
    screen:print(2,26,"FPS: " .. FPS:update(),Color.new(255,255,255))
    screen:print(2,34,LI:update(),Color.new(255,255,255))

    if STATUS1 == JavaSrv.WAITING then
      screen:print(2,2,"Waiting! (2)",Color.new(255,255,255))
      screen:print(2,10,"Status2: " .. tostring(STATUS2) .. " (2)",Color.new(255,255,255))
      screen:print(2,18,"PSP IP: " .. Wlan.getIPAddress() .. " (2)",Color.new(255,255,255))
    elseif STATUS1 == JavaSrv.SERVER_SHUTDOWN then
      screen:print(2,2,"Shutdown! (2)",Color.new(255,255,255))
      screen:print(2,10,"Status2: " .. tostring(STATUS2) .. " (2)",Color.new(255,255,255))
      screen:print(2,18,"PSP IP: " .. Wlan.getIPAddress() .. " (2)",Color.new(255,255,255))
      screen:flip()
      screen.waitVblankStart()
      return
    elseif STATUS1 == JavaSrv.SERVER_ERROR then
      screen:print(2,2,"Error! (2)",Color.new(255,255,255))
      screen:print(2,10,"Status2: " .. tostring(STATUS2) .. " (2)",Color.new(255,255,255))
      screen:print(2,18,"PSP IP: " .. Wlan.getIPAddress() .. " (2)",Color.new(255,255,255))
      screen:flip()
      screen.waitVblankStart()
      return
    elseif STATUS1 == JavaSrv.WORKING then
      screen:print(2,2,"Working! (2)",Color.new(255,255,255))
      screen:print(2,10,"Status2: " .. tostring(STATUS2) .. " (2)",Color.new(255,255,255))
      screen:print(2,18,"PSP IP: " .. Wlan.getIPAddress() .. " (2)",Color.new(255,255,255))
    elseif STATUS1 == JavaSrv.DISCONNECTED then
      screen:print(2,2,"Disconnected! (2)",Color.new(255,255,255))
      screen:print(2,10,"Status2: " .. tostring(STATUS2) .. " (2)",Color.new(255,255,255))
      screen:print(2,18,"PSP IP: " .. Wlan.getIPAddress() .. " (2)",Color.new(255,255,255))
      screen:flip()
      screen.waitVblankStart()
      return
    elseif STATUS1 == JavaSrv.SOCKET_ERROR then
      screen:print(2,2,"Socket Error! (1)",Color.new(255,255,255))
      screen:print(2,10,"Status2: " .. tostring(STATUS2) .. " (1)",Color.new(255,255,255))
      screen:print(2,18,"PSP IP: " .. Wlan.getIPAddress() .. " (2)",Color.new(255,255,255))
      screen:flip()
      screen.waitVblankStart()
      return
    else
      screen:print(2,2,"Status1: " .. STATUS1 .. " (2)",Color.new(255,255,255))
      screen:print(2,10,"Status2: " .. tostring(STATUS2) .. " (2)",Color.new(255,255,255))
      screen:print(2,18,"PSP IP: " .. Wlan.getIPAddress() .. " (2)",Color.new(255,255,255))
    end

    screen:flip()
    screen.waitVblankStart()

    if Controls.read():start() then
      Srv:close()
      return
    end
  end
end

screen:clear(Color.new(0,0,0))
screen:print(2,2,"Initilizing Wlan...",Color.new(255,255,255))
screen:flip()
screen.waitVblankStart()

Wlan.init()
Wlan.useConnectionConfig(2)

local IP = Wlan.getIPAddress()
local FPS1 = FPSCounter.new()
local LI1 = loader_icon.new()

while true do
  screen:clear(Color.new(0,0,0))
  screen:print(2,2,"Retreving IP address",Color.new(255,255,255))
  screen:print(2,26,"FPS: " .. FPS1:update(),Color.new(255,255,255))
  screen:print(2,34,LI1:update(),Color.new(255,255,255))
  screen:flip()
  screen.waitVblankStart()
  System.sleep(100)
  IP = Wlan.getIPAddress()
  if IP ~= nil then break end
  if Controls.read():start() then
    Wlan.term()
    break
  end
end

--local Srv = JavaSrv.new("10.185.193.171",5555,"alatnet")
local Srv = JavaSrv.new("192.168.1.100",5555,"alatnet")

ServerTest(Srv,FPS1,LI1)

local wait = 0
local waitTime = 100
while true do
  if Controls.read():start() then
    wait = wait + 1
  end

  if wait >= waitTime then
    break
  end
end        

Wlan.term()