TrigArea = {}

function TrigArea.new(xpos,ypos,width,height)
  local c = setmetatable(
    {
      pos = {x = xpos,y = ypos},
      size = {w = width,h = height}
    },
    {
      __index = TrigArea
    }
  )
  return c
end

function TrigArea:Pos(x,y)
  if x == nil or y == nil then
    return self.pos.x,self.pos.y
  else
    self.pos.x = x
    self.pos.y = y
  end
end

function TrigArea:Size(w,h)
  if w == nil or h == nil then
    return self.size.w,self.size.h
  else
    self.size.w = w
    self.size.h = h
  end
end

function TrigArea:inArea(x,y)
  if x >= self.pos.x and y >= self.pos.y then
    if x <= self.pos.x + self.size.w and y <= self.pos.y + self.size.h then
      return true
    end
  end

  return false
end