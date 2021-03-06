requireC (Global.system.dir.main .. "BAR.lua")
requireC (Global.system.dir.main .."advancedDrawFuncs.lua")

Loading_GUI = {}

function Loading_GUI.NewCO(list,title)
  local CO = coroutine.create(
    function (list,title)
      local bar = BAR.new(0,table.getn(list),0,0,300,12,Color.new(0,0,255))
      local x = (screen:width()/2) - (bar:getWidth()/2)
      local y = (screen:height()/2) - (bar:getHeight()/2)
      local w = bar:getWidth()
      local h = bar:getHeight()
      local msg = ""
      local perc = 0
      local str_perc = ""

      local txtX = (screen:width()/2) - ((string.len(title)*8)/2)

      while true do
        screen:clear(Color.new(255,255,255)) --0,0,0
        
        Gu.start3d()
          Global.draw.advancedFillRect(x-2,y-2,w+4,h+4,Color.new(64,64,64))
          Global.draw.advancedFillRect(x,y,w,h,Color.new(128,128,128))
          Global.draw.advancedFillRect(x-2,y+h+2,w+4,10,Color.new(128,128,128))
        Gu.end3d()
        
        --[[
        screen:fillRect(x-2,y-2,w+4,h+4,Color.new(64,64,64))
        screen:fillRect(x,y,w,h,Color.new(128,128,128))
        screen:fillRect(x-2,y+h+2,w+4,10,Color.new(128,128,128))
        ]]--
        
        bar:Draw(x,y)

        if bar:getVal() == bar:getMaxVal() then
          msg = "Loading Complete"
        else
          msg = "Loading \'" .. list[bar:getVal()+1] .. "\'"
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

        screen:print(txtX,y-12,title,Color.new(0,0,0))

        screen:print((screen:width()/2) - ((string.len(str_perc)*8)/2),(screen:height()/2) - 4,str_perc .. "%",Color.new(0,0,0)) -- 255,255,255
        screen:print((screen:width()/2) - ((string.len(msg)*8)/2),y+h+3,msg,Color.new(0,0,0)) -- 255,255,255
        screen.waitVblankStart()
        screen.flip()
        if bar:getVal() == bar:getMaxVal() then
          break
        end
        bar:setVal(bar:getVal()+1)
        coroutine.yield()
      end
    end
  )

  coroutine.resume(CO,list,title)

  return CO
end

function Loading_GUI.new(list,title)
  title = title or "Loading.  Please Wait..."
  local c = setmetatable(
    {
      CO = Loading_GUI.NewCO(list,title)
    },
    {
      __index = Loading_GUI
    }
  )
  
  return c
end                

function Loading_GUI:update()
  if coroutine.status (self.CO) == "dead" then
    return
  end

  coroutine.resume(self.CO)
end