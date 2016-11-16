--[[
NEW!!!
]]--

Ctrl = {
  input = Controls.read(),
  
  up = {press = false,hold = false,press1 = false,tap = false},
  down = {press = false,hold = false,press1 = false,tap = false},
  left = {press = false,hold = false,press1 = false,tap = false},
  right = {press = false,hold = false,press1 = false,tap = false},
  
  triangle = {press = false,hold = false,press1 = false,tap = false},
  cross = {press = false,hold = false,press1 = false,tap = false},
  square = {press = false,hold = false,press1 = false,tap = false},
  circle = {press = false,hold = false,press1 = false,tap = false},
  
  ltrig = {press = false,hold = false,press1 = false,tap = false},
  rtrig = {press = false,hold = false,press1 = false,tap = false},
  
  start = {press = false,hold = false,press1 = false,tap = false},
  select = {press = false,hold = false,press1 = false,tap = false},
  
  nub = {
    pos = {
      x = 0,
      y = 0
    },
    dz = {
      x = 32,
      y = 32
    },
    up = {press = false,hold = false,press1 = false,tap = false},
    down = {press = false,hold = false,press1 = false,tap = false},
    left = {press = false,hold = false,press1 = false,tap = false},
    right = {press = false,hold = false,press1 = false,tap = false}
  },
  hold = {
    timer = Timer.new(),
    time = 500
  },
  tap = {
    timer = Timer.new(),
    time = 100
  },
  pressed = {left = false,right = false,bottom = false,nub = false,total = false},
  prev = {
    up = {press = false,hold = false,press1 = false,tap = false},
    down = {press = false,hold = false,press1 = false,tap = false},
    left = {press = false,hold = false,press1 = false,tap = false},
    right = {press = false,hold = false,press1 = false,tap = false},
    
    triangle = {press = false,hold = false,press1 = false,tap = false},
    cross = {press = false,hold = false,press1 = false,tap = false},
    square = {press = false,hold = false,press1 = false,tap = false},
    circle = {press = false,hold = false,press1 = false,tap = false},
    
    ltrig = {press = false,hold = false,press1 = false,tap = false},
    rtrig = {press = false,hold = false,press1 = false,tap = false},
    
    start = {press = false,hold = false,press1 = false,tap = false},
    select = {press = false,hold = false,press1 = false,tap = false},
    nub = {
      up = {press = false,hold = false,press1 = false,tap = false},
      down = {press = false,hold = false,press1 = false,tap = false},
      left = {press = false,hold = false,press1 = false,tap = false},
      right = {press = false,hold = false,press1 = false,tap = false}
    }
  }
}

function Ctrl:AX()
  return self.nub.pos.x
end

function Ctrl:AY()
  return self.nub.pos.y
end

function Ctrl:NubX()
  return self.nub.pos.x
end

function Ctrl:NubY()
  return self.nub.pos.y
end

function Ctrl:NubPos()
  return self.nub.pos.x,self.nub.pos.y
end

function Ctrl:NubUp()
  return self.nub.up.press
end

function Ctrl:NubDown()
  return self.nub.down.press
end

function Ctrl:NubLeft()
  return self.nub.left.press
end

function Ctrl:NubRight()
  return self.nub.right.press
end

function Ctrl:NubUp1()
  return self.nub.up.press1
end

function Ctrl:NubDown1()
  return self.nub.down.press1
end

function Ctrl:NubLeft1()
  return self.nub.left.press1
end

function Ctrl:NubRight1()
  return self.nub.right.press1
end

function Ctrl:NubUpHold()
  return self.nub.up.hold
end

function Ctrl:NubDownHold()
  return self.nub.down.hold
end

function Ctrl:NubLeftHold()
  return self.nub.left.hold
end

function Ctrl:NubRightHold()
  return self.nub.right.hold
end

function Ctrl:Up()
  return self.up.press
end

function Ctrl:Down()
  return self.down.press
end

function Ctrl:Left()
  return self.left.press
end

function Ctrl:Right()
  return self.right.press
end

function Ctrl:Triangle()
  return self.triangle.press
end

function Ctrl:Cross()
  return self.cross.press
end

function Ctrl:Square()
  return self.square.press
end

function Ctrl:Circle()
  return self.circle.press
end

