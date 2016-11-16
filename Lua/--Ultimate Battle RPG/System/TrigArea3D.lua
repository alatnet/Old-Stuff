TrigArea3D = {}

function TrigArea3D.new(xpos,ypos,zpos,width,height,length)
  local c = setmetatable(
    {
      pos = {x = xpos,y = ypos,z = zpos},
      size = {w = width,h = height,l = length}
    },
    {
      __index = TrigArea
    }
  )
  return c
end

function TrigArea3D:Pos(x,y,z)
  if x == nil or y == nil or z == nil then
    return self.pos.x,self.pos.y,self.pos.z
  else
    self.pos.x = x
    self.pos.y = y
    self.pos.z = z
  end
end

function TrigArea3D:Size(w,h,l)
  if w == nil or h == nil or l == nil then
    return self.size.w,self.size.h,self.size.l
  else
    self.size.w = w
    self.size.h = h
    self.size.l = l
  end
end

function TrigArea3D:inArea(x,y,z)
  if x >= self.pos.x and y >= self.pos.y and z >= self.pos.z then
    if x <= self.pos.x + self.size.w and y <= self.pos.y + self.size.h and z <= self.pos.z + self.size.l then
      return true
    end
  end

  return false
end