requireC (Global.system.dir.main .."AnimatedSprite.lua")
requireC (Global.system.dir.main .."FPSCounter.lua")
requireC (Global.system.dir.main .."Petals.lua")
requireC (Global.system.dir.main .."colors.lua")
requireC (Global.system.dir.main .. "Ctrl.lua")
requireC (Global.system.dir.main .. "advancedDrawFuncs.lua")

function LOGO()
  local logo = Image.load(Global.system.dir.main .. Global.system.dir.img .. "Logo.png")
  local ONE_SECOND = 1000
  local time = {
    curr = 0,
    pause = 3,
    timer = Timer.new()
  }
  local EXIT = false
  local fadeSpd = 3

  Ctrl:Update()

  for a=0,255,fadeSpd do
    if EXIT then break end
    Global.draw.s()
    --DRAW
    Gu.start3d()
      Gum.matrixMode(Gu.MODEL)
      Gum.loadIdentity()
      Gu.colorMaterial(Gu.AMBIENT+Gu.DIFFUSE)
      Gu.color(Color.new(0,0,0,a))
      Global.draw.advancedBlit(logo,(480/2)-(logo:width()/2),(272/2)-(logo:height()/2))--,0,0,logo:width(),logo:height(),128)
    Gu.end3d()
    --DRAW
    if Global.system.displayFPS then screen:print(2,2,"FPS: " .. Global.system.counter:update(),black) end
    screen.waitVblankStart()
    screen.flip()
    if Ctrl:Start1() then
      EXIT = true
      break
    end
  end
  
  while not EXIT do
    Global.draw.s()
    --DRAW
    Gu.start3d()
      Gum.matrixMode(Gu.MODEL)
      Gum.loadIdentity()
      Gu.colorMaterial(Gu.AMBIENT+Gu.DIFFUSE)
      Gu.color(Color.new(0,0,0,255))
      Global.draw.advancedBlit(logo,(480/2)-(logo:width()/2),(272/2)-(logo:height()/2))--,0,0,logo:width(),logo:height(),128)
    Gu.end3d()
    --DRAW
    if Global.system.displayFPS then screen:print(2,2,"FPS: " .. Global.system.counter:update(),black) end
    screen.waitVblankStart()
    screen.flip()
    
    if time.timer:start() >= ONE_SECOND then
      time.timer:reset()
      time.curr = time.curr + 1
    end

    if time.curr >= time.pause then break end
    if Ctrl:Start1() then
      EXIT = true
      break
    end
  end
  
  for a=255,0,-fadeSpd do
    if EXIT then break end
    Global.draw.s()
    --DRAW
    Gu.start3d()
      Gum.matrixMode(Gu.MODEL)
      Gum.loadIdentity()
      Gu.colorMaterial(Gu.AMBIENT+Gu.DIFFUSE)
      Gu.color(Color.new(0,0,0,a))
      Global.draw.advancedBlit(logo,(480/2)-(logo:width()/2),(272/2)-(logo:height()/2))--,0,0,logo:width(),logo:height(),128)
    Gu.end3d()
    --DRAW
    if Global.system.displayFPS then screen:print(2,2,"FPS: " .. Global.system.counter:update(),black) end
    screen.waitVblankStart()
    screen.flip()
    if Ctrl:Start1() then
      EXIT = true
      break
    end
  end
  
  --[[
  while not EXIT do
    Global.draw.s()

    screen:blit(((screen:width()/2) - (logo:width()/2)),((screen:height()/2) - (logo:height()/2)),logo)
    if Global.system.displayFPS then screen:print(2,2,"FPS: " .. Global.system.counter:update(),black) end
    screen.waitVblankStart()
    screen.flip()

    if time.timer:start() >= ONE_SECOND then
      time.timer:reset()
      time.curr = time.curr + 1
    end

    if time.curr >= time.pause then break end
    if Ctrl:Start1() then
      EXIT = true
      break
    end
  end
  ]]--
  
  logo = nil
  collectgarbage()

  time.curr = 0
  time.pause = 3
  time.timer:reset()
  
  local LINES = {
    {
      "Ultimate Battle MMO",
      "Copyright (C) 2007 alatnet"
    },
    {
      "*~Developed By~*",
      "Dev Team X"
    },
    {
      "*~Developers~*",
      "alatnet (Dev Team X Founder)"
    },
    {
      "*~Special Thanks~*",
      "cools (Luaplayer 0.20 Mod 4)",
      "The Spriters Resource (www.spriters-resource.com)",
      "PSPUpdates (Qj.net)"
    }
  }
  local currLn = 1
  
  local LINES_H = table.getn(LINES[currLn]) * 9
  local LINE_W
  
  local XX
  local YY = (screen:height()/2)-(LINES_H/2)

  while not EXIT do
    Global.draw.s()

    LINES_H = table.getn(LINES[currLn]) * 9
    YY = (screen:height()/2)-(LINES_H/2)

    for i=1,table.getn(LINES[currLn]) do
      LINE_W = string.len(LINES[currLn][i])*8
      XX = (screen:width()/2)-(LINE_W/2)
      screen:print(XX,YY,LINES[currLn][i],black)
      YY=YY+9
    end

    if Global.system.displayFPS then screen:print(2,2,"FPS: " .. Global.system.counter:update(),black) end
    screen.waitVblankStart()
    screen.flip()

    if time.timer:start() >= ONE_SECOND then
      time.timer:reset()
      time.curr = time.curr + 1
    end

    if time.curr >= time.pause then
      currLn = currLn + 1
      time.curr = 0
    end
    
    if currLn >= table.getn(LINES) + 1 then
      break
    end
    
    if Ctrl:Start1() then
      EXIT = true
      break
    end
  end
end