requireC ("./CONTROLS.lua")
requireC ("./3DObj.x")

Test_3D = {
  FUNC = {
    Rect = function (w,h,c1,c2)
      local verts = {
        {c1,0,0,0},
        {c2,w,h,0}
      }
      return verts
    end
  }
}

--[[
      local verts = {
        {col,0,h,0},
        {col,w,h,0},
        {col,0,0,0}, 
        {col,w,0,0},
        {col,0,0,0},
        {col,w,h,0}
      }
]]--

function Test_3D.new()
  local c = setmetatable(
    {
      Cube = {
        Rot = {x = 0,y = 0,z = 0,spd = 1},
        Pos = {x = 0,y = 0,z = 0}
      },
      Camera = {
        Pos = {x = 0,y = 0,z = 300}, --290
        Target = {x = 0,y = 0,z = 0},
        Tilt = {x = 0,y = 1,z = 0}
      }
    },
    {
      __index = Test_3D
    }
  )

  return c
end

function Test_3D:Draw()
  -- clear screen --
  Gu.clearDepth(0)
  Gu.clear(Gu.COLOR_BUFFER_BIT+Gu.DEPTH_BUFFER_BIT)
  --Gu.clearColor(Color.new(255,255,255))

  -- setup projection and view matrices --
  Gum.matrixMode(Gu.PROJECTION)
  Gum.loadIdentity()
  Gum.perspective(50, 16/9, 1, 1000)

  Gum.matrixMode(Gu.VIEW)
  Gum.loadIdentity()
  
  -- CAMEREA --
  Gum.lookAt(self.Camera.Pos.x,self.Camera.Pos.y,self.Camera.Pos.z,self.Camera.Target.x,self.Camera.Target.y,self.Camera.Target.z,self.Camera.Tilt.x,self.Camera.Tilt.y,self.Camera.Tilt.z)

  -- setup matrix for rectangle backing --
  Gum.matrixMode(Gu.MODEL)
  Gum.loadIdentity()
  Gum.translate(-500, -500, -30)
  Gum.rotateXYZ(0,0,0)

  -- draw rectangle backing without texture --
  Gu.disable(Gu.TEXTURE_2D)
  Gum.drawArray(Gu.SPRITES, Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, Test_3D.FUNC.Rect(1000,1000,Color.new(100, 255, 255),Color.new(0, 0, 255)))

  -- setup matrix for cube --
  Gum.matrixMode(Gu.MODEL)
  Gum.loadIdentity()
  Gum.translate(self.Cube.Pos.x, self.Cube.Pos.y, self.Cube.Pos.z)
  Gum.rotateXYZ(self.Cube.Rot.x*(Gu.PI/180),self.Cube.Rot.y*(Gu.PI/180),self.Cube.Rot.z*(Gu.PI/180))

  -- draw cube without texture --
  Gu.disable(Gu.TEXTURE_2D)
  Gum.drawArray(Gu.TRIANGLES, Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, Cube)

  -- setup matrix for axis --
  Gum.matrixMode(Gu.MODEL)
  Gum.loadIdentity()
  Gum.translate(0,0,0)
  Gum.rotateXYZ(0,0,0)

  -- draw axis without texture --
  Gu.disable(Gu.TEXTURE_2D)
  Gum.drawArray(Gu.LINES, Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, Axis)
  
  --[[
  -- setup matrix for screen boarder --
  Gum.matrixMode(Gu.MODEL)
  Gum.loadIdentity()
  Gum.translate(0, 0, 0)
  Gum.rotateXYZ(0,0,0)

  -- draw screen boarder without texture --
  Gu.disable(Gu.TEXTURE_2D)
  Gum.drawArray(Gu.LINES, Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, Screen_Boarder)
  ]]--
end

function Test_3D:Update()
  self.Cube.Rot.x = self.Cube.Rot.x + self.Cube.Rot.spd
  self.Cube.Rot.y = self.Cube.Rot.y + self.Cube.Rot.spd
  self.Cube.Rot.z = self.Cube.Rot.z + self.Cube.Rot.spd

  if self.Cube.Rot.x >= 360 then self.Cube.Rot.x = self.Cube.Rot.x - 360 end
  if self.Cube.Rot.y >= 360 then self.Cube.Rot.y = self.Cube.Rot.y - 360 end
  if self.Cube.Rot.z >= 360 then self.Cube.Rot.z = self.Cube.Rot.z - 360 end
end

function Test_3D:ControlUpdate()
  --local AX = AX(40,10)
  --local AY = AY(40,10)


  --[[ CAMERA POSITION CONTROLS ]]--
  if up() then
    self.Camera.Pos.y = self.Camera.Pos.y - 1
  end

  if down() then
    self.Camera.Pos.y = self.Camera.Pos.y + 1
  end

  if left() then
    self.Camera.Pos.x = self.Camera.Pos.x - 1
  end

  if right() then
    self.Camera.Pos.x = self.Camera.Pos.x + 1
  end

  if ltrig() then
    self.Camera.Pos.z = self.Camera.Pos.z - 1
  end
  
  if rtrig() then
    self.Camera.Pos.z = self.Camera.Pos.z + 1
  end

  --[[ CAMERA TARGET CONTROLS ]]--
  if triangle() then
    self.Camera.Target.y = self.Camera.Target.y - 1
  end

  if cross() then
    self.Camera.Target.y = self.Camera.Target.y + 1
  end

  if square() then
    self.Camera.Target.x = self.Camera.Target.x - 1
  end

  if circle() then
    self.Camera.Target.x = self.Camera.Target.x + 1
  end
end

function Test_3D:tostring()
  local str = ""
  
  str = str .. "Camera: Pos(" .. self.Camera.Pos.x .. "," .. self.Camera.Pos.y .. "," .. self.Camera.Pos.z .. ")  "
  str = str .. "Target(" .. self.Camera.Target.x .. "," .. self.Camera.Target.y .. "," .. self.Camera.Target.z .. ")"
  
  return str
end

--[[
function Test_3D:
end
]]--