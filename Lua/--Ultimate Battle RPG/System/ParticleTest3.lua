requireC("System/Particle.lc")
requireC("System/Ctrl.lc")
requireC("System/FPSCounter.lua")

do
  math.randomseed(os.time())
  local PS = ParticleSystem.new(240,136,0,0,-45,45,0.1,1.0,30,60,25)
  local FPS = FPSCounter.new()
  while not Ctrl:Start() do
    Ctrl:Update()
    PS:update()
    screen:clear(Color.new(255,255,255))
    screen:print(2,2,FPS:update(),Color.new(0,0,0))
    PS:draw()
    screen.waitVblankStart()
    screen.flip()
  end
end