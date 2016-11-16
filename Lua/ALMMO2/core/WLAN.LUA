function wlan_check()
  Wlan.term()
  Wlan.init()
  NET.connect.sel = Wlan.getConnectionConfigs()
  table.insert (NET.connect.sel, "Back")
  Wlan.term()
end

function use_wlan(sel)
  NET.connect.curr = sel
end

function WLAN_Connect_Menu()
  local cursor = 1

  Wlan.term()
  Wlan.init()

  if table.getn(NET.connect.sel) == 1 then
    Wlan.term()
    screen:clear(Game.col.clear)
    screen:print(Game.titlepos.x,Game.titlepos.y,"Angelic Layer MMO",Game.col.txt)
    screen:print(16,16,"Error!  No wlan connections found!",red)
    screen:print(16,25,"Please exit the game and configure your infrastructure wlan.",blue)
    screen:print(16,34,"Press start to go back.",white)
    screen:flip()
    while not start1() do
      screen.waitVblankStart()
    end
    return
  end

  while true do
    play_music()
    if up1() then
      cursor=cursor-1
      key_tone()
    end
    if down1() then
      cursor=cursor+1
      key_tone()
    end

    if cursor==0 then cursor=table.getn(NET.connect.sel) end
    if cursor==table.getn(NET.connect.sel)+1 then cursor=1 end

    screen:clear(Game.col.clear)
    screen:print(Game.titlepos.x,Game.titlepos.y,"Angelic Layer MMO",Game.col.txt)
    display_curr_Wlan_Connection(8,16,blue)
    list_options(16,26,NET.connect.sel,">",Game.col.txt,Game.col.sel,cursor)
    screen:flip()
    screen.waitVblankStart()

    if cross1() or circle1() then
      if cursor == table.getn(NET.connect.sel) then break end
      use_wlan(cursor)
    end
    if triangle1() then break end
  end

  Wlan.term()
end

function display_curr_Wlan_Connection(xpos,ypos,col,img)
  img = img or screen
  img:print(xpos,ypos,"Using: " .. NET.connect.sel[NET.connect.curr],col)
end
--[[
function display_wlan_status(xpos,ypos,col,img)
  img = img or screen
  img:print(xpos,ypos,"Wlan Status: " .. NET.status.sel[NET.status.curr],col)
end

function change_wlan_status(var)
  NET.status.curr = var
end
]]--
function startupWlan()
  Wlan.term()
  Wlan.init()
  Wlan.useConnectionConfig(NET.connect.curr)
  NET.ip = Wlan.getIPAddress()
end

function shutdownWlan()
  Wlan.term()
  NET.ip = nil
end

wlan_check()