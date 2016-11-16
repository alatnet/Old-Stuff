requireC (Global.system.dir.main .."advancedDrawFuncs.lua")

TextField = {}

function TextField.new(size,label_txt,cursor_char,blink_spd,bg,fg)
  local c = setmetatable(
    {
      SIZE = size or 10,
      CURSOR = cursor_char or "_",
      BLK_SPD = blink_spd or 500,
      BG = bg or Color.new(255,255,255),
      FG = fg or Color.new(0,0,0),
      timer = Timer.new(),
      BUFF = {},
      BLINK = false,
      LBL = label_txt
    },
    {
      __index = TextField
    }
  )

  return c
end

function TextField:addChar(char)
  if char == nil or char == "\n" or char == "\t" then
    return
  elseif char == "\b" then
    self:removeChar()
    return
  end
  
  table.insert(self.BUFF,char)
end

function TextField:removeChar()
  if table.getn(self.BUFF) == 0 then
    return
  end
  
  table.remove(self.BUFF)
end


function TextField:setCursor(char)
  char = char or "_"
  self.CURSOR = char
end

function TextField:setBG(col)
  col = col or Color.new(255,255,255)
  self.BG = col
end

function TextField:setFG(col)
  col = col or Color.new(0,0,0)
  self.FG = col
end

function TextField:getText()
  return table.concat(self.BUFF)
end

function TextField:height()
  return 10
end

function TextField:width()
  return (self.SIZE * 8) + (string.len(self.LBL)*8)
end

function TextField:Draw(x,y,active,s)
  s = s or screen

  if active == nil then
    active = false
  elseif active == false then
    active = false
  else
    active = true
  end
  
  if active then
    if self.timer:start() >= self.BLK_SPD then
      self.timer:reset()
      if self.BLINK then
        self.BLINK = false
      else
        self.BLINK = true
      end
    end
  else
    self.timer:reset()
    self.BLINK = false
  end
  
  Gu.start3d()
    Global.draw.advancedFillRect(x,y,(string.len(self.LBL)*8),10,self.FG)
    Global.draw.advancedFillRect(x+(string.len(self.LBL)*8),y,(self.SIZE*8),10,self.BG)
  Gu.end3d()
  
  --s:fillRect(x, y,(string.len(self.LBL)*8), 10, self.FG)
  --s:fillRect(x + (string.len(self.LBL)*8), y,(self.SIZE * 8), 10, self.BG)
  s:print(x + 1,y + 1,self.LBL,self.BG)

  if self.BLINK then
    s:print(x + 1 + (string.len(self.LBL)*8),y+1,table.concat(self.BUFF) .. self.CURSOR,self.FG)
  else
    s:print(x + 1 + (string.len(self.LBL)*8),y+1,table.concat(self.BUFF),self.FG)
  end
end