function Ctrl:LTrig()
  return self.ltrig.press
end

function Ctrl:RTrig()
  return self.rtrig.press
end

function Ctrl:Start()
  return self.start.press
end

function Ctrl:Select()
  return self.select.press
end

function Ctrl:Up1()
  return self.up.press1
end

function Ctrl:Down1()
  return self.down.press1
end

function Ctrl:Left1()
  return self.left.press1
end

function Ctrl:Right1()
  return self.right.press1
end

function Ctrl:Triangle1()
  return self.triangle.press1
end

function Ctrl:Cross1()
  return self.cross.press1
end

function Ctrl:Square1()
  return self.square.press1
end

function Ctrl:Circle1()
  return self.circle.press1
end

function Ctrl:LTrig1()
  return self.ltrig.press1
end

function Ctrl:RTrig1()
  return self.rtrig.press1
end

function Ctrl:Start1()
  return self.start.press1
end

function Ctrl:Select1()
  return self.select.press1
end

function Ctrl:UpHold()
  return self.up.hold
end

function Ctrl:DownHold()
  return self.down.hold
end

function Ctrl:LeftHold()
  return self.left.hold
end

function Ctrl:RightHold()
  return self.right.hold
end

function Ctrl:TriangleHold()
  return self.triangle.hold
end

function Ctrl:CrossHold()
  return self.cross.hold
end

function Ctrl:SquareHold()
  return self.square.hold
end

function Ctrl:CircleHold()
  return self.circle.hold
end

function Ctrl:LTrigHold()
  return self.ltrig.hold
end

function Ctrl:RTrigHold()
  return self.rtrig.hold
end

function Ctrl:StartHold()
  return self.start.hold
end

function Ctrl:SelectHold()
  return self.select.hold
end

function Ctrl:GetLh()
  if self.right.press then return  1 end
  if self.left.press then return -1 end
  return 0
end

function Ctrl:GetLv()
  if self.down.press then return  1 end
  if self.up.press then return -1 end
  return 0
end

function Ctrl:GetRh()
  if self.circle.press then return  1 end
  if self.square.press then return -1 end
  return 0
end

function Ctrl:GetRv()
  if self.cross.press then return  1 end
  if self.triangle.press then return -1 end
  return 0
end

function Ctrl:GetTrigs()
  if self.rtrig.press then return  1 end
  if self.ltrig.press then return -1 end
  return 0
end

function Ctrl.CalcDeadZone(x,d)
  if x >= d then
    return x - d
  elseif x >= -d then
    return 0
  else
    return x + d
  end
end

function Ctrl:Update()
  -- local vars and funcs --
  self.input = Controls.read()
------------------------------------------------------
  -- pressed --
  self.pressed.left = false
  self.pressed.right = false
  self.pressed.bottom = false
  self.pressed.nub = false
  self.pressed.total = false
------------------------------------------------------
  -- dpad press (prev) --
  self.prev.up.press = self.up.press
  self.prev.down.press = self.down.press
  self.prev.left.press = self.left.press
  self.prev.right.press = self.right.press
------------------------------------------------------
  -- face press (prev) --
  self.prev.triangle.press = self.triangle.press
  self.prev.cross.press = self.cross.press
  self.prev.square.press = self.square.press
  self.prev.circle.press = self.circle.press
------------------------------------------------------
  -- trig press (prev) --
  self.prev.ltrig.press = self.ltrig.press
  self.prev.rtrig.press = self.rtrig.press
------------------------------------------------------
  -- start and select press (prev) --
  self.prev.start.press = self.start.press
  self.prev.select.press = self.select.press
------------------------------------------------------
  -- nub (prev) --
  self.prev.nub.up.press = self.nub.up.press
  self.prev.nub.down.press = self.nub.down.press
  self.prev.nub.left.press = self.nub.left.press
  self.prev.nub.right.press = self.nub.right.press
------------------------------------------------------
  -- dpad hold (prev) --
  self.prev.up.hold = self.up.hold
  self.prev.down.hold = self.down.hold
  self.prev.left.hold = self.left.hold
  self.prev.right.hold = self.right.hold
------------------------------------------------------
  -- face hold (prev) --
  self.prev.triangle.hold = self.triangle.hold
  self.prev.cross.hold = self.cross.hold
  self.prev.square.hold = self.square.hold
  self.prev.circle.hold = self.circle.hold
