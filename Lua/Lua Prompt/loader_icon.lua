loader_icon = {
  NewCO = function ()
    return coroutine.create(
      function (speed,life)
        local loading_icon = {
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
            if curr > table.getn(loading_icon) then curr = 1 end
          end

          if life_timer:time() >= 1000 then
            life_timer:reset()
            life_timer:start()
            curr_life = curr_life + 1
            if curr_life > life then break end
          end

          coroutine.yield(loading_icon[curr])
        end
      end
    )
  end
}

function loader_icon.new(s, l)
  local c = setmetatable(
    {
      speed = s or 100,
      life = l or 1,
      CO = loader_icon.NewCO()
    },
    {
      __index = loader_icon
    }
  )

  return c
end

function loader_icon:update()
  local bool_status = true
  local char_icon = ""

  if coroutine.status (self.CO) == "dead" then
    self.CO = self.NewCO()
  end

  bool_status, char_icon = coroutine.resume(self.CO,self.speed,self.life)

  if char_icon == nil then
    self.CO = self.NewCO()
    bool_status, char_icon = coroutine.resume(self.CO,self.speed,self.life)
  end
  
  return char_icon
end