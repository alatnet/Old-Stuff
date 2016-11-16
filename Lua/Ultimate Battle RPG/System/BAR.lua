--[[
BAR Class\Library  Ver. 2.2
Created By: alatnet
Dev Team X Productions
]]--

BAR = {
  fnfp = function (max_num, percentage)
    if percentage > 100 then percentage = 100 end
    if percentage < 0 then percentage = 0 end
    return (percentage * max_num)/100
  end,
  fpfn = function (max_num, num)
    if num > max_num then num = max_num end
    if num < 0 then num = 0 end
    return (num * 100)/max_num
  end,
  MODE = {
    VIS = {
      H = 0,
      V = 1
    },
    SLIDE = {
      LT = 0,
      RB = 1
    }
  }
}

--[[ CONSTRUCTOR ]]--
function BAR.new(val,max_val,slide_mode,vis_mode,width,height,col)
  val = val or 0
  mav_val = max_val or 100

  slide_mode = slide_mode or BAR.MODE.SLIDE.LT
  vis_mode = vis_mode or BAR.MODE.VIS.H
  
  if vis_mode == BAR.MODE.VIS.V then
    width = width or 10
    height = height or 100
  else
    width = width or 100
    height = height or 10
  end

  col = col or Color.new(0,0,255)  --Blue

  local c = setmetatable(
    {
      W = width,
      H = height,
      C = col,
      V = val,
      MV = max_val,
      mode = {
        slide = slide_mode,
        vis = vis_mode
      }
    },
    {
      __index = BAR
    }
  )

  return c
end

function BAR:setColor(val)
  self.C = val
end

function BAR:setHeight(val)
  self.H = val
end

function BAR:setWidth(val)
  self.W = val
end

function BAR:setMaxVal(val)
  self.MV = val
end

function BAR:setVal(val)
  if val < 0 then val = 0 end
  if val > self.MV then val = self.MV end
  self.V = val
end

function BAR:setPercentage(val)
  if val < 0 then val = 0 end
  if val > 100 then val = 100 end
  self.V = BAR.fnfp(self.MV,val)
end

function BAR:setSlideMode(val)
  val = val or 0
  self.mode.slide = val
end

function BAR:setVisMode(val)
  val = val or 0
  self.mode.vis = val
end

function BAR:getHeight()
  return self.H
end

function BAR:getWidth()
  return self.W
end

function BAR:getMaxVal()
  return self.MV
end

function BAR:getVal()
  return self.V
end

function BAR:getPercentage()
  return BAR.fpfn(self.MV,self.V)
end

function BAR:getSlideMode()
  return self.mode.slide
end

function BAR:getVisMode()
  return self.mode.vis
end

function BAR:Draw(x,y,s)
  s = s or screen
  x = x or 0
  y = y or 0
  
  local w = 0
  local h = 0
  local PERCENTAGE = BAR.fpfn(self.MV,self.V)

  if self.mode.vis == 0 then          --[[ bar displays horizontaly ]]--
    if self.mode.slide == 0 then        --[[ bar decreases/increases from the left ]]--
      h = self.H
      w = BAR.fnfp(self.W,PERCENTAGE)
    elseif self.mode.slide == 1 then    --[[ bar decreases/increases from the right ]]--
      x = x + (self.W - BAR.fnfp(self.W,PERCENTAGE))
      h = self.H
      w = BAR.fnfp(self.W,PERCENTAGE)
    end
  elseif self.mode.vis == 1 then    --[[ bar displays vertical ]]--
    if self.mode.slide == 0 then        --[[ bar decreases/increases from the top ]]--
      w = self.W
      h = BAR.fnfp(self.H,PERCENTAGE)
    elseif self.mode.slide == 1 then    --[[ bar decreases/increases from the bottom ]]--
      y = y + (self.H - BAR.fnfp(self.H,PERCENTAGE))
      w = self.W
      h = BAR.fnfp(self.H,PERCENTAGE)
    end
  end
  
  s:fillRect(x, y , w, h, self.C)
end

function BAR:DrawGU(x,y)
  x = x or 0
  y = y or 0
  
  local w = 0
  local h = 0
  local PERCENTAGE = BAR.fpfn(self.MV,self.V)

  if self.mode.vis == 0 then          --[[ bar displays horizontaly ]]--
    if self.mode.slide == 0 then        --[[ bar decreases/increases from the left ]]--
      h = self.H
      w = BAR.fnfp(self.W,PERCENTAGE)
    elseif self.mode.slide == 1 then    --[[ bar decreases/increases from the right ]]--
      x = x + (self.W - BAR.fnfp(self.W,PERCENTAGE))
      h = self.H
      w = BAR.fnfp(self.W,PERCENTAGE)
    end
  elseif self.mode.vis == 1 then    --[[ bar displays vertical ]]--
    if self.mode.slide == 0 then        --[[ bar decreases/increases from the top ]]--
      w = self.W
      h = BAR.fnfp(self.H,PERCENTAGE)
    elseif self.mode.slide == 1 then    --[[ bar decreases/increases from the bottom ]]--
      y = y + (self.H - BAR.fnfp(self.H,PERCENTAGE))
      w = self.W
      h = BAR.fnfp(self.H,PERCENTAGE)
    end
  end
  
  Gu.enable(Gu.BLEND)
  Gu.disable(Gu.TEXTURE_2D)
  
  Gum.matrixMode(Gu.MODEL)
  Gum.loadIdentity()

  local verts = {
    {self.C,x,y,0},
    {self.C,x+w,y+h,0}
  }
  Gum.drawArray(Gu.SPRITES,Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_2D,verts)
end