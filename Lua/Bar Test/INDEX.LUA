requireC("./BAR.lc")

function START()
  return Controls.read():start()
end

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


test_bar = BAR.new(0,100,150,10,Color.new(255,0,0))

while not START() do
  screen:clear(Color.new(255,255,255))
  
  local x = (screen:width()/2) - (test_bar:getWidth()/2)
  local y = (screen:height()/2) - (test_bar:getHeight()/2)

  test_bar:Draw(x,y)

  screen:print(8,8,"V: " .. test_bar:getVal(),Color.new(0,0,0))
  screen:print(8,16,"%: " .. test_bar:getPercentage(),Color.new(0,0,0))

  screen:flip()

  if UP() then
    test_bar:setVal(test_bar:getVal()+1)
  elseif DOWN() then
    test_bar:setVal(test_bar:getVal()-1)
  elseif LEFT() then
    test_bar:setPercentage(test_bar:getPercentage()-1)
  elseif RIGHT() then
    test_bar:setPercentage(test_bar:getPercentage()+1)
  end
end