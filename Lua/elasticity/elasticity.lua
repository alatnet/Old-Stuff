LUA_PATH = "./?;../?;./?.lua;./?.lc;../?.lua;../?.lc"
require("pad.lc")
require("TwinTail.LC")
require("controls.lua")
require("calculation functions.lua")

local black = Color.new(0, 0, 0)
local white = Color.new(256, 256, 256)
local purple = Color.new(256,0,256)
local blue = Color.new(0, 0, 256)

function menuoption(xpos,ypos,txt,cursor,col,selcol,selcondition,img)
  img = img or screen
  local num_cursor_char = string.len(cursor)
  img:print(xpos+(8*num_cursor_char),ypos,txt,col)
  if selcondition then
    img:print(xpos,ypos,cursor .. txt,selcol)
  end
end

function list_options(xpos,ypos,options,cursor,col,selcol,cursor_pos,img)
  img = img or screen
  local YY=ypos
  
  for i=1, table.getn(options) do
    menuoption(xpos,YY,options[i],cursor,col,selcol,i==cursor_pos)
    YY = YY + 9
  end
end

function Osk_textinput(char,str)
  if char == nil or char == "\n" or char == "\t" or char == " " then
    return str
  elseif char == "\b" then
    return string.sub(str,1,string.len(str)-1)
  else
    return str .. char
  end
end

function textinput(xpos,ypos,txt,cursor,col,selcondition,blink,img)
  img = img or screen
  if selcondition then
    if blink then
      img:print(xpos,ypos,txt .. cursor,col)
    else
      img:print(xpos,ypos,txt,col)
    end
  else
    img:print(xpos,ypos,txt,col)
  end
end

