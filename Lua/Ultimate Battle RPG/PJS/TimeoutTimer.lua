TimeoutTimer = {}

function TimeoutTimer.new(timeoutMax)
  local c = setmetatable(
    {
      timer = Timer.new(),
      curr = 0,
      max = timeoutMax or 30,
      timedOut = false,
      stop = false
    },
    {
      __index = TimeoutTimer
    }
  )
  
  return c
end

function TimeoutTimer:start()
  if not self.stop then
    if self.timer:start()>= 1000 then
      self.curr = self.curr + 1
      self.timer:reset()
      if self.curr >= self.max then
        self.timedOut = true
        self.stop = true
      end
    end
  end
  return self.timedOut
end

function TimeoutTimer:reset()
  self.curr = 0
  self.timer:reset()
  self.timer:stop()
  self.timedOut = false
  self.stop = false
end

function TimeoutTimer:resume()
  self.stop = false
end

function TimeoutTimer:stop()
  self.stop = true
  self.timer:reset()
  self.timer:stop()
end

function TimeoutTimer:time()
  return self.curr
end

function TimeoutTimer:isTimedOut()
  return self.timedOut
end

function TimeoutTimer:isStopped()
  return self.stop
end

function TimeoutTimer:setTimeout(timeout)
  self.max = timeout
end

function TimeoutTimer:getTimeout()
  return self.max
end