------------------------------------------------------
  -- trig hold (prev) --
  self.prev.ltrig.hold = self.ltrig.hold
  self.prev.rtrig.hold = self.rtrig.hold
------------------------------------------------------
  -- start and select hold (prev) --
  self.prev.start.hold = self.start.hold
  self.prev.select.hold = self.select.hold
------------------------------------------------------
  -- nub hold (prev) --
  self.prev.nub.up.hold = self.nub.up.hold
  self.prev.nub.down.hold = self.nub.down.hold
  self.prev.nub.left.hold = self.nub.left.hold
  self.prev.nub.right.hold = self.nub.right.hold
------------------------------------------------------
  -- dpad press --
  self.up.press = self.input:up()
  self.down.press = self.input:down()
  self.left.press = self.input:left()
  self.right.press = self.input:right()
------------------------------------------------------
  -- face press --
  self.triangle.press = self.input:triangle()
  self.cross.press = self.input:cross()
  self.square.press = self.input:square()
  self.circle.press = self.input:circle()
------------------------------------------------------
  -- trig press --
  self.ltrig.press = self.input:l()
  self.rtrig.press = self.input:r()
------------------------------------------------------
  -- start and select press --
  self.start.press = self.input:start()
  self.select.press = self.input:select()
------------------------------------------------------
  -- nub press --
  self.nub.up.press = false
  self.nub.down.press = false
  self.nub.left.press = false
  self.nub.right.press = false
------------------------------------------------------
  -- dpad tap --
  self.up.tap = false
  self.down.tap = false
  self.left.tap = false
  self.right.tap = false
------------------------------------------------------
  -- face tap --
  self.triangle.tap = false
  self.cross.tap = false
  self.square.tap = false
  self.circle.tap = false
------------------------------------------------------
  -- trig tap --
  self.ltrig.tap = false
  self.rtrig.tap = false
------------------------------------------------------
  -- start and select tap --
  self.start.tap = false
  self.select.tap = false
------------------------------------------------------
  -- nub tap
  self.nub.up.tap = false
  self.nub.down.tap = false
  self.nub.left.tap = false
  self.nub.right.tap = false
------------------------------------------------------
  -- nub --
  if self.input:hold() then
    self.nub.pos.x = 0
    self.nub.pos.y = 0
  else
    self.nub.pos.x = Ctrl.CalcDeadZone(self.input:analogX(), self.nub.dz.x)
    self.nub.pos.y = Ctrl.CalcDeadZone(self.input:analogY(), self.nub.dz.y)
  end
  
  if self.nub.pos.x ~= 0 or self.nub.pos.y ~= 0 then self.pressed.nub = true end
  
  if self.nub.pos.y > 0 then
    self.nub.up.press = true
    --self.pressed.nub = true
  elseif self.nub.pos.y < 0 then
    self.nub.down.press = true
    --self.pressed.nub = true
  end

  if self.nub.pos.x > 0 then
    self.nub.right.press = true
    --self.pressed.nub = true
  elseif self.nub.pos.x < 0 then
    self.nub.left.press = true
    --self.pressed.nub = true
  end

  if self.nub.up.press then
    self.pressed.nub = true
  else
    self.nub.up.hold = false
  end
  if self.nub.down.press then
    self.pressed.nub = true
  else
    self.nub.down.hold = false
  end
  if self.nub.left.press then
    self.pressed.nub = true
  else
    self.nub.left.hold = false
  end
  if self.nub.right.press then
    self.pressed.nub = true
  else
    self.nub.right.hold = false
  end
------------------------------------------------------
  -- dpad --
  if self.up.press then
    self.pressed.left = true
  else
    self.up.hold = false
  end
  if self.down.press then
    self.pressed.left = true
  else 
    self.down.hold = false
  end
  if self.left.press then
    self.pressed.left = true
  else
    self.left.hold = false
  end
  if self.right.press then
    self.pressed.left = true
  else
    self.right.hold = false
  end
