requireC (Global.system.dir.main .. "AnimatedSprite.lc")
requireC (Global.system.dir.main .. "MENU.LC")
requireC (Global.system.dir.main .. "FPSCounter.lua")
requireC (Global.system.dir.main .. "Petals.lua")
requireC (Global.system.dir.main .. "colors.lua")
requireC (Global.system.dir.main .. "Ctrl.lc")
requireC (Global.system.dir.main .. "TrigArea.lua")
requireC (Global.system.dir.main .. "Mouse.lua")
requireC (Global.system.dir.main .. "BAR.lc")
requireC (Global.system.dir.main .."advancedDrawFuncs.lua")

function SoundMenu()
  local menu = MENU.new({"Music Vol              ","  SFX Vol              ","Keytone:               ","Back                   "},"Options\\Sound",">")
  local trigareas = Global.system.buildTrigAreaList(menu)
  local cursor = 0
  local mx,my = Global.system.mouse.cursor:Pos()
  local mhx,mhy = Global.system.mouse.cursor:HotSpot()
  local ta_pos_x,ta_pos_y = 0,0
  local ta_size_w,ta_size_h = 0,0
  
  local KTO = {
    txt = {[true] = "On",[false] = "Off"},
    pos = {
      x = ((screen:width()/2)-(menu:width()/2))+80,
      y = ((screen:height()/2)-(menu:height()/2))+29
    },
    col = {[false] = black,[true] = Color.new(0,0,128)}
  }
  
  local VolBars = {
    Music = {
      bar = BAR.new(Global.system.vol.music,128,0,0,104,8),
      pos = {
        x = ((screen:width()/2)+(menu:width()/2))-110,
        y = ((screen:height()/2)-(menu:height()/2))+10
      },
      perc = BAR.fpfn(128,Global.system.vol.music) .. "%"
    },
    SFX = {
      bar = BAR.new(Global.system.vol.sfx,128,0,0,104,8),
      pos = {
        x = ((screen:width()/2)+(menu:width()/2))-110,
        y = ((screen:height()/2)-(menu:height()/2))+19
      },
      perc = BAR.fpfn(128,Global.system.vol.sfx) .. "%"
    },
    size = {
      w = 104,
      h = 8
    },
    col = {[false] = Color.new(0,0,128),[true] = blue},
    bg = {[false] = Color.new(128,0,0),[true] = Color.new(255,0,0)}
  }
  
  Ctrl:Update()

  while not Ctrl:Start1() and not Ctrl:Triangle1() do
    Global.draw.s()
    menu:Draw(((screen:width()/2)-(menu:width()/2)),((screen:height()/2)-(menu:height()/2)),cursor)
    Gu.start3d()
      --screen:fillRect(VolBars.Music.pos.x,VolBars.Music.pos.y, VolBars.size.w, VolBars.size.h,VolBars.bg[cursor == 1])
      --screen:fillRect(VolBars.SFX.pos.x,VolBars.SFX.pos.y, VolBars.size.w, VolBars.size.h,VolBars.bg[cursor == 2])
      Global.draw.advancedFillRect(VolBars.Music.pos.x,VolBars.Music.pos.y, VolBars.size.w, VolBars.size.h,VolBars.bg[cursor == 1])
      Global.draw.advancedFillRect(VolBars.SFX.pos.x,VolBars.SFX.pos.y, VolBars.size.w, VolBars.size.h,VolBars.bg[cursor == 2])
    Gu.end3d()
    VolBars.Music.bar:Draw(VolBars.Music.pos.x,VolBars.Music.pos.y)
    VolBars.SFX.bar:Draw(VolBars.SFX.pos.x,VolBars.SFX.pos.y)
    screen:print(KTO.pos.x,KTO.pos.y,KTO.txt[Global.system.useKeyTone],KTO.col[cursor == 3])
    screen:print(VolBars.Music.pos.x+((VolBars.size.w/2)-((string.len(VolBars.Music.perc)*8)/2)),VolBars.Music.pos.y,VolBars.Music.perc,black)
    screen:print(VolBars.SFX.pos.x+((VolBars.size.w/2)-((string.len(VolBars.SFX.perc)*8)/2)),VolBars.SFX.pos.y,VolBars.SFX.perc,black)
    Global.draw.e()

    mx,my = Global.system.mouse.cursor:Pos()

    cursor = Global.system.getCursorFromTrigAreaList(trigareas,mx,my,mhx,mhy)

    VolBars.Music.bar:setColor(VolBars.col[cursor == 1])
    VolBars.SFX.bar:setColor(VolBars.col[cursor == 2])

    if cursor == 1 then
      if Ctrl:Left1() or Ctrl:LeftHold() then
        VolBars.Music.bar:setPercentage(VolBars.Music.bar:getPercentage()-1)
        VolBars.Music.perc = VolBars.Music.bar:getPercentage() .. "%"
        Global.system.vol.music = VolBars.Music.bar:getVal()
        Music.volume(Global.system.vol.music)
      elseif Ctrl:Right1() or Ctrl:RightHold() then
        VolBars.Music.bar:setPercentage(VolBars.Music.bar:getPercentage()+1)
        VolBars.Music.perc = VolBars.Music.bar:getPercentage() .. "%"
        Global.system.vol.music = VolBars.Music.bar:getVal()
        Music.volume(Global.system.vol.music)
      end
    elseif cursor == 2 then
      if Ctrl:Left1() or Ctrl:LeftHold() then
        VolBars.SFX.bar:setPercentage(VolBars.SFX.bar:getPercentage()-1)
        VolBars.SFX.perc = VolBars.SFX.bar:getPercentage() .. "%"
        Global.system.vol.sfx = VolBars.SFX.bar:getVal()
        SoundSystem.SFXVolume(Global.system.vol.sfx)
        Global.sfx.system.keytone:play()
      elseif Ctrl:Right1() or Ctrl:RightHold() then
        VolBars.SFX.bar:setPercentage(VolBars.SFX.bar:getPercentage()+1)
        VolBars.SFX.perc = VolBars.SFX.bar:getPercentage() .. "%"
        Global.system.vol.sfx = VolBars.SFX.bar:getVal()
        SoundSystem.SFXVolume(Global.system.vol.sfx)
        Global.sfx.system.keytone:play()
      end
    end

    if Ctrl:Cross1() or Ctrl:Circle1() then
      if cursor == menu:numOptions() then
        break
      elseif cursor == 3 then
        Global.system.useKeyTone = not Global.system.useKeyTone
      end
    end
  end
end