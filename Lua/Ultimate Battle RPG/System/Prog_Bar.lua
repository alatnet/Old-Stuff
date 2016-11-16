requireC (Global.system.dir.main .. "BAR.lua")

Prog_Bar = {}

function Prog_Bar.NewCO(x,y,mv,Llist)
  local CO = coroutine.create(
    function (x,y,mv,list)
      local list_given = false
      
      if list ~= nil then
        list_given = true
      end
      
      local bar = BAR.new(0,mv,0,0,w,h,Color.new(0,0,255))
      local w = bar:getWidth()
      local h = bar:getHeight()
      local msg = ""
      local perc = 0
      local str_perc = ""
      
      while true do
        screen:fillRect(x-2,y-2,w+4,h+4,Color.new(64,64,64))
        screen:fillRect(x,y,w,h,Color.new(128,128,128))

        bar:Draw(x,y)
        
        if list_given then
          msg = "Loading " .. list[bar:getVal()+1]
        else
          msg = "Loading ..."
        end
        
        if bar:getVal() == bar:getMaxVal() then
            msg = "Loading Complete"
        end
        
        perc = tostring(bar:getPercentage())
        str_perc = ""

        for i=1,string.len(perc) do
          if string.sub(perc,i,i) ~= "." then
            str_perc = str_perc .. string.sub(perc,i,i)
          else
            break
          end
        end
        str_perc = "Loading... " .. str_perc .. "%"

        screen:print(x + ((string.len(str_perc)/2)*8),y + 1,str_perc,Color.new(255,255,255))
        if bar:getVal() == bar:getMaxVal() then
          break
        end
        bar:setVal(bar:getVal()+1)
        coroutine.yield()
      end
    end
  )

  return CO
end

function Prog_Bar.new(x,y,mv,Llist)
  local c = setmetatable(
    {
      CO = Prog_Bar.NewCO(x,y,mv,Llist)
    },
    {
      __index = Prog_Bar
    }
  )
  
  return c
end                

function Prog_Bar:update()
  if coroutine.status (self.CO) == "dead" then
    return
  end

  coroutine.resume(self.CO)
end