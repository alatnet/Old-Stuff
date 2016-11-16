requireC ("Ctrl.lc")
requireC ("colors.lua")
requireC ("MENU.lc")
requireC ("FPSCounter.lua")

Grapher = {
  col = {
    graph = {
      grid = black,
      points = lblue,
      lines = {
        purple,
        orange,
        lgray,
        gray,
        dgray
      }
    },
    BG = white,
    FG = black,
    menu = {
      title = lgray,
      body = gray
    }
  }
}

function Grapher.new()
  local c = setmetatable(
    {
      graph = {
        points = {
          {}
        },
        lines = {
          {}
        },
        grid = {},
        axis = {
          {red,-15,0,0},
          {red,15,0,0},
          {green,0,-15,0},
          {green,0,15,0},
          {blue,0,0,-15},
          {blue,0,0,15}
        },
        RX = 0,
        RY = 0,
        RZ = 0,
        TX = 0,
        TY = 0,
        TZ = -10,
        rows = 15,
        cols = 15
      },
      modes_3d = {
        rotation = false,
        move = true
      },
      show = {
        points = true,
        lines = true,
        grid = true,
        axis = true
      },
      prev = {
        x = 0,
        y = 0
      },
      curr_line = 1,
      next_ln_col = 1,
      resize = {
        rows = "",
        col = ""
      },
      fps = FPSCounter.new()
    },
    {
      __index = Grapher
    }
  )

  return c
end

--[[ menus functions start ]]--
function Grapher:MainMenu()
  local m = MENU.new({"Points Menu","Lines Menu","Show Menu","Back","Quit"},"Main Menu",">")
  while not Ctrl.triangle.press1 do
    self:Start3D()
    self:Draw3D()
    self:End3D()
    self:DrawInfoBar()
    m:Draw((screen:width()/2)-(m:width()/2),(screen:height()/2)-(m:height()/2))
    self:flip()
    
    if Ctrl.up.press1 then
      m:moveCursor("u")
    elseif Ctrl.down.press1 then
      m:moveCursor("d")
    end

    if Ctrl.cross.press1 or Ctrl.circle.press1 then
      if m:CursorPos() == m:numOptions() then return "exit" end
      if m:CursorPos() == 4 then break end
      if m:CursorPos() == 3 then self:ShowMenu() end
      if m:CursorPos() == 2 then self:LinesMenu() end
      if m:CursorPos() == 1 then self:PointsMenu() end
    end
  end
end

function Grapher:ShowMenu()
  local m = MENU.new({"Points","Lines","Grid","Axis","Back"},"Show Menu",">")
  while not Ctrl.triangle.press1 do
    self:Start3D()
    self:Draw3D()
    self:End3D()
    self:DrawInfoBar()
    m:Draw((screen:width()/2)-(m:width()/2),(screen:height()/2)-(m:height()/2))
    self:flip()
    
    if Ctrl.up.press1 then
      m:moveCursor("u")
    elseif Ctrl.down.press1 then
      m:moveCursor("d")
    end
    
    if Ctrl.cross.press1 or Ctrl.circle.press1 then
      if m:CursorPos() == 1 then
        if self.show.points then
          self.show.points = false
        else
          self.show.points = true
        end
      end
      if m:CursorPos() == 2 then
        if self.show.lines then
          self.show.lines = false
        else
          self.show.lines = true
        end
      end
      if m:CursorPos() == 3 then
        if self.show.grid then
          self.show.grid = false
        else
          self.show.grid = true
        end
      end
      if m:CursorPos() == 4 then
        if self.show.axis then
          self.show.axis = false
        else
          self.show.axis = true
        end
      end
      if m:CursorPos() == m:numOptions() then break end
    end
  end
end

function Grapher:PointsMenu()
  local m = MENU.new({"Add Point","Remove last point","Clear Graph","Back"},"Points Menu",">")
  while not Ctrl.triangle.press1 do
    self:Start3D()
    self:Draw3D()
    self:End3D()
    self:DrawInfoBar()
    m:Draw((screen:width()/2)-(m:width()/2),(screen:height()/2)-(m:height()/2))
    self:flip()
    
    if Ctrl.up.press1 then
      m:moveCursor("u")
    elseif Ctrl.down.press1 then
      m:moveCursor("d")
    end
    
    if Ctrl.cross.press1 or Ctrl.circle.press1 then
      if m:CursorPos() == m:numOptions() then break end
      if m:CursorPos() == 3 then self:ClearGrid() end
      if m:CursorPos() == 2 then self:RemoveLastPoint() end
      if m:CursorPos() == 1 then self:Plot() end
    end
  end
