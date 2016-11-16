TripleBuff = {}

function TripleBuff.new()
  local c = setmetatable(
    {
      BUFF = Image.createEmpty(screen:width(), screen:height())
    },
    {
      __index = TripleBuff
    }
  )

  return c
end

function TripleBuff:blit(x, y, source,...)
  self.BUFF:blit(x, y, source,arg)
end

function TripleBuff:clear(...)
  self.BUFF:clear(arg)
end

function TripleBuff:fillRect(x, y, width, height, color)
  self.BUFF:fillRect(x, y, width, height, color)
end

function TripleBuff:drawLine(x0, y0, x1, y1, color)
  self.BUFF:drawLine(x0, y0, x1, y1, color)
end

function TripleBuff:pixel(x, y, color)
  if color == nil then
    return self.BUFF:pixel(x,y)
  else
    self.BUFF:pixel(x,y,color)
  end
end

function TripleBuff:print(x, y, text, color)
  if color == nil then
    self.BUFF:print(x, y, text)
  else
    self.BUFF:print(x, y, text, color)
  end
end

function TripleBuff:fontPrint(font, x, y, text, color)
  if color == nil then
    self.BUFF:fontPrint(font, x, y, text)
  else
    self.BUFF:fontPrint(font, x, y, text, color)
  end
end

function TripleBuff:width()
  return self.BUFF:width()
end

function TripleBuff:height()
  return self.BUFF:height()
end

function TripleBuff:save(filename)
  self.BUFF:save(filename)
end 

function TripleBuff:Update()
  screen:clear(Color.new(0,0,0,0))
  screen:blit(0, 0,self.BUFF)
  screen.flip()
end