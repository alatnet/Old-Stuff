--[[
Animated Sprite Luaplayer Class\Library  Ver. 2.2
Created By: alatnet
Dev Team X Productions
NEW!!!
]]--

requireC (Global.system.dir.main .."advancedDrawFuncs.lua")

AnimatedSprite = {
  _LOADED = {},
  _RELOC = {}
}

function AnimatedSprite.removeImage(img)
  for k,v in pairs(AnimatedSprite._RELOC) do
    if v == img then AnimatedSprite._RELOC[k] = nil end
  end
  
  AnimatedSprite._LOADED[img] = nil
  
  collectgarbage()
end

function AnimatedSprite.CheckReloc(img,name)
  if AnimatedSprite._LOADED[img] ~= nil then
    if AnimatedSprite._RELOC[name] == img then
      return 0 --"Relocation Set"
    else
      return 2 --"No Relocation Set"
    end
  else
    return 1 --"No Img Loaded"
  end
end

function AnimatedSprite.addImage(img,name)
  if type(img) == "string" then
    if type(name) == "string" then
      local Reloc_Check = AnimatedSprite.CheckReloc(img,name)
      if Reloc_Check == 1 then
        AnimatedSprite._LOADED[img] = Image.load(img)
        AnimatedSprite._RELOC[name] = img
      elseif Reloc_Check == 2 then
        AnimatedSprite._RELOC[name] = img
      end
    else
      error("bad argument #2: (string expected, got " .. type(name) .. ")",2)
    end
  else
    error("bad argument #1: (Path expected, got " .. type(img) .. ")",2)
  end
end

function AnimatedSprite.purgeList()
  AnimatedSprite._LOADED = nil
  AnimatedSprite._RELOC = nil
  collectgarbage()
  AnimatedSprite._LOADED = {}
  AnimatedSprite._RELOC = {}
end

function AnimatedSprite:toString()
  return "Image: " .. self.IMG .. "\nRows: " .. self.ROWS .. "\nCols: " .. self.COLS .. "\nFreq: " .. self.interval .. "\nFrame:" .. "\n-Curr: " .. self.frame.curr .. "\n-Max:" .. self.frame.max .. "\n-Pos: " .. "\n--X: " .. self.frame.x .. "\n--Y: " .. self.frame.y .. "\n-Width: " .. self.frame.width .. "\n-Height" .. self.frame.height .. "\nPause: " .. tostring(self.pause) .. "\nReverse: " .. tostring(self.reverse) .. "\nLoop: " .. tostring(self.loop.enable) .. "\nTransparancy: " .. tostring(self.Transparency.Enabled)
end

function AnimatedSprite.new(img,Num_Sprites_Vertical,Num_Sprites_Horizontal,freq)
  if type(img) == "string" then
    if AnimatedSprite._RELOC[img] == nil then
      AnimatedSprite.addImage(img,img)
    end
  else
    error("bad argument #1: (string expected, got " .. type(img) .. ")",2)
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

  Num_Sprites_Horizontal = Num_Sprites_Horizontal or 1
  Num_Sprites_Vertical = Num_Sprites_Vertical or 1
  freq = freq or 1000

  local c = setmetatable(
    {
      IMG = img,
      ROWS = Num_Sprites_Vertical,  --rows are y axis
      COLS = Num_Sprites_Horizontal,  --cols are x axis
      interval = freq,
      frame = {
        curr = 1,
        max = Num_Sprites_Vertical*Num_Sprites_Horizontal,
        x = 0,
        y = 0,
        width = AnimatedSprite._LOADED[AnimatedSprite._RELOC[img]]:width()/Num_Sprites_Horizontal,
        height = AnimatedSprite._LOADED[AnimatedSprite._RELOC[img]]:height()/Num_Sprites_Vertical,
        IMG = nil
      },
      pause = false,
      reverse = false,
      loop = {
        enable = true,
        stopAt = Num_Sprites_Vertical*Num_Sprites_Horizontal
      },
      timer = Timer.new(),
      Transparency = {
        Enabled = true,
        Color = {[false] = Color.new(255,0,255),[true] = Color.new(255,255,255,0)}
      }
    },
    {
      __index = AnimatedSprite,
      __tostring = AnimatedSprite["toString"]
    }
  )

  c.frame.IMG = Image.createEmpty(c.frame.width,c.frame.height)
  c.frame.IMG:clear(c.Transparency.Color[c.Transparency.Enabled])
  c.frame.IMG:blit(0,0,AnimatedSprite._LOADED[AnimatedSprite._RELOC[c.IMG]],c.frame.x,c.frame.y,c.frame.width,c.frame.height,true)

  return c
