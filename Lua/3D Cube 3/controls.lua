dpadup=0
dpaddown=0
dpadleft=0
dpadright=0
buttoncross=0
buttoncircle=0
buttontriangle=0
buttonsquare=0
buttonltrig=0
buttonrtrig=0
buttonstart=0
buttonselect=0

function UP()
  return Controls.read():up()
end

function DOWN()
  return Controls.read():down()
end

function LEFT()
  return Controls.read():left()
end

function RIGHT()
  return Controls.read():right()
end

function CROSS()
  return Controls.read():cross()
end

function CIRCLE()
  return Controls.read():circle()
end

function TRIANGLE()
  return Controls.read():triangle()
end

function SQUARE()
  return Controls.read():square()
end

function LTRIG()
  return Controls.read():l()
end

function RTRIG()
  return Controls.read():r()
end

function START()
  return Controls.read():start()
end

function SELECT()
  return Controls.read():select()
end

function UP1()          
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

function DOWN1()
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

function LEFT1()
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

function RIGHT1()
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

function CROSS1()
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

function CIRCLE1()
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

function TRIANGLE1()
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

function SQUARE1()
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

function LTRIG1()
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

function RTRIG1()
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

function START1()
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

function SELECT1()
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

AnalogY=Controls.read():analogY()
AnalogX=Controls.read():analogX()