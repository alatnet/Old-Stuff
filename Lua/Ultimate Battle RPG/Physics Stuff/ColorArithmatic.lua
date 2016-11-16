function Color.add(a,b)
  if type(a) == "number" and getmetatable(b).__index == Color then
    cols = b:colors()
    return Color.new(cols.r+a,cols.g+a,cols.b+a,cols.a)
  elseif getmetatable(a).__index == Color and type(b) == "number" then
    cols = a:colors()
    return Color.new(cols.r+b,cols.g+b,cols.b+b,cols.a)
  elseif getmetatable(a).__index == Color and getmetatable(b).__index == Color then
    colsA = a:colors()
    colsB = b:colors()
    return Color.new(colsA.r+colsB.r,colsA.g+colsB.g,colsA.b+colsB.b,colsA.a+colsB.a)
  else
    error("attempt to 'add' a Color with a non-Color or non-number value",2)
  end
end

function Color.sub(a,b)
  if type(a) == "number" and getmetatable(b).__index == Color then
    cols = b:colors()
    return Color.new(cols.r-a,cols.g-a,cols.b-a,cols.a)
  elseif getmetatable(a).__index == Color and type(b) == "number" then
    cols = a:colors()
    return Color.new(cols.r-b,cols.g-b,cols.b-b,cols.a)
  elseif getmetatable(a).__index == Color and getmetatable(b).__index == Color then
    colsA = a:colors()
    colsB = b:colors()
    return Color.new(colsA.r-colsB.r,colsA.g-colsB.g,colsA.b-colsB.b,colsA.a-colsB.a)
  else
    error("attempt to 'subtract' a Color with a non-Color or non-number value",2)
  end
end

function Color.mul(a,b)
  if type(a) == "number" and getmetatable(b).__index == Color then
    cols = b:colors()
    return Color.new(cols.r*a,cols.g*a,cols.b*a,cols.a)
  elseif getmetatable(a).__index == Color and type(b) == "number" then
    cols = a:colors()
    return Color.new(cols.r*b,cols.g*b,cols.b*b,cols.a)
  elseif getmetatable(a).__index == Color and getmetatable(b).__index == Color then
    colsA = a:colors()
    colsB = b:colors()
    return Color.new(colsA.r*colsB.r,colsA.g*colsB.g,colsA.b*colsB.b,colsA.a*colsB.a)
  else
    error("attempt to 'multiply' a Color with a non-Color or non-number value",2)
  end
end

function Color.div(a,b)
  if type(a) == "number" and getmetatable(b).__index == Color then
    cols = b:colors()
    return Color.new(cols.r/a,cols.g/a,cols.b/a,cols.a)
  elseif getmetatable(a).__index == Color and type(b) == "number" then
    cols = a:colors()
    return Color.new(cols.r/b,cols.g/b,cols.b/b,cols.a)
  elseif getmetatable(a).__index == Color and getmetatable(b).__index == Color then
    colsA = a:colors()
    colsB = b:colors()
    return Color.new(colsA.r/colsB.r,colsA.g/colsB.g,colsA.b/colsB.b,colsA.a/colsB.a)
  else
    error("attempt to 'divide' a Color with a non-Color or non-number value",2)
  end
end

function Color.mod(a,b)
  if type(a) == "number" and getmetatable(b).__index == Color then
    cols = b:colors()
    return Color.new(cols.r%a,cols.g%a,cols.b%a,cols.a)
  elseif getmetatable(a).__index == Color and type(b) == "number" then
    cols = a:colors()
    return Color.new(cols.r%b,cols.g%b,cols.b%b,cols.a)
  elseif getmetatable(a).__index == Color and getmetatable(b).__index == Color then
    colsA = a:colors()
    colsB = b:colors()
    return Color.new(colsA.r%colsB.r,colsA.g%colsB.g,colsA.b%colsB.b,colsA.a%colsB.a)
  else
    error("attempt to 'mod' a Color with a non-Color or non-number value",2)
  end
end

function Color.pow(a,b)
  if type(a) == "number" and getmetatable(b).__index == Color then
    cols = b:colors()
    return Color.new(cols.r^a,cols.g^a,cols.b^a,cols.a)
  elseif getmetatable(a).__index == Color and type(b) == "number" then
    cols = a:colors()
    return Color.new(cols.r^b,cols.g^b,cols.b^b,cols.a)
  elseif getmetatable(a).__index == Color and getmetatable(b).__index == Color then
    colsA = a:colors()
    colsB = b:colors()
    return Color.new(colsA.r^colsB.r,colsA.g^colsB.g,colsA.b^colsB.b,colsA.a^colsB.a)
  else
    error("attempt to 'power' a Color with a non-Color or non-number value",2)
  end
end

colorMeta = getmetatable(Color)

colorMeta.__add = Color.add
colorMeta.__sub = Color.sub
colorMeta.__mul = Color.mul
colorMeta.__div = Color.div
colorMeta.__mod = Color.mod
colorMeta.__pow = Color.pow

setmetatable(Color,colorMeta)