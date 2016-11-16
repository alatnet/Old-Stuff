--*************************************************************************************************
-- Angelic Layer MMO (ALMMO) Lua Game
-- Coded by by alatnet
--*************************************************************************************************

--require("core/pad.lc")
--require(OSK.dir .. "/" .. OSK.sel[OSK.curr].name)

dofile("core/pad.lc")
dofile(OSK.dir .. "/" .. OSK.sel[OSK.curr].name)

function login_menu()
  local cursor=1
  local oskActive = false
  local osk = Osk.new()
  local b_timer = Timer.new()
  local b_interval = 500
  local blink = true
  local options = {
    "Change Wlan Settings",
    "OK!",
    "Cancel",
    "Reset Fields"
  }

  b_timer:start()

  while true do
    play_music()
    Pad:Update()

    if not oskActive then
      if Pad.tR1 then
        oskActive = true
        osk = Osk.new()
      end
    end

    if up1() and not oskActive then
      cursor=cursor-1
      key_tone()
    end
    if down1() and not oskActive then
      cursor=cursor+1
      key_tone()
    end

    if cursor==0 then cursor=table.getn(options)+2 end  --[[ table.getn(options)+2 ]]--
    if cursor==table.getn(options)+3 then cursor=1 end  --[[ table.getn(options)+3 ]]--

    if b_timer:time() >= b_interval then
      b_timer:reset()
      b_timer:start()
      if blink then
        blink = false
      else
        blink = true
      end
    end

    screen:clear(Game.col.clear)
    screen:print(Game.titlepos.x,Game.titlepos.y,"Angelic Layer MMO",Game.col.txt)
    display_curr_Wlan_Connection(8,16,blue)
    textinput(8,24,"Username: " .. NET.username,"_",Game.col.txt,cursor==1,blink)
    textinput(8,32,"Password: " .. NET.password,"_",Game.col.txt,cursor==2,blink)
    list_options(8,40,options,">",Game.col.txt,Game.col.sel,cursor-2)
    --display_login_error(8,screen:height()-9)
--[[
    textinput(8,16,"Username: " .. NET.username,"_",Game.col.txt,cursor==1,blink)
    textinput(8,24,"Password: " .. NET.password,"_",Game.col.txt,cursor==2,blink)
    list_options(8,32,options,">",Game.col.txt,Game.col.sel,cursor-2)
]]--

    if oskActive then
      if cursor==1 then
        local In, cont = osk:Update()
        oskX = 88 + (string.len(NET.username)*8)
        --osk:Draw(oskX,26)
        osk:Draw(oskX,40)
        NET.username = Osk_textinput(In,NET.username)
        if not cont then oskActive = false end
      elseif cursor==2 then
        local In, cont = osk:Update()
        oskX = 88 + (string.len(NET.password)*8)
        --osk:Draw(oskX,35)
        osk:Draw(oskX,48)
        NET.password = Osk_textinput(In,NET.password)
        if not cont then oskActive = false end
      else
        oskActive = false
      end
    end

    screen:flip()
    screen.waitVblankStart()

    if cross1() or circle1() then
      if cursor==3 then
        WLAN_Connect_Menu()
      elseif cursor==4 then
        login_working()
        shutdownWlan()
      elseif cursor==5 then
        NET.error.display = false
        NET.username=""
        NET.password=""
        break
      elseif cursor==6 then
        NET.error.display = false
        NET.username=""
        NET.password=""
      end
    end
    if triangle1() and not oskActive then
      NET.error.display = false
      NET.username=""
      NET.password=""
      break
    end
  end
end

function login()
  startupWlan()
  send_login()
  shutdownWlan()
end

