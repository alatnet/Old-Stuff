requireC (Global.system.dir.main .."advancedDrawFuncs.lua")

Mouse = {
  Images = {
    arrow = Image.createEmpty(11,19)
  }
}

--[[ Mouse Arrow Start ]]--
Mouse.Images.arrow = Image.createEmpty(11,19)
Mouse.Images.arrow:clear(Color.new(255,255,255,0))

-- black lines
Mouse.Images.arrow:drawLine(0, 0, 10, 10, Color.new(0,0,0))
Mouse.Images.arrow:drawLine(10,10,4,10,Color.new(0,0,0))
Mouse.Images.arrow:drawLine(6,10,9,17,Color.new(0,0,0))
Mouse.Images.arrow:drawLine(9,18,7,18,Color.new(0,0,0))
Mouse.Images.arrow:pixel(3,11,Color.new(0,0,0))
Mouse.Images.arrow:pixel(1,13,Color.new(0,0,0))
Mouse.Images.arrow:pixel(0,14,Color.new(0,0,0))

-- white lines
Mouse.Images.arrow:drawLine(1,4,1,11,Color.new(255,255,255))
Mouse.Images.arrow:drawLine(2,6,2,10,Color.new(255,255,255))
Mouse.Images.arrow:drawLine(3,8,3,9,Color.new(255,255,255))
Mouse.Images.arrow:drawLine(5,12,6,15,Color.new(255,255,255))
Mouse.Images.arrow:pixel(4,11,Color.new(255,255,255))
Mouse.Images.arrow:pixel(7,16,Color.new(255,255,255))

-- grey1 lines
Mouse.Images.arrow:drawLine(0,1,0,13,Color.new(128,128,128))
Mouse.Images.arrow:drawLine(4,12,6,17,Color.new(128,128,128))

-- grey2 lines
Mouse.Images.arrow:drawLine(1,2,8,9,Color.new(192,192,192))
Mouse.Images.arrow:drawLine(1,3,7,9,Color.new(192,192,192))
Mouse.Images.arrow:drawLine(2,5,6,9,Color.new(192,192,192))
Mouse.Images.arrow:drawLine(3,7,5,9,Color.new(192,192,192))
Mouse.Images.arrow:drawLine(4,9,1,12,Color.new(192,192,192))
Mouse.Images.arrow:drawLine(6,12,8,17,Color.new(192,192,192))
Mouse.Images.arrow:pixel(5,11,Color.new(192,192,192))
Mouse.Images.arrow:pixel(7,17,Color.new(192,192,192))
--[[ Mouse Arrow End ]]--


function Mouse.new(img)
  img = img or Mouse.Images.arrow
  local c = setmetatable(
    {
      cursor = {
        img = img,
        hot_spot = {x=0,y=0}
      },
      pos = {x=0,y=0}
    },
    {
      __index = Mouse
    }
  )

  return c
end

function Mouse:Image(img)
  if img == nil then
    return self.cursor.img
  else
    self.cursor = img
  end
end

function Mouse:Move(x,y)
  self.pos.x = self.pos.x + x
  self.pos.y = self.pos.y + y
  
  if self.pos.x + self.cursor.hot_spot.x <= 0 then
    self.pos.x = -self.cursor.hot_spot.x
  end

  if self.pos.y + self.cursor.hot_spot.y <= 0 then
    self.pos.y = -self.cursor.hot_spot.y
  end
  
  if self.pos.x + self.cursor.hot_spot.x >= screen:width() then
    self.pos.x = screen:width() - self.cursor.hot_spot.x - 1
  end

  if self.pos.y + self.cursor.hot_spot.y >= screen:height() then
    self.pos.y = screen:height() - self.cursor.hot_spot.y - 1
  end
end

function Mouse:HotSpot(x,y)
  if x == nil or y == nil then
    return self.cursor.hot_spot.x,self.cursor.hot_spot.y
  else
    self.cursor.hot_spot.x = x
    self.cursor.hot_spot.y = y
  end
end

function Mouse:Pos(x,y)
  if x == nil or y == nil then
    return self.pos.x,self.pos.y
  else
    self.pos.x = x
    self.pos.y = y

    if self.pos.x + self.cursor.hot_spot.x <= 0 then
      self.pos.x = -self.cursor.hot_spot.x
    end
  
    if self.pos.y + self.cursor.hot_spot.y <= 0 then
      self.pos.y = -self.cursor.hot_spot.y
    end
    
    if self.pos.x + self.cursor.hot_spot.x >= screen:width() then
      self.pos.x = screen:width() - self.cursor.hot_spot.x - 1
    end
  
    if self.pos.y + self.cursor.hot_spot.y >= screen:height() then
      self.pos.y = screen:height() - self.cursor.hot_spot.y - 1
    end
  end
end

function Mouse:Draw(s)
  s = s or screen
  s:blit(self.pos.x-self.cursor.hot_spot.x,self.pos.y-self.cursor.hot_spot.y,self.cursor.img)
  --[[
  Gu.start3d()
    Gum.matrixMode(Gu.MODEL)
    Gum.loadIdentity()
    Gu.colorMaterial(Gu.AMBIENT+Gu.DIFFUSE)
    Gu.color(Color.new(0,0,0,255))
    Global.draw.advancedBlit(self.cursor.img,self.pos.x-self.cursor.hot_spot.x,self.pos.y-self.cursor.hot_spot.y)
  Gu.end3d()
  ]]--
end

function Mouse:DrawHS(s)
  s = s or screen
  s:drawLine(x1,y1,x2,y2,Color.new(255,0,0))
  s:drawLine(x1,y1,x2,y2,Color.new(0,0,255))
end

--[[
function Mouse:()
end
]]--