------------------------------------------------------
  -- face --
  if self.triangle.press then
    self.pressed.right = true
  else
    self.triangle.hold = false
  end
  if self.cross.press then
    self.pressed.right = true
  else
    self.cross.hold = false
  end
  if self.square.press then
    self.pressed.right = true
  else
    self.square.hold = false
  end
  if self.circle.press then
    self.pressed.right = true
  else
    self.circle.hold = false
  end
------------------------------------------------------
  -- trig --
  if self.ltrig.press then
    self.pressed.left = true
  else
    self.ltrig.hold = false
  end
  if self.rtrig.press then
    self.pressed.right = true
  else
    self.rtrig.hold = false
  end
------------------------------------------------------
  -- start and select --
  if self.start.press then
    self.pressed.bottom = true
  else
    self.start.hold = false
  end
  if self.select.press then
    self.pressed.bottom = true
  else
    self.select.hold = false
  end
------------------------------------------------------
  -- hold --
  if self.hold.timer:start() >= self.hold.time then
    self.hold.timer:reset(1)
  ------------------------------------------------------
    -- dpad --
    if self.up.press then
      if self.prev.up.press then
        self.up.hold = true
      end
    end
    if self.down.press then
      if self.prev.down.press then
        self.down.hold = true
      end
    end
    if self.left.press then
      if self.prev.left.press then
        self.left.hold = true
      end
    end
    if self.right.press then
      if self.prev.right.press then
        self.right.hold = true
      end
    end
  ------------------------------------------------------
    -- face --
    if self.triangle.press then
      if self.prev.triangle.press then
        self.triangle.hold = true
      end
    end
    if self.cross.press then
      if self.prev.cross.press then
        self.cross.hold = true
      end
    end
    if self.square.press then
      if self.prev.square.press then
        self.square.hold = true
      end
    end
    if self.circle.press then
      if self.prev.circle.press then
        self.circle.hold = true
      end
    end
  ------------------------------------------------------
    -- trig --
    if self.ltrig.press then
      if self.prev.ltrig.press then
        self.ltrig.hold = true
      end
    end
    if self.rtrig.press then
      if self.prev.rtrig.press then
        self.rtrig.hold = true
      end
    end
  ------------------------------------------------------
    -- start and select --
    if self.start.press then
      if self.prev.start.press then
        self.start.hold = true
      end
    end
    if self.select.press then
      if self.prev.select.press then
        self.select.hold = true
      end
    end
  ------------------------------------------------------
    -- nub --
    if self.nub.up.press then
      if self.prev.nub.up.press then
        self.nub.up.hold = true
      end
    end
    if self.nub.down.press then
      if self.prev.nub.down.press then
        self.nub.down.hold = true
      end
    end
    if self.nub.left.press then
      if self.prev.nub.left.press then
        self.nub.left.hold = true
      end
    end
    if self.nub.right.press then
      if self.prev.nub.right.press then
        self.nub.right.hold = true
      end
    end
  end
------------------------------------------------------
  -- dpad press1 --
  if self.up.press then
    if not self.prev.up.press1 then
      self.prev.up.press1 = true
      self.up.press1 = true
    else
      self.up.press1 = false
    end
  else
    self.up.press1 = false
    self.prev.up.press1 = false
  end
  if self.down.press then
    if not self.prev.down.press1 then
      self.prev.down.press1 = true
      self.down.press1 = true
    else
      self.down.press1 = false
    end
  else
    self.down.press1 = false
    self.prev.down.press1 = false
  end
  if self.left.press then
    if not self.prev.left.press1 then
      self.prev.left.press1 = true
      self.left.press1 = true
    else
      self.left.press1 = false
    end
  else
    self.left.press1 = false
    self.prev.left.press1 = false
  end
  if self.right.press then
    if not self.prev.right.press1 then
      self.prev.right.press1 = true
      self.right.press1 = true
    else
      self.right.press1 = false
    end
  else
    self.right.press1 = false
    self.prev.right.press1 = false
  end
