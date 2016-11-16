requireC ("AnimatedSprite.lc")
requireC ("colors.lua")
requireC ("Controls.lua")
requireC ("FPSCounter.lua")

function AnimatedSpriteExample()
  local logo = Image.load("logo.png")
  --local sakura_petals_img = "SakuraSmall.png"
  AnimatedSprite.addImage2List("SakuraSmall.png","petal")
  local num_sakura_petals = 20
  local sakura_petals = {
    sprites = {
    },
    pos = {
    },
    speed = {
    },
    direction_change_time = {
    },
    draw = {}
  }
  local counter = FPSCounter.new()

  local direction_change_time_min = 1000
  local direction_change_time_max = 2000
  local animation_spd = 40

  for i=1,num_sakura_petals do
    table.insert(sakura_petals.sprites,AnimatedSprite.new("petal",2,4,math.random(20,animation_spd))) --animation_spd))
    table.insert(sakura_petals.pos,{x=0,y=0})
    table.insert(sakura_petals.speed,{x=0,y=0})
    table.insert(sakura_petals.direction_change_time,{0,Timer.new()})
    table.insert(sakura_petals.draw,false)

    sakura_petals.pos[i].x = math.random(480 - sakura_petals.sprites[i]:getWidth())
    sakura_petals.pos[i].y = (math.random(sakura_petals.sprites[i]:getHeight()) * -1) -- 272 - 
    yspeed = math.random(3)
    xspeed = math.random(4,6)
    direction_change_time = math.random(1,direction_change_time_max)

    if math.random(1,20)<=10 then
      xspeed = xspeed * -1
      sakura_petals.sprites[i]:setReverse(true)
    end
    
    sakura_petals.speed[i].x = xspeed
    sakura_petals.speed[i].y = yspeed
    sakura_petals.direction_change_time[i][1] = direction_change_time
  end

  while not start1() do
    screen:clear(white)

    for i=1,num_sakura_petals do
      if sakura_petals.draw[i] then
        sakura_petals.sprites[i]:Draw(sakura_petals.pos[i].x,sakura_petals.pos[i].y)
        sakura_petals.pos[i].x = sakura_petals.pos[i].x + sakura_petals.speed[i].x
        sakura_petals.pos[i].y = sakura_petals.pos[i].y + sakura_petals.speed[i].y
      end

      if sakura_petals.pos[i].x + sakura_petals.sprites[i]:getWidth()/2 < 0 then sakura_petals.pos[i].x = (screen:width() - sakura_petals.sprites[i]:getWidth()/2) - 1 end
      if sakura_petals.pos[i].x + sakura_petals.sprites[i]:getWidth()/2 > screen:width() then sakura_petals.pos[i].x = (0 - sakura_petals.sprites[i]:getWidth()/2) + 1 end
      if sakura_petals.pos[i].y + sakura_petals.sprites[i]:getHeight()/2 > screen:height() then sakura_petals.pos[i].y = 0 - sakura_petals.sprites[i]:getHeight()/2 end

      if sakura_petals.direction_change_time[i][2]:start() >= sakura_petals.direction_change_time[i][1] then
        sakura_petals.draw[i] = true
        sakura_petals.speed[i].x = sakura_petals.speed[i].x * -1
        sakura_petals.speed[i].y = math.random(2)
        sakura_petals.direction_change_time[i][1] = math.random(direction_change_time_min,direction_change_time_max)
        if sakura_petals.sprites[i]:isReverse() then
          sakura_petals.sprites[i]:setReverse(false)
        else
          sakura_petals.sprites[i]:setReverse(true)
        end
        sakura_petals.direction_change_time[i][2]:reset()
      end
    end

    screen:print(2,2,"FPS: " .. counter:update(),black)
    screen:print(2,10,"Number of Sakura Petals: " .. num_sakura_petals,black)
    screen:blit(screen:width()/2 - logo:width()/2,screen:height()/2 - logo:height()/2,logo)
    screen:flip()

    if right() then
      table.insert(sakura_petals.sprites,AnimatedSprite.new("petal",2,4,math.random(animation_spd))) --animation_spd))
      table.insert(sakura_petals.pos,{x=0,y=0})
      table.insert(sakura_petals.speed,{x=0,y=0})
      table.insert(sakura_petals.direction_change_time,{0,Timer.new()})
      table.insert(sakura_petals.draw,true)

      sakura_petals.pos[table.getn(sakura_petals.sprites)].x = math.random(480 - sakura_petals.sprites[table.getn(sakura_petals.sprites)]:getWidth())
      sakura_petals.pos[table.getn(sakura_petals.sprites)].y = (math.random(sakura_petals.sprites[table.getn(sakura_petals.sprites)]:getHeight()) * -1)
      yspeed = math.random(3)
      xspeed = math.random(4,6)
      direction_change_time = math.random(direction_change_time_min,direction_change_time_max)
  
      if math.random(1,20)<=10 then
        xspeed = xspeed * -1
        sakura_petals.sprites[table.getn(sakura_petals.sprites)]:setReverse(true)
      end
      
      sakura_petals.speed[table.getn(sakura_petals.sprites)].x = xspeed
      sakura_petals.speed[table.getn(sakura_petals.sprites)].y = yspeed
      sakura_petals.direction_change_time[table.getn(sakura_petals.sprites)][1] = direction_change_time
      
      num_sakura_petals = num_sakura_petals + 1
    end
    if left() then
      table.remove(sakura_petals.sprites)
      table.remove(sakura_petals.pos)
      table.remove(sakura_petals.speed)
      table.remove(sakura_petals.direction_change_time)
      table.remove(sakura_petals.draw)
      num_sakura_petals = num_sakura_petals - 1
    end
  end
  
  AnimatedSprite.purgeList()
end

AnimatedSpriteExample()