requireC (Global.system.dir.main .."advancedDrawFuncs.lua")

MsgBox = {
  CANCEL = 1,
  YESNO = 2,
  OKCANCEL = 3,
  BACK = 4,
  CONTINUE = 5
}

function MsgBox.new(msg,msgtype,shadow,bg,fg)
  msgtype = msgtype or 99
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
      MSG = {},
      WIDTH = 0,
      HEIGHT = 0,
      shadow = {
        on = shadow,
        col = Color.new(0,0,0,96),
        x = 5,
        y = 6
      },
      TYPE = ""
    },
    {
      __index = MsgBox
    }
  )

  local index = 1

  for i=1,string.len(msg) do
    if string.sub(msg,i,i) == "\n" then
      table.insert(c.MSG,string.sub(msg,index,i-1))
      index = i+1
    end
    if i == string.len(msg) then
      table.insert(c.MSG,string.sub(msg,index))
    end
  end

  c.HEIGHT = (table.getn(c.MSG) * 9) + 8

  for i=1,table.getn(c.MSG) do
    if (string.len(c.MSG[i])*8) > c.WIDTH then c.WIDTH = (string.len(c.MSG[i])*8) end
  end

  c.WIDTH=c.WIDTH+4

  if msgtype == MsgBox.CANCEL then
    c.TYPE = "O Cancel"
    c.HEIGHT = c.HEIGHT + 18
  elseif msgtype == MsgBox.YESNO then
    c.TYPE = "X Yes  O No"
    c.HEIGHT = c.HEIGHT + 18
  elseif msgtype == MsgBox.OKCANCEL then
    c.TYPE = "X OK  O Cancel"
    c.HEIGHT = c.HEIGHT + 18
  elseif msgtype == MsgBox.BACK then
    c.TYPE = "O Back"
    c.HEIGHT = c.HEIGHT + 18
  elseif msgtype == MsgBox.CONTINUE then
    c.TYPE = "O Continue"
    c.HEIGHT = c.HEIGHT + 18
  end
  
  return c
end

function MsgBox:Shadow_Offset(x,y)
  if x == nil or y == nil then
    return self.shadow.x,self.shadow.y
  end

  self.shadow.x = x
  self.shadow.y = y
end

function MsgBox:Shadow_Col(col)
  if col ~= nil then
    self.shadow.col = col
  else
    return self.shadow.col
  end
end

function MsgBox:Shadow(on)
  self.shadow.on = on
end

function MsgBox:width()
  return self.WIDTH
end

function MsgBox:height()
  return self.HEIGHT
end

function MsgBox:Draw(x,y,s)
  s = s or screen

  Gu.start3d()
    if self.shadow.on then
      Global.draw.advancedFillRect(x+self.shadow.x,y+self.shadow.y,self.WIDTH,self.HEIGHT,self.shadow.col)
    end

    --s:fillRect(x, y, self.WIDTH, self.HEIGHT, self.BG)
    Global.draw.advancedFillRect(x,y,self.WIDTH,self.HEIGHT,self.BG)
  Gu.end3d()

  local Y = y+4

  for i=1,table.getn(self.MSG) do
    s:print(x+4,Y,self.MSG[i],self.FG)
    Y = Y + 9
  end

  s:print((x+(self.WIDTH/2))-((string.len(self.TYPE) * 8)/2),y+self.HEIGHT-11,self.TYPE,self.FG)
end