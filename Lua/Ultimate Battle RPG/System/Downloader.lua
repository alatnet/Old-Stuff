Downloader = {
  Status = {
    TimedOut = -1,
    Waiting = 0,
    QueringSize = 1,
    DownloadSize = 2,
    Connecting = 3,
    Downloading = 4,
    Finished = 5
  },
  strip_header = function (str)
    local startIndex, endIndex = string.find(str, "\r\n\r\n")
    if endIndex then
      return string.sub(str, endIndex+1),true
    end
    return str,false
  end
}

function Downloader.CO(url,port,saveTo,timeout)
  timeout = timeout or 30
  port = port or 80

  coroutine.yield(Downloader.Status.Waiting)

  local socket, err = nil,nil
  local buff1,buff2 = "",""
  local headerStriped = false
  local file = nil
  local Timeout = {
    curr = 0,
    timer = Timer.new()
  }
  local TimedOut = false
  local host = ""
  local fileUrlPath = ""
  local headerBuff = ""

  local sI,eI = string.find(url,"/")
  if eI then
    host = string.sub(url,1,eI-1)
    fileUrlPath = string.sub(url,eI)
  end

  --[[ Querring of filesize part ]]--
  --connect and retrieve size of file and yield the size
  socket, err = Socket.connect(host,port)

  while not TimedOut and not socket:isConnected() do
    if Timeout.timer:start() >= 1000 then
      Timeout.curr = Timeout.curr + 1
      Timeout.timer:reset()
    end
    if Timeout.curr >= timeout then
      TimedOut = true
      socket:close()
    end

    coroutine.yield(Downloader.Status.QueringSize)
  end

  socket:send("HEAD " .. fileUrlPath .. " HTTP/1.1\r\n")
  socket:send("host: " .. host .. "\r\n\r\n")

  Timeout.curr = 0

  while not TimedOut and socket:isConnected() do
    if Timeout.timer:start() >= 1000 then
      Timeout.curr = Timeout.curr + 1
      Timeout.timer:reset()
    end
    if Timeout.curr >= timeout then
      TimedOut = true
      socket:close()
    end

    headerBuff = headerBuff .. socket:recv()

    coroutine.yield(Downloader.Status.QueringSize)
  end
  
  sI,eI = string.find(headerBuff,"Content-length: ")
  headerBuff = string.sub(headerBuff,eI+1)
  sI,eI = string.find(headerBuff,"\r\n")

  coroutine.yield(Downloader.Status.DownloadSize,tonumber(string.sub(headerBuff,1,sI-1)))

  Timeout.curr = 0

  --[[ downloading part ]]--
  socket, err = Socket.connect(host,port)

  while not TimedOut and not socket:isConnected() do
    if Timeout.timer:start() >= 1000 then
      Timeout.curr = Timeout.curr + 1
      Timeout.timer:reset()
    end
    if Timeout.curr >= timeout then
      TimedOut = true
      socket:close()
    end

    coroutine.yield(Downloader.Status.Connecting)
  end

  Timeout.curr = 0

  file = io.open(saveTo,"w")
  
  buff1,buff2 = "",""
  
  socket:send("GET " .. fileUrlPath .. " HTTP/1.1\r\n")
  socket:send("host: " .. host .. "\r\n\r\n")

  while not TimedOut and socket:isConnected() do
    if Timeout.timer:start() >= 1000 then
      Timeout.curr = Timeout.curr + 1
      Timeout.timer:reset()
    end
    if Timeout.curr >= timeout then
      TimedOut = true
      socket:close()
    end

    buff1 = socket:recv()

    if not headerStriped then
      buff2 = buff2 .. buff1
      buff2,headerStriped = Downloader.strip_header(buff2)
      writeToFile = true
      writeWait = true
      file:write(buff2)
    end

    if headerStriped then
      if writeToFile = true then
        if writeWait = true then
          writeWait = false
        else
          file:write(buff1)
        end
      end
      coroutine.yield(Downloader.Status.Downloading,file:seek())
    else
      coroutine.yield(Downloader.Status.Downloading,0)
    end
  end
  
  file:flush()
  file:close()

  if TimedOut then
    coroutine.yield(Downloader.Status.TimedOut)
  else
    coroutine.yield(Downloader.Status.Finished)
  end
end

function Downloader.new(timeout)
  local c = setmetatable(
    {
      Downloading = {},
      Status = {},
      Queued = {},
      Finished = {},
      maxRunningDownloads = 2,
      timeout = timeout or 30
    },
    {
      __index = Downloader
    }
  )

  return c
end

function Downloader:add(url,port,saveTo)
  port = port or 80

  table.insert(self.Queued,{URL = url, PORT = port,SAVETO = saveTo})
end

function Downloader:setMaxRunningDownloads(val)
  if type(val) == "number" then
    if val >= 1 then
      self.maxRunningDownloads = val
    end
  end
end

function Downloader:getMaxRunningDownloads()
  return self.maxRunningDownloads
end

function Downloader:getDownloadStatus(index)
  if index > table.getn(self.Downloading) then return nil end
  return self.Status[index]
end

function Downloader:numRunningDownloads()
  return table.getn(self.Downloading)
end

function Downloader:getQueuedUrl(index)
  if index > table.getn(self.Queued) then return nil end
  return self.Queued[index].URL
end

function Downloader:numQueuedDownloads()
  return table.getn(self.Queued)
end

function Downloader:getFinishedInfo(index)
  if index > table.getn(self.Finished) then return nil end
  return self.Finished[index]
end

function Downloader:numFinishedDownloads()
  return table.getn(self.Finished)
end

function Downloader:update()
  local downloadStatus,var1 = nil,nil

  while table.getn(self.Downloading) < self.maxRunningDownloads do
    if table.getn(self.Downloading) == self.maxRunningDownloads then break end
    if table.getn(self.Queued) == 0 then break end

    table.insert(self.Downloading,coroutine.create(Downloader.CO))
    table.insert(self.Status,{filesize = -1, downloaded = -1,url = self.Queued[1].URL,port = self.Queued[1].PORT,saveTo = self.Queued[1].SAVETO})
    coroutine.resume(self.Downloading[table.getn(self.Downloading)],self.Queued[1].URL,self.Queued[1].PORT,self.Queued[1].SAVETO,self.timeout)
    table.remove(self.Queued,1)

    if table.getn(self.Queued) == 0 then break end
    if table.getn(self.Downloading) == self.maxRunningDownloads then break end
  end

  for i=1,table.getn(self.Downloading) do
    downloadStatus,var1 = coroutine.resume(self.Downloading[i])
    if downloadStatus == Downloader.Status.DownloadSize then
      self.Status[i].filesize = var1
    elseif downloadStatus == Downloader.Status.Downloading then
      self.Status[i].downloaded = var1
    elseif downloadStatus == Downloader.Status.Finished then
      table.insert(self.Finished,{url = self.Status[i].url,saveTo = self.Status[i].saveTo})
      table.remove(self.Downloading,i)
      table.remove(self.Status,i)
    elseif downloadStatus == Downloader.Status.TimedOut then
      table.insert(self.Finished,{url = self.Status[i].url,port = self.Status[i].port,saveTo = self.Status[i].saveTo,timedout = true})
      table.remove(self.Downloading,i)
      table.remove(self.Status,i)
    end
    downloadStatus = nil
    var1 = nil
  end
end

function Downloader:draw()
end