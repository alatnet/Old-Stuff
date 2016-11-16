requireC (Global.system.dir.main .."advancedDrawFuncs.lua")

MENU = {
  default = {
    col = {
      title = {
        BG = Color.new(192,192,192),
        FG = Color.new(0,0,0)
      },
      body = {
        BG = Color.new(128,128,128),
        FG = Color.new(0,0,0),
        SEL = Color.new(0,0,128)
      }
    },
    title = "Untitled",
    cursor = ">"
  }
}

function MENU.new(options_array,title_txt,cursor_txt,shadow,BG1,FG1,BG2,FG2,selcol)
  if shadow == nil then
    shadow = true
  elseif shadow == false then
    shadow = false
  else
    shadow = true
  end

  BG1 = BG1 or MENU.default.col.title.BG
  FG1 = FG1 or MENU.default.col.title.FG
  BG2 = BG2 or MENU.default.col.body.BG
  FG2 = FG2 or MENU.default.col.body.FG
  selcol = selcol or MENU.default.col.body.SEL
  title_txt = title_txt or MENU.default.title
  cursor_txt = cursor_txt or MENU.default.cursor

  local WIDTH = (string.len(title_txt)*8)
  local HEIGHT = table.getn(options_array) * 9

  for i=1,table.getn(options_array) do
    if (string.len(options_array[i])*8)+(string.len(cursor_txt)*8) > WIDTH then WIDTH = (string.len(options_array[i])*8)+(string.len(cursor_txt)*8) end
  end

  local c = setmetatable(
    {
      col = {
        title = {
          BG = BG1,
          FG = FG1
        },
        body = {
          BG = BG2,
          FG = {[false] = FG2, [true] = selcol}
          --FG = FG2,
          --SEL = selcol
        }
      },
      title = title_txt,
      options = options_array,
      cursor = cursor_txt,
      w = WIDTH + 1,
      h = HEIGHT + 2,
      cursor_pos = {
        curr = 1,
        prev = 1
      },
      shadow = {
        on = shadow,
        col = Color.new(0,0,0,96),
        x = 5,
        y = 6
      }
    },
    {
      __index = MENU
    }
  )

  return c
end

function MENU:Update(options_array)
  local WIDTH = (string.len(self.title)*8)
  local HEIGHT = table.getn(options_array) * 9

  for i=1,table.getn(options_array) do
    if (string.len(options_array[i])*8)+(string.len(self.cursor)*8) > WIDTH then WIDTH = (string.len(options_array[i])*8)+(string.len(self.cursor)*8) end
  end
  
  self.w = WIDTH + 1
  self.h = HEIGHT + 2
  self.options = options_array

  collectgarbage()
end

function MENU:Shadow_Offset(x,y)
  if x == nil or y == nil then
    return self.shadow.x,self.shadow.y
  end

  self.shadow.x = x
  self.shadow.y = y
end

function MENU:Shadow_Col(col)
  if col ~= nil then
    self.shadow.col = col
  else
    return self.shadow.col
  end
end

function MENU:Shadow(on)
  self.shadow.on = on
end

function MENU:menuoption(xpos,ypos,txt,selcondition,img)
  img = img or screen
  local num_cursor_char = string.len(self.cursor)
  if selcondition then
    img:print(xpos,ypos,self.cursor .. txt,self.col.body.FG[true])
  else
    img:print(xpos+(8*num_cursor_char),ypos,txt,self.col.body.FG[false])
  end
end

function MENU:list_options(xpos,ypos,cursor_pos,img)
  img = img or screen
  local YY=ypos
  
  for i=1, table.getn(self.options) do
    self:menuoption(xpos,YY,self.options[i],i==cursor_pos,img)
    YY = YY + 9
  end
end

function MENU:width()
  return self.w
end

function MENU:height()
  return self.h + 9
end

function MENU:numOptions()
  return table.getn(self.options)
end

function MENU:moveCursor(direction)
  if string.lower(direction) == "u" then
    self.cursor_pos.curr = self.cursor_pos.curr - 1
    if self.cursor_pos.curr == 0 then self.cursor_pos.curr = self:numOptions() end
  elseif string.lower(direction) == "d" then
    self.cursor_pos.curr = self.cursor_pos.curr + 1
    if self.cursor_pos.curr == self:numOptions() + 1 then self.cursor_pos.curr = 1 end
  end
end

function MENU:CursorPos()
  return self.cursor_pos.curr
end

function MENU:ResetCursorPos()
  self.cursor_pos.curr = 1
end

function MENU:Draw(x,y,c,s)
  s = s or screen
  c = c or self.cursor_pos.curr
  
  Gu.start3d()
    if self.shadow.on then
      Global.draw.advancedFillRect(x + self.shadow.x,y + self.shadow.y,self.w,self.h+9,self.shadow.col)
    end
    
    --s:fillRect(x, y, self.w, 9, self.col.title.BG)
    --s:fillRect(x, y+9, self.w, self.h, self.col.body.BG)
    Global.draw.advancedFillRect(x,y,self.w,9,self.col.title.BG)
    Global.draw.advancedFillRect(x,y+9,self.w,self.h,self.col.body.BG)
  Gu.end3d()
  
  s:print(x+2,y+1,self.title,self.col.title.FG)
  self:list_options(x+2,y+11,c,s)
end