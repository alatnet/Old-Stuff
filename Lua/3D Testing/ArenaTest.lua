Environment = {
  Boarders = {  --{x,y,w,h},
    x=-600,
    y=0,
    w=1200,
    h=300
  },
  Platforms = {
    --{x,y,w,h},
  },
  Obj3D ={
    Num = 2,
    Images = {
      dir = "./",
      list = {
        "Backing.png",
        "Ground.png"
      }
    },
    Pos = {
      {x=0.0,y=-50.0,z=-350.0},
      {x=0.0,y=0.0,z=0} --35
    },
    Size = {
      {w = 1400,h = 600},
      {w = 1200,h = 200}
    },
    Tiling = {
      {u = 2,v = 1},
      {u = 4,v = 1}
    },
    Rot ={
      {x=180.0,y=0.0,z=0.0},
      {x=180.0,y=0.0,z=0.0}
    },
    Prim = {
      Gu.TRIANGLE_STRIP,
      Gu.TRIANGLE_STRIP
    },
    VType = {
      Gu.TEXTURE_32BITF+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D,
      Gu.TEXTURE_32BITF+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D
    },
    Models = {
      {   --[BG 3D Model Code Start]
        {0.0,0.0,-700.0,-300.0,0.0},  --Vertex 1
        {1.0,0.0,700.0,-300.0,0.0},  --Vertex 2
        {0.0,1.0,-700.0,300.0,0.0},  --Vertex 3
        {1.0,1.0,700.0,300.0,0.0}  --Vertex 4
      },   --[BG 3D Model Code End]
      {   --[Floor 3D Model Code Start]
        {0.0,0.0,-600.0,0.0,100.0},  --Vertex 1
        {1.0,0.0,600.0,0.0,100.0},  --Vertex 2
        {0.0,1.0,-600.0,0.0,-100.0},  --Vertex 3
        {1.0,1.0,600.0,0.0,-100.0}  --Vertex 4
      }   --[Floor 3D Model Code End]
    }
  }
}

function Environment:checkBoarders(x,y,w,h)
  if x > self.Boarders.x and x+w < self.Boarders.x+self.Boarders.w and y > self.Boarders.y and y+h < self.Boarders.y+self.Boarders.h then
    return x,y
  else
    local retX,retY = x,y
    if x < self.Boarders.x then
      retX = self.Boarders.x
    elseif x+w > self.Boarders.x+self.Boarders.w then
      retX = ((self.Boarders.x+self.Boarders.w)-w)
    end
    
    if y < self.Boarders.y then
      retY = self.Boarders.y
    elseif y+h > self.Boarders.y+self.Boarders.h then
      retY = (self.Boarders.y+self.Boarders.h)
    end
    
    return retX,retY
  end
end

function Environment:load()
  for i=1,self.Obj3D.Num do
    self.Obj3D.Images.list[i] = Image.load(self.Obj3D.Images.dir .. self.Obj3D.Images.list[i])
  end
end

function Environment:draw()
  Gu.enable(Gu.TEXTURE_2D)
  for i=1,self.Obj3D.Num do
    Gum.matrixMode(Gu.MODEL)
    Gum.loadIdentity()
    
    Gu.texEnvColor(Color.new(255,255,255))  --COLOR!!!--
    Gu.texFunc(Gu.TFX_BLEND, Gu.TCC_RGBA)
    Gu.texFilter(Gu.NEAREST_MIPMAP_NEAREST,Gu.LINEAR_MIPMAP_LINEAR)
    Gu.texOffset(0, 0)
    
    if _G.Gu["texWrap"] ~= nil then
      Gu.texWrap(Gu.REPEAT,Gu.REPEAT)
    end
    
    Gu.texImage(self.Obj3D.Images.list[i])
    Gu.texScale(self.Obj3D.Tiling[i].u, self.Obj3D.Tiling[i].v)
    
    Gu.colorMaterial(Gu.AMBIENT)
    Gu.color(Color.new(0,0,0,255))
    
    Gu.colorMaterial(Gu.DIFFUSE)
    Gu.color(Color.new(0,0,0,255))
    
    Gu.colorMaterial(Gu.SPECULAR)
    Gu.color(Color.new(0,0,0,255))
    
    -- setup matrix for img
    Gum.translate(self.Obj3D.Pos[i].x, self.Obj3D.Pos[i].y, self.Obj3D.Pos[i].z)
    Gum.rotateXYZ(self.Obj3D.Rot[i].x*(Gu.PI/180),self.Obj3D.Rot[i].y*(Gu.PI/180),self.Obj3D.Rot[i].z*(Gu.PI/180))
    -- draw img
    Gum.drawArray(self.Obj3D.Prim[i], self.Obj3D.VType[i], self.Obj3D.Models[i])
    --Gum.drawArray(Gu.TRIANGLE_STRIP, Gu.TEXTURE_32BITF+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, self.Obj3D.Models[i])
  end
end

--[[
function Environment:()
end
]]--

--[[
local Environment = {
  Boarders = {
    --{x,y,w,h},
  },
  Platforms = {
    --{x,y,w,h},
  },
  Obj3D ={
    Images = {
      dir = "",
      list = {
        [1] = "",
        -- etc...
      }
    },
    Models = {
      [1] = {},
      -- etc...
    }
  }
}

function Environment:checkBoundries(x,y,w,h)
end

function Environment:load(dir)
  dir = dir or ""

  local LoadedList = {}

  for i=1,table.getn(self.Obj3D.Images.list) do
    table.insert(LoadedList,Image.load(self.Obj3D.Images.list[i]))
  end

  return LoadedList
end

function Environment:draw()
  for i=1,table.getn(self.Obj3D.Models do
    --draw
  end
end
]]--

--[[
--(3D MODELS)=================================
--------------------------------
-- Floor detailed information:
--    Number of Vertexs: 4
--    Number of Edges: 6
--    Number of Faces: 2
--------------------------------

--[Floor Material]
Floorbmp="down.jpg"

FloorPos = {x=0.0,y=0.0,z=30.0}

Floor = {   --[Floor 3D Model Code Start]
  --(Face 1 of 2)
  {0.0,1.0,-300.0,0.0,-100.0},  --Vertex 3
  {1.0,1.0,300.0,0.0,-100.0},  --Vertex 4
  {0.0,0.0,-300.0,0.0,100.0},  --Vertex 1
  --(Face 2 of 2)
  {1.0,0.0,300.0,0.0,100.0},  --Vertex 2
  {0.0,0.0,-300.0,0.0,100.0},  --Vertex 1
  {1.0,1.0,300.0,0.0,-100.0}  --Vertex 4
}   --[Floor 3D Model Code End]


--------------------------------
-- BG detailed information:
--    Number of Vertexs: 4
--    Number of Edges: 6
--    Number of Faces: 2
--------------------------------

--[BG Material]
BGbmp="006-Mountains01.jpg"

BGPos = {x=0.0,y=70.0,z=-100.0}

BG = {   --[BG 3D Model Code Start]
  --(Face 1 of 2)
  {0.0,1.0,-350.0,150.0,0.0},  --Vertex 3
  {1.0,1.0,350.0,150.0,0.0},  --Vertex 4
  {0.0,0.0,-350.0,-150.0,0.0},  --Vertex 1
  --(Face 2 of 2)
  {1.0,0.0,350.0,-150.0,0.0},  --Vertex 2
  {0.0,0.0,-350.0,-150.0,0.0},  --Vertex 1
  {1.0,1.0,350.0,150.0,0.0}  --Vertex 4
}   --[BG 3D Model Code End]
]]--