requireC (Global.system.dir.main .."AnimatedSprite.lc")
requireC (Global.system.dir.main .."MENU.LC")
requireC (Global.system.dir.main .."FPSCounter.lua")
requireC (Global.system.dir.main .."Petals.lua")
requireC (Global.system.dir.main .."colors.lua")
requireC (Global.system.dir.main .."Ctrl.lc")
requireC (Global.system.dir.main .."TrigArea.lua")
requireC (Global.system.dir.main .."Mouse.lua")

function MainMenu()
  local menu = MENU.new({"Login","Options","Exit"},"Ultimate Battle MMO",">")
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
    Global.draw.e()

    mx,my = Global.system.mouse.cursor:Pos()
    cursor = Global.system.getCursorFromTrigAreaList(trigareas,mx,my,mhx,mhy)

    if Ctrl:Cross1() or Ctrl:Circle1() then
      if cursor == 1 then
        if LoginScreen() == 0 then
          menu = nil
          trigareas = nil
          cursor = nil
          mx,my = nil,nil
          mhx,mhy = nil,nil
          ta_pos_x,ta_pos_y = nil,nil
          ta_size_w,ta_size_h = nil,nil
          collectgarbage()
          Ctrl:Update()
          
          --[[ insert game code here ]]--
          
          menu = MENU.new({"Login","Options","Exit"},"Ultimate Battle RPG",">")
          trigareas = Global.system.buildTrigAreaList(menu)
          cursor = 0
          mx,my = Global.system.mouse.cursor:Pos()
          mhx,mhy = Global.system.mouse.cursor:HotSpot()
          ta_pos_x,ta_pos_y = 0,0
          ta_size_w,ta_size_h = 0,0
        end
        Ctrl:Update()
      elseif cursor == 2 then
        OptionsMenu()
        Ctrl:Update()
      elseif cursor == menu:numOptions() then
        --os.exit(0)
        break
      end
    end
  end
end