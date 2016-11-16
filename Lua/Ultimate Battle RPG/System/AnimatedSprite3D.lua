--[[
3D Animated Sprite Luaplayer Class\Library  Ver. 1.0
Created By: alatnet
Dev Team X Productions
NEW!!!
]]--

requireC(Global.system.dir.main .. "AnimatedSprite.lua")

AnimatedSprite3D = {}

function AnimatedSprite3D.ImgPlane(xo,yo,w,h,mult)
  --local w = width
  --local h = height
  local s

  if w >= h then
    s = w
  elseif h >= w then
    s = h
  end
  
  s = s*mult
  
  --[[
  local verts = {
    {0,0,-xo,-yo,0}, --1
    {1,0,w-xo,-yo,0}, --2
    {0,1,-xo,h-yo,0}, --3
    {1,1,w-xo,h-xo,0} --4
  }
  ]]--
  
  local verts = {
    {0,0,-xo,-yo,0}, --1
    {1,0,s-xo,-yo,0}, --2
    {0,1,-xo,s-yo,0}, --3
    {1,1,s-xo,s-xo,0} --4
  }
  
  --[[
  local verts = {
    {0,0,-xo,-yo,0},
    {1,1,s-xo,s-xo,0}
  }
  ]]--

  --local c = Color.new(255,255,255)
  -- -90 degrees z rotation
  --[[
  local verts = {
    {0,0,-xo,-yo,0}, --1
    {1,0,-xo,s-yo,0}, --3
    {0,1,s-xo,-yo,0}, --2

    {1,1,s-xo,s-yo,0}, --4
    {0,1,s-xo,-yo,0}, --2
    {1,0,-xo,s-yo,0}  --3
  }
  ]]--
  --[[
  local verts = {
    {0,0,-xo,-yo,0}, --1
    {1,0,-xo,h-yo,0}, --3
    {0,1,w-xo,-yo,0}, --2

    {1,1,w-xo,h-yo,0}, --4
    {0,1,w-xo,-yo,0}, --2
    {1,0,-xo,h-yo,0}  --3
  }
  ]]--

  -- 0 degrees z rotation
  --[[
  local verts = {
    {0,0,-xo,s-yo,0}, --3
    {1,0,s-xo,s-yo,0}, --4
    {0,1,-xo,-yo,0}, --1

    {1,1,s-xo,-yo,0}, --2
    {0,1,-xo,-yo,0}, --1
    {1,0,s-xo,s-yo,0}  --4
  }
  ]]--
  --[[
  local verts = {
    {0,0,-xo,h-yo,0}, --3
    {1,0,w-xo,h-yo,0}, --4
    {0,1,-xo,-yo,0}, --1

    {1,1,w-xo,-yo,0}, --2
    {0,1,-xo,-yo,0}, --1
    {1,0,w-xo,h-yo,0}  --4
  }
  ]]--
  
  return verts
end

function AnimatedSprite3D.DefaultTexFunc()
  Gu.texFunc(Gu.TFX_BLEND,Gu.TCC_RGBA) --TFX_MODULATE TFX_DECAL TFX_BLEND TFX_REPLACE TFX_ADD
  Gu.texEnvColor(Color.new(255,255,255,255))
  Gu.texFilter(Gu.NEAREST_MIPMAP_NEAREST,Gu.LINEAR_MIPMAP_LINEAR)
  Gu.texScale(1, 1)
  Gu.texOffset(0, 0)

  if _G.Gu["texWrap"] ~= nil then
    Gu.texWrap(Gu.CLAMP,Gu.CLAMP)
  end

  --if _G.Gu["texProjMapMode"] ~= nil then
  --  Gu.texProjMapMode(Gu.POSITION)
  --end
end

