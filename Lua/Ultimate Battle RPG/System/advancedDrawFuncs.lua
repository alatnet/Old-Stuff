function Global.draw.advancedBlit2(img,dx,dy,sx,sy,sw,sh,slice)
  dx = dx or 0
  dy = dy or 0
  sx = sx or 0
  sy = sy or 0
  sw = sw or img:width()
  sh = sh or img:height()
  slice = slice or 128

  Gu.enable(Gu.BLEND)
  Gu.enable(Gu.TEXTURE_2D)
  Gu.texMode(Gu.PSM_8888,0,Gu.FALSE)
  Gu.texImage(img)
  Gu.texFunc(Gu.TFX_BLEND,Gu.TCC_RGBA) --TFX_MODULATE TFX_DECAL TFX_BLEND TFX_REPLACE TFX_ADD
  Gu.texEnvColor(Color.new(255,255,255,255))
  Gu.texFilter(Gu.NEAREST_MIPMAP_LINEAR,Gu.NEAREST_MIPMAP_LINEAR)
  Gu.texScale(1, 1)
  Gu.texOffset(0, 0)
  Gu.texWrap(Gu.CLAMP,Gu.CLAMP)
  
  local w,h = slice,slice
  local verts = {}

  for x=sx,sx+sw,slice do
    for y=sy,sy+sh,slice do
      if (x+slice)<(sx+sw) then w=slice else w=(sx+sw)-x end
      if (y+slice)<(sy+sh) then h=slice else h=(sy+sh)-y end
      --[[
      local verts = {
        {x,y,x+dx,y+dy,0},  --1
        {x+w,y+h,(x+w)+dx,(y+h)+dy,0}  --4
      }
      ]]--

      table.insert(verts,{x,y,x+dx,y+dy,0})  --1
      table.insert(verts,{x+w,y+h,(x+w)+dx,(y+h)+dy,0})  --4
      --Gum.drawArray(Gu.SPRITES,Gu.TEXTURE_32BITF+Gu.VERTEX_32BITF+Gu.TRANSFORM_2D,verts)
    end
  end

  Gum.drawArray(Gu.SPRITES,Gu.TEXTURE_32BITF+Gu.VERTEX_32BITF+Gu.TRANSFORM_2D,verts)
end

function Global.draw.advancedBlit(img,dx,dy,sx,sy,sw,sh,slice)
  dx = dx or 0
  dy = dy or 0
  sx = sx or 0
  sy = sy or 0
  sw = sw or img:width()
  sh = sh or img:height()
  slice = slice or 128

  Gu.enable(Gu.BLEND)
  Gu.enable(Gu.TEXTURE_2D)
  Gu.texMode(Gu.PSM_8888,0,Gu.FALSE)
  Gu.texImage(img)
  Gu.texFunc(Gu.TFX_BLEND,Gu.TCC_RGBA) --TFX_MODULATE TFX_DECAL TFX_BLEND TFX_REPLACE TFX_ADD
  Gu.texEnvColor(Color.new(255,255,255,255))
  Gu.texFilter(Gu.NEAREST_MIPMAP_LINEAR,Gu.NEAREST_MIPMAP_LINEAR)
  Gu.texScale(1, 1)
  Gu.texOffset(0, 0)
  Gu.texWrap(Gu.CLAMP,Gu.CLAMP)

  local w,h = slice,slice
  --local verts = {}

  for x=sx,sx+sw,slice do
    for y=sy,sy+sh,slice do
      if (x+slice)<(sx+sw) then w=slice else w=(sx+sw)-x end
      if (y+slice)<(sy+sh) then h=slice else h=(sy+sh)-y end

      local verts = {
        {x,y,x+dx,y+dy,0},  --1
        {x+w,y,(x+w)+dx,y+dy,0}, --2
        {x,y+h,x+dx,(y+h)+dy,0}, --3
        {x+w,y+h,(x+w)+dx,(y+h)+dy,0}  --4
      }

      --table.insert(verts,{x,y,x+dx,y+dy,0})  --1
      --table.insert(verts,{x+w,y,(x+w)+dx,y+dy,0})  --2
      --table.insert(verts,{x,y+h,x+dx,(y+h)+dy,0})  --3
      --table.insert(verts,{x+w,y+h,(x+w)+dx,(y+h)+dy,0})  --4

      Gum.drawArray(Gu.TRIANGLE_STRIP,Gu.TEXTURE_32BITF+Gu.VERTEX_32BITF+Gu.TRANSFORM_2D,verts)
    end
  end

  --Gum.drawArray(Gu.TRIANGLE_STRIP,Gu.TEXTURE_32BITF+Gu.VERTEX_32BITF+Gu.TRANSFORM_2D,verts)