end

function AnimatedSprite:resetAnim()
  self.frame.curr = 1
  self.frame.x = 0
  self.frame.y = 0
  self.frame.IMG:clear(self.Transparency.Color[self.Transparency.Enabled])
  self.frame.IMG:blit(0,0,AnimatedSprite._LOADED[AnimatedSprite._RELOC[self.IMG]],self.frame.x,self.frame.y,self.frame.width,self.frame.height,true)
end

function AnimatedSprite:shiftFrame(val)
  if val == 1 then
    self.frame.curr = self.frame.curr + 1
    self.frame.x = self.frame.x + self.frame.width
    if self.frame.x >= AnimatedSprite._LOADED[AnimatedSprite._RELOC[self.IMG]]:width() then
      self.frame.x = 0
      self.frame.y = self.frame.y + self.frame.height
    end
    if self.frame.y >= AnimatedSprite._LOADED[AnimatedSprite._RELOC[self.IMG]]:height() then
      self.frame.x = 0
      self.frame.y = 0
      self.frame.curr = 1
    end
  elseif val == -1 then
    self.frame.curr = self.frame.curr - 1
    self.frame.x = self.frame.x - self.frame.width
    if self.frame.x < 0 then
      self.frame.x = AnimatedSprite._LOADED[AnimatedSprite._RELOC[self.IMG]]:width() - self.frame.width
      self.frame.y = self.frame.y - self.frame.height
    end
    if self.frame.y < 0 then
      self.frame.x = AnimatedSprite._LOADED[AnimatedSprite._RELOC[self.IMG]]:width() - self.frame.width
      self.frame.y = AnimatedSprite._LOADED[AnimatedSprite._RELOC[self.IMG]]:height() - self.frame.height
      self.frame.curr = self.frame.max
    end
  elseif val > 0 then
    for i=1,val do
      self.frame.x = self.frame.x + self.frame.width
      self.frame.curr = self.frame.curr + 1
      if self.frame.x >= AnimatedSprite._LOADED[AnimatedSprite._RELOC[self.IMG]]:width() then
        self.frame.x = 0
        self.frame.y = self.frame.y + self.frame.height
      end
      if self.frame.y >= AnimatedSprite._LOADED[AnimatedSprite._RELOC[self.IMG]]:height() then
        self.frame.x = 0
        self.frame.y = 0
      end
    end
  elseif val < 0 then
    val = val * -1
    for i=1,val do
      self.frame.x = self.frame.x - self.frame.width
      self.frame.curr = self.frame.curr - 1
      if self.frame.x < 0 then
        self.frame.x = AnimatedSprite._LOADED[AnimatedSprite._RELOC[self.IMG]]:width() - self.frame.width
        self.frame.y = self.frame.y - self.frame.height
      end
      if self.frame.y < 0 then
        self.frame.x = AnimatedSprite._LOADED[AnimatedSprite._RELOC[self.IMG]]:width() - self.frame.width
        self.frame.y = AnimatedSprite._LOADED[AnimatedSprite._RELOC[self.IMG]]:height() - self.frame.height
      end
    end
  end

--  self.frame.IMG:clear(self.Transparency.Color[self.Transparency.Enabled])
--  self.frame.IMG:blit(0,0,AnimatedSprite._LOADED[AnimatedSprite._RELOC[self.IMG]],self.frame.x,self.frame.y,self.frame.width,self.frame.height,true)
end

