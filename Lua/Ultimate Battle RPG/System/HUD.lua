requireC ("System/BAR.lua")
requireC ("System/FPSCounter.lua")
requireC ("System/colors.lua")

HUD = {}

function HUD.new()

  local c = setmetatable(
    {     
    },
    {
      __index = HUD
    }
  )
end

function HUD:Draw()
end
