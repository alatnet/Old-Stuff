requireC (Global.system.dir.main .. "AnimatedSprite.lua")
requireC (Global.system.dir.main .. "MENU.lua")
requireC (Global.system.dir.main .. "FPSCounter.lua")
requireC (Global.system.dir.main .. "Petals.lua")
requireC (Global.system.dir.main .. "colors.lua")
requireC (Global.system.dir.main .. "Ctrl.lua")
requireC (Global.system.dir.main .. "TrigArea.lua")
requireC (Global.system.dir.main .. "Mouse.lua")
requireC (Global.system.dir.main .."advancedDrawFuncs.lua")

function WlanConfigsMenu()
  local wlan_array = {}
  
  for i=1,table.getn(Global.wlan.configs) do
    table.insert(wlan_array, Global.wlan.configs[i])
  end
  
  table.insert (wlan_array,"Adjust Offset")
  table.insert (wlan_array,"Back")

  local menu = MENU.new(wlan_array,"Wlan Configurations",">")
  local trigareas = Global.system.buildTrigAreaList(menu)
  local cursor = 0
  local mx,my = Global.system.mouse.cursor:Pos()
  local mhx,mhy = Global.system.mouse.cursor:HotSpot()
  local ta_pos_x,ta_pos_y = 0,0
  local ta_size_w,ta_size_h = 0,0
  local wlan_selected = false

  Ctrl:Update()

  while not Ctrl:Start1() and not Ctrl:Triangle1() do
    Global.draw.s()

    menu:Draw(((screen:width()/2)-(menu:width()/2)),((screen:height()/2)-(menu:height()/2)),cursor)
    
    Gu.start3d()
      Gum.matrixMode(Gu.MODEL)
      Gum.loadIdentity()
      Global.draw.advancedFillRect(0,screen:height()-9, 480, 9, Color.new(223,223,223,160))
    Gu.end3d()
    
    --screen:fillRect(0,screen:height()-9, 480, 9, Color.new(223,223,223))
    screen:print(1,screen:height()-8,"Current Wlan Config: " .. wlan_array[Global.wlan.useConfig],Color.new(0,0,0))
    
    Global.draw.e()

    mx,my = Global.system.mouse.cursor:Pos()
    
    cursor = Global.system.getCursorFromTrigAreaList(trigareas,mx,my,mhx,mhy)

    if Ctrl:Cross1() or Ctrl:Circle1() then
      if cursor == menu:numOptions() then
        break
      elseif cursor == menu:numOptions()-1 then
        Global.wlan.offset = WlanOffsetMenu(Global.wlan.offset)
      else
        for i=1,menu:numOptions() do
          if cursor == i then
            Global.wlan.useConfig = i
            wlan_selected = true
            break
          end
        end
      end
    end
    
    if wlan_selected then
      break
    end
  end
end

function WlanOffsetMenu(offset)
  local menu = MENU.new({"-2","-1","0","+1","+2"},"Wlan Offset",">")
  local ret = {-2,-1,0,1,2}
  local trigareas = Global.system.buildTrigAreaList(menu)
  local cursor = 0
  local mx,my = Global.system.mouse.cursor:Pos()
  local mhx,mhy = Global.system.mouse.cursor:HotSpot()
  local ta_pos_x,ta_pos_y = 0,0
  local ta_size_w,ta_size_h = 0,0

  Ctrl:Update()

  while not Ctrl:Start1() and not Ctrl:Triangle1() do
  
    Global.draw.s()

    menu:Draw(((screen:width()/2)-(menu:width()/2)),((screen:height()/2)-(menu:height()/2)),cursor)
    
    Gu.start3d()
      Gum.matrixMode(Gu.MODEL)
      Gum.loadIdentity()
      Global.draw.advancedFillRect(0,screen:height()-9, 480, 9, Color.new(223,223,223,160))
    Gu.end3d()
    
    --screen:fillRect(0,screen:height()-9, 480, 9, Color.new(223,223,223))
    screen:print(1,screen:height()-8,"Current Wlan Offset: " .. offset,Color.new(0,0,0))
    
    Global.draw.e()
    
    mx,my = Global.system.mouse.cursor:Pos()
    
    cursor = Global.system.getCursorFromTrigAreaList(trigareas,mx,my,mhx,mhy)
    
    if Ctrl:Cross1() or Ctrl:Circle1() then
      return ret[cursor]
    end
  end
end