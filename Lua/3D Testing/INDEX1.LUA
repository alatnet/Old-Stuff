requireC ("./Ctrl.lc")
requireC ("./FPSCounter.lua")
requireC ("./AnimatedSprite3D.lc")
requireC ("./CameraSystem.lc")
requireC ("./Char.lc")

dofile "arenatest.lua"
Environment:load()

do
  local counter = FPSCounter.new()
  
  local xpos = 0
  local ypos = 0 --50
  local zpos = -200
  local Axis = {
    {Color.new(255,0,0),-10,0,0},
    {Color.new(255,0,0),10,0,0},
    {Color.new(0,255,0),0,-10,0},
    {Color.new(0,255,0),0,10,0},
    {Color.new(0,0,255),0,0,-10},
    {Color.new(0,0,255),0,0,10}
  }
  
  --[[
  local Boarder = {
    {0,0,0},
    {480,0,0},
    {480,272,0},
    {0,272,0},
    {0,0,0}
  }
  ]]--

  local Zero = {
    {IMG = "Zero-S",V = 2,H = 3,F = 160,M = 1.56},   --
    {IMG = "Zero-W",V = 1,H = 9,F = 50,M = 1.64}
  }
  
  AnimatedSprite.addImage2List("Standing.png",Zero[1].IMG)
  AnimatedSprite.addImage2List("Walking.png",Zero[2].IMG)

  local SPRITE = AnimatedSprite3D.new(Zero[1].IMG,Zero[1].V,Zero[1].H,Zero[1].F,Zero[1].M)
  --SPRITE:rotateXYZ(180*(Gu.PI/180),0*(Gu.PI/180),0*(Gu.PI/180))
  --local SPRITE2 = AnimatedSprite.new(Zero[1].IMG,Zero[1].V,Zero[1].H,Zero[1].F)
  --SPRITE:getSprite():setTransparency(false)
  --SPRITE2:setTransparency(false)
  --SPRITE:Size(34,41)
  --SPRITE:Size(20,20)
  --SPRITE:rotateXYZ(45*(Gu.PI/180),0*(Gu.PI/180),-90*(Gu.PI/180))
  
  ypos = SPRITE:height()
  xpos = -(SPRITE:width()/2)
  
  --                 (x,   y   ,spdX,spdX2,spdY,spdY2,stopX,stopX2,acceleration,gravX,gravY,groundY,Dimension)
  ZeroChar = Char.new(xpos,ypos,   5,    7,   7,    5,    1,  0.75,         0.1,    0, 0.25,   ypos,        3)
  --                 (xpos,ypos,   1,    4,   7,    5,    1,     1,           1,    0,  0.1,   ypos,        2)
  
  local xo,yo = SPRITE:Center()
  local w = SPRITE:width()
  local h = SPRITE:height()
  
  local pointS = {
    {Color.new(255,255,255),-xo,-yo,0}, --1
    {Color.new(255,255,255),-xo,h-yo,0}, --2
    {Color.new(255,255,255),w-xo,h-yo,0}, --4
    {Color.new(255,255,255),w-xo,-yo,0}, --3
    {Color.new(255,255,255),-xo,-yo,0}, --1
  }
  local point2 = {
    {Color.new(0,255,255),-2,-2,0},
    {Color.new(0,255,255),2,2,0},
    {Color.new(0,255,255),-2,2,0},
    {Color.new(0,255,255),2,-2,0},
  }
  
  local SpriteSwap = false
  local grav = {
    x = 0,
    y = 0.25
  }

  local clearColor = Color.new(255,255,255)
  
  local cx,cy = 0,0
  
  while not Ctrl:Start1() do
    Ctrl:Update()
    screen:clear(clearColor)

    Gu.start3d()
      Gu.clearDepth(0)
      Gu.clear(Gu.COLOR_BUFFER_BIT+Gu.DEPTH_BUFFER_BIT+Gu.STENCIL_BUFFER_BIT)
      
      if _G.Gu["fog"] ~= nil then
        Gu.enable(Gu.FOG)
        Gu.fog(250,900,clearColor)
      end
      
      Gum.matrixMode(Gu.PROJECTION)
      Gum.loadIdentity()
      
      if _G.Gum["ortho"] ~= nil then
        --Gum.ortho(0, 480, 272, 0, -1, 1)

        --sceGumOrtho(left,right,bottom,top,near,far)
        --Gum.ortho(-240, 240, 41, -231, -1, 1000)
        
        Gum.ortho(-240,240,-202,70,1,1000)
  
        --Gum.perspective(59.8,30/17,1,1000)
        --16/9
      else
        Gum.perspective(59.8,30/17,1,1000)
      end
      --CS:useCamera(cid)
      
      Gum.matrixMode(Gu.VIEW)
      Gum.loadIdentity()
      
      if _G.Gum["lookAt"] ~= nil then
        cx = (xpos+(SPRITE:width()/2))
        cy = (ypos+(SPRITE:height()/2))
        if _G.Gum["ortho"] ~= nil then
          Gum.lookAt(cx,cy+35,100,cx,cy,0,0,1,0)
        else
          Gum.lookAt(cx,cy+35,220,cx,cy,0,0,1,0)
        end
      end
      
      --[[
      -- setup matrix for boarder --
      Gum.matrixMode(Gu.MODEL)
      Gum.loadIdentity()
      Gum.translate(-240,-272,0)
      Gum.rotateXYZ(0,0,0)
      
      -- draw boarder without texture --
      Gu.disable(Gu.TEXTURE_2D)
      --Gu.color(Color.new(255,255,255))
      Gu.colorMaterial(Gu.AMBIENT+Gu.DIFFUSE+Gu.SPECULAR)
      Gu.color(Color.new(255,0,0))
      Gum.drawArray(Gu.LINE_STRIP,Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, Boarder)
      ]]--
      
      -- setup matrix for axis --
      Gum.matrixMode(Gu.MODEL)
      Gum.loadIdentity()
      Gum.translate(0,0,0)
      Gum.rotateXYZ(0*(Gu.PI/180),0*(Gu.PI/180),0*(Gu.PI/180))

      -- draw axis without texture --
      Gu.disable(Gu.TEXTURE_2D)
      Gum.drawArray(Gu.LINES,Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, Axis)
      
      Environment:draw()
      
      -- draw sprite
      xpos,ypos = ZeroChar:pos()
      xpos,ypos = Environment:checkBoarders(xpos,ypos,SPRITE:width(),SPRITE:height())
      ZeroChar:pos(xpos,ypos)
      
      SPRITE:Draw(xpos,ypos,0)
            
      -- setup matrix for points/lines --
      Gum.matrixMode(Gu.MODEL)
      Gum.loadIdentity()
      Gum.translate(xpos,ypos,0)
      Gum.rotateXYZ(SPRITE:rotateXYZ())
  
      -- draw points/lines without texture --
      Gu.disable(Gu.TEXTURE_2D)
      Gum.drawArray(Gu.LINE_STRIP,Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, pointS)
      
      --[[
      Gum.matrixMode(Gu.MODEL)
      Gum.loadIdentity()
      Gum.translate(xpos,ypos,zpos)
      Gum.rotateXYZ(SPRITE:rotateXYZ())
      ]]--
      
      -- draw points/lines without texture --
      Gu.disable(Gu.TEXTURE_2D)
      Gum.drawArray(Gu.LINES,Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, point2)
    Gu.end3d()

    screen:print(2,2,"FPS: " .. counter:update(),Color.new(0,0,0))
