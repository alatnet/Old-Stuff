requireC (Global.system.dir.main .."advancedDrawFuncs.lua")

Label = {}

function Label.new(text,shadow,bg,fg)
  text = text or ""
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
      Text = text,
      Size = {
        w = (string.len(text)*8),
        h = 10
      },
      shadow = {
        on = shadow,
        col = Color.new(0,0,0,96),
        x = 5,
        y = 6
      }
    },
    {
      __index = Label
    }
  )
  
  return c
end

function Label:Shadow_Offset(x,y)
  if x == nil or y == nil then
    return self.shadow.x,self.shadow.y
  end

  self.shadow.x = x
  self.shadow.y = y
end

function Label:Shadow_Col(col)
  if col ~= nil then
    self.shadow.col = col
  else
    return self.shadow.col
  end
end

function Label:Shadow(on)
  self.shadow.on = on
end

function Label:width()
  return self.Size.w
end

function Label:height()
  return self.Size.h
end

function Label:draw(x,y)
  Gu.start3d()
    if self.shadow.on then
      Global.draw.advancedFillRect(x+self.shadow.x,y+self.shadow.y,self.Size.w,self.Size.h,self.shadow.col)
    end
    Global.draw.advancedFillRect(x,y,self.Size.w,self.Size.h,self.BG)
  Gu.end3d()
  screen:print(x+1,y+1,self.Text,self.FG)
end