end

function Grapher:LinesMenu()
  local m = MENU.new({"Add Line","Remove last Line","Change Line","Clear Graph","Back"},"Lines Menu",">")
  while not Ctrl.triangle.press1 do
    self:Start3D()
    self:Draw3D()
    self:End3D()
    self:DrawInfoBar()
    m:Draw((screen:width()/2)-(m:width()/2),(screen:height()/2)-(m:height()/2))
    self:flip()
    
    if Ctrl.up.press1 then
      m:moveCursor("u")
    elseif Ctrl.down.press1 then
      m:moveCursor("d")
    end
    
    if m:CursorPos() == 3 then
      if Ctrl.left.press1 then
        self:ChangeLine("l")
      elseif Ctrl.right.press1 then
        self:ChangeLine("r")
      end
    end
    
    if Ctrl.cross.press1 or Ctrl.circle.press1 then
      if m:CursorPos() == m:numOptions() then break end
      if m:CursorPos() == 4 then self:ClearGrid() end
      if m:CursorPos() == 2 then self:ChangeLine("re") end
      if m:CursorPos() == 1 then
        self:ChangeLine("n")
        break
      end
    end
  end
end
--[[ menus functions end ]]--

function Grapher:Plot()
  local X = self.prev.x
  local Y = self.prev.y
  local add = 1
  local add2 = 1

  while not Ctrl.triangle.press1 do
    self:Start3D()
    --self:Draw3D()
    
    self:DrawGrid()
    self:DrawAxis()
    self:DrawLines()
    self:DrawPoints()
    
    self:DrawPointAdd(X,Y)
    self:End3D()
    self:DrawPlotBar(X,Y,add)
    self:flip()

    if Ctrl.up.press1 or Ctrl.up.hold then Y = Y + add end
    if Ctrl.down.press1 or Ctrl.down.hold then Y = Y - add end
    if Ctrl.left.press1 or Ctrl.left.hold then X = X - add end
    if Ctrl.right.press1 or Ctrl.right.hold then X = X + add end

    if Ctrl.ax>=80 then self.graph.TX = self.graph.TX - add2 end
    if Ctrl.ax<=-79 then self.graph.TX = self.graph.TX + add2 end
    if Ctrl.ay>=80 then self.graph.TY = self.graph.TY + add2 end
    if Ctrl.ay<=-79 then self.graph.TY = self.graph.TY - add2 end

    add = 1
    add2 = 1

    if Ctrl.ltrig.press then
      add = 0.50
      add2 = 3
    elseif Ctrl.rtrig.press then
      add = 0.25
      add2 = 4
    elseif Ctrl.square.press then
      add = 0.01
      add2 = 2
    end

    --if Ctrl.circle.press then add = 0.10 end

    if Ctrl.cross.press1 or Ctrl.circle.press1 then
      self:AddPoint(X,Y,0)
      self.prev.x = X
      self.prev.y = Y
      break
    end
  end
end

--[[ drawing functions start ]]--
function Grapher:Start3D()
  Gu.start3d()  -- 3D Drawing Start

  -- clear screen
  Gu.clearDepth(0)
  Gu.clear(Gu.COLOR_BUFFER_BIT+Gu.DEPTH_BUFFER_BIT)

  -- setup projection and view matrices
  Gum.matrixMode(Gu.PROJECTION)
  Gum.loadIdentity()
  Gum.perspective(75, 16/9, 0.5, 1000)

  Gum.matrixMode(Gu.VIEW)
  Gum.loadIdentity()
end

function Grapher:End3D()
  Gu.end3d()  -- 3D Drawing End
end

function Grapher:flip()
  screen:print(2, 2,self.fps:update(),self.col.FG)
  screen.waitVblankStart()
  screen.flip()
  Ctrl:Update()
  screen:clear(self.col.BG)
end

