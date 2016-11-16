requireC (Global.system.dir.main .."advancedDrawFuncs.lua")

TextField2 = {}

function TextField2.new(charW,bSpd,cursor_char,bg,fg,shadow)
  charW = charW or 10
  cursor_char = cursor_char or "_"
  bSpd = bSpd or 500
  bg = bg or Color.new(128,128,128,255)
  fg = fg or Color.new(0,0,0,255)
  
  if shadow == nil then
    shadow = true
  elseif shadow == false then
    shadow = false
  else
    shadow = true
  end

  local c = setmetatable(
    {
      charW = charW,
      cursor = {
        char = cursor_char,
        bSpd = bSpd,
        pos = 1,
        pos2 = 0,
        timer = Timer.new(),
        blink = true
      },
      col = {
        bg = bg,
        fg = fg
      },
      size = {
        w = (charW*8)+1,
        h = 10
      },
      shadow = {
        on = shadow,
        col = Color.new(0,0,0,96),
        x = 5,
        y = 6
      },
      buff = " "
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

function TextField2:setText(text)
  self.buff = text .. " "
end

function TextField2:getText()
  return string.sub(self.buff,string.len(self.buff)-1)
end

function TextField2:addChar(char)
  self.buff = string.sub(self.buff,1,self.cursor.pos-1) .. char .. string.sub(self.buff,self.cursor.pos)
end

function TextField2:removeChar()
  self.buff = string.sub(self.buff,1,self.cursor.pos-1) .. string.sub(self.buff,self.cursor.pos+1)
end

function TextField2:moveCursor(dir)
  if dir == "l" then
    if self.cursor.pos2 == 0 and self.cursor.pos ~= 0 then
      self.cursor.pos = self.cursor.pos - 1
    else
      self.cursor.pos2 = self.cursor.pos2 - 1
    end
    if self.cursor.pos2 < 0 then
      self.cursor.pos2 = 0
    end
    if self.cursor.pos < 0 then
      self.cursor.pos = 0
    end
    self.cursor.blink = true
  elseif dir == "r" then
    if self.cursor.pos2 == self.charW-1 and self.cursor.pos ~= string.len(self.buff) then
      self.cursor.pos = self.cursor.pos + 1
    else
      self.cursor.pos2 = self.cursor.pos2 + 1
    end
    if self.cursor.pos2 > self.charW then
      self.cursor.pos2 = self.charW
    end
    if self.cursor.pos > string.len(self.buff) then
      self.cursor.pos = string.len(self.buff)
    end
    self.cursor.blink = true
  end
end

function TextField2:Draw(x,y,active)
  --add esc char parsing
  
  Gu.start3d()
    if self.shadow.on then
      Global.draw.advancedFillRect(x+self.shadow.x,y+self.shadow.y,self.size.w,self.size.h,self.shadow.col)
    end
    Global.draw.advancedFillRect(x,y,self.size.w,self.size.h,self.col.bg)
  Gu.end3d()
  
  local MIN = self.cursor.pos+1
  local MAX = (self.cursor.pos+self.charW)
  if string.len(self.buff) < self.charW then
    MIN = 1
    MAX = string.len(self.buff)
  end
  
  screen:print(x+1,y+1,string.sub(self.buff,MIN,MAX),self.col.fg)
  
  if active then
    if self.cursor.blink then
      screen:print((x+1)+(self.cursor.pos2*8),y+2,self.cursor.char,self.col.fg)
    end
    
    if self.cursor.timer:start() >= self.cursor.bSpd then
      self.cursor.timer:reset()
      self.cursor.blink = not self.cursor.blink
    end
  else
    self.cursor.blink = false
  end
end