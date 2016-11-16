Image3D = {
  fnfp = function (max_num, percentage)
    if percentage > 100 then percentage = 100 end
    if percentage < 0 then percentage = 0 end
    return (percentage * max_num)/100
  end,
  fpfn = function (max_num, num)
    if num > max_num then num = max_num end
    if num < 0 then num = 0 end
    return (num * 100)/max_num
  end
}

function Image3D.createVerts(img,sx,sy,sw,sh,slice)
  local SPRITES_verts = {}
  local TRIANGE_STRIP_verts = {}

  sx = sx or 0
  sy = sy or 0
  sw = sw or img:width()
  sh = sh or img:height()
  slice = slice or 128
  local w,h = slice,slice

  for x=sx,sx+sw,slice do
    for y=sy,sy+sh,slice do
      if (x+slice)<(sx+sw) then w=slice else w=(sx+sw)-x end
      if (y+slice)<(sy+sh) then h=slice else h=(sy+sh)-y end

      --sprites
      table.insert(SPRITES_verts,{x,y,x,y,0})  --1
      table.insert(SPRITES_verts,{x+w,y+h,x+w,y+h,0})  --4

      --triangle strip
      local verts = {
        {x,y,x,y,0},  --1
        {x+w,y,x+w,y,0}, --2
        {x,y+h,x,y+h,0}, --3
        {x+w,y+h,x+w,y+h,0}  --4
      }
      
      table.insert(TRIANGE_STRIP_verts,verts)
    end
  end

  return SPRITES_verts,TRIANGE_STRIP_verts
end

function Image3D.new(img)
  local c = setmetatable(
    {
      IMG = img,
      verts = {
        SPRITES = nil,
        TRIANGLE_STRIP = nil
      },
      rot = {
        x = 0,
        y = 0,
        z = 0
      },
      col = {
        r = 0,
        g = 0,
        b = 0,
        a = 255
      }
    },
    {
      __index = Image3D
    }
  )

  c.verts.SPRITES,c.verts.TRIANGLE_STRIP = Image3D.createVerts(c.IMG,0,0,c.IMG:width(),c.IMG:height(),128)

  return c
end

function Image3D:crop(x,y,w,h,slice)
  x = x or 0
  y = y or 0
  w = w or self.IMG:width()
  h = h or self.IMG:height()
  slice = slice or 128

  self.verts.SPRITES,self.verts.TRIANGLE_STRIP = Image3D.createVerts(self.IMG,x,y,w,h,slice)
end

-- Color Shift Functions START
function Image3D:setColorShift(r,g,b,a)
  r = r or self.col.r
  g = g or self.col.g
  b = b or self.col.b
  a = a or self.col.a

  if r < 0 then r = 0 end
  if r > 255 then r = 255 end
  if g < 0 then g = 0 end
  if g > 255 then g = 255 end
  if b < 0 then b = 0 end
  if b > 255 then b = 255 end
  if a < 0 then a = 0 end
  if a > 255 then a = 255 end

  self.col.r = r
  self.col.g = g
  self.col.b = b
  self.col.a = a
end

function Image3D:setRedShift(val)
  val = val or self.col.r

  if val < 0 then val = 0 end
  if val > 255 then val = 255 end

  self.col.r = val
end

function Image3D:getRedShift()
  return self.col.r
end

function Image3D:setGreenShift(val)
  val = val or self.col.g

  if val < 0 then val = 0 end
  if val > 255 then val = 255 end

  self.col.g = val
end

function Image3D:getGreenShift()
  return self.col.g
end

function Image3D:setBlueShift(val)
  val = val or self.col.b

  if val < 0 then val = 0 end
  if val > 255 then val = 255 end

  self.col.b = val
end

function Image3D:getBlueShift()
  return self.col.b
end

function Image3D:setAlphaShift(val)
  val = val or self.col.a

  if val < 0 then val = 0 end
  if val > 255 then val = 255 end

  self.col.a = val
end

function Image3D:getAlphaShift()
  return self.col.a
end
-- Color Shift Functions END

function Image3D:setOpacity(percentage)
  percentage = percentage or Image3D.fpfn(255,self.col.a)

  self.col.a = Image3D.fnfp(255, percentage)
end

function Image3D:getOpacity()
  return Image3D.fpfn(255,self.col.a)
end

function Image3D:getRot()
  return self.rot.x,self.rot.y,self.rot.z
end

function Image3D:setRot(x,y,z)
  self.rot.x = x or 0
  self.rot.y = y or 0
  self.rot.z = z or 0
end

function Image3D:getImg()
  return self.IMG
end

function Image3D:setImg(img)
  self.IMG = img or self.IMG
  self.verts.SPRITES,self.verts.TRIANGLE_STRIP = Image3D.createVerts(img,0,0,img:width(),img:height(),128)
end

function Image3D:draw(x,y,z,prim)
  prim = prim or Gu.TRIANGLE_STRIP

  if prim ~= Gu.TRIANGLE_STRIP or prim ~= Gu.SPRITES then
    error("error: argumen #4: expected Gu.TRIANGLE_STRIP or Gu.SPRITES",2)
  end

  Gu.enable(Gu.BLEND)
  Gu.enable(Gu.TEXTURE_2D)

  Gum.matrixMode(Gu.MODEL)
  Gum.loadIdentity()

  Gu.texMode(Gu.PSM_8888,0,Gu.FALSE)
  Gu.texImage(img)
  Gu.texFunc(Gu.TFX_BLEND,Gu.TCC_RGBA) --TFX_MODULATE TFX_DECAL TFX_BLEND TFX_REPLACE TFX_ADD
  Gu.texEnvColor(Color.new(255,255,255,255))
  Gu.texFilter(Gu.NEAREST_MIPMAP_LINEAR,Gu.NEAREST_MIPMAP_LINEAR)
  Gu.texScale(1, 1)
  Gu.texOffset(0, 0)
  Gu.texWrap(Gu.CLAMP,Gu.CLAMP)

  Gu.colorMaterial(Gu.AMBIENT+Gu.DIFFUSE)
  Gu.color(Color.new(self.col.r,self.col.g,self.col.b,self.col.a))

  Gum.translate(x,y,z)
  Gum.rotateXYZ(self.rot.x,self.rot.y,self.rot.z)
  --Gum.scale(x,y,1)

  if prim = Gu.TRIANGLE_STRIP then
    Gum.drawArray(Gu.TRIANGLE_STRIP,Gu.TEXTURE_32BITF+Gu.VERTEX_32BITF+Gu.TRANSFORM_2D,self.verts.SPRITES)
  elseif prim = Gu.SPRITES then
    for i=1,table.getn(self.verts.TRIANGLE_STRIP) do
      Gum.drawArray(Gu.SPRITES,Gu.TEXTURE_32BITF+Gu.VERTEX_32BITF+Gu.TRANSFORM_2D,self.verts.TRIANGLE_STRIP[i])
    end
  end
end

--[[
function Image3D:()
end
]]--