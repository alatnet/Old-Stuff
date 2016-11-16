requireC (Global.system.dir.main .. "AnimatedSprite.lua")
requireC (Global.system.dir.main .. "MENU.lua")
requireC (Global.system.dir.main .. "FPSCounter.lua")
requireC (Global.system.dir.main .. "Petals.lua")
requireC (Global.system.dir.main .. "colors.lua")
requireC (Global.system.dir.main .. "Ctrl.lua")
requireC (Global.system.dir.main .. "TrigArea.lua")
requireC (Global.system.dir.main .. "Mouse.lua")
requireC (Global.system.dir.main .."advancedDrawFuncs.lua")

function OSKMenu()
  local menu = MENU.new(Global.osk.list,"Options\\OSK",">")
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
      Global.draw.advancedFillRect(0,screen:height()-9, 480, 9, Color.new(223,223,223,160))
    Gu.end3d()
    --screen:fillRect(0,screen:height()-9, 480, 9, Color.new(223,223,223))
    
    screen:print(1,screen:height()-8,"Current OSK: " .. Global.osk.curr,Color.new(0,0,0))
    
    Global.draw.e()

    mx,my = Global.system.mouse.cursor:Pos()
    
    cursor = Global.system.getCursorFromTrigAreaList(trigareas,mx,my,mhx,mhy)

    if Ctrl:Cross1() or Ctrl:Circle1() then
      if cursor == menu:numOptions() then
        break
      else
        for i=1,menu:numOptions() do
          if cursor == i then
            Global.osk.curr = Global.osk.list[i]
            dofile(Global.osk.dir .. Global.osk.curr)
            return
          end
        end
      end
    end
  end
end