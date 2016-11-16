--[[
Frames Per Second (FPS) Counter Luaplayer Class\Library  Ver. 1.0
Created By: alatnet
Dev Team X Productions
]]--

FPSCounter = {}

function FPSCounter.new()
  local c = setmetatable(
    {
      FPS = 0,
      Frames = 0,
      timer = Timer.new()
    },
    {
      __index = FPSCounter
    }
  )

  return c
end

function FPSCounter:update()
  self.Frames = self.Frames + 1
  
  if self.timer:start() >= 1000 then
    self.timer:reset()
    self.FPS = self.Frames
    self.Frames = 0
  end

  return self.FPS
end