function AnimatedSprite3D.new(img,Num_Sprites_Vertical,Num_Sprites_Horizontal,freq,mult,func)
  mult = mult or 1.56
  if type(img) ~= "string" then
    error("bad argument #1: (string expected, got " .. type(img) ..")",2)
  end
  
  if type(Num_Sprites_Vertical) ~= "number" then
    error("bad argument #2: (number expected, got " .. type(Num_Sprites_Vertical) ..")",2)
  end
  
  if type(Num_Sprites_Horizontal) ~= "number" then
    error("bad argument #3: (number expected, got " .. type(Num_Sprites_Horizontal) ..")",2)
  end
  
  if type(freq) ~= "number" then
    error("bad argument #4: (number expected, got " .. type(freq) ..")",2)
  end
  
  if type(mult) ~= "number" then
    error("bad argument #5: (number expected, got " .. type(mult) ..")",2)
  end
  
  func = func or AnimatedSprite3D.DefaultTexFunc
  if type(func) ~= "function" then
    error("bad argument #6: (function expected, got " .. type(func) ..")",2)
  end
  
  local c = setmetatable(
    {
      SPRITE = AnimatedSprite.new(img,Num_Sprites_Vertical,Num_Sprites_Horizontal,freq),
      FUNC = func,
      VERTS = nil,
      MULT = mult,
      ROT = {
        x = 180 *(Gu.PI/180),
        y = 0 *(Gu.PI/180),
        z = 0 *(Gu.PI/180)
      },
      SIZE = {
        IMG = {
          w = 0,
          h = 0
        },
        PLANE = {
          w = 0,
          h = 0
        }
      },
      OFFSET = {
        x = 0,
        y = 0
      },
      COL = {
        AMBIENT = Color.new(0,0,0,255),
        DIFFUSE = Color.new(0,0,0,255),
        SPECULAR = Color.new(0,0,0,255)
      }
    },
    {
      __index = AnimatedSprite3D
    }
  )

  c.SIZE.IMG.w = c.SPRITE:width()
  c.SIZE.IMG.h = c.SPRITE:height()
  c.SIZE.PLANE.w = c.SPRITE:width()
  c.SIZE.PLANE.h = c.SPRITE:height()
  c.VERTS = AnimatedSprite3D.ImgPlane(c.OFFSET.x,c.OFFSET.y,c.SIZE.PLANE.w,c.SIZE.PLANE.h,c.MULT)
  
  --[[
  local s

  if c.SPRITE:width() >= c.SPRITE:height() then
    s = c.SPRITE:width()
  elseif c.SPRITE:height() >= c.SPRITE:width() then
    s = c.SPRITE:height()
  end
  
  c.IMG = Image.createEmpty(s,s)
  ]]--

  return c
end

function AnimatedSprite3D:TexFunc(func)
  if type(func) ~= "function" then
    error("bad argument #1: (function expected, got " .. type(func) ..")",2)
  end
  
  self.FUNC = func
end

function AnimatedSprite3D:Size(w,h,mult)
  mult = mult or 1.56
  if w == nil or h == nil then
    return self.SIZE.PLANE.w,self.SIZE.PLANE.h
  else
    self.SIZE.PLANE.w = w
    self.SIZE.PLANE.h = h
    self.MULT = mult
    self.VERTS = AnimatedSprite3D.ImgPlane(self.OFFSET.x,self.OFFSET.y,self.SIZE.PLANE.w,self.SIZE.PLANE.h,self.MULT)
  end
end

function AnimatedSprite3D:getMult()
  return self.MULT
end

function AnimatedSprite3D:setMult(mult)
  mult = mult or 1.56
  self.MULT = mult
  self.VERTS = AnimatedSprite3D.ImgPlane(self.OFFSET.x,self.OFFSET.y,self.SIZE.PLANE.w,self.SIZE.PLANE.h,self.MULT)
end

function AnimatedSprite3D:width()
  return self.SIZE.PLANE.w
end

function AnimatedSprite3D:height()
  return self.SIZE.PLANE.h
end