function elasticity()
  local cursor=1
  local oskActive = false
  local osk = Osk.new()
  local oskX = 0
  local b_timer = Timer.new()
  local b_interval = 500
  local blink = true
  local options = {
    "Calculate!",
    "Reset",
    "Quit"
  }
  
  local __Q = ""
  local __Q1 = ""
  local __P = ""
  local __P1 = ""
  local __DQ = ""
  local __DP = ""
  local __PerQ = ""
  local __PerP = ""
  local __SQ = ""
  local __SP = ""
  
  local _R_DQ = 0
  local _R_DP = 0
  local _R_E = 0
  local _R_PerQ = 0
  local _R_PerP = 0
  local _R_SQ = 0
  local _R_SP = 0


  local x=screen:width()/2
  local y=0
  local yy =0

  b_timer:start()

  while true do
    Pad:Update()

    if not oskActive then
      if Pad.tR1 then
        oskActive = true
        osk = Osk.new()
      end
    end

    if up1() and not oskActive then cursor=cursor-1 end
    if down1() and not oskActive then cursor=cursor+1 end

    if cursor==0 then cursor=table.getn(options)+10 end  --[[ table.getn(options)+2 ]]--
    if cursor==table.getn(options)+11 then cursor=1 end  --[[ table.getn(options)+3 ]]--

    if b_timer:time() >= b_interval then
      b_timer:reset()
      b_timer:start()
      if blink then
        blink = false
      else
        blink = true
      end
    end

    yy=8

    screen:clear(white)
    textinput(8,yy,"Q: " .. __Q,"_",black,cursor==1,blink)
    yy=yy+8
    textinput(8,yy,"Q1: " .. __Q1,"_",black,cursor==2,blink)
    yy=yy+8
    textinput(8,yy,"P: " .. __P,"_",black,cursor==3,blink)
    yy=yy+8
    textinput(8,yy,"P1: " .. __P1,"_",black,cursor==4,blink)
    yy=yy+8
    textinput(8,yy,"DQ: " .. __DQ,"_",black,cursor==5,blink)
    yy=yy+8
    textinput(8,yy,"DP: " .. __DP,"_",black,cursor==6,blink)
    yy=yy+8
    textinput(8,yy,"PerQ: " .. __PerQ,"_",black,cursor==7,blink)
    yy=yy+8
    textinput(8,yy,"PerP: " .. __PerP,"_",black,cursor==8,blink)
    yy=yy+8
    textinput(8,yy,"SQ: " .. __SQ,"_",black,cursor==9,blink)
    yy=yy+8
    textinput(8,yy,"SP: " .. __SP,"_",black,cursor==10,blink)
    yy=yy+8
    list_options(8,yy,options,">",black,blue,cursor-10)
    
    if oskActive then
      if cursor==1 then
        local In, cont = osk:Update()
        oskX = 4 + (string.len(__Q)*8)
        osk:Draw(oskX,16)
        __Q = Osk_textinput(In,__Q)
        if not cont then oskActive = false end
      elseif cursor==2 then
        local In, cont = osk:Update()
        oskX = 5 + (string.len(__Q1)*8)
        osk:Draw(oskX,24)
        __Q1 = Osk_textinput(In,__Q1)
        if not cont then oskActive = false end
      elseif cursor==3 then
        local In, cont = osk:Update()
        oskX = 4 + (string.len(__P)*8)
        osk:Draw(oskX,32)
        __P = Osk_textinput(In,__P)
        if not cont then oskActive = false end
      elseif cursor==4 then
        local In, cont = osk:Update()
        oskX = 5 + (string.len(__P1)*8)
        osk:Draw(oskX,40)
        __P1 = Osk_textinput(In,__P1)
        if not cont then oskActive = false end
      elseif cursor==5 then
        local In, cont = osk:Update()
        oskX = 5 + (string.len(__DQ)*8)
        osk:Draw(oskX,48)
        __DQ = Osk_textinput(In,__DQ)
        if not cont then oskActive = false end
      elseif cursor==6 then
        local In, cont = osk:Update()
        oskX = 5 + (string.len(__DP)*8)
        osk:Draw(oskX,56)
        __DP = Osk_textinput(In,__DP)
        if not cont then oskActive = false end
      elseif cursor==7 then
        local In, cont = osk:Update()
        oskX = 5 + (string.len(__PerQ)*8)
        osk:Draw(oskX,64)
        __PerQ = Osk_textinput(In,__PerQ)
        if not cont then oskActive = false end
      elseif cursor==8 then
        local In, cont = osk:Update()
        oskX = 5 + (string.len(__PerP)*8)
        osk:Draw(oskX,72)
        __PerP = Osk_textinput(In,__PerP)
        if not cont then oskActive = false end
      elseif cursor==9 then
        local In, cont = osk:Update()
        oskX = 5 + (string.len(__SQ)*8)
        osk:Draw(oskX,80)
        __SQ = Osk_textinput(In,__SQ)
        if not cont then oskActive = false end
      elseif cursor==10 then
        local In, cont = osk:Update()
        oskX = 5 + (string.len(__SP)*8)
        osk:Draw(oskX,88)
        __SP = Osk_textinput(In,__SP)
        if not cont then oskActive = false end
      else
        oskActive = false
      end
    end

    y=8

    --screen:print(8, y, ": " .. _R_, purple)
    screen:print(x, y, "DQ: " .. _R_DQ, purple)
    y=y+8
    screen:print(x, y, "DP: " .. _R_DP, purple)
    y=y+8
    screen:print(x, y, "PerQ: " .. _R_PerQ, purple)
    y=y+8
    screen:print(x, y, "PerP: " .. _R_PerP, purple)
    y=y+8
    screen:print(x, y, "SQ: " .. _R_SQ, purple)
    y=y+8
    screen:print(x, y, "SP: " .. _R_SP, purple)
    y=y+8
    screen:print(x, y, "E: " .. _R_E, purple)
    screen:flip()
    screen.waitVblankStart()
    
    if (cross1() or circle1()) and not oskActive then
      if cursor==11 then
        if __Q ~= "" and __Q1 ~= "" and __P ~= "" and __P1 ~= "" and __DQ == "" and __DP == "" and __PerQ == "" and __PerP == "" and __SQ == "" and __SP == "" then
          _R_DQ,_R_DP,_R_PerQ,_R_PerP,_R_SQ,_R_SP,_R_E = calculate_elasticity(1,__Q,__Q1,__P,__P1)
        elseif __Q ~= "" and __Q1 ~= "" and __P ~= "" and __P1 ~= "" and __DQ ~= "" and __DP ~= "" and __PerQ == "" and __PerP == "" and __SQ == "" and __SP == "" then
          _R_PerQ,_R_PerP,_R_SQ,_R_SP,_R_E = calculate_elasticity(2,__DQ,__DP,__Q,__Q1,__P,__P1)
        elseif __Q ~= "" and __Q1 ~= "" and __P ~= "" and __P1 ~= "" and __DQ ~= "" and __DP == "" and __PerQ == "" and __PerP == "" and __SQ == "" and __SP == "" then
          _R_DP,_R_PerQ,_R_PerP,_R_SQ,_R_SP,_R_E = calculate_elasticity(3,__DQ,__Q,__Q1,__P,__P1)
        elseif __Q ~= "" and __Q1 ~= "" and __P ~= "" and __P1 ~= "" and __DQ == "" and __DP ~= "" and __PerQ == "" and __PerP == "" and __SQ == "" and __SP == "" then
          _R_DQ,_R_PerQ,_R_PerP,_R_SQ,_R_SP,_R_E = calculate_elasticity(4,__Q,__Q1,__P,__P1,__DP)
        elseif __Q == "" and __Q1 == "" and __P == "" and __P1 == "" and __DQ == "" and __DP == "" and __PerQ ~= "" and __PerP ~= "" and __SQ == "" and __SP == "" then
          _R_E = calculate_elasticity(5,__PerQ,__PerP)
        elseif __Q == "" and __Q1 == "" and __P ~= "" and __P1 ~= "" and __DQ == "" and __DP == "" and __PerQ ~= "" and __PerP == "" and __SQ == "" and __SP == "" then
          _R_DP,_R_PerP,_R_SP,_R_E = calculate_elasticity(6,__PerQ,__P,__P1)
        elseif __Q ~= "" and __Q1 ~= "" and __P == "" and __P1 == "" and __DQ == "" and __DP == "" and __PerQ == "" and __PerP ~= "" and __SQ == "" and __SP == "" then
          _R_DQ,_R_PerQ,_R_SQ,_R_E = calculate_elasticity(7,__Q,__Q1,__PerP)
        elseif __Q == "" and __Q1 == "" and __P ~= "" and __P1 ~= "" and __DQ == "" and __DP ~= "" and __PerQ ~= "" and __PerP == "" and __SQ == "" and __SP == "" then
          _R_PerP,_R_SP,_R_E = calculate_elasticity(8,__PerQ,__DP,__P,__P1)
        elseif __Q ~= "" and __Q1 ~= "" and __P == "" and __P1 == "" and __DQ ~= "" and __DP == "" and __PerQ == "" and __PerP ~= "" and __SQ == "" and __SP == "" then
          _R_PerQ,_R_SQ,_R_E = calculate_elasticity(9,__DQ,__Q,__Q1,__PerP)
        elseif __Q == "" and __Q1 == "" and __P ~= "" and __P1 ~= "" and __DQ ~= "" and __DP == "" and __PerQ == "" and __PerP == "" and __SQ ~= "" and __SP ~= "" then
          _R_DP,_R_PerQ,_R_PerP,_R_E = calculate_elasticity(10,__DQ,__P,__P1,__SQ,__SP)
        elseif __Q ~= "" and __Q1 ~= "" and __P == "" and __P1 == "" and __DQ == "" and __DP ~= "" and __PerQ == "" and __PerP == "" and __SQ ~= "" and __SP ~= "" then
          _R_DQ,_R_PerQ,_R_PerP,_R_E = calculate_elasticity(11,__Q,__Q1,__DP,__SQ,__SP)
        elseif __Q == "" and __Q1 == "" and __P == "" and __P1 == "" and __DQ ~= "" and __DP ~= "" and __PerQ == "" and __PerP == "" and __SQ ~= "" and __SP ~= "" then
          _R_PerQ,_R_PerP,_R_E = calculate_elasticity(12,__DQ,__DP,__SQ,__SP)
        elseif __Q == "" and __Q1 == "" and __P ~= "" and __P1 ~= "" and __DQ == "" and __DP == "" and __PerQ ~= "" and __PerP == "" and __SQ == "" and __SP ~= "" then
          _R_DP,_R_PerP,_R_E = calculate_elasticity(13,__PerQ,__P,__P1,__SP)
        elseif __Q ~= "" and __Q1 ~= "" and __P == "" and __P1 == "" and __DQ == "" and __DP == "" and __PerQ == "" and __PerP ~= "" and __SQ ~= "" and __SP == "" then
          _R_DQ,_R_PerQ,_R_SQ,_R_E = calculate_elasticity(14,__Q,__Q1,__PerP,__SQ)
        elseif __Q == "" and __Q1 == "" and __P == "" and __P1 == "" and __DQ ~= "" and __DP == "" and __PerQ == "" and __PerP ~= "" and __SQ ~= "" and __SP == "" then
          _R_PerQ,_R_E = calculate_elasticity(15,__DQ,__SQ,__PerP)
        elseif __Q == "" and __Q1 == "" and __P == "" and __P1 == "" and __DQ == "" and __DP ~= "" and __PerQ ~= "" and __PerP == "" and __SQ == "" and __SP ~= "" then
          _R_PerP,_R_E = calculate_elasticity(16,__PerQ,__DP,__SP)
        end
      elseif cursor==12 then
         __Q = ""
         __Q1 = ""
         __P = ""
         __P1 = ""
         __DQ = ""
         __DP = ""
         __PerQ = ""
         __PerP = ""
         __SQ = ""
         __SP = ""
         _R_DQ = 0
         _R_DP = 0
         _R_E = 0
         _R_PerQ = 0
         _R_PerP = 0
         _R_SQ = 0
         _R_SP = 0
      elseif cursor==13 then
        break
      end
    elseif triangle1() and not oskActive then break end
  end
end

elasticity()