function Grapher:DrawPointAdd(x,y)
  local lines = {
    {Color.new(255,128,64),x,y,0},
    {Color.new(255,128,64),x+0.25,y+0.25,0},
    {Color.new(255,128,64),x,y,0},
    {Color.new(255,128,64),x-0.25,y-0.25,0},
    {Color.new(255,128,64),x,y,0},
    {Color.new(255,128,64),x-0.25,y+0.25,0},
    {Color.new(255,128,64),x,y,0},
    {Color.new(255,128,64),x+0.25,y-0.25,0},
    {Color.new(255,128,64),x,y,0},
    {Color.new(255,128,64),x+0.25,y,0},
    {Color.new(255,128,64),x,y,0},
    {Color.new(255,128,64),x,y+0.25,0},
    {Color.new(255,128,64),x,y,0},
    {Color.new(255,128,64),x-0.25,y,0},
    {Color.new(255,128,64),x,y,0},
    {Color.new(255,128,64),x,y-0.25,0},
    {Color.new(255,128,64),x,y,0},
    {Color.new(256,256,0),self.prev.x,self.prev.y,0}
  }

  -- setup matrix for pointadd
  Gum.matrixMode(Gu.MODEL)
  Gum.loadIdentity()
  Gum.translate(self.graph.TX, self.graph.TY, self.graph.TZ)
  Gum.rotateXYZ(self.graph.RX*(Gu.PI/180),self.graph.RY*(Gu.PI/180),self.graph.RZ*(Gu.PI/180))

  -- draw pointadd without texture
  Gu.disable(Gu.TEXTURE_2D)
  Gum.drawArray(Gu.LINES, Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, lines)
end

function Grapher:DrawLines()
  if table.getn(self.graph.lines) == 0 then return end
  
  for i=1,table.getn(self.graph.lines) do
    -- setup matrix for lines
    Gum.matrixMode(Gu.MODEL)
    Gum.loadIdentity()
    Gum.translate(self.graph.TX, self.graph.TY, self.graph.TZ)
    Gum.rotateXYZ(self.graph.RX*(Gu.PI/180),self.graph.RY*(Gu.PI/180),self.graph.RZ*(Gu.PI/180))
  
    -- draw lines without texture
    Gu.disable(Gu.TEXTURE_2D)
    Gum.drawArray(Gu.LINE_STRIP, Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, self.graph.lines[i])
  end
end

function Grapher:DrawPoints()
  if table.getn(self.graph.points) == 0 then return end

  for i=1,table.getn(self.graph.points) do
    -- setup matrix for points
    Gum.matrixMode(Gu.MODEL)
    Gum.loadIdentity()
    Gum.translate(self.graph.TX, self.graph.TY, self.graph.TZ)
    Gum.rotateXYZ(self.graph.RX*(Gu.PI/180),self.graph.RY*(Gu.PI/180),self.graph.RZ*(Gu.PI/180))
  
    -- draw points without texture
    Gu.disable(Gu.TEXTURE_2D)
    Gum.drawArray(Gu.POINTS, Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, self.graph.points[i])
  end
end

function Grapher:DrawGrid()
  -- setup matrix for grid
  Gum.matrixMode(Gu.MODEL)
  Gum.loadIdentity()
  Gum.translate(self.graph.TX, self.graph.TY, self.graph.TZ)
  Gum.rotateXYZ(self.graph.RX*(Gu.PI/180),self.graph.RY*(Gu.PI/180),self.graph.RZ*(Gu.PI/180))

  -- draw grid without texture
  Gu.disable(Gu.TEXTURE_2D)
  Gum.drawArray(Gu.LINES, Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, self.graph.grid)
end

function Grapher:DrawAxis()
  -- setup matrix for axis
  Gum.matrixMode(Gu.MODEL)
  Gum.loadIdentity()
  Gum.translate(self.graph.TX, self.graph.TY, self.graph.TZ)
  Gum.rotateXYZ(self.graph.RX*(Gu.PI/180),self.graph.RY*(Gu.PI/180),self.graph.RZ*(Gu.PI/180))

  -- draw axis without texture
  Gu.disable(Gu.TEXTURE_2D)
  Gum.drawArray(Gu.LINES, Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, self.graph.axis)
end

function Grapher:Draw3D()
  if self.show.grid then
    self:DrawGrid()
  end
  if self.show.axis then
    self:DrawAxis()
  end
  if self.show.lines then
    self:DrawLines()
  end
  if self.show.points then
    self:DrawPoints()
  end
end
--[[ drawing functions end ]]--

--[[ Infobar functions start ]]--
function Grapher:DrawInfoBar()
  local xpos = 0
  local ypos = screen:height()-8

  screen:fillRect(xpos, ypos, screen:width(), 8, dgray)
  if self.modes_3d.move then
    screen:print(xpos+2, ypos,"Mode: Move | TX: " .. self.graph.TX .. " | TY: " .. self.graph.TY .. " | TZ: " .. self.graph.TZ .. " | Curr Ln: " .. self.curr_line,self.col.FG)
  elseif self.modes_3d.rotation then
    screen:print(xpos+2, ypos,"Mode: Rotation | RX: " .. self.graph.RX .. " | RY: " .. self.graph.RY .. " | RZ: " .. self.graph.RZ .. " | Curr Ln: " .. self.curr_line,self.col.FG)
  end