function AnimatedSprite3D:Center(x,y,mult)
  mult = mult or 1.56
  if x == nil or y == nil then
    return self.OFFSET.x,self.OFFSET.y
  else
    self.OFFSET.x = x
    self.OFFSET.y = y
    self.MULT = mult
    self.VERTS = AnimatedSprite3D.ImgPlane(self.OFFSET.x,self.OFFSET.y,self.SIZE.PLANE.w,self.SIZE.PLANE.h,self.MULT)
  end
end

function AnimatedSprite3D:rotateXYZ(x,y,z)
  if x == nil or y == nil or z == nil then
    return self.ROT.x,self.ROT.y,self.ROT.z
  else
    self.ROT.x = x
    self.ROT.y = y
    self.ROT.z = z
  end
end

function AnimatedSprite3D:getSprite()
  return self.SPRITE
end

function AnimatedSprite3D:setSprite(img,Num_Sprites_Vertical,Num_Sprites_Horizontal,freq,mult)
  mult = mult or 1.56
  self.SPRITE:setImage(img,Num_Sprites_Vertical,Num_Sprites_Horizontal,freq)
  self.SIZE.IMG.w = self.SPRITE:width()
  self.SIZE.IMG.h = self.SPRITE:height()
  
  self.SIZE.PLANE.w = self.SPRITE:width()
  self.SIZE.PLANE.h = self.SPRITE:height()
  self.MULT = mult
  self.VERTS = AnimatedSprite3D.ImgPlane(self.OFFSET.x,self.OFFSET.y,self.SIZE.PLANE.w,self.SIZE.PLANE.h,self.MULT)
  
  --[[
  local s

  if self.SPRITE:width() >= self.SPRITE:height() then
    s = self.SPRITE:width()
  elseif self.SPRITE:height() >= self.SPRITE:width() then
    s = self.SPRITE:height()
  end
  
  self.IMG = nil
  collectgarbage()
  self.IMG = Image.createEmpty(s,s)
  ]]--
end

function AnimatedSprite3D:setBlendCol(mat,col)
  if mat == Gu.AMBIENT then
    self.COL.AMBIENT = col
  elseif mat == Gu.DIFFUSE then
    self.COL.DIFFUSE = col
  elseif mat == Gu.SPECULAR then
    self.COL.SPECULAR = col
  end
end

function AnimatedSprite3D:Draw(x,y,z)
  self.SPRITE:Update()
--  self.IMG:clear()
--  self.IMG:blit(0,0,self.SPRITE:getCurrSprite(),0,0,self.SPRITE:getCurrSprite():width(),self.SPRITE:getCurrSprite():height(),true)
  
  Gu.enable(Gu.BLEND)
  Gu.enable(Gu.TEXTURE_2D)
  --Gu.disable(Gu.LINE_SMOOTH)

  -- setup matrix for img
  Gum.matrixMode(Gu.MODEL)
  Gum.loadIdentity()
  Gum.translate(x, y, z)
  Gum.rotateXYZ(self.ROT.x,self.ROT.y,self.ROT.z) --*(Gu.PI/180)

  if _G.Gu["texMode"] ~= nil then
    Gu.texMode(Gu.PSM_8888,0,Gu.FALSE)
  end
  Gu.texImage(self.SPRITE:getCurrSprite())
  self.FUNC()
  
  Gu.colorMaterial(Gu.AMBIENT)
  Gu.color(self.COL.AMBIENT)

  Gu.colorMaterial(Gu.DIFFUSE)
  Gu.color(self.COL.DIFFUSE)

  Gu.colorMaterial(Gu.SPECULAR)
  Gu.color(self.COL.SPECULAR)

  -- draw img
  Gum.drawArray(Gu.TRIANGLE_STRIP, Gu.TEXTURE_32BITF+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, self.VERTS)
  --Gu.disable(Gu.BLEND)
  
  --Gu.enable(Gu.LINE_SMOOTH)
end