--[[
OLD!!!
]]--

Char = {}

function Char.new(x,y,spdX,spdX2,spdY,spdY2,stopX,stopX2,gravX,gravY,groundY)
  local c = setmetatable(
    {
      POS = {
        x = x,
        y = y
      },
      GRAV = {
        x = gravX,
        y = gravY,
        g = groundY
      },
      SPD = {
        x = spdX,
        x2 = spdX2,
        y = spdY,
        y2 = spdY2,
        stop = {
          x = stopX,
          x2 = stopX2
        },
        init = {
          x = spdX,
          x2 = spdX2,
          y = spdY,
          y2 = spdY2
        }
      },
      STATE = {
        move = {
          l = false,
          r = false,
          run = false,
          prev = {
            l = false,
            r = false,
            run = false
          }
        },
        jump = 0
      }
    },
    {
      __index = Char
    }
  )

  return c
end

function Char:spd(x,x2,y,y2,stopX,stopX2)
  if x == nil or x2 == nil or y == nil or y2 == nil or stopX == nil or stopX2 == nil then
    return self.SPD.init.x,self.SPD.init.x2,self.SPD.init.y,self.SPD.init.y2,self.SPD.stop.x,self.SPD.stop.x2
  else
    self.SPD.init.x = x
    self.SPD.init.x2 = x2
    self.SPD.init.y = y
    self.SPD.init.y2 = y2
    self.SPD.stop.x = stopX
    self.SPD.stop.x2 = stopX2
  end
end

function Char:grav(x,y,groundY)
  if x == nil or y == nil or groundY == nil then
    return self.GRAV.x,self.GRAV.y,self.GRAV.g
  else
    self.GRAV.x = x
    self.GRAV.y = y
    self.GRAV.g = groundY
  end
end

function Char:pos(x,y)
  if x == nil or y == nil then
    return self.POS.x,self.POS.y
  else
    self.POS.x = x
    self.POS.y = y
  end
end

function Char:update()
  self.POS.x = self.POS.x + self.GRAV.x

  if self.STATE.move.l then
    if self.STATE.move.run then
      self.POS.x = self.POS.x - self.SPD.x2
      self.STATE.move.prev.run = true
    else
      self.POS.x = self.POS.x - self.SPD.x
    end
    self.STATE.move.prev.l = true
  elseif self.STATE.move.r then
    if self.STATE.move.run then
      self.POS.x = self.POS.x + self.SPD.x2
      self.STATE.move.prev.run = true
    else
      self.POS.x = self.POS.x + self.SPD.x
    end
    self.STATE.move.prev.r = true
  else
    if self.STATE.move.prev.l then
      if self.STATE.move.prev.run then
        self.POS.x = self.POS.x - self.SPD.x2
      else
        self.POS.x = self.POS.x - self.SPD.x
      end
      
      if self.SPD.x <= 0 then
        self.SPD.x = 0
        self.STATE.move.prev.l = false
        self.STATE.move.prev.r = false
        self.STATE.move.prev.run = false
      else
        self.SPD.x = self.SPD.x - self.SPD.stop.x
      end

      if self.SPD.x2 <= 0 then
        self.SPD.x2 = 0
        self.STATE.move.prev.l = false
        self.STATE.move.prev.r = false
        self.STATE.move.prev.run = false
      else
        self.SPD.x2 = self.SPD.x2 - self.SPD.stop.x2
      end
    elseif self.STATE.move.prev.r then
      if self.STATE.move.prev.run then
        self.POS.x = self.POS.x + self.SPD.x2
      else
        self.POS.x = self.POS.x + self.SPD.x
      end
      
      if self.SPD.x <= 0 then
        self.SPD.x = 0
        self.STATE.move.prev.l = false
        self.STATE.move.prev.r = false
        self.STATE.move.prev.run = false
      else
        self.SPD.x = self.SPD.x - self.SPD.stop.x
      end

      if self.SPD.x2 <= 0 then
        self.SPD.x2 = 0
        self.STATE.move.prev.l = false
        self.STATE.move.prev.r = false
        self.STATE.move.prev.run = false
      else
        self.SPD.x2 = self.SPD.x2 - self.SPD.stop.x2
      end
    else
      if self.SPD.x ~= self.SPD.init.x then
        self.SPD.x = self.SPD.init.x
      end

      if self.SPD.x2 ~= self.SPD.init.x2 then
        self.SPD.x2 = self.SPD.init.x2
      end
    end
  end

  if self.STATE.jump == 2 then
    if self.STATE.move.run then
      self.POS.y = self.POS.y - self.SPD.y2
      self.SPD.y2 = self.SPD.y2 - self.GRAV.y
      if self.SPD.y2 <= 0 then
        self.STATE.jump = 1
      end
    else
      self.POS.y = self.POS.y - self.SPD.y
      self.SPD.y = self.SPD.y - self.GRAV.y
      if self.SPD.y <= 0 then
        self.STATE.jump = 1
      end
    end
  elseif self.STATE.jump == 1 then
    if self.STATE.move.run then
      self.POS.y = self.POS.y - self.SPD.y2
      self.SPD.y2 = self.SPD.y2 - self.GRAV.y
    else
      self.POS.y = self.POS.y - self.SPD.y
      self.SPD.y = self.SPD.y - self.GRAV.y
    end

    if self.POS.y >= self.GRAV.g then
      self.STATE.jump = 0
      self.POS.y = self.GRAV.g
    end
  elseif self.STATE.jump == 0 then
    if self.SPD.y ~= self.SPD.init.y then
      self.SPD.y = self.SPD.init.y
    end

    if self.SPD.y2 ~= self.SPD.init.y then
      self.SPD.y2 = self.SPD.init.y2
    end
    
    if self.POS.y >= self.GRAV.g then
      self.STATE.jump = 0
      self.POS.y = self.GRAV.g
    end
  end
end

function Char:action(moveL,moveR,run,jump)
  if moveL then
    self.STATE.move.l = true
    self.STATE.move.r = false
    if self.SPD.x ~= self.SPD.init.x then
      self.SPD.x = self.SPD.init.x
    end
    if self.SPD.x2 ~= self.SPD.init.x2 then
      self.SPD.x2 = self.SPD.init.x2
    end
  elseif moveR then
    self.STATE.move.l = false
    self.STATE.move.r = true
    if self.SPD.x ~= self.SPD.init.x then
      self.SPD.x = self.SPD.init.x
    end
    if self.SPD.x2 ~= self.SPD.init.x2 then
      self.SPD.x2 = self.SPD.init.x2
    end
  else
    self.STATE.move.l = false
    self.STATE.move.r = false
  end

  self.STATE.move.run = run

  if jump then
    if self.STATE.jump == 0 then
      self.STATE.jump = 2
      if self.SPD.y ~= self.SPD.init.y then
        self.SPD.y = self.SPD.init.y
      end
  
      if self.SPD.y2 ~= self.SPD.init.y then
        self.SPD.y2 = self.SPD.init.y2
      end
    end
  else
    if self.STATE.jump == 2 or self.STATE.jump == 1 then
      self.STATE.jump = 1
    end
  end
end