------------------------------------------------------
  -- face press1 --
  if self.triangle.press then
    if not self.prev.triangle.press1 then
      self.prev.triangle.press1 = true
      self.triangle.press1 = true
    else
      self.triangle.press1 = false
    end
  else
    self.triangle.press1 = false
    self.prev.triangle.press1 = false
  end
  if self.cross.press then
    if not self.prev.cross.press1 then
      self.prev.cross.press1 = true
      self.cross.press1 = true
    else
      self.cross.press1 = false
    end
  else
    self.cross.press1 = false
    self.prev.cross.press1 = false
  end
  if self.square.press then
    if not self.prev.square.press1 then
      self.prev.square.press1 = true
      self.square.press1 = true
    else
      self.square.press1 = false
    end
  else
    self.square.press1 = false
    self.prev.square.press1 = false
  end
  if self.circle.press then
    if not self.prev.circle.press1 then
      self.prev.circle.press1 = true
      self.circle.press1 = true
    else
      self.circle.press1 = false
    end
  else
    self.circle.press1 = false
    self.prev.circle.press1 = false
  end
------------------------------------------------------
  -- trig press1 --
  if self.ltrig.press then
    if not self.prev.ltrig.press1 then
      self.prev.ltrig.press1 = true
      self.ltrig.press1 = true
    else
      self.ltrig.press1 = false
    end
  else
    self.ltrig.press1 = false
    self.prev.ltrig.press1 = false
  end
  if self.rtrig.press then
    if not self.prev.rtrig.press1 then
      self.prev.rtrig.press1 = true
      self.rtrig.press1 = true
    else
      self.rtrig.press1 = false
    end
  else
    self.rtrig.press1 = false
    self.prev.rtrig.press1 = false
  end
------------------------------------------------------
  -- start and select press1 --
  if self.start.press then
    if not self.prev.start.press1 then
      self.prev.start.press1 = true
      self.start.press1 = true
    else
      self.start.press1 = false
    end
  else
    self.start.press1 = false
    self.prev.start.press1 = false
  end
  if self.select.press then
    if not self.prev.select.press1 then
      self.prev.select.press1 = true
      self.select.press1 = true
    else
      self.select.press1 = false
    end
  else
    self.select.press1 = false
    self.prev.select.press1 = false
  end
------------------------------------------------------
  -- nub press1 --
  if self.nub.up.press then
    if not self.prev.nub.up.press1 then
      self.prev.nub.up.press1 = true
      self.nub.up.press1 = true
    else
      self.nub.up.press1 = false
    end
  else
    self.nub.up.press1 = false
    self.prev.nub.up.press1 = false
  end
  if self.nub.down.press then
    if not self.prev.nub.down.press1 then
      self.prev.nub.down.press1 = true
      self.nub.down.press1 = true
    else
      self.nub.down.press1 = false
    end
  else
    self.nub.down.press1 = false
    self.prev.nub.down.press1 = false
  end
  if self.nub.left.press then
    if not self.prev.nub.left.press1 then
      self.prev.nub.left.press1 = true
      self.nub.left.press1 = true
    else
      self.nub.left.press1 = false
    end
  else
    self.nub.left.press1 = false
    self.prev.nub.left.press1 = false
  end
  if self.nub.right.press then
    if not self.prev.nub.right.press1 then
      self.prev.nub.right.press1 = true
      self.nub.right.press1 = true
    else
      self.nub.right.press1 = false
    end
  else
    self.nub.right.press1 = false
    self.prev.nub.right.press1 = false
  end
