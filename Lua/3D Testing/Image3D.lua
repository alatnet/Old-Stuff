Image3D = {
  Default = {
    FUNC = {
      Tex = function (img)
        -- setup texture
        Gu.enable(Gu.TEXTURE_2D);
        Gu.texImage(img)--IMAGE!!!--
        Gu.texFunc(Gu.TFX_MODULATE, Gu.TCC_RGBA)
        Gu.texEnvColor(Color.new(255,255,255))--COLOR!!!--
        Gu.texFilter(Gu.LINEAR, Gu.LINEAR)
        Gu.texScale(1, 1)
        Gu.texOffset(0, 0)
        Gu.ambientColor(Color.new(255,255,255))--???--
      end
    }
  },
  IMG_3D_FUNC = function (xo,yo,width,height)
    local w = width/2
    local h = height/2
    local c = Color.new(255,255,255)
    local verts = {
      {0,0,c,-xo,-yo,0},
      {1,0,c,-xo,h-yo,0},
      {0,1,c,w-xo,-yo,0},

      {1,1,c,w-xo,h-yo,0},
      {0,1,c,w-xo,-yo,0},
      {1,0,c,-xo,h-yo,0}
    }

--    local verts = {
--      {0,0,c,-w,-h,0},
--      {1,0,c,-w,h,0},
--      {0,1,c,w,-h,0},

--      {1,1,c,w,h,0},
--      {0,1,c,w,-h,0},
--      {1,0,c,-w,h,0}
--    }
--    local verts = {
--      {0,0,c,-w,-h,0},
--      {1,1,c,w,h,0}
--    }
    return verts
  end
}

--[[
local verts = {
  {1,0,Color.new(255,255,255),-w,h,0},
  {1,1,Color.new(255,255,255),w,h,0},
  {0,0,Color.new(255,255,255),-w,-h,0},

  {0,1,Color.new(255,255,255),w,-h,0},
  {0,0,Color.new(255,255,255),-w,-h,0},
  {1,1,Color.new(255,255,255),w,h,0}
}
]]--
--[[
  {0, 0, red, -1, -1,  1},  -- 0       0,0
  {2, 0, red, -1,  1,  1},  -- 4       0,h
  {2, 2, red,  1,  1,  1},  -- 5       w,h

  {0, 0, red, -1, -1,  1},  -- 0       0,0
  {2, 2, red,  1,  1,  1},  -- 5       w,h
  {0, 2, red,  1, -1,  1},  -- 1       w,0
]]--
--[[
  {Color.new(0,0,0),-sW,-sH,0},
  {Color.new(0,0,0),sW,-sH,0},

  {Color.new(0,0,0),-sW,sH,0},
  {Color.new(0,0,0),sW,sH,0},

  {Color.new(0,0,0),-sW,-sH,0},
  {Color.new(0,0,0),-sW,sH,0},

  {Color.new(0,0,0),sW,-sH,0},
  {Color.new(0,0,0),sW,sH,0},
]]--

function Image3D.createFromImage(image)
  local img = image
  
  if type(image) == "nil" then
    error("bad argument #1: (Image or string expected, got nil)",2)
  elseif type(image) == "number" then
    error("bad argument #1: (Image or string expected, got number)",2)
  elseif type(image) == "string" then
    img = assert (Image.load(image),"Invalid path to Image.")
  elseif type(image) == "boolean" then
    error("bad argument #1: (Image or string expected, got boolean)",2)
  elseif type(image) == "table" then
    error("bad argument #1: (Image or string expected, got table)",2)
  elseif type(image) == "function" then
    error("bad argument #1: (Image or string expected, got function)",2)
  elseif type(image) == "thread" then
    error("bad argument #1: (Image or string expected, got thread)",2)
  end

  local c = setmetatable(
    {
      IMG = img,
      size = {w = img:width(),h = img:height()},
      IMG_3D = Image3D.IMG_3D_FUNC(0,0,img:width(),img:height()),
      IMG_ROT = {x = 0,y = 0,z = -90},
      FUNC = Image3D.Default.FUNC,
      offset = {x = 0,y = 0}
    },
    {
      __index = Image3D
    }
  )

  return c
end

function Image3D:width()
  return self.size.w
end

function Image3D:height()
  return self.size.h
end

function Image3D:img_width()
  return self.IMG:width()
end

function Image3D:img_height()
  return self.IMG:height()
end

function Image3D:size()
  return self.size.w,self.size.h
end

function Image3D:img_size()
  return self.IMG:width(),self.IMG:height()
end

function Image3D:center(x,y)
  if x == nil then
    return self.offset.x,self.offset.y
  else
    if y == nil then
      return self.offset.x,self.offset.y
    else
      self.offset.x = x
      self.offset.y = y
    end
  end
end

function Image3D:resize(w,h)
  self.size.w = w
  self.size.h = h

  self.IMG_3D = Image3D.IMG_3D_FUNC(self.offset.x,self.offset.y,w,h)
  collectgarbage()
end

function Image3D:getRotateXYZ()
  return self.IMG_ROT.x,self.IMG_ROT.y,self.IMG_ROT.z
end

function Image3D:setRotateXYZ(x,y,z)
  if x >= 360 then x = x - 360 end
  if y >= 360 then y = y - 360 end
  if z >= 360 then z = z - 360 end
  
  if x <= -360 then x = x + 360 end
  if y <= -360 then y = y + 360 end
  if z <= -360 then z = z + 360 end

  self.IMG_ROT.x = x
  self.IMG_ROT.y = y
  self.IMG_ROT.z = z
end

function Image3D:getImage()
  return self.IMG
end

function Image3D:setImage(image)
  local img = image
  
  if type(image) == "nil" then
    error("bad argument #1: (Image or string expected, got nil)",2)
  elseif type(image) == "number" then
    error("bad argument #1: (Image or string expected, got number)",2)
  elseif type(image) == "string" then
    img = assert (Image.load(image),"Invalid path to Image.")
  elseif type(image) == "boolean" then
    error("bad argument #1: (Image or string expected, got boolean)",2)
  elseif type(image) == "table" then
    error("bad argument #1: (Image or string expected, got table)",2)
  elseif type(image) == "function" then
    error("bad argument #1: (Image or string expected, got function)",2)
  elseif type(image) == "thread" then
    error("bad argument #1: (Image or string expected, got thread)",2)
  end
  
  self.IMG = img
  collectgarbage()
end

function Image3D:setTexFunc(func)
  if type(func) ~= "function" then
    error("bad argument #1: (function expected, got " .. type(func) ..")",2)
  end
  self.FUNC.Tex = func
end

function Image3D:Draw(x,y,z)
  self.FUNC.Tex(self.IMG)
  
  -- setup matrix for img
  Gum.matrixMode(Gu.MODEL)
  Gum.loadIdentity()
  Gum.translate(x, y, z)
  Gum.rotateXYZ(self.IMG_ROT.x*(Gu.PI/180),self.IMG_ROT.y*(Gu.PI/180),self.IMG_ROT.z*(Gu.PI/180))
  
  -- draw img
  Gum.drawArray(Gu.TRIANGLES, Gu.TEXTURE_32BITF+Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, self.IMG_3D)
end

--[[
function Image3D:
end
]]--