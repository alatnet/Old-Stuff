ThreadMan = {
  Threads = {},
  Threads_Timers = {},
  Threads_Status = {},
  Threads_Sleep_Length = {}
}

function ThreadMan.pause()
  coroutine.yield()
end

function ThreadMan.sleep(length)
  coroutine.yield("Sleep",length)
end

function ThreadMan.stop()
  coroutine.yield("Stop")
end

function ThreadMan.terminate()
  corutine.yield("Term")
end

function ThreadMan:create(f,...)
  local CO = coroutine.create(
    function ()
      f(arg)
    end
  )

  if self.Threads ~= nil then
    --table.insert(self.Threads,{CO = CO__,timer=Timer.new(),Status = 0,Sleep_Length = 0})
    table.insert(self.Threads,CO)

    if self.Threads_Timers ~= nil then
      table.insert(self.Thread_Timers,Timer.new())
      if self.Threads_Status ~= nil then
        table.insert(self.Threads_Status,0)
        if self.Threads_Sleep_Length ~= nil then
          table.insert(self.Threads_Sleep_Length,0)
        else
          self.Threads_Sleep_Length = {}
          table.insert(self.Threads_Sleep_Length,0)
        end
      else
        self.Threads_Status = {}
        table.insert(self.Threads_Status,0)
        if self.Threads_Sleep_Length ~= nil then
          table.insert(self.Threads_Sleep_Length,0)
        else
          self.Threads_Sleep_Length = {}
          table.insert(self.Threads_Sleep_Length,0)
        end
      end
    else
      self.Thread_Timers = {}
      table.insert(self.Thread_Timers,Timer.new())
      if self.Threads_Status ~= nil then
        table.insert(self.Threads_Status,0)
        if self.Threads_Sleep_Length ~= nil then
          table.insert(self.Threads_Sleep_Length,0)
        else
          self.Threads_Sleep_Length = {}
          table.insert(self.Threads_Sleep_Length,0)
        end
      else
        self.Threads_Status = {}
        table.insert(self.Threads_Status,0)
        if self.Threads_Sleep_Length ~= nil then
          table.insert(self.Threads_Sleep_Length,0)
        else
          self.Threads_Sleep_Length = {}
          table.insert(self.Threads_Sleep_Length,0)
        end
      end
    end

    return table.getn(self.Threads)
  else
    self.Threads = {}
    --table.insert(self.Threads,{CO = CO__,timer=Timer.new(),Status = 0,Sleep_Length = 0})
    table.insert(self.Threads,CO)

    if self.Threads_Timers ~= nil then
      table.insert(self.Thread_Timers,Timer.new())
      if self.Threads_Status ~= nil then
        table.insert(self.Threads_Status,0)
        if self.Threads_Sleep_Length ~= nil then
          table.insert(self.Threads_Sleep_Length,0)
        else
          self.Threads_Sleep_Length = {}
          table.insert(self.Threads_Sleep_Length,0)
        end
      else
        self.Threads_Status = {}
        table.insert(self.Threads_Status,0)
        if self.Threads_Sleep_Length ~= nil then
          table.insert(self.Threads_Sleep_Length,0)
        else
          self.Threads_Sleep_Length = {}
          table.insert(self.Threads_Sleep_Length,0)
        end
      end
    else
      self.Thread_Timers = {}
      table.insert(self.Thread_Timers,Timer.new())
      if self.Threads_Status ~= nil then
        table.insert(self.Threads_Status,0)
        if self.Threads_Sleep_Length ~= nil then
          table.insert(self.Threads_Sleep_Length,0)
        else
          self.Threads_Sleep_Length = {}
          table.insert(self.Threads_Sleep_Length,0)
        end
      else
        self.Threads_Status = {}
        table.insert(self.Threads_Status,0)
        if self.Threads_Sleep_Length ~= nil then
          table.insert(self.Threads_Sleep_Length,0)
        else
          self.Threads_Sleep_Length = {}
          table.insert(self.Threads_Sleep_Length,0)
        end
      end
    end

    return 1
  end
end

function ThreadMan:start(ID)
  self.Threads[ID].Status = 1
end

function ThreadMan:suspend(ID)
  self.Threads[ID].Status = 2
end

function ThreadMan:resume(ID)
  self.Threads[ID].Status = 1
end

function ThreadMan:kill(ID)
  table.remove(self.Threads,ID)
  collectgarbage()
end

function ThreadMan:Update()
  for i=1,table.getn(self.Threads) do
    local ret1,ret2,ret3 = corutine.resume(self.Threads[i])
  end
end

--[[
function ThreadMan:Update()
  local ret1,ret2,ret3
  for i=1,table.getn(self.Threads) do
    if self.Threads[i].status == 1 then
      ret1,ret2,ret3 = corutine.resume(self.Threads[i].CO)
      if ret2 == "Sleep" then
        self.Threads[i].Sleep_Length = ret3
        self.Threads[i].status = 3
      elseif ret2 == "Term" then
        table.remove(self.Threads,i)
      elseif ret2 == "Stop" then
        self.Threads[i].status = 2
      end
    elseif self.Threads[i].status == 2 then
      self.Threads[i].timer:reset(1)
    elseif self.Threads[i].status == 3 then
      if self.Threads[i].timer:start() >= self.Threads[i].Sleep_Length then
        self.Threads[i].status = 1
        self.Threads[i].Sleep_Length = 0
        self.Threads[i].timer:reset(1)
      end
    end
  end
end
]]--