------------------------------------------------------
  -- tap --
  if self.tap.timer:start() >= self.tap.time then
    self.tap.timer:reset(1)
  ------------------------------------------------------
    -- dpad tap --
    if self.prev.up.tap then
      if not self.up.press then
        self.up.tap = true
      else
        self.up.tap = false
      end
    else
      self.up.tap = false
    end
    if self.prev.down.tap then
      if not self.down.press then
        self.down.tap = true
      else
        self.down.tap = false
      end
    else
      self.down.tap = false
    end
    if self.prev.left.tap then
      if not self.left.press then
        self.left.tap = true
      else
        self.left.tap = false
      end
    else
      self.left.tap = false
    end
    if self.prev.right.tap then
      if not self.right.press then
        self.right.tap = true
      else
        self.right.tap = false
      end
    else
      self.right.tap = false
    end
  ------------------------------------------------------
    -- face tap --
    if self.prev.triangle.tap then
      if not self.triangle.press then
        self.triangle.tap = true
      else
        self.triangle.tap = false
      end
    else
      self.triangle.tap = false
    end
    if self.prev.cross.tap then
      if not self.cross.press then
        self.cross.tap = true
      else
        self.cross.tap = false
      end
    else
      self.cross.tap = false
    end
    if self.prev.square.tap then
      if not self.square.press then
        self.square.tap = true
      else
        self.square.tap = false
      end
    else
      self.square.tap = false
    end
    if self.prev.circle.tap then
      if not self.circle.press then
        self.circle.tap = true
      else
        self.circle.tap = false
      end
    else
      self.circle.tap = false
    end
  ------------------------------------------------------
    -- trig tap --
    if self.prev.ltrig.tap then
      if not self.ltrig.press then
        self.ltrig.tap = true
      else
        self.ltrig.tap = false
      end
    else
      self.ltrig.tap = false
    end
    if self.prev.rtrig.tap then
      if not self.rtrig.press then
        self.rtrig.tap = true
      else
        self.rtrig.tap = false
      end
    else
      self.rtrig.tap = false
    end
  ------------------------------------------------------
    -- start and select tap --
    if self.prev.start.tap then
      if not self.start.press then
        self.start.tap = true
      else
        self.start.tap = false
      end
    else
      self.start.tap = false
    end
    if self.prev.select.tap then
      if not self.select.press then
        self.select.tap = true
      else
        self.select.tap = false
      end
    else
      self.select.tap = false
    end
  ------------------------------------------------------
    -- nub tap --
    if self.prev.nub.up.tap then
      if not self.nub.up.press then
        self.nub.up.tap = true
      else
        self.nub.up.tap = false
      end
    else
      self.nub.up.tap = false
    end
    if self.prev.nub.down.tap then
      if not self.nub.down.press then
        self.nub.down.tap = true
      else
        self.nub.down.tap = false
      end
    else
      self.nub.down.tap = false
    end
    if self.prev.nub.left.tap then
      if not self.nub.left.press then
        self.nub.left.tap = true
      else
        self.nub.left.tap = false
      end
    else
      self.nub.left.tap = false
    end
    if self.prev.nub.right.tap then
      if not self.nub.right.press then
        self.nub.right.tap = true
      else
        self.nub.right.tap = false
      end
    else
      self.nub.right.tap = false
    end
  ------------------------------------------------------
    -- dpad tap prev --
    self.prev.up.tap = self.up.press
    self.prev.down.tap = self.down.press
    self.prev.left.tap = self.left.press
    self.prev.right.tap = self.right.press
  ------------------------------------------------------
    -- face tap prev --
    self.prev.triangle.tap = self.triangle.press
    self.prev.cross.tap = self.cross.press
    self.prev.square.tap = self.square.press
    self.prev.circle.tap = self.circle.press
  ------------------------------------------------------
    -- trig tap prev --
    self.prev.ltrig.tap = self.ltrig.press
    self.prev.rtrig.tap = self.rtrig.press
  ------------------------------------------------------
    -- start and select tap prev --
    self.prev.start.tap = self.start.press
    self.prev.select.tap = self.select.press
  ------------------------------------------------------
    -- nub tap prev --
    self.prev.nub.up.tap = self.nub.up.press
    self.prev.nub.down.tap = self.nub.down.press
    self.prev.nub.left.tap = self.nub.left.press
    self.prev.nub.right.tap = self.nub.right.press
  end
------------------------------------------------------
  -- pressed --
  self.pressed.total = self.pressed.left or self.pressed.right or self.pressed.nub or self.pressed.bottom
------------------------------------------------------
  if not self.pressed.total then
    self.hold.timer:reset(1)
  end
------------------------------------------------------
  -- return true if the controls were pressed --
  return self.pressed.total
end

function Ctrl:reset()
  -- hold and tap timers --
  self.hold.timer:reset(1)
  self.tap.timer:reset(1)
------------------------------------------------------
  -- pressed --
  self.pressed.left = false
  self.pressed.right = false
  self.pressed.bottom = false
  self.pressed.nub = false
  self.pressed.total = false

