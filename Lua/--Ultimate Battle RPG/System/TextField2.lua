requireC (Global.system.dir.main .."advancedDrawFuncs.lua")

TextField2 = {}

function TextField2.new(size,bSpd,bg,fg,shadow)
  if shadow == nil then
    shadow = true
  elseif shadow == false then
    shadow = false
  else
    shadow = true
  end
  
  size = size or 10
  
  local c = setmetatable(
    {
      buff = "",
      size = {
        c = size,
        w = (size*8)+2,
        h = 10
      },
      cursor = { -- controls cursors movement in
        pos1 = 1, -- the box
        pos2 = 1, -- the buffer
        pos3 = 0  -- the buffer in the box
      },
      blink = {
        timer = Timer.new(),
        active = true,
        spd = bSpd or 500
      },
      col = {
        bg = bg or Color.new(128,128,128,255),
        fg = fg or Color.new(0,0,0,255)
      },
      shadow = {
        on = shadow,
        col = Color.new(0,0,0,96),
        x = 5,
        y = 6
      }--[[,
      highlight = {
        active = false,
        pos1 = 1,
        pos2 = 1,
        col = Color.new(r,g,b,255)
      }
      ]]--
    },
    {
      __index = TextField2
    }
  )

  return c
end

function TextField2:width()
  return self.size.w
end

function TextField2:height()
  return self.size.h
end

function TextField2:setText(txt)
  if type(txt) ~= "string" then
    self.buff = tostring(txt)
  else
    self.buff = txt
  end
end

function TextField2:getText()
  return self.buff
end

function TextField2:addChar(char)
  if char == "\b" then
    self:removeChar()
  elseif char == "\n" then
  elseif char == "\t" then
  elseif char == nil then
  else
    if self.cursor.pos2 == string.len(self.buff) then
      self.buff = self.buff .. char
    else
      self.buff = string.sub(self.buff,1,self.cursor.pos2-1) .. char .. string.sub(self.buff,self.cursor.pos2)
    end
    self:moveCursor("r")
  end
end

function TextField2:removeChar()
  if self.cursor.pos2 == string.len(self.buff) then
    self.buff = string.sub(self.buff,1,string.len(self.buff)-1)
  else
    self.buff = string.sub(self.buff,1,self.cursor.pos2-2) .. string.sub(self.buff,self.cursor.pos2)
  end
  self:moveCursor("l")
end

function TextField2:moveCursor(dir)
  if dir == "l" then
    if self.cursor.pos2 > 1 then
      self.cursor.pos2 = self.cursor.pos2 - 1
    end
    
    if self.cursor.pos1 == 1 then
      if self.cursor.pos3 > 0 then
        self.cursor.pos3 = self.cursor.pos3 - 1
      end
    elseif self.cursor.pos1 > 1 then
      self.cursor.pos1 = self.cursor.pos1 - 1
    end
    self.blink.active = true
  elseif dir == "r" then
    if self.cursor.pos2 < string.len(self.buff) then
        self.cursor.pos2 = self.cursor.pos2 + 1
    end
    
    if self.cursor.pos1 == self.size.c then
      local SIZE = string.len(self.buff) - self.size.c
      
      if string.len(self.buff) < self.size.c then
        SIZE = 0
      end
      
      if self.cursor.pos3 < SIZE then
        self.cursor.pos3 = self.cursor.pos3 + 1
      end
    elseif self.cursor.pos1 < self.size.c then
      self.cursor.pos1 = self.cursor.pos1 + 1
    end
    self.blink.active = true
  end
end

function TextField2:Draw(x,y,active)
  if active then
    if self.blink.timer:start() >= self.blink.spd then
      self.blink.timer:reset()
      self.blink.active = not self.blink.active
    end
  else
    self.blink.timer:stop()
    self.blink.active = true
  end
  
  Gu.start3d()
    if self.shadow.on then
      Global.draw.advancedFillRect(x+self.shadow.x,y+self.shadow.y,self.size.w,self.size.h,self.shadow.col)
    end
    Global.draw.advancedFillRect(x,y,self.size.w,self.size.h,self.col.bg)
    
    if active then
      if self.blink.active then
        local POS = x+((self.cursor.pos1-1)*8)
        Global.draw.advancedDrawLine(POS,y,POS,y+self.size.h,self.col.fg)
      end
    end
  Gu.end3d()
  
  local MAX = self.size.c + self.cursor.pos3
  
  if string.len(self.buff) < self.size.c then
    MAX = string.len(self.buff)
  end
  
  screen:print(x+1,y+1,string.sub(self.buff,self.cursor.pos3+1,MAX),self.col.fg)
end