--[[
///////////////////////////////////////////////////////////////////////////////
 'Pad input support routine'

 Copyright(c) 2005-2006, ema.
///////////////////////////////////////////////////////////////////////////////
]]--

Pad = {
  UseAnalog = string.find(System.currentDirectory(), "/cygdrive/") == nil
, timer = Timer.new()
, Step = 0
, Tick = 0
, cLu = 0
, cLd = 0
, cLl = 0
, cLr = 0
, cRu = 0
, cRd = 0
, cRl = 0
, cRr = 0
, cL1 = 0
, cR1 = 0
, cSt = 0
, cSl = 0
}

function Pad:GetRepeat(t)
  local dt = self.Tick-t
  return t>0 and (dt==0 or dt>333)
end

function Pad:nGetRepeat(t)
  if t==0 then return 0 end
  local dt = self.Tick-t
  if dt==0  then return 1 end
  if dt>333 then return self.Step end
  return 0
end

function Pad:GetHrep()
  local v = Pad:nGetRepeat(self.cLr) - Pad:nGetRepeat(self.cLl)
  return v + math.ceil(self.Ax/20-0.5)
end

function Pad:GetVrep()
  local v = Pad:nGetRepeat(self.cLd) - Pad:nGetRepeat(self.cLu)
  return v + math.ceil(self.Ay/20-0.5)
end

function Pad:GetLh()
  if self.tLr then return  1 end
  if self.tLl then return -1 end
  return 0
end

function Pad:GetLv()
  if self.tLd then return  1 end
  if self.tLu then return -1 end
  return 0
end

function Pad:GetRh()
  if self.tRr then return  1 end
  if self.tRl then return -1 end
  return 0
end

function Pad:GetRv()
  if self.tRd then return  1 end
  if self.tRu then return -1 end
  return 0
end

function Pad:Update()
  local Push = Controls.read()
  local fl, fr, fx = false, false, false
  local function CalcDeadZone(x, d)
    if x >= d then
      return x - d
    elseif x >= -d then
      return 0
    else
      return x + d
    end
  end

  if self.UseAnalog then
    self.Ax = CalcDeadZone(Push:analogX(), 32)
    self.Ay = CalcDeadZone(Push:analogY(), 32)
    if self.Ax ~= 0 or self.Ay ~= 0 then fl = true end
  else
    self.Ax = 0
    self.Ay = 0
  end

  self.Lu = Push:up()
  self.Ld = Push:down()
  self.Ll = Push:left()
  self.Lr = Push:right()
  self.Ru = Push:triangle()
  self.Rd = Push:cross()
  self.Rl = Push:square()
  self.Rr = Push:circle()
  self.L1 = Push:l()
  self.R1 = Push:r()
  self.St = Push:start()
  self.Sl = Push:select()

  self.Step=math.floor((self.timer:start()-self.Tick)/17)+1
  self.Tick=self.timer:start()

  if self.Lu then
    fl = true
    self.rLu = false
    self.tLu = self.cLu == 0
    if self.tLu then self.cLu = self.Tick end
  else
    self.rLu = self.cLu > 0
    self.tLu = false
    self.cLu = 0
  end
  if self.Ld then
    fl = true
    self.rLd = false
    self.tLd = self.cLd == 0
    if self.tLd then self.cLd = self.Tick end
  else
    self.rLd = self.cLd > 0
    self.tLd = false
    self.cLd = 0
  end
  if self.Ll then
    fl = true
    self.rLl = false
    self.tLl = self.cLl == 0
    if self.tLl then self.cLl = self.Tick end
  else
    self.rLl = self.cLl > 0
    self.tLl = false
    self.cLl = 0
  end
  if self.Lr then
    fl = true
    self.rLr = false
    self.tLr = self.cLr == 0
    if self.tLr then self.cLr = self.Tick end
  else
    self.rLr = self.cLr > 0
    self.tLr = false
    self.cLr = 0
  end

  if self.Ru then
    fr = true
    self.rRu = false
    self.tRu = self.cRu == 0
    if self.tRu then self.cRu = self.Tick end
  else
    self.rRu = self.cRu > 0
    self.tRu = false
    self.cRu = 0
  end
  if self.Rd then
    fr = true
    self.rRd = false
    self.tRd = self.cRd == 0
    if self.tRd then self.cRd = self.Tick end
  else
    self.rRd = self.cRd > 0
    self.tRd = false
    self.cRd = 0
  end
  if self.Rl then
    fr = true
    self.rRl = false
    self.tRl = self.cRl == 0
    if self.tRl then self.cRl = self.Tick end
  else
    self.rRl = self.cRl > 0
    self.tRl = false
    self.cRl = 0
  end
  if self.Rr then
    fr = true
    self.rRr = false
    self.tRr = self.cRr == 0
    if self.tRr then self.cRr = self.Tick end
  else
    self.rRr = self.cRr > 0
    self.tRr = false
    self.cRr = 0
  end

  if self.L1 then
    fx = true
    self.rL1 = false
    self.tL1 = self.cL1 == 0
    if self.tL1 then self.cL1 = self.Tick end
  else
    self.rL1 = self.cL1 > 0
    self.tL1 = false
    self.cL1 = 0
  end
  if self.R1 then
    fx = true
    self.rR1 = false
    self.tR1 = self.cR1 == 0
    if self.tR1 then self.cR1 = self.Tick end
  else
    self.rR1 = self.cR1 > 0
    self.tR1 = false
    self.cR1 = 0
  end
  if self.St then
    fx = true
    self.rSt = false
    self.tSt = self.cSt == 0
    if self.tSt then self.cSt = self.Tick end
  else
    self.rSt = self.cSt > 0
    self.tSt = false
    self.cSt = 0
  end
  if self.Sl then
    fx = true
    self.rSl = false
    self.tSl = self.cSl == 0
    if self.tSl then self.cSl = self.Tick end
  else
    self.rSl = self.cSl > 0
    self.tSl = false
    self.cSl = 0
  end

  self.PressedL = fl
  self.PressedR = fr
  self.PressedX = fx
  self.PressedLR= fl or fr
  self.Pressed  = fl or fr or fx
  if not self.Pressed then
    self.timer:reset(1)
  end

  return self.Pressed
end