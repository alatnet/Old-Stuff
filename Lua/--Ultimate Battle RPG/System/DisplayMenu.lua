requireC (Global.system.dir.main .. "AnimatedSprite.lc")
requireC (Global.system.dir.main .. "MENU.LC")
requireC (Global.system.dir.main .. "FPSCounter.lua")
requireC (Global.system.dir.main .. "Petals.lua")
requireC (Global.system.dir.main .. "colors.lua")
requireC (Global.system.dir.main .. "Ctrl.lc")
requireC (Global.system.dir.main .. "TrigArea.lua")
requireC (Global.system.dir.main .. "Mouse.lua")
requireC (Global.system.dir.main .. "BAR.lc")

function DisplayMenu()
  local menu = MENU.new({"Display FPS:     ","Back"},"Options\\Display",">")
  local trigareas = Global.system.buildTrigAreaList(menu)
  local cursor = 0
  local mx,my = Global.system.mouse.cursor:Pos()
  local mhx,mhy = Global.system.mouse.cursor:HotSpot()
  local ta_pos_x,ta_pos_y = 0,0
  local ta_size_w,ta_size_h = 0,0

  local FPSO = {
    txt = {[true] = "On",[false] = "Off"},
    pos = {
      x = ((screen:width()/2)-(menu:width()/2))+115,
      y = ((screen:height()/2)-(menu:height()/2))+11
    },
    col = {[false] = black,[true] = Color.new(0,0,128)}
  }

  Ctrl:Update()

  while not Ctrl:Start1() and not Ctrl:Triangle1() do
    Global.draw.s()
    menu:Draw(((screen:width()/2)-(menu:width()/2)),((screen:height()/2)-(menu:height()/2)),cursor)
    screen:print(FPSO.pos.x,FPSO.pos.y,FPSO.txt[Global.system.displayFPS],FPSO.col[cursor == 1])
    Global.draw.e()

    mx,my = Global.system.mouse.cursor:Pos()

    cursor = Global.system.getCursorFromTrigAreaList(trigareas,mx,my,mhx,mhy)

    if Ctrl:Cross1() or Ctrl:Circle1() then
      if cursor == menu:numOptions() then
        break
      elseif cursor == 1 then
        Global.system.displayFPS = not Global.system.displayFPS
      end
    end
  end
end