function login_working()
  screen:clear(Game.col.clear)
  screen:print(Game.titlepos.x,Game.titlepos.y,"Angelic Layer MMO",Game.col.txt)
  screen:print(8,16,"Initilizing wlan...",Game.col.txt)
  screen:flip()
  screen.waitVblankStart()
  
  startupWlan()
  
  local interface = NET.login.new()
  local spinner = loader_icon.new()
  local status = true
  local status2 = true
  local ret = 99
  local icon = ""

  local timer = Timer.new()
  local ONE_SECOND = 1000
  local count = 0
  local count_max = 15
  
  timer:start()

  while ret == 99 do
    if timer:time() >= ONE_SECOND then
      timer:reset()
      timer:start()
      count = count + 1
      if count >= count_max then
        NET.error.str = "Server Timed Out."
        NET.error.display = true
        ret = ret - 1
      end
    end

    icon = spinner:update()

    if ret == 99 then
      ret = interface:update()
    end

    screen:clear(Game.col.clear)
    screen:print(Game.titlepos.x,Game.titlepos.y,"Angelic Layer MMO",Game.col.txt)
    screen:print(8,16,"Sending Login..." .. icon,Game.col.txt)
    screen:print(8,50,count,white)
    screen:flip()
    screen.waitVblankStart()
  end
  if ret == 0 then
    NET.error.str = ""
    NET.error.display = false
    while true do
      screen:clear(Game.col.clear)
      screen:print(Game.titlepos.x,Game.titlepos.y,"Angelic Layer MMO",Game.col.txt)
      screen:print(8,16,"Login Successful!",green)
      screen:print(8,32,"Press a button to Continue.",green)
      screen:flip()
      screen.waitVblankStart()
      if buttons1() then break end
    end
    server_list_working()
  else
    while true do
      screen:clear(Game.col.clear)
      screen:print(Game.titlepos.x,Game.titlepos.y,"Angelic Layer MMO",Game.col.txt)
      screen:print(8,16,"Login Failed!",red)
      display_net_error(16,24)
      screen:print(8,32,"Press a button to Continue.",red)
      screen:flip()
      screen.waitVblankStart()
      if buttons1() then break end
    end
    NET.error.str = ""
    NET.error.display = false
  end
end

--[[ Auto Login Functions ]]--
function Auto_Login_Toggle()
  if NET.auto_login.val then
    NET.auto_login.val = false
    NET.auto_login.str = "No"
  else
    NET.auto_login.val = true
    NET.auto_login.str = "Yes"
  end
end

function Auto_Login_Menu()
  local cursor=1
  local oskActive = false
  local osk = Osk.new()
  local b_timer = Timer.new()
  local b_interval = 500
  local blink = true
  local options = {
    "OK!",
    "Cancel",
    "Reset Fields"
  }
  
  local prev_val = NET.auto_login.val
  local prev_str = NET.auto_login.str
  local prev_username = NET.auto_login.username
  local prev_password = NET.auto_login.password

  b_timer:start()

  while true do
    play_music()
    Pad:Update()

    if not oskActive then
      if Pad.tR1 then
        oskActive = true
        osk = Osk.new()
      end
    end

    if up1() and not oskActive then
      cursor=cursor-1
      key_tone()
    end
    if down1() and not oskActive then
      cursor=cursor+1
      key_tone()
    end

    if cursor==0 then cursor=table.getn(options)+3 end
    if cursor==table.getn(options)+4 then cursor=1 end

    if b_timer:time() >= b_interval then
      b_timer:reset()
      b_timer:start()
      if blink then
        blink = false
      else
        blink = true
      end
    end

    screen:clear(Game.col.clear)
    screen:print(Game.titlepos.x,Game.titlepos.y,"Angelic Layer MMO",Game.col.txt)
    textinput(8,16,"Username: " .. NET.auto_login.username,"_",Game.col.txt,cursor==1,blink)
    textinput(8,24,"Password: " .. NET.auto_login.password,"_",Game.col.txt,cursor==2,blink)
    menuoption(8,32,"Auto Login: " .. NET.auto_login.str,">",Game.col.txt,Game.col.sel,cursor==3)
    list_options(8,40,options,">",Game.col.txt,Game.col.sel,cursor-3)

    if oskActive then
      if cursor==1 then
        local In, cont = osk:Update()
        oskX = 88 + (string.len(NET.auto_login.username)*8)
        osk:Draw(oskX,24)
        NET.auto_login.username = Osk_textinput(In,NET.auto_login.username)
        if not cont then oskActive = false end
      elseif cursor==2 then
        local In, cont = osk:Update()
        oskX = 88 + (string.len(NET.auto_login.password)*8)
        osk:Draw(oskX,32)
        NET.auto_login.password = Osk_textinput(In,NET.auto_login.password)
        if not cont then oskActive = false end
      else
        oskActive = false
      end
    end

    screen:flip()
    screen.waitVblankStart()

    if cross1() or circle1() then
      if cursor==3 then
        Auto_Login_Toggle()
      elseif cursor==4 then
        break
      elseif cursor==5 then
        NET.auto_login.username=prev_username
        NET.auto_login.password=prev_password
        NET.auto_login.val = prev_val
        NET.auto_login.str = prev_str
        break
      elseif cursor==6 then
        NET.auto_login.username=""
        NET.auto_login.password=""
        NET.auto_login.val = false
        NET.auto_login.str = "No"
      end
    end
    if triangle1() and not oskActive then
      NET.auto_login.username=prev_username
      NET.auto_login.password=prev_password
      NET.auto_login.val = prev_val
      NET.auto_login.str = prev_str
      break
    end
  end
end