end

function Grapher:DrawPlotBar(x,y,add)
  local xpos = 0
  local ypos = screen:height()-8

  screen:fillRect(xpos, ypos, screen:width(), 8, dgray)
  screen:print(xpos+2, ypos,"Mode: Plot | X: " .. x .. " | Y: " .. y .. " | Incriment: " .. add .. " | Curr Ln: " .. self.curr_line,self.col.FG)
end
--[[ Infobar functions end ]]--

--[[ add/remove functions start ]]--
function Grapher:ChangeLine(direction)
  if string.lower(direction) == "l" then
    if self.curr_line - 1 < 1 then
      self.curr_line = 1
      self.next_ln_col = self.next_ln_col - 1
      if self.next_ln_col < 1 then
        self.next_ln_col = table.getn(self.col.graph.lines)
      end
      return      
    end
    self.curr_line = self.curr_line - 1
    self.next_ln_col = self.next_ln_col - 1
    if self.next_ln_col < 1 then
      self.next_ln_col = table.getn(self.col.graph.lines)
    end
  elseif string.lower(direction) == "r" then
    if self.curr_line + 1 > table.getn(self.graph.points) then
      self.curr_line = table.getn(self.graph.points) + 1
      self.next_ln_col = self.next_ln_col + 1
      if self.next_ln_col > table.getn(self.col.graph.lines) then
        self.next_ln_col = 1
      end
      self:NewLine()
      return      
    end
    self.curr_line = self.curr_line + 1
    self.next_ln_col = self.next_ln_col + 1
    if self.next_ln_col > table.getn(self.col.graph.lines) then
      self.next_ln_col = 1
    end
  elseif string.lower(direction) == "re" then
    if self.graph.points[table.getn(self.graph.points)] ~= nil then
      table.remove(self.graph.points[table.getn(self.graph.points)])
      self.curr_line = self.curr_line - 1
    end
    if table.getn(self.graph.points) == 0 or table.getn(self.graph.points) == 1 then
      self.next_ln_col = 2
    end
    self.next_ln_col = self.next_ln_col - 1
    if self.next_ln_col < 1 then
      self.next_ln_col = table.getn(self.col.graph.lines)
    end
    
    if self.curr_line == 0 then
      self.curr_line = 1
      self:NewLine()
    end
  elseif string.lower(direction) == "n" then
    self.curr_line = table.getn(self.graph.points) + 1
    self:NewLine()
    self.next_ln_col = self.next_ln_col + 1
    if self.next_ln_col > table.getn(self.col.graph.lines) then
      self.next_ln_col = 1
    end
  end
end

function Grapher:NewLine()
  if self.graph.points[self.curr_line] == nil then self.graph.points[self.curr_line] = {} end
  if self.graph.lines[self.curr_line] == nil then self.graph.lines[self.curr_line] = {} end
end

function Grapher:AddPoint(x,y,z)
  self:NewLine()
  table.insert(self.graph.points[self.curr_line],{self.col.graph.points,x,y,z})
  table.insert(self.graph.lines[self.curr_line],{self.col.graph.lines[self.next_ln_col],x,y,z})
end

function Grapher:RemoveLastPoint()
  table.remove(self.graph.points[self.curr_line])
  table.remove(self.graph.lines[self.curr_line])
end

function Grapher:AddRow(x,y1,y2)
  table.insert(self.graph.grid,{self.col.graph.grid,x,y1,0})
  table.insert(self.graph.grid,{self.col.graph.grid,x,y2,0})
end

function Grapher:AddCol(x1,x2,y)
  table.insert(self.graph.grid,{self.col.graph.grid,x1,y,0})
  table.insert(self.graph.grid,{self.col.graph.grid,x2,y,0})
end

function Grapher:ClearGrid()
  self.graph.points = {}
  self.graph.lines = {}
  self.graph.grid = {}

  --self:AddRow(x,y1,y2)
  --self:AddCol(x1,x2,y)
  for i=(self.graph.rows*-1),self.graph.rows do
    self:AddRow(i,(self.graph.rows*-1),self.graph.rows)
  end
  
  for i=(self.graph.cols*-1),self.graph.cols do
    self:AddCol((self.graph.cols*-1),self.graph.cols,i)
  end
