requireC (Global.system.dir.main .. "AnimatedSprite.lua")
requireC (Global.system.dir.main .. "AnimatedSprite3D.lua")

Char3D = {
  DIR = {
    L = -1,
    R = -2
  },
  STATE = {
    MOVE = {
      STAND = 1,
      WALK = 2,
      RUN = 3
    },
    JUMP = {
      GROUND = 4,
      JUMPING = 5,
      FALLING = 6,
      LANDING = 7
    },
    GUARD = {
      ON = 8,
      OFF = 9
    }
  },
  SPRITE = {
    STAND = 10,
    WALK = 11,
    RUN = 12,
    JUMP = {
      UP = 13,
      DOWN = 14,
      LAND = 15
    },
    ATTACK = {
      AIR = 16,
      C1 = 17,
      C2 = 18,
      C3 = 19
    },
    GUARD = {
      GROUND = 20,
      AIR = 21
    },
    DAMMAGE = 22,
    KB = 23,
    KBR = 24
  }
}

--[[ spriteList template ]]--
--[[
spriteList = {
  standing = {
    l = "",
    r = "",
    rows = 1,
    cols = 1,
    freq = 0
  },
  walking = {
    l = "",
    r = "",
    rows = 1,
    cols = 1,
    freq = 0
  },
  running = {
    l = "",
    r = "",
    rows = 1,
    cols = 1,
    freq = 0
  },
  jumping = {
    l = "",
    r = "",
    rows = 1,
    cols = 1,
    freq = 0
  },
  falling = {
    l = "",
    r = "",
    rows = 1,
    cols = 1,
    freq = 0
  },
  guarding = {
    ground = {
      l = "",
      r = "",
      rows = 1,
      cols = 1,
      freq = 0
    },
    air = {
      l = "",
      r = "",
      rows = 1,
      cols = 1,
      freq = 0
    }
  },
  attacking = {
    air = {
      l = "",
      r = "",
      rows = 1,
      cols = 1,
      freq = 0
    },
    c1 = {
      l = "",
      r = "",
      rows = 1,
      cols = 1,
      freq = 0
    },
    c2 = {
      l = "",
      r = "",
      rows = 1,
      cols = 1,
      freq = 0
    c3 = {
      l = "",
      r = "",
      rows = 1,
      cols = 1,
      freq = 0
    }
  },
  dammaged = {
    l = "",
    r = "",
    rows = 1,
    cols = 1,
    freq = 0
  },
  knockback = {
    l = "",
    r = "",
    rows = 1,
    cols = 1,
    freq = 0,
    spd = {
      x = 0,
      y = 0
    },
    amt = 2,
    wait = 500
  },
  knockback_r = {
    l = "",
    r = "",
    rows = 1,
    cols = 1,
    freq = 0
  }
}
]]--

function Char3D.new(x,y,z,groundY,spdX,spdX2,spdY,gravX,gravY,stopW,stopR,direction,folder,spriteList,dir)
  local c = setmetatable(
    {
      pos = {
        x = x,
        y = y,
        z = z
      },
      spd = {
        x = spdX, -- 2
        x2 = spdX2, -- 2
        y = spdY, -- 2
        z = 0,
        stoping = {
          walk = stopW -- 0.5,
          running = stopR -- 0.25
        },
        init = {
          x = spdX, -- 1
          x2 = spdX2, -- 2
          y = spdY,  -- 2
          z = 0
        }
      },
      grav = {
        x = gravX,  -- 0
        y = gravY,  -- 0.25
        z = 0
      },
      ground = groundY,
      state = {
        dir = direction,
        move = {
          curr = Char3D.STATE.MOVE.STAND,
          prev = Char3D.STATE.MOVE.STAND,
          slowing1 = false,
          slowing2 = false
        },
        jump = Char3D.STATE.JUMP.GROUND,
        guard = {
          air = Char3D.STATE.GUARD.OFF,
          ground = Char3D.STATE.GUARD.OFF,
          guarding = false
        },
        attack = {
          attacking = false,
          air = false,
          c1 = false,
          c2 = false,
          c3 = false,
          AnimDone = {
            c1 = false,
            c2 = false,
            c3 = false
          }
        },
        dammage = false,
        kb = false,
        kbr = false
      },
      sprite = {
        curr = Char3D.SPRITE.STAND,
        Anim = nil,
        folder = folder,
        dir = dir,
        list = spriteList
      },
      timer = Timer.new()
    },
    {
      __index = Char3D
    }
  )
  
  if direction == Char3D.DIR.L then
    direction = c.sprite.dir.left .. c.sprite.list.standing.l
  elseif dir == Char3D.DIR.R then
    direction = c.sprite.dir.right .. c.sprite.list.standing.r
  end

  c.sprite.Anim = AnimatedSprite3D.new(c.sprite.folder .. direction,c.sprite.list.standing.rows,c.sprite.list.standing.cols,c.sprite.list.standing.freq)
end

function Char3D:Grav(x,y)
  if x == nil or y == nil then
    return self.grav.x,self.grav.y
  else
    self.grav.x = x
    self.grav.y = y
  end
end

function Char3D:Spd(x,x2,y,stopW,stopR)
  if x == nil or x2 == nil or y == nil or stopW == nil or stopR == nil then
    return self.spd.x,self.spd.x2,self.spd.y,self.spd.stopping.walk,self.spd.stopping.running
  else
    self.spd.x = x
    self.spd.x2 = x2
    self.spd.y = y
    self.spd.stopping.walk = stopW
    self.spd.stopping.running = stopR
    self.spd.init.x = x
    self.spd.init.x2 = x2
    self.spd.init.y = y
  end
end

function Char3D:Pos(x,y,z)
  if x == nil or y == nil or z == nil then
    return self.pos.x,self.pos.y,self.pos.z
  else
    self.pos.x = x
    self.pos.y = y
    self.pos.z = z
  end
end

function Char3D:groundY(y)
  if y == nil then
    return self.ground
  else
    self.ground = y
  end
end

function Char3D:currDir(dir)
  if dir == nil then
    if self.state.dir == Char3D.DIR.L then
      return 1
    elseif self.state.dir == Char3D.DIR.R then
      return 2
    end
  else
    if dir == "L" or dir == "l" then
      self.state.dir == Char3D.DIR.L
    elseif dir == "R" or dir == "r" then
      self.state.dir == Char3D.DIR.R
    end
  end
end

function Char3D:currStatus(statusType,air)
  if statusType == 1 then
    if self.state.move.curr == Char3D.STATE.MOVE.RUN then
      return 1
    elseif self.state.move.curr == Char3D.STATE.MOVE.WALK then
      return 2
    elseif self.state.move.curr == Char3D.STATE.MOVE.STAND then
      return 3
    end
  elseif statusType == 2 then
    if self.state.jump == Char3D.STATE.JUMP.GROUND then
      return 1
    elseif self.state.jump == Char3D.STATE.JUMP.JUMPING then
      return 2
    elseif self.state.jump == Char3D.STATE.JUMP.FALLING then
      return 3
    end
  elseif statusType == 3 then
    if air then
      return self.state.guard.air == Char3D.STATE.GUARD.ON
    else
      return self.state.guard.ground == Char3D.STATE.GUARD.ON
    end
  elseif statusType == 4 then
    if air then
      return self.state.attack.air
    else
      if self.state.attack.c3 then
        return 3
      elseif self.state.attack.c2 then
        return 2
      elseif self.state.attack.c1 then
        return 1
      end
    end
  elseif statusType == 5 then
    return self.state.dammage
  elseif statusType == 6 then
    return self.state.kb
  end
  return 0
end

function Char3D:update()
  self.state.attack.attacking = self.state.attack.air or self.state.attack.c1 or self.state.attack.c2 or self.state.attack.c3
  
  self.state.move.prev = self.state.move.curr
  
  self.state.guard.guarding = self.state.guard.ground == Char3D.STATE.GUARD.ON or self.state.guard.air == Char3D.STATE.GUARD.ON
  
  if self.state.move.curr == Char3D.STATE.MOVE.STAND then
    if self.state.dir == Char3D.DIR.L then
      self.pos.x = self.pos.x - self.spd.x - self.grav.x
    elseif self.state.dir == Char3D.DIR.R then
      self.pos.x = self.pos.x + self.spd.x + self.grav.x
    end
    
    if self.spd.x > 0 then
      if self.state.move.prev == Char3D.STATE.MOVE.WALK or self.state.move.slowing1 then
        self.spd.x = self.spd.x - self.spd.stoping.walk
        self.state.move.slowing1 = true
      elseif self.state.move.prev == Char3D.STATE.MOVE.RUN or self.state.move.slowing2 then
        self.spd.x = self.spd.x - self.spd.stoping.running
        self.state.move.slowing2 = true
      end
    else
      self.spd = 0
      self.state.move.slowing1 = false
      self.state.move.slowing2 = false
    end
  elseif self.state.move.curr == Char3D.STATE.MOVE.WALK then
    if not self.state.attack.attacking or not self.state.guard.guarding then
      self.spd.x = self.spd.init.x
    end
    
    if self.state.dir == Char3D.DIR.L then
      self.pos.x = self.pos.x - self.spd.x - self.grav.x
    elseif self.state.dir == Char3D.DIR.R then
      self.pos.x = self.pos.x + self.spd.x + self.grav.x
    end
    
    if self.state.attack.attacking or self.state.guard.guarding then
      self.spd.x = self.spd.x - self.spd.stoping.walk
    end
    
    if self.spd.x <= 0 then self.spd.x = 0 end
  elseif self.state.move.curr == Char3D.STATE.MOVE.RUN then
    if not self.state.attack.attacking or not self.state.guard.guarding then
      self.spd.x = self.spd.init.x
    end
    
    if self.state.dir == Char3D.DIR.L then
      self.pos.x = self.pos.x - self.spd.x2 - self.grav.x
    elseif self.state.dir == Char3D.DIR.R then
      self.pos.x = self.pos.x + self.spd.x2 + self.grav.x
    end
    
    if self.state.attack.attacking or self.state.guard.guarding then
      self.spd.x = self.spd.x - self.spd.stoping.running
    end
    
    if self.spd.x <= 0 then self.spd.x = 0 end
  end

  if self.state.jump == Char3D.STATE.JUMP.JUMPING then
    self.pos.y = self.pos.y - self.spd.y
    self.spd.y = self.spd.y - self.grav.y

    if self.spd.y <= 0 then
      self.state.jump = Char3D.STATE.JUMP.FALLING
    end
  elseif self.state.jump == Char3D.STATE.JUMP.FALLING then
    self.pos.y = self.pos.y - self.spd.y
    self.spd.y = self.spd.y - self.grav.y
    
    if self.pos.y <= self.ground then
      self.pos.y = self.ground
      self.spd.y = self.spd.init.y
      self.state.jump = Char3D.STATE.JUMP.LANDING
    end
  end

  --[[ SPRITE ANIMATION ]]--

  local spriteChange = false
  local newSprite = {
    img = "",
    rows = 1,
    cols = 1,
    freq = 0
  }

  if self.state.move.curr == Char3D.STATE.MOVE.STAND
     and self.state.jump == Char3D.STATE.JUMP.GROUND
     and not self.state.attack.attacking
     and not self.state.guard.guarding
     and not self.state.dammage 
     and not self.state.kb then
    if self.sprite.curr ~= Char3D.SPRITE.STAND then
      spriteChange = true
      if self.state.dir == Char3D.DIR.L then
        newSprite.img = self.sprite.dir.left .. self.sprite.list.standing.l
      elseif self.state.dir == Char3D.DIR.R then
        newSprite.img = self.sprite.dir.right .. self.sprite.list.standing.r
      end
      newSprite.rows = self.sprite.list.standing.rows
      newSprite.cols = self.sprite.list.standing.cols
      newSprite.freq = self.sprite.list.standing.freq
      self.sprite.curr = Char3D.SPRITE.STAND
    end
  elseif self.state.move.curr == Char3D.STATE.MOVE.WALK then
    if self.sprite.curr ~= Char3D.SPRITE.WALK then
      spriteChange = true
      if self.state.dir == Char3D.DIR.L then
        newSprite.img = self.sprite.dir.left .. self.sprite.list.walking.l
      elseif self.state.dir == Char3D.DIR.R then
        newSprite.img = self.sprite.dir.right .. self.sprite.list.walking.r
      end
      newSprite.rows = self.sprite.list.walking.rows
      newSprite.cols = self.sprite.list.walking.cols
      newSprite.freq = self.sprite.list.walking.freq
      self.sprite.curr = Char3D.SPRITE.WALK
    end
  elseif self.state.move.curr == Char3D.STATE.MOVE.RUN then
    if self.sprite.curr ~= Char3D.SPRITE.RUN then
      spriteChange = true
      if self.state.dir == Char3D.DIR.L then
        newSprite.img = self.sprite.dir.left .. self.sprite.list.running.l
      elseif self.state.dir == Char3D.DIR.R then
        newSprite.img = self.sprite.dir.right .. self.sprite.list.running.r
      end
      newSprite.rows = self.sprite.list.running.rows
      newSprite.cols = self.sprite.list.running.cols
      newSprite.freq = self.sprite.list.running.freq
      self.sprite.curr = Char3D.SPRITE.RUN
    end
  elseif self.state.jump == Char3D.STATE.JUMP.JUMPING then
    if self.sprite.curr ~= Char3D.SPRITE.JUMP.UP then
      spriteChange = true
      if self.state.dir == Char3D.DIR.L then
        newSprite.img = self.sprite.dir.left .. self.sprite.list.jumping.l
      elseif self.state.dir == Char3D.DIR.R then
        newSprite.img = self.sprite.dir.right .. self.sprite.list.jumping.r
      end
      newSprite.rows = self.sprite.list.jumping.rows
      newSprite.cols = self.sprite.list.jumping.cols
      newSprite.freq = self.sprite.list.jumping.freq
      self.sprite.curr = Char3D.SPRITE.JUMP.UP
    end
  elseif self.state.jump == Char3D.STATE.JUMP.FALLING then
    if self.sprite.curr ~= Char3D.SPRITE.JUMP.DOWN then
      spriteChange = true
      if self.state.dir == Char3D.DIR.L then
        newSprite.img = self.sprite.dir.left .. self.sprite.list.falling.l
      elseif self.state.dir == Char3D.DIR.R then
        newSprite.img = self.sprite.dir.right .. self.sprite.list.falling.r
      end
      newSprite.rows = self.sprite.list.falling.rows
      newSprite.cols = self.sprite.list.falling.cols
      newSprite.freq = self.sprite.list.falling.freq
      self.sprite.curr = Char3D.SPRITE.JUMP.DOWN
    end
  elseif self.state.jump == Char3D.STATE.JUMP.LANDING then
    if self.sprite.curr ~= Char3D.SPRITE.JUMP.LAND then
      spriteChange = true
      if self.state.dir == Char3D.DIR.L then
        newSprite.img = self.sprite.dir.left .. self.sprite.list.landing.l
      elseif self.state.dir == Char3D.DIR.R then
        newSprite.img = self.sprite.dir.right .. self.sprite.list.landing.r
      end
      newSprite.rows = self.sprite.list.landing.rows
      newSprite.cols = self.sprite.list.landing.cols
      newSprite.freq = self.sprite.list.landing.freq
      self.sprite.curr = Char3D.SPRITE.JUMP.LAND
    else
      if self.sprite.curr:getSprite():atLastFrame() then
        self.state.jump = Char3D.STATE.JUMP.GROUND
      end
    end
  elseif self.state.guard.ground == Char3D.STATE.GUARD.ON then
    if self.sprite.curr ~= Char3D.SPRITE.GUARD.GROUND then
      spriteChange = true
      if self.state.dir == Char3D.DIR.L then
        newSprite.img = self.sprite.dir.left .. self.sprite.list.guarding.ground.l
      elseif self.state.dir == Char3D.DIR.R then
        newSprite.img = self.sprite.dir.right .. self.sprite.list.guarding.ground.r
      end
      newSprite.rows = self.sprite.list.guarding.ground.rows
      newSprite.cols = self.sprite.list.guarding.ground.cols
      newSprite.freq = self.sprite.list.guarding.ground.freq
      self.sprite.curr = Char3D.SPRITE.GUARD.GROUND
    end
  elseif self.state.guard.air == Char3D.STATE.GUARD.ON then
    if self.sprite.curr ~= Char3D.SPRITE.GUARD.AIR then
      spriteChange = true
      if self.state.dir == Char3D.DIR.L then
        newSprite.img = self.sprite.dir.left .. self.sprite.list.guarding.air.l
      elseif self.state.dir == Char3D.DIR.R then
        newSprite.img = self.sprite.dir.right .. self.sprite.list.guarding.air.r
      end
      newSprite.rows = self.sprite.list.guarding.air.rows
      newSprite.cols = self.sprite.list.guarding.air.cols
      newSprite.freq = self.sprite.list.guarding.air.freq
      self.sprite.curr = Char3D.SPRITE.GUARD.AIR
    end
  elseif self.state.dammage then
    if self.sprite.curr ~= Char3D.SPRITE.DAMMAGE then
      spriteChange = true
      if self.state.dir == Char3D.DIR.L then
        newSprite.img = self.sprite.dir.left .. self.sprite.list.dammaged.l
      elseif self.state.dir == Char3D.DIR.R then
        newSprite.img = self.sprite.dir.right .. self.sprite.list.dammaged.r
      end
      newSprite.rows = self.sprite.list.dammaged.rows
      newSprite.cols = self.sprite.list.dammaged.cols
      newSprite.freq = self.sprite.list.dammaged.freq
      self.sprite.curr = Char3D.SPRITE.DAMMAGE
    end
  elseif self.state.kb then
    if self.sprite.curr ~= Char3D.SPRITE.KB then
      spriteChange = true
      if self.state.dir == Char3D.DIR.L then
        newSprite.img = self.sprite.dir.left .. self.sprite.list.knockback.l
      elseif self.state.dir == Char3D.DIR.R then
        newSprite.img = self.sprite.dir.right .. self.sprite.list.knockback.r
      end
      newSprite.rows = self.sprite.list.knockback.rows
      newSprite.cols = self.sprite.list.knockback.cols
      newSprite.freq = self.sprite.list.knockback.freq
      self.sprite.curr = Char3D.SPRITE.KB
    end
    --[[ Have it move and wait ]]--
  elseif self.state.kbr then
    if self.sprite.curr ~= Char3D.SPRITE.KBR then
      spriteChange = true
      if self.state.dir == Char3D.DIR.L then
        newSprite.img = self.sprite.dir.left .. self.sprite.list.knockback_r.l
      elseif self.state.dir == Char3D.DIR.R then
        newSprite.img = self.sprite.dir.right .. self.sprite.list.knockback_r.r
      end
      newSprite.rows = self.sprite.list.knockback_r.rows
      newSprite.cols = self.sprite.list.knockback_r.cols
      newSprite.freq = self.sprite.list.knockback_r.freq
      self.sprite.curr = Char3D.SPRITE.KBR
    end
    --[[ Occurs after knockback ]]--
  elseif self.state.attack.attacking then
    if not self.state.attack.air then
      if self.sprite.curr == Char3D.SPRITE.ATTACK.C3 then
        if self.sprite.curr:getSprite():atLastFrame() then
          self.state.attack.AnimDone.c3 = true
        end
      elseif self.sprite.curr == Char3D.SPRITE.ATTACK.C2 then
        if self.sprite.curr:getSprite():atLastFrame() then
          self.state.attack.AnimDone.c2 = true
        end
      elseif self.sprite.curr == Char3D.SPRITE.ATTACK.C1 then
        if self.sprite.curr:getSprite():atLastFrame() then
          self.state.attack.AnimDone.c1 = true
        end
      end

      if self.state.attack.c3 and not self.state.attack.c2 not self.state.attack.c1 then
        if self.sprite.curr ~= Char3D.SPRITE.ATTACK.C3 then
          spriteChange = true
          if self.state.dir == Char3D.DIR.L then
            newSprite.img = self.sprite.dir.left .. self.sprite.list.attacking.c3.l
          elseif self.state.dir == Char3D.DIR.R then
            newSprite.img = self.sprite.dir.right .. self.sprite.list.attacking.c3.r
          end
          newSprite.rows = self.sprite.list.attacking.c3.rows
          newSprite.cols = self.sprite.list.attacking.c3.cols
          newSprite.freq = self.sprite.list.attacking.c3.freq
          self.sprite.curr = Char3D.SPRITE.ATTACK.C3
        end
      end
    
      if self.state.attack.c2 and not self.state.attack.c3 not self.state.attack.c1 then
        if self.sprite.curr ~= Char3D.SPRITE.ATTACK.C2 then
          spriteChange = true
          if self.state.dir == Char3D.DIR.L then
            newSprite.img = self.sprite.dir.left .. self.sprite.list.attacking.c2.l
          elseif self.state.dir == Char3D.DIR.R then
            newSprite.img = self.sprite.dir.right .. self.sprite.list.attacking.c2.r
          end
          newSprite.rows = self.sprite.list.attacking.c2.rows
          newSprite.cols = self.sprite.list.attacking.c2.cols
          newSprite.freq = self.sprite.list.attacking.c2.freq
          self.sprite.curr = Char3D.SPRITE.ATTACK.C2
        end
      end

      if self.state.attack.c1 and not self.state.attack.c2 not self.state.attack.c3 then
        if self.sprite.curr ~= Char3D.SPRITE.ATTACK.C1 then
          spriteChange = true
          if self.state.dir == Char3D.DIR.L then
            newSprite.img = self.sprite.dir.left .. self.sprite.list.attacking.c1.l
          elseif self.state.dir == Char3D.DIR.R then
            newSprite.img = self.sprite.dir.right .. self.sprite.list.attacking.c1.r
          end
          newSprite.rows = self.sprite.list.attacking.c1.rows
          newSprite.cols = self.sprite.list.attacking.c1.cols
          newSprite.freq = self.sprite.list.attacking.c1.freq
          self.sprite.curr = Char3D.SPRITE.ATTACK.C1
        end
      end
    else
      if self.sprite.curr ~= Char3D.SPRITE.ATTACK.AIR then
        spriteChange = true
        if self.state.dir == Char3D.DIR.L then
          newSprite.img = self.sprite.dir.left .. self.sprite.list.attacking.air.l
        elseif self.state.dir == Char3D.DIR.R then
          newSprite.img = self.sprite.dir.right .. self.sprite.list.attacking.air.r
        end
        newSprite.rows = self.sprite.list.attacking.air.rows
        newSprite.cols = self.sprite.list.attacking.air.cols
        newSprite.freq = self.sprite.list.attacking.air.freq
        self.sprite.curr = Char3D.SPRITE.ATTACK.AIR
      end
    end
  end

  if spriteChange then
    self.sprite.Anim:setSprite(self.sprite.folder .. newSprite.img,newSprite.cols,newSprite.rows,newSprite.freq)
  end
end

function Char3D:action(moveL,moveR,run,jump,guard,attack,dammage,kb)
  if dammage and not self.state.attack.attacking and not self.state.guard.guarding then
    self.state.dammage = true
  end
  if kb and not self.state.attack.attacking and not self.state.guard.guarding then
    self.state.kb = true
  end
  
  if moveL and not self.state.attack.attacking and not self.state.guard.guarding and not self.state.dammage and not self.state.kb and not self.state.kbr then
    self.state.dir = Char3D.DIR.L
    if run then
      self.state.move.curr = Char3D.STATE.MOVE.RUN
    else
      self.state.move.curr = Char3D.STATE.MOVE.WALK
    end
  elseif moveR and not self.state.attack.attacking and not self.state.guard.guarding and not self.state.dammage and not self.state.kb and not self.state.kbr then
    self.state.dir = Char3D.DIR.R
    if run then
      self.state.move.curr = Char3D.STATE.MOVE.RUN
    else
      self.state.move.curr = Char3D.STATE.MOVE.WALK
    end
  else
    self.state.move.curr = Char3D.STATE.MOVE.STAND
  end
  
  if jump and not self.state.dammage and not self.state.kb and not self.state.kbr then
    if self.state.jump == Char3D.STATE.JUMP.GROUND then
      self.state.jump = Char3D.STATE.JUMP.JUMPING
    end
  else
    if self.state.jump == Char3D.STATE.JUMP.JUMPING then
      self.state.jump = Char3D.STATE.JUMP.FALLING
    end
  end
  
  if guard and not self.state.attack.attacking and not self.state.dammage and not self.state.kb and not self.state.kbr then
    if self.state.jump == Char3D.STATE.JUMP.JUMPING or self.state.jump = Char3D.STATE.JUMP.FALLING then
      self.state.guard.air = Char3D.STATE.GUARD.ON
    else
      self.state.guard.ground = Char3D.STATE.GUARD.ON
    end
  else
    self.state.guard.air = Char3D.STATE.GUARD.OFF
    self.state.guard.ground = Char3D.STATE.GUARD.OFF
  end
  
  if attack and not self.state.guard.guarding and not self.state.dammage and not self.state.kb and not self.state.kbr then
    if self.state.jump == Char3D.STATE.JUMP.JUMPING or self.state.jump = Char3D.STATE.JUMP.FALLING then
      self.state.attack.air = true
    else
      if not self.state.attack.c1
         and self.state.attack.c2
         and not self.state.attack.c3
         and self.state.attack.AnimDone.c2 then
        self.state.attack.c3 = true
        self.state.attack.AnimDone.c2 = false
        self.state.attack.c2 = false
      end

      if self.state.attack.c1
         and not self.state.attack.c2
         and not self.state.attack.c3
         and self.state.attack.AnimDone.c1 then
        self.state.attack.c2 = true
        self.state.attack.AnimDone.c1 = false
        self.state.attack.c1 = false
      end

      if not self.state.attack.c1
         and not self.state.attack.c2
         and not self.state.attack.c3 then
        self.state.attack.c1 = true
      end

      if not self.state.attack.c1
         and not self.state.attack.c2
         and self.state.attack.c3
         and self.state.attack.AnimDone.c3 then
        self.state.attack.c1 = true
        self.state.attack.AnimDone.c3 = false
        self.state.attack.c3 = false
      end
    end
  else
    self.state.attack.air = false
    
    if self.state.attack.c1 and self.state.attack.AnimDone.c1 then
      self.state.attack.c1 = false
      self.state.attack.AnimDone.c1 = false
    end
    
    if self.state.attack.c2 and self.state.attack.AnimDone.c2 then
      self.state.attack.c2 = false
      self.state.attack.AnimDone.c2 = false
    end
    
    if self.state.attack.c3 and self.state.attack.AnimDone.c3 then
      self.state.attack.c3 = false
      self.state.attack.AnimDone.c3 = false
    end
  end
end

function Char3D:draw()
  self:update()
  self.sprite.Anim:draw(self.pos.x,self.pos.y,self.pos.z)
end