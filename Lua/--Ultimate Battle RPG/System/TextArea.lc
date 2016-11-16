requireC (Global.system.dir.main .."advancedDrawFuncs.lua")

TextArea = {}

function TextArea.new(text,charW,lineH,shadow,bg,fg)
  text = text or ""
  charW = charW or 10
  lineH = lineH or 10
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
      BG = bg,
      FG = fg,
      WIDTH = (charW*8)+1,
      HEIGHT = (lineH*9)+1,
      charW = charW,
      lineH = lineH,
      LINE = 0,
      shadow = {
        on = shadow,
        col = Color.new(0,0,0,96),
        x = 5,
        y = 6
      },
      TEXT = {},
      OrigText = text
    },
    {
      __index = TextArea
    }
  )
  
  local tmp = ""

  for i=1,string.len(text) do
    if string.sub(text,i,i) == "\n" then
      table.insert(c.TEXT,tmp)
      tmp = ""
    elseif string.len(tmp) >= charW-1 then
      table.insert(c.TEXT,tmp .. string.sub(text,i,i))
      tmp = ""
    else
      tmp = tmp .. string.sub(text,i,i)
    end
  end
  
  table.insert(c.TEXT,tmp)
  
  return c
end

function TextArea:Shadow_Offset(x,y)
  if x == nil or y == nil then
    return self.shadow.x,self.shadow.y
  end

  self.shadow.x = x
  self.shadow.y = y
end

function TextArea:Shadow_Col(col)
  if col ~= nil then
    self.shadow.col = col
  else
    return self.shadow.col
  end
end

function TextArea:Shadow(on)
  self.shadow.on = on
end

function TextArea:width()
  return self.WIDTH
end

function TextArea:height()
  return self.HEIGHT
end

function TextArea:scroll(dir)
  if dir == "u" and self.LINE ~= 0 then
    self.LINE = self.LINE - 1
  elseif dir == "d" and self.LINE ~= self:numLines() then
    self.LINE = self.LINE + 1
  end
end

function TextArea:currLine()
  return self.LINE
end

function TextArea:numLines()
  if table.getn(self.TEXT)<self.lineH then
    return 0
  end
  
  return table.getn(self.TEXT)-self.lineH
end

function TextArea:append(txt)
  txt = self.TEXT[table.getn(self.TEXT)] .. txt
  
  table.remove(self.TEXT)

  local tmp = ""

  for i=1,string.len(txt) do
    if string.sub(txt,i,i) == "\n" then
      table.insert(self.TEXT,tmp)
      tmp = ""
    elseif string.len(tmp) >= self.charW-1 then
      table.insert(self.TEXT,tmp .. string.sub(txt,i,i))
      tmp = ""
    else
      tmp = tmp .. string.sub(txt,i,i)
    end
  end

  table.insert(self.TEXT,tmp)
  self.OrigText = self.OrigText .. txt
end

function TextArea:getText()
  return self.OrigText
end

function TextArea:Draw(x,y)
  Gu.start3d()
    if self.shadow.on then
      Global.draw.advancedFillRect(x+self.shadow.x,y+self.shadow.y,self.WIDTH,self.HEIGHT,self.shadow.col)
    end
    Global.draw.advancedFillRect(x,y,self.WIDTH,self.HEIGHT,self.BG)
  Gu.end3d()

  y = y + 1
  
  local LineMax = (self.LINE+self.lineH)
  if table.getn(self.TEXT) < self.lineH then LineMax = table.getn(self.TEXT) end

  for i=self.LINE+1,LineMax do
    screen:print(x+2,y,self.TEXT[i],self.FG)
    y = y + 9
  end
end