------------------------------------------------------
  --[[ press (prev) start ]]--
  -- dpad press (prev) --
  self.prev.up.press = false
  self.prev.down.press = false
  self.prev.left.press = false
  self.prev.right.press = false
  
  -- face press (prev) --
  self.prev.triangle.press = false
  self.prev.cross.press = false
  self.prev.square.press = false
  self.prev.circle.press = false
  
  -- trig press (prev) --
  self.prev.ltrig.press = false
  self.prev.rtrig.press = false
  
  -- start and select press (prev) --
  self.prev.start.press = false
  self.prev.select.press = false
  
  -- nub press (prev) --
  self.prev.nub.up.press = false
  self.prev.nub.down.press = false
  self.prev.nub.left.press = false
  self.prev.nub.right.press = false
  --[[ press (prev) end ]]--
------------------------------------------------------
  --[[ hold (prev) start ]]--
  -- dpad hold (prev) --
  self.prev.up.hold = false
  self.prev.down.hold = false
  self.prev.left.hold = false
  self.prev.right.hold = false
  
  -- face hold (prev) --
  self.prev.triangle.hold = false
  self.prev.cross.hold = false
  self.prev.square.hold = false
  self.prev.circle.hold = false
  
  -- trig hold (prev) --
  self.prev.ltrig.hold = false
  self.prev.rtrig.hold = false
  
  -- start and select hold (prev) --
  self.prev.start.hold = false
  self.prev.select.hold = false
  
  -- nub hold (prev) --
  self.prev.nub.up.hold = false
  self.prev.nub.down.hold = false
  self.prev.nub.left.hold = false
  self.prev.nub.right.hold = false
  --[[ hold (prev) end ]]--
------------------------------------------------------
  --[[ tap (prev) start ]]--
  -- dpad tap (prev) --
  self.prev.up.tap = false
  self.prev.down.tap = false
  self.prev.left.tap = false
  self.prev.right.tap = false
  
  -- face tap (prev) --
  self.prev.triangle.hold = false
  self.prev.cross.tap = false
  self.prev.square.tap = false
  self.prev.circle.tap = false
  
  -- trig tap (prev) --
  self.prev.ltrig.tap = false
  self.prev.rtrig.tap = false
  
  -- start and select tap (prev) --
  self.prev.start.tap = false
  self.prev.select.tap = false
  
  -- nub tap (prev) --
  self.prev.nub.up.tap = false
  self.prev.nub.down.tap = false
  self.prev.nub.left.tap = false
  self.prev.nub.right.tap = false
  --[[ tap (prev) end ]]--
------------------------------------------------------
  --[[ press start ]]--
  -- dpad press --
  self.up.press = false
  self.down.press = false
  self.left.press = false
  self.right.press = false
  
  -- face press --
  self.triangle.press = false
  self.cross.press = false
  self.square.press = false
  self.circle.press = false
  
  -- trig press --
  self.ltrig.press = false
  self.rtrig.press = false
  
  -- start and select press --
  self.start.press = false
  self.select.press = false
  
  -- nub press --
  self.nub.up.press = false
  self.nub.down.press = false
  self.nub.left.press = false
  self.nub.right.press = false
  self.nub.pos.x = 0
  self.nub.pos.y = 0
  --[[ press end ]]--
------------------------------------------------------
  --[[ hold start ]]--
  -- dpad hold --
  self.up.hold = false
  self.down.hold = false
  self.left.hold = false
  self.right.hold = false
  
  -- face hold --
  self.triangle.hold = false
  self.cross.hold = false
  self.square.hold = false
  self.circle.hold = false
  
  -- trig hold --
  self.ltrig.hold = false
  self.rtrig.hold = false
  
  -- start and select hold --
  self.start.hold = false
  self.select.hold = false
  
  -- nub hold --
  self.nub.up.hold = false
  self.nub.down.hold = false
  self.nub.left.hold = false
  self.nub.right.hold = false
  --[[ hold end ]]--
------------------------------------------------------
  --[[ tap start ]]--
  -- dpad tap --
  self.up.tap = false
  self.down.tap = false
  self.left.tap = false
  self.right.tap = false
  
  -- face tap --
  self.triangle.tap = false
  self.cross.tap = false
  self.square.tap = false
  self.circle.tap = false
  
  -- trig tap --
  self.ltrig.tap = false
  self.rtrig.tap = false
  
  -- start and select tap --
  self.start.tap = false
  self.select.tap = false
  
  -- nub tap --
  self.nub.up.tap = false
  self.nub.down.tap = false
  self.nub.left.tap = false
  self.nub.right.tap = false
  --[[ tap end ]]--
end