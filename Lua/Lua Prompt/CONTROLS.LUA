local dpadup=0
local dpaddown=0
local dpadleft=0
local dpadright=0
local buttoncross=0
local buttoncircle=0
local buttontriangle=0
local buttonsquare=0
local buttonltrig=0
local buttonrtrig=0
local buttonstart=0
local buttonselect=0
local buttonnote=0
local button=0

function AX(num)
  if num ~= nil then
    return math.floor(Controls.read():analogX()/num)
  else
    return Controls.read():analogX()
  end
end

function AY(num)
  if num ~= nil then
    return math.floor(Controls.read():analogY()/num)
  else
    return Controls.read():analogY()
  end
end

function up()
  return Controls.read():up()
end

function down()
  return Controls.read():down()
end

function left()
  return Controls.read():left()
end

function right()
  return Controls.read():right()
end

function cross()
  return Controls.read():cross()
end

function circle()
  return Controls.read():circle()
end

function triangle()
  return Controls.read():triangle()
end

function square()
  return Controls.read():square()
end

function ltrig()
  return Controls.read():l()
end

function rtrig()
  return Controls.read():r()
end

function start()
  return Controls.read():start()
end

function select()
  return Controls.read():select()
end

function hold()
  return Controls.read():hold()
end

function note()
  return Controls.read():note()
end

function buttons()
  if Controls.read():cross() or Controls.read():circle() or Controls.read():triangle() or Controls.read():square() or Controls.read():l() or Controls.read():r() or Controls.read():note() then
    return true
  else
    return false
  end
end

function up1()
  if Controls.read():up() then
    if dpadup==0 then
      dpadup=1
      return true
    else
      return false
    end
  else
    dpadup=0
  end
end

function down1()
  if Controls.read():down() then
    if dpaddown==0 then
      dpaddown=1
      return true
    else
      return false
    end
  else
    dpaddown=0
  end
end

function left1()
  if Controls.read():left() then
    if dpadleft==0 then
      dpadleft=1
      return true
    else
      return false
    end
  else
    dpadleft=0
  end
end

function right1()
  if Controls.read():right() then
    if dpadright==0 then
      dpadright=1
      return true
    else
      return false
    end
  else
    dpadright=0
  end
end

function cross1()
  if Controls.read():cross() then
    if buttoncross==0 then
      buttoncross=1
      return true
    else
      return false
    end
  else
    buttoncross=0
  end
end

function circle1()
  if Controls.read():circle() then
    if buttoncircle==0 then
      buttoncircle=1
      return true
    else
      return false
    end
  else
    buttoncircle=0
  end
end

function triangle1()
  if Controls.read():triangle() then
    if buttontriangle==0 then
      buttontriangle=1
      return true
    else
      return false
    end
  else
    buttontriangle=0
  end
end

function square1()
  if Controls.read():square() then
    if buttonsquare==0 then
      buttonsquare=1
      return true
    else
      return false
    end
  else
    buttonsquare=0
  end
end

function ltrig1()
  if Controls.read():l() then
    if buttonltrig==0 then
      buttonltrig=1
      return true
    else
      return false
    end
  else
    buttonltrig=0
  end
end

function rtrig1()
  if Controls.read():r() then
    if buttonrtrig==0 then
      buttonrtrig=1
      return true
    else
      return false
    end
  else
    buttonrtrig=0
  end
end

function start1()
  if Controls.read():start() then
    if buttonstart==0 then
      buttonstart=1
      return true
    else
      return false
    end
  else
    buttonstart=0
  end
end

function select1()
  if Controls.read():select() then
    if buttonselect==0 then
      buttonselect=1
      return true
    else
      return false
    end
  else
    buttonselect=0
  end
end

function note1()
  if Controls.read():note() then
    if buttonnote==0 then
      buttonnote=1
      return true
    else
      return false
    end
  else
    buttonnote=0
  end
end

function buttons1()
  if Controls.read():cross() or Controls.read():circle() or Controls.read():triangle() or Controls.read():square() or Controls.read():l() or Controls.read():r() or Controls.read():note() then
    if button==0 then
      button=1
      return true
    else
      return false
    end
  else
    button=0
  end
end

function creset()
  up1()
  down1()
  left1()
  right1()
  cross1()
  circle1()
  triangle1()
  square1()
  ltrig1()
  rtrig1()
  start1()
  select1()
  note1()
  buttons1()
end