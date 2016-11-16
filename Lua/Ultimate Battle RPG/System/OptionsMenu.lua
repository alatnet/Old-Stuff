requireC (Global.system.dir.main .. "AnimatedSprite.lua")
requireC (Global.system.dir.main .. "MENU.lua")
requireC (Global.system.dir.main .. "FPSCounter.lua")
requireC (Global.system.dir.main .. "Petals.lua")
requireC (Global.system.dir.main .. "colors.lua")
requireC (Global.system.dir.main .. "Ctrl.lua")
requireC (Global.system.dir.main .. "TrigArea.lua")
requireC (Global.system.dir.main .. "Mouse.lua")

function OptionsMenu()
  local menu = MENU.new({"Controls","Display","Sound","Network","OSK (On Screen Keyboard)","Back"},"Options",">")
  local trigareas = Global.system.buildTrigAreaList(menu)
  local cursor = 0
  local mx,my = Global.system.mouse.cursor:Pos()
  local mhx,mhy = Global.system.mouse.cursor:HotSpot()
  local ta_pos_x,ta_pos_y = 0,0
  local ta_size_w,ta_size_h = 0,0

  Ctrl:Update()

  while not Ctrl:Start1() and not Ctrl:Triangle() do
    Global.draw.s()
    menu:Draw(((screen:width()/2)-(menu:width()/2)),((screen:height()/2)-(menu:height()/2)),cursor)
    Global.draw.e()

    mx,my = Global.system.mouse.cursor:Pos()
    cursor = Global.system.getCursorFromTrigAreaList(trigareas,mx,my,mhx,mhy)

    if Ctrl:Cross1() or Ctrl:Circle1() then
      if cursor == 1 then
        --[[ controls ]]--
      elseif cursor == 2 then
        DisplayMenu()
        Ctrl:Update()
      elseif cursor == 3 then
        SoundMenu()
        Ctrl:Update()
      elseif cursor == 4 then
        --[[ network ]]--
      elseif cursor == 5 then
        OSKMenu()
        Ctrl:Update()
      elseif cursor == menu:numOptions() then
        break
      end
    end
  end
end