end

function Global.draw.advancedPixel(x,y,col)
  col = col or Color.new(0,0,0,255)
  
  Gu.enable(Gu.BLEND)
  Gu.disable(Gu.TEXTURE_2D)
  
  Gum.matrixMode(Gu.MODEL)
  Gum.loadIdentity()

  local verts = {
    {col,x,y,0}
  }
  Gum.drawArray(Gu.POINTS,Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_2D,verts)
end

function Global.draw.advancedFillRect(x,y,w,h,col)
  x = x or 0
  y = y or 0
  w = w or 0
  h = h or 0
  col = col or Color.new(0,0,0,255)
  
  Gu.enable(Gu.BLEND)
  Gu.disable(Gu.TEXTURE_2D)
  
  Gum.matrixMode(Gu.MODEL)
  Gum.loadIdentity()

  local verts = {
    {col,x,y,0},
    {col,x+w,y+h,0}
  }
  Gum.drawArray(Gu.SPRITES,Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_2D,verts)
end

function Global.draw.advancedGradient(x,y,w,h,col1,col2)
  x = x or 0
  y = y or 0
  w = w or 0
  h = h or 0
  col = col or Color.new(0,0,0,255)

  Gu.enable(Gu.BLEND)
  Gu.disable(Gu.TEXTURE_2D)

  Gum.matrixMode(Gu.MODEL)
  Gum.loadIdentity()

  local verts = {
    {col1,x,y,0},
    {col2,x+w,y+h,0}
  }
  Gum.drawArray(Gu.SPRITES,Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_2D,verts)
end

function Global.draw.advancedRect(x,y,w,h,col)
  x = x or 0
  y = y or 0
  w = w or 0
  h = h or 0
  col = col or Color.new(0,0,0,255)
  
  Gu.enable(Gu.BLEND)
  Gu.disable(Gu.TEXTURE_2D)
  
  Gum.matrixMode(Gu.MODEL)
  Gum.loadIdentity()

  local verts = {
    {col,x,y,0},
    {col,x+w,y,0},
    {col,x+w,y+h,0},
    {col,x,y+h,0},
    {col,x,y,0}
  }
  Gum.drawArray(Gu.LINE_STRIP,Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_2D,verts)
end

function Global.draw.advancedDrawLine(x1,y1,x2,y2,col)
  x1 = x1 or 0
  y1 = y1 or 0
  x2 = x2 or 0
  y2 = y2 or 0
  col = col or Color.new(0,0,0,255)
  
  Gu.enable(Gu.BLEND)
  Gu.disable(Gu.TEXTURE_2D)
  
  Gum.matrixMode(Gu.MODEL)
  Gum.loadIdentity()

  local verts = {
    {col,x1,y1,0},
    {col,x2,y2,0}
  }
  Gum.drawArray(Gu.LINES,Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_2D,verts)
end

function Global.draw.advancedClear(col)
  Gu.clearDepth(0)
  Gu.clear(Gu.COLOR_BUFFER_BIT+Gu.DEPTH_BUFFER_BIT+Gu.STENCIL_BUFFER_BIT)
  Gu.clearColor(col or Color.new(0,0,0,0))
end