end

function Grapher:ResizeGrid()
  if false then
    self.graph.grid = {}
  
    --self:AddRow(x,y1,y2)
    --self:AddCol(x1,x2,y)
    for i=(self.graph.rows*-1),self.graph.rows do
      self:AddRow(i,(self.graph.rows*-1),self.graph.rows)
    end
    
    for i=(self.graph.cols*-1),self.graph.cols do
      self:AddCol((self.graph.cols*-1),self.graph.cols,i)
    end
  end
end
--[[ add/remove functions end ]]--

--[[ misc functions start ]]--
function Grapher:Controls3D()
  local add = 1
  
  if self.modes_3d.move then
    if Ctrl.square.press then
      add = 2
    elseif Ctrl.ltrig.press then
      add = 3
    elseif Ctrl.rtrig.press then
      add = 4
    end
    
    if Ctrl.up.press1 or Ctrl.up.hold then
      self.graph.TY = self.graph.TY + add
    end
    if Ctrl.down.press1 or Ctrl.down.hold then
      self.graph.TY = self.graph.TY - add
    end
    if Ctrl.left.press1 or Ctrl.left.hold then
      self.graph.TX = self.graph.TX - add
    end
    if Ctrl.right.press1 or Ctrl.right.hold then
      self.graph.TX = self.graph.TX + add
    end
    if Ctrl.cross.press1 or Ctrl.cross.hold then
      self.graph.TZ = self.graph.TZ - add
    end
    if Ctrl.triangle.press1 or Ctrl.triangle.hold then
      self.graph.TZ = self.graph.TZ + add
    end
    
    --[[
    if Ctrl.ax>=80 then self.graph.TX = self.graph.TX + add end
    if Ctrl.ax<=-79 then self.graph.TX = self.graph.TX - add end
    if Ctrl.ay>=80 then self.graph.TY = self.graph.TY - add end
    if Ctrl.ay<=-79 then self.graph.TY = self.graph.TY + add end
    ]]--
    
    self.graph.TX = self.graph.TX + math.ceil(Ctrl.ax/35)
    self.graph.TY = self.graph.TY - math.ceil(Ctrl.ay/35)
  elseif self.modes_3d.rotation then
    if Ctrl.square.press then
      add = 2
    elseif Ctrl.triangle.press then
      add = 3
    elseif Ctrl.cross.press then
      add = 4
    end
    
    if Ctrl.up.press1 or Ctrl.up.hold then
      self.graph.RX = self.graph.RX + add
    end
    if Ctrl.down.press1 or Ctrl.down.hold then
      self.graph.RX = self.graph.RX - add
    end
    if Ctrl.left.press1 or Ctrl.left.hold then
      self.graph.RY = self.graph.RY - add
    end
    if Ctrl.right.press1 or Ctrl.right.hold then
      self.graph.RY = self.graph.RY + add
    end
    if Ctrl.ltrig.press1 or Ctrl.ltrig.hold then
      self.graph.RZ = self.graph.RZ - add
    end
    if Ctrl.rtrig.press1 or Ctrl.rtrig.hold then
      self.graph.RZ = self.graph.RZ + add
    end
    
    --[[
    if Ctrl.ax>=80 then self.graph.RY = self.graph.RY + add end
    if Ctrl.ax<=-79 then self.graph.RY = self.graph.RY - add end
    if Ctrl.ay>=80 then self.graph.RX = self.graph.RX - add end
    if Ctrl.ay<=-79 then self.graph.RX = self.graph.RX + add end
    ]]--

    self.graph.RY = self.graph.RY + math.ceil(Ctrl.ax/35)
    self.graph.RX = self.graph.RX - math.ceil(Ctrl.ay/35)
  end
end

function Grapher:Init()
  self:ClearGrid()
  
  while not Ctrl.select.press1 do
    self:Start3D()
    self:Draw3D()
    self:End3D()
    self:DrawInfoBar()
    self:flip()
    self:Controls3D()
    
    if Ctrl.start.press1 then
      if self:MainMenu()=="exit" then break end
    elseif Ctrl.circle.press1 then
      if self.modes_3d.move then
        self.modes_3d.move = false
        self.modes_3d.rotation = true
      elseif self.modes_3d.rotation then
        self.modes_3d.rotation = false
        self.modes_3d.move = true
      end
    end
  end
end
--[[ misc functions end ]]--

--[[ MAIN ROUTINE ]]--
do
  local GRAPHER = Grapher.new()
  GRAPHER:Init()
end

