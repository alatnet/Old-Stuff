login = coroutine.wrap(
  function ()
  change_wlan_status(2)
  for i=0,100 do screen.waitVblankStart() end
  coroutine.yield()
  end
)

co = coroutine.create(function ()
           for i=1,10 do
             print("co", i)
             coroutine.yield()
           end
         end)

coroutine.resume (co, val1, ...)

DISPLAY = coroutine.wrap(
  function ()

    coroutine.yield()
  end
)

loader_icon = coroutine.wrap(
  function (xpos,ypos,col,kill,img)
    img = img or screen

    local loading_cursor = {
      "|",
      "/",
      "-",
      "\\"
    }
    
    local timer = Timer.new()
    local interval = 500
    local curr = 1

    timer:start()

    while not kill do
      if timer:time() >= interval then
        timer:reset()
        timer:start()
        curr = curr + 1
        if curr > table.getn(loading_cursor) then curr = 1 end
      end
      
      img:print(xpos,ypos,loading_cursor[curr],col)

      coroutine.yield()
    end
  end
)

----------------------
function create_loader_icon_co()
  local co = coroutine.create(
    function (xpos,ypos,col,speed,life,img)
      img = img or screen
      speed = speed or 100

      local loading_cursor = {
        "|",
        "/",
        "-",
        "\\"
      }

      local timer = Timer.new()
      local life_timer = Timer.new()
      local curr = 1
      local curr_life = 0

      timer:start()
      life_timer:start()

      while true do
        if timer:time() >= speed then
          timer:reset()
          timer:start()
          curr = curr + 1
          if curr > table.getn(loading_cursor) then curr = 1 end
        end

        if life_timer:time() >= 1000 then
          life_timer:reset()
          life_timer:start()
          curr_life = curr_life + 1
          if curr_life > life then break end
        end

        --img:print(xpos,ypos,loading_cursor[curr],col)

        coroutine.yield(loading_cursor[curr])
      end
    end
  )
  
  return co
end
------------------------
    --[[
    if coroutine.status (loader_icon) == "dead" then
      loader_icon = create_loader_icon_co()
    end

    if curr_line >= 7 then
      coroutine.resume(loader_icon,(string.len(lines[7].txt)*8)+8,ypos-8,white,1)
    end
    ]]--
--------------------------
  local loader_icon = create_loader_icon_co()
----------------------------