function AnimatedSprite:atLastFrame()
  return self.frame.curr == self.frame.max
end

function AnimatedSprite:getFreq()
  return self.interval
end

function AnimatedSprite:setFreq(freq)
  freq = freq or 1000

  if freq <= -1 then freq = -1 end

  self.interval = freq
end

function AnimatedSprite:getImage()
  return AnimatedSprite._LOADED[AnimatedSprite._RELOC[self.IMG]]
end

function AnimatedSprite:setImage(img,Num_Sprites_Vertical,Num_Sprites_Horizontal,freq)
  if type(img) == "string" then
    if AnimatedSprite._RELOC[img] == nil then
      AnimatedSprite.addImage(img,img)
    end
    self.IMG = img
  else
    error("bad argument #1: (string expected, got " .. type(img) .. ")", 2)
  end

  Num_Sprites_Horizontal = Num_Sprites_Horizontal or 1
  Num_Sprites_Vertical = Num_Sprites_Vertical or 1
  freq = freq or 1000

  local num_rows = Num_Sprites_Vertical   --rows are y axis
  local num_cols = Num_Sprites_Horizontal     --cols are x axis

  self.ROWS = num_rows
  self.COLS = num_cols
  self.interval = freq
  self.frame.curr = 1
  self.frame.max = num_rows*num_cols
  self.frame.x = 0
  self.frame.y = 0
  self.frame.width = AnimatedSprite._LOADED[AnimatedSprite._RELOC[img]]:width()/num_cols
  self.frame.height = AnimatedSprite._LOADED[AnimatedSprite._RELOC[img]]:height()/num_rows
  self.frame.IMG = Image.createEmpty(self.frame.width,self.frame.height)
  collectgarbage()
  
  self.frame.IMG:clear(self.Transparency.Color[self.Transparency.Enabled])
  self.frame.IMG:blit(0,0,AnimatedSprite._LOADED[AnimatedSprite._RELOC[self.IMG]],self.frame.x,self.frame.y,self.frame.width,self.frame.height,true)
end

function AnimatedSprite:getSpriteFromPos(x,y)
  x = x or 0
  y = y or 0

  if x < 0 or y < 0 or x > self.COLS or y > self.ROWS then
    error("Position out of bounds.",2)
  end

  local image = Image.createEmpty(self.frame.width,self.frame.height)
  image:clear(Color.new(256,256,256,0))
  image:blit(0, 0, AnimatedSprite._LOADED[AnimatedSprite._RELOC[self.IMG]], x * self.frame.width, y * self.frame.height, self.frame.width, self.frame.height,true)
  return image
end

function AnimatedSprite:getSpriteFromFrame(val)
  val = val or 1
  
  --if val == 1 then
  --  return self:getSpriteFromPos(0,0)
  --end
  
  if val < 0 or val > self.frame.max then
      error("Frame out of bounds",2)
  end
  
  local x = val * self.frame.width
  local y = 0
  
  while x > AnimatedSprite._LOADED[AnimatedSprite._RELOC[self.IMG]]:width() do
    x = x - self.frame.width
    y = y + self.frame.height
  end
  
  local image = Image.createEmpty(self.frame.width,self.frame.height)
  image:clear(Color.new(256,256,256,0))
  image:blit(0, 0, AnimatedSprite._LOADED[AnimatedSprite._RELOC[self.IMG]], x, y, self.frame.width, self.frame.height,true)
  return image

  --[[
  local x=0
  local y=0

  for i=1,val do
    x = x + 1
    if x > self.COLS then
      x=0
      y=y+1
    end
  end

  return self:getSpriteFromPos(x,y)
  ]]--
end

function AnimatedSprite:getCurrSprite()
  return self.frame.IMG
end

function AnimatedSprite:setPause(val)
  if type(val) == "boolean" then
    self.pause = val
  else
    error("bad argument #1: (boolean expected, got " .. type(val) .. ")", 2)
  end
end

function AnimatedSprite:isPause()
  return self.pause == true
end

