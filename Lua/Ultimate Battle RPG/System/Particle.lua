Particle = {}

function Particle.new(xpos,ypos,xspd,yspd,xgrav,ygrav,life)
  local c = setmetatable(
    {
      Pos = {
        x = xpos,
        y = ypos
      },
      Spd = {
        x = xspd,
        y = yspd
      },
      Grav = {
        x = xgrav,
        y = ygrav
      },
      Life = {
        max = life,
        curr = 0,
        dead = false
      }
    },
    {
      __index = Particle
    }
  )

  return c
end

function Particle:pos()
  return self.Pos.x,self.Pos.y
end

function Particle:isDead()
  return self.Life.dead
end

function Particle:update()
  if not self.Life.dead then
    self.Pos.x = self.Pos.x + self.Spd.x + self.Grav.x
    self.Pos.y = self.Pos.y + self.Spd.y + self.Grav.y
    self.Life.curr = self.Life.curr + 1
    if self.Life.curr > self.Life.max then
      self.Life.dead = true
    end
  end
end
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
ParticleSystem = {}

function ParticleSystem.getXYSpd(angle,spd)
  angle = angle or 0
  
  if angle>=360 then
    while angle>=360 do
      angle=angle-360
    end
  elseif angle<=360 then
    while angle<=360 do
      angle=angle+360
    end
  end
  
  angle = angle - 90

  return (math.cos(math.rad(angle))*spd),(math.sin(math.rad(angle))*spd)
end

function ParticleSystem.defaultDrawFunc(x,y,col)
  Gu.enable(Gu.BLEND)
  Gu.disable(Gu.TEXTURE_2D)
  
  Gum.matrixMode(Gu.MODEL)
  Gum.loadIdentity()
  
  local verts = {
    {col,x,y,0}
  }
  Gum.drawArray(Gu.POINTS,Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_2D,verts)
end

function ParticleSystem.new(xpos,ypos,xgrav,ygrav,angleMin,angleMax,spdMin,spdMax,lifeMin,lifeMax,numParticles)
  local c = setmetatable(
    {
      pos = {
        x = xpos,
        y = ypos
      },
      grav = {
        x = xgrav,
        y = ygrav
      },
      angle = {
        min = angleMin,
        max = angleMax
      },
      spd = {
        min = spdMin,
        max = spdMax
      },
      life = {
        min = lifeMin,
        max = lifeMax
      },
      numParticles = numParticles,
      particles = {}
    },
    {
      __index = ParticleSystem
    }
  )

  local spdx,spdy,Angle,Spd,Life

  for i=1,numParticles do
    Angle = math.random(c.angle.min,c.angle.max)
    Spd = math.random(c.spd.min,c.spd.max)
    Life = math.random(c.life.min,c.life.max)
    spdx,spdy = ParticleSystem.getXYSpd(Angle,Spd)
    table.insert(c.particles,Particle.new(xpos,ypos,spdx,spdy,xgrav,ygrav,Life))
  end

  return c
end

function ParticleSystem:update()
  local spdx,spdy,Angle,Spd,Life

  for i=1,table.getn(self.particles) do
    if self.particles[i]:isDead() then
      Angle = math.random(self.angle.min,self.angle.max)
      Spd = math.random(self.spd.min,self.spd.max)
      Life = math.random(self.life.min,self.life.max)
      spdx,spdy = ParticleSystem.getXYSpd(Angle,Spd)
      self.particles[i] = Particle.new(self.pos.x,self.pos.y,spdx,spdy,self.grav.x,self.grav.y,Life)
    else
      self.particles[i]:update()
    end
  end
end

function ParticleSystem:getParticle(index)
  return self.particles[index]
end

function ParticleSystem:draw()
  local x,y

  Gu.start3d()
    for i=1,table.getn(self.particles) do
      if not self.particles[i]:isDead() then
        x,y = self.particles[i]:pos()
        ParticleSystem.defaultDrawFunc(x,y,Color.new(255,0,0))
      end
    end
  Gu.end3d()
end