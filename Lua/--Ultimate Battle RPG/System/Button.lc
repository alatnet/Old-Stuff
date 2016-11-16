Button = {
  default = {
    col = {
      BG = Color.new(128,128,128),
      FG = Color.new(0,0,0),
      HOVER = Color.new(0,0,128)
      CLICK = Color.new(128,0,128)
    }
  }
}

function Button.new(txt,width,height,shadow,BG,FG,HOVERcol,CLICKcol)
  if shadow == nil then
    shadow = true
  elseif shadow == false then
    shadow = false
  else
    shadow = true
  end

  BG = BG or Button.default.col.BG
  FG = FG or Button.default.col.FG
  HOVERcol = HOVERcol or MENU.default.col.HOVER
  CLICKcol = HOVERcol or MENU.default.col.CLICK

  local c = setmetatable(
    {
      col = {
        BG = BG,
        FG = FG,
        HOVER = HOVERcol,
        CLICK = CLICKcol
      },
      txt = txt,
      w = width,
      h = height,
      shadow = {
        on = shadow,
        col = Color.new(0,0,0,96),
        img = nil,
        x = 5,
        y = 6
      }
    },
    {
      __index = Button
    }
  )

  if shadow then
    c.shadow.img = Image.createEmpty(width,height+9)
    c.shadow.img:clear(c.shadow.col)
  end

  return c
end