function AnimatedSprite:setReverse(val)
  if type(val) == "boolean" then
    self.reverse = val
  else
    error("bad argument #1: (boolean expected, got " .. type(val) .. ")", 2)
  end
end

function AnimatedSprite:isReverse()
  return self.reverse == true
end

function AnimatedSprite:width()
  return self.frame.width
end

function AnimatedSprite:height()
  return self.frame.height
end

function AnimatedSprite:getCurrFrame()
  return self.frame.curr
end

function AnimatedSprite:setCurrFrame(val)
  if val <= 1 or val > self.frame.max then
    self.frame.x = 0
    self.frame.y = 0
    self.frame.curr = 1
  elseif val == self.frame.max then
    self.frame.curr = self.frame.max
    self.frame.x = self.frame.width * self.COLS
    self.frame.y = self.frame.height * self.ROWS
  else
    self:shiftFrame(val - self.frame.curr)
  end
  
  self.frame.IMG:clear(self.Transparency.Color[self.Transparency.Enabled])
  self.frame.IMG:blit(0,0,AnimatedSprite._LOADED[AnimatedSprite._RELOC[self.IMG]],self.frame.x,self.frame.y,self.frame.width,self.frame.height,true)
end

function AnimatedSprite:checkCollision(x,y,Obj_x,Obj_y,Obj_w,Obj_h)
  local up,down,left,right = false,false,false,false
  
  local w1 = self.frame.width
  local h1 = self.frame.height

  local x2 = Obj_x
  local y2 = Obj_y
  local w2 = Obj_w
  local h2 = Obj_h

  if ((x >= x2 and x <= x2 + w2) or (x+w1 >= x2 and x+w1 <= x2 + w2) or (x >= x2 and x+w1 <= x2+w2)) and (y+h1 >= y and y <= y2) then
    up = true  -- Up Collision
  end
  if ((x >= x2 and x <= x2 + w2) or (x+w1 >= x2 and x+w1 <= x2 + w2) or (x >= x2 and x+w1 <= x2+w2)) and (y <= y2+h2 and y+h1 >= y2+h2) then
    down = true  -- Down Collision
  end
  if ((y >=y2 and y1 <= x2 + h2) or (y+h1 >= y2 and y+h1 <= y2 + h2) or (y>=y2 and y+h1 <= y2+h2)) and (x+w1 >= x2 and x <= x2) then
    left = true -- Left Collision
  end
  if ((y >=y2 and y <= x2 + h2) or (y+h1 >= y2 and y+h1 <= y2 + h2) or (y>=y2 and y+h1 <= y2+h2)) and (x <= x2+w2 and x+w1 >= x2+w2) then
    right = true -- Right Collision
  end

  return up,down,left,right
end

function AnimatedSprite:setTransparency(val)
  if type(val) == "boolean" then
    self.Transparency.Enabled = val
    self.frame.IMG:clear(self.Transparency.Color[self.Transparency.Enabled])
    self.frame.IMG:blit(0,0,AnimatedSprite._LOADED[AnimatedSprite._RELOC[self.IMG]],self.frame.x,self.frame.y,self.frame.width,self.frame.height,true)
  else
    error("bad argument #1: (boolean expected, got " .. type(val) .. ")", 2)
  end
end

function AnimatedSprite:isTransparent()
  return self.Transparency.Enabled == true
end

function AnimatedSprite:setTransparencyColor(col)
  if type(val) == "userdata" then
    if getmetatable(col).__index == Color then
      col = col or Color.new(255,0,255)
      self.Transparency.Color[false] = col
      
      self.frame.IMG:clear(self.Transparency.Color[self.Transparency.Enabled])
      self.frame.IMG:blit(0,0,AnimatedSprite._LOADED[AnimatedSprite._RELOC[self.IMG]],self.frame.x,self.frame.y,self.frame.width,self.frame.height,true)
      
      return
    end
  end
  
  error("bad argument #1: (Color expected, got " .. type(val) .. ")", 2)
end

function AnimatedSprite:getTransparencyColor()
  return self.Transparency.Color
end

