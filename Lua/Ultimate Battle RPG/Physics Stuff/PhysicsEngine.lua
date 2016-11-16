dofile("Vector3D.lua")

Mass = {}

function Mass.new(m)
  local c = setmetatable(
    {
      mass = m,
      pos = Vector3D.new(0,0,0),
      vel = Vector3D.new(0,0,0),
      force = Vector3D.new(0,0,0)
    },
    {
      __index = Mass
    }
  )
  
  return c
end

function Mass:init()
  self.force.x = 0
  self.force.y = 0
  self.force.z = 0
end

function Mass:applyForce(force)
  self.force = self.force + force
end

function Mass:simulate(dt)
  self.vel = self.vel + ((self.force / self.mass) * dt)
  self.pos = self.pos + (self.vel * dt)
end
------------------------------------------------------------------------------------

Simulation = {}

function Simulation.new(numOfMasses, m)
  local c = setmetatable(
    {
      numOfMasses = numOfMasses,
      masses = {},
      funcSolve = function(self) end
    },
    {
      __index = Simulation
    }
  )
  
  for i=1,numOfMasses do
    table.insert(c.masses,Mass.new(m))
  end

  return c
end

function Simulation:release()
  while table.getn(self.masses) do
    table.remove(self.masses)
  end
end

function Simulation:getMass(index)
  if index < 1 or index > table.getn(self.masses) then
    return
  end
  
  return self.masses[index]
end

function Simulation:init()
  for i=1,table.getn(self.masses) do
    self.masses[i]:init()
  end
end

function Simulation:setSolve(func)
  self.funcSolve = func
end

function Simulation:simulate(dt)
  for i=1,table.getn(self.masses) do
    self.masses[i]:simulate(dt)
  end
end

function Simulation:operate(dt)
  self:init()
  self.funcSolve(self)
  self:simulate(dt)
end