Vector3D = {}

function Vector3D.tostring(a)
  return "(" .. a.x .. "," .. a.y .. "," .. a.z .. ")"
end

--arithmetic operatiors
function Vector3D.add(a,b)
  if type(a) == "number" and getmetatable(b).__index == Vector3D then
    return Vector3D.new(b.x+a,b.y+a,b.z+a)
  elseif getmetatable(a).__index == Vector3D and type(b) == "number" then
    return Vector3D.new(a.x+b,a.y+b,a.z+b)
  elseif getmetatable(a).__index == Vector3D and getmetatable(b).__index == Vector3D then
    return Vector3D.new(a.x+b.x,a.y+b.y,a.z+b.z)
  else
    error("attempt to 'add' a vector with a non-vector or non-number value",2)
  end
end

function Vector3D.sub(a,b)
  if type(a) == "number" and getmetatable(b).__index == Vector3D then
    return Vector3D.new(b.x-a,b.y-a,b.z-a)
  elseif getmetatable(a).__index == Vector3D and type(b) == "number" then
    return Vector3D.new(a.x-b,a.y-b,a.z-b)
  elseif getmetatable(a).__index == Vector3D and getmetatable(b).__index == Vector3D then
    return Vector3D.new(a.x-b.x,a.y-b.y,a.z-b.z)
  else
    error("attempt to 'subtract' a vector with a non-vector or non-number value",2)
  end
end

function Vector3D.mul(a,b)
  if type(a) == "number" and getmetatable(b).__index == Vector3D then
    return Vector3D.new(b.x*a,b.y*a,b.z*a)
  elseif getmetatable(a).__index == Vector3D and type(b) == "number" then
    return Vector3D.new(a.x*b,a.y*b,a.z*b)
  elseif getmetatable(a).__index == Vector3D and getmetatable(b).__index == Vector3D then
    return Vector3D.new(a.x*b.x,a.y*b.y,a.z*b.z)
  else
    error("attempt to 'multiply' a vector with a non-vector or non-number value",2)
  end
end

function Vector3D.div(a,b)
  if type(a) == "number" and getmetatable(b).__index == Vector3D then
    return Vector3D.new(b.x/a,b.y/a,b.z/a)
  elseif getmetatable(a).__index == Vector3D and type(b) == "number" then
    return Vector3D.new(a.x/b,a.y/b,a.z/b)
  elseif getmetatable(a).__index == Vector3D and getmetatable(b).__index == Vector3D then
    return Vector3D.new(a.x/b.x,a.y/b.y,a.z/b.z)
  else
    error("attempt to 'divide' a vector with a non-vector or non-number value",2)
  end
end

function Vector3D.mod(a,b)
  if type(a) == "number" and getmetatable(b).__index == Vector3D then
    return Vector3D.new(b.x%a,b.y%a,b.z%a)
  elseif getmetatable(a).__index == Vector3D and type(b) == "number" then
    return Vector3D.new(a.x%b,a.y%b,a.z%b)
  elseif getmetatable(a).__index == Vector3D and getmetatable(b).__index == Vector3D then
    return Vector3D.new(a.x%b.x,a.y%b.y,a.z%b.z)
  else
    error("attempt to 'mod' a vector with a non-vector or non-number value",2)
  end
end

function Vector3D.pow(a,b)
  if type(a) == "number" and getmetatable(b).__index == Vector3D then
    return Vector3D.new(b.x^a,b.y^a,b.z^a)
  elseif getmetatable(a).__index == Vector3D and type(b) == "number" then
    return Vector3D.new(a.x^b,a.y^b,a.z^b)
  elseif getmetatable(a).__index == Vector3D and getmetatable(b).__index == Vector3D then
    return Vector3D.new(a.x^b.x,a.y^b.y,a.z^b.z)
  else
    error("attempt to 'power' a vector with a non-vector or non-number value",2)
  end
end

--relation operatiors
function Vector3D.eq(a,b)
  if getmetatable(a).__index == Vector3D and getmetatable(b).__index == Vector3D then
    return (a.x == b.x) and (a.y == b.y) and (a.z == b.z)
  end
  return false
end

function Vector3D.lt(a,b)
  if getmetatable(a).__index == Vector3D and getmetatable(b).__index == Vector3D then
    return (a.x < b.x) and (a.y < b.y) and (a.z < b.z)
  end
  return false
end

function Vector3D.le(a,b)
  if getmetatable(a).__index == Vector3D and getmetatable(b).__index == Vector3D then
    return (a.x <= b.x) and (a.y <= b.y) and (a.z <= b.z)
  end
  return false
end

function Vector3D.new(x,y,z)
  local c = setmetatable(
    {
      x = x,
      y = y,
      z = z
    },
    {
      __index = Vector3D,
      __tostring = Vector3D.tostring,
      
      --arithmetic operatiors
      __add = Vector3D.add,
      __sub = Vector3D.sub,
      __mul = Vector3D.mul,
      __div = Vector3D.div,
      __mod = Vector3D.mod,
      __pow = Vector3D.pow,

      --relation operatiors
      __eq = Vector3D.eq,
      __lt = Vector3D.lt,
      __le = Vector3D.le
    }
  )
  
  return c
end

function Vector3D:getX()
  return self.x
end

function Vector3D:getY()
  return self.y
end

function Vector3D:getZ()
  return self.z
end

function Vector3D:setX(x)
  self.x = x
end

function Vector3D:setY(y)
  self.y = y
end

function Vector3D:setZ(z)
  self.z = z
end