function AnimatedSprite:setLooping(val)
  if type(val) == "boolean" then
    self.loop.enable = val
  else
    error("bad argument #1: (boolean expected, got " .. type(val) .. ")", 2)
  end
end

function AnimatedSprite:isLooping()
  return self.loop.enable == true
end

function AnimatedSprite:setLoopStopAt(val)
  if val >= 1 and val <= self.frame.max then
    self.loop.stopAt = val
  end
end

function AnimatedSprite:getLoopStopAt()
  return self.loop.stopAt
end

function AnimatedSprite:Update()
  if not self.loop.enable then
    if self.frame.curr == self.loop.stopAt then
      self.pause = true
    end
  end
  
  if self.interval > -1 then
    if not self.pause then
      if self.timer:start() >= self.interval then
        if self.reverse then
          self:shiftFrame(-1)
        else
          self:shiftFrame(1)
        end
        self.frame.IMG:clear(self.Transparency.Color[self.Transparency.Enabled])
        self.frame.IMG:blit(0,0,AnimatedSprite._LOADED[AnimatedSprite._RELOC[self.IMG]],self.frame.x,self.frame.y,self.frame.width,self.frame.height,true)
        self.timer:reset()
      end
    else
      self.timer:stop()
    end
  else
    self.timer:stop()
  end
end

function AnimatedSprite:Draw(x,y,s)
  s = s or screen
  x = x or 0
  y = y or 0

  self:Update()

  if x + self.frame.width > 0 and y + self.frame.height > 0 and x < s:width() and y < s:height() then
    --s:blit(x,y,AnimatedSprite._LOADED[AnimatedSprite._RELOC[self.IMG]],self.frame.x,self.frame.y,self.frame.width,self.frame.height,true)
    
    s:blit(x,y,self.frame.IMG,0,0,self.frame.IMG:width(),self.frame.IMG:height(),true)
  end
end

function AnimatedSprite:DrawGU(x,y)
  x = x or 0
  y = y or 0

  local drawFunc = function (img,dx,dy,sx,sy,sw,sh,slice)
    dx = dx or 0
    dy = dy or 0
    sx = sx or 0
    sy = sy or 0
    sw = sw or img:width()
    sh = sh or img:height()
    slice = slice or 128
  
    Gu.enable(Gu.BLEND)
    Gu.enable(Gu.TEXTURE_2D)
    Gu.texMode(Gu.PSM_8888,0,Gu.FALSE)
    Gu.texImage(img)
    Gu.texFunc(Gu.TFX_BLEND,Gu.TCC_RGBA) --TFX_MODULATE TFX_DECAL TFX_BLEND TFX_REPLACE TFX_ADD
    Gu.texEnvColor(Color.new(255,255,255,255))
    Gu.texFilter(Gu.NEAREST_MIPMAP_LINEAR,Gu.NEAREST_MIPMAP_LINEAR)
    Gu.texScale(1, 1)
    Gu.texOffset(0, 0)
    Gu.texWrap(Gu.CLAMP,Gu.CLAMP)
    
    local w,h = slice,slice
    
    for x=sx,sx+sw,slice do
      for y=sy,sy+sh,slice do
        if (x+slice)<(sx+sw) then w=slice else w=(sx+sw)-x end
        if (y+slice)<(sy+sh) then h=slice else h=(sy+sh)-y end
        local verts = {
          {x,y,x+dx,y+dy,0},  --1
          {x+w,y,(x+w)+dx,y+dy,0}, --2
          {x,y+h,x+dx,(y+h)+dy,0}, --3
          {x+w,y+h,(x+w)+dx,(y+h)+dy,0}  --4
        }

        Gum.drawArray(Gu.TRIANGLE_STRIP,Gu.TEXTURE_32BITF+Gu.VERTEX_32BITF+Gu.TRANSFORM_2D,verts)
      end
    end
  end

  self:Update()

  if x + self.frame.width > 0 and y + self.frame.height > 0 and x < s:width() and y < s:height() then
    drawFunc(self.frame.IMG,x,y,0,0,self.frame.IMG:width(),self.frame.IMG:height())
  end
end