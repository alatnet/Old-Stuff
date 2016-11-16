requireC (Global.system.dir.main .. "AnimatedSprite.lua")

Petal = {}

function Petal.new(img,NumV,NumH,AnimSpdMin,AnimSpdMax,DCTMin,DCTMax)
  local c = setmetatable(
    {
      sprite = AnimatedSprite.new(img,NumV,NumH,math.random(AnimSpdMin,AnimSpdMax)),
      Draw = false,
      pos = {
        x = 0,
        y = 0
      },
      spd = {
        x = 1,
        y = math.random(2)
      },
      DCT = {
        min = DCTMin,
        max = DCTMax,
        val = math.random(DCTMin,DCTMax),
        timer = Timer.new()
      }
    },
    {
      __index = Petal
    }
  )

  c.pos.x = math.random(480 - c.sprite:width())
  c.pos.y = (math.random(75) * -1)

  if math.random(1,20) <= 10 then
    c.spd.x = c.spd.x * -1
    c.sprite:setReverse(true)
  end

  return c
end

function Petal:draw(s)
  s = s or screen

  if self.Draw then
    self.sprite:Draw(self.pos.x,self.pos.y,s)
    self.pos.x = self.pos.x + self.spd.x
    self.pos.y = self.pos.y + self.spd.y
  end

  if self.pos.x + self.sprite:width()/2 >= s:width() then
    self.pos.x = (0 - self.sprite:width()/2) + 1
  elseif self.pos.x + self.sprite:width()/2 <= 0 then
    self.pos.x = (s:width() - self.sprite:width()/2) - 1
  end
  if self.pos.y + self.sprite:height()/2 > s:height() then self.pos.y = 0 - self.sprite:height()/2 end

  if self.DCT.timer:start() >= self.DCT.val then
    self.Draw = true
    self.spd.x = self.spd.x * -1
    self.spd.y = math.random(2)
    self.DCT.val = math.random(self.DCT.min,self.DCT.max)
    if self.sprite:isReverse() then
      self.sprite:setReverse(false)
    else
      self.sprite:setReverse(true)
    end
    self.DCT.timer:reset()
  end
end


Petals = {}

function Petals.new(img,NumV,NumH,NumPetals,AnimSpdMin,AnimSpdMax,DCTMin,DCTMax)
  AnimatedSprite.addImage(img,img)

  NumPetals = NumPetals or 20
  AnimSpdMin = AnimSpdMin or 10
  AnimSpdMax = AnimSpdMax or 30
  DCTMin = DCTMin or 1000
  DCTMax = DCTMax or 2000

  local c = setmetatable(
    {
      IMG = img,
      NUM = {
        V = NumV,
        H = NumH,
        Petals = NumPetals
      },
      AnimSpd = {
        Min = AnimSpdMin,
        Max = AnimSpdMax,
      },
      DCT = {
        Min = DCTMin,
        Max = DCTMax
      },
      sprites = {}
    },
    {
      __index = Petals
    }
  )
  
  for i=1,NumPetals do
    table.insert(c.sprites,Petal.new(img,NumV,NumH,AnimSpdMin,AnimSpdMax,DCTMin,DCTMax))
  end

  return c
end

function Petals:getNumPetals()
  return self.NUM.Petals
end

function Petals:reload()
  AnimatedSprite.addImage2List(self.IMG,self.IMG)
end

function Petals:add(val)
  self.NUM.Petals = self.NUM.Petals + val

  for i=0,val do
    table.insert(self.sprites,Petal.new(self.IMG,self.NUM.V,self.NUM.H,self.AnimSpd.Min,self.AnimSpd.Max,self.DCT.Min,self.DCT.Max))
  end
end

function Petals:remove(val)
  self.NUM.Petals = self.NUM.Petals - val
  
  for i=0,val do
    table.remove(self.sprites)
  end
end

function Petals:Draw(s)
  s = s or screen
  for i=1,table.getn(self.sprites) do
    self.sprites[i]:draw(s)
  end
end