--    screen:print(2,10,"sl: " .. sl .. "   esl: " .. tostring(esl),Color.new(0,0,0))

    screen.waitVblankStart()
    screen:flip()
    
    ZeroChar:update()
    ZeroChar:action(Ctrl:NubLeft(),Ctrl:NubRight(),Ctrl:RTrig(),Ctrl:Cross())
    
    if Ctrl:LTrig1() then
      if not SpriteSwap then
        SPRITE:setSprite(Zero[2].IMG,Zero[2].V,Zero[2].H,Zero[2].F,Zero[2].M)
        SpriteSwap = true
      elseif SpriteSwap then
        SPRITE:setSprite(Zero[1].IMG,Zero[1].V,Zero[1].H,Zero[1].F,Zero[1].M)
        SpriteSwap = false
      end
      
      xo,yo = SPRITE:Center()
      w = SPRITE:width()
      h = SPRITE:height()
      pointS = {
        {Color.new(255,255,255),-xo,-yo,0}, --1
        {Color.new(255,255,255),-xo,h-yo,0}, --2
        {Color.new(255,255,255),w-xo,h-yo,0}, --4
        {Color.new(255,255,255),w-xo,-yo,0}, --3
        {Color.new(255,255,255),-xo,-yo,0}, --1
      }
      ZeroChar:grav(grav.x,grav.y,SPRITE:height())
    end
  end
  screen:clear()
end
screen:clear()