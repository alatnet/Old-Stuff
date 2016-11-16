requireC (Global.system.dir.main .."AnimatedSprite.lc")
requireC (Global.system.dir.main .."MENU.LC")
requireC (Global.system.dir.main .."FPSCounter.lua")
requireC (Global.system.dir.main .."Petals.lua")
requireC (Global.system.dir.main .."colors.lua")
requireC (Global.system.dir.main .."Ctrl.lc")
requireC (Global.system.dir.main .."PAD.lc")
requireC (Global.system.dir.main .."TrigArea.lua")
requireC (Global.system.dir.main .."Mouse.lua")
requireC (Global.system.dir.main .."TextField.lc")

function LoginScreen()
  local UsernameField = TextField2.new(20) --48,"Username: "
  local PasswordField = TextField2.new(20) --48,"Password: "
  local menu = MENU.new({"Login","Change WLAN Config","Back"},"Login",">")
  local cursor = 0
  local trigareas = {
    TrigArea.new(((screen:width()/2)-(UsernameField:width()/2)),((screen:height()/2)-(UsernameField:height()/2))-12,UsernameField:width(),UsernameField:height()),
    TrigArea.new(((screen:width()/2)-(PasswordField:width()/2)),((screen:height()/2)-(PasswordField:height()/2)),PasswordField:width(),PasswordField:height()),
    TrigArea.new(((screen:width()/2)-(menu:width()/2)),((screen:height()/2)-(menu:height()/2)) + 27 + 9,menu:width(),9),
    TrigArea.new(((screen:width()/2)-(menu:width()/2)),((screen:height()/2)-(menu:height()/2)) + 27 + 18,menu:width(),9),
    TrigArea.new(((screen:width()/2)-(menu:width()/2)),((screen:height()/2)-(menu:height()/2)) + 27 + 27,menu:width(),9)
  }
  
  local mx,my = Global.system.mouse.cursor:Pos()
  local mhx,mhy = Global.system.mouse.cursor:HotSpot()
  local ta_pos_x,ta_pos_y = 0,0
  local ta_size_w,ta_size_h = 0,0

  local osk = Osk.new()
  local oskActive = false
  
  local EXIT = false

  Ctrl:Update()
  Pad:Update()

  while not EXIT do  
    if not oskActive then
      Ctrl:Update()
      if Ctrl:Start1() or Ctrl:Triangle1() then
        EXIT = true
      end
      
      if Ctrl:RTrig1() and (cursor == 1 or cursor == 2) then
        oskActive = true
        osk = Osk.new()
      end
    end

    screen:clear(LightSkyBlue)
    Global.system.petals:Draw()
    if Global.system.displayFPS then screen:print(2,2,"FPS: " .. Global.system.counter:update(),black) end
    UsernameField:Draw(((screen:width()/2)-(UsernameField:width()/2)),((screen:height()/2)-(UsernameField:height()/2))-12,cursor==1)
    PasswordField:Draw(((screen:width()/2)-(PasswordField:width()/2)),((screen:height()/2)-(PasswordField:height()/2)),cursor==2)
    menu:Draw(((screen:width()/2)-(menu:width()/2)),((screen:height()/2)-(menu:height()/2)) + 30,cursor-2)

    if not oskActive then
      Global.system.mouse.cursor:Draw()
    else
      osk:Draw(480 - osk:width(),272 - osk:height())
    end
    screen.flip()

    if not oskActive then
      Global.system.mouse.cursor:Move((Ctrl:AX()/Global.system.mouse.spd),(Ctrl:AY()/Global.system.mouse.spd))  -- math.ceil

      mx,my = Global.system.mouse.cursor:Pos()

      cursor = Global.system.getCursorFromTrigAreaList(trigareas,mx,my,mhx,mhy)
    end

    if oskActive then
      Pad:Update()
      if cursor==1 then
        local In, cont = osk:Update()
        UsernameField:addChar(In)
        if not cont then oskActive = false end
      elseif cursor==2 then
        local In, cont = osk:Update()
        PasswordField:addChar(In)
        if not cont then oskActive = false end
      else
        oskActive = false
      end
    end

    if not oskActive then
      if Ctrl:Cross1() or Ctrl:Circle1() then
        if cursor == 3 then
          if WlanLogin(UsernameField:getText(),PasswordField:getText()) == 0 then
            return 0
          end
        elseif cursor == 4 then
          WlanConfigsMenu()
        elseif cursor == menu:numOptions()+2 then
          Pad:Update()
          return -1
        end
      end
    end
  end
end