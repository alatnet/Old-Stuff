--*************************************************************************************************
-- Angelic Layer MMO (ALMMO) Lua Game
-- Coded by by alatnet
--*************************************************************************************************

function psudo_console_loading()
  local lines = {
    {txt = "",pause = 1,num_dis = 0},
    {txt = "",pause = 1,num_dis = 0},
    {txt = "",pause = 2500,num_dis = 0},
    {txt = "       cd PSP\\GAME\\__SCE__ALMMO",pause = 1500,num_dis = 7},
    {txt = "",pause = 2500,num_dis = 0},
    {txt = "                            EBOOT.PBP",pause = 1500,num_dis = 29},
    {txt = "Welcome to Angelic Layer MMO!",pause = 1,num_dis = 0},
    {txt = "Now Loading...",pause = 5000,num_dis = 0},
    {txt = "",pause = 1000,num_dis = 0},
    {txt = "",pause = 1000,num_dis = 0},
    {txt = "",pause = 1000,num_dis = 0},
    {txt = "",pause = 1000,num_dis = 0}
  }

  local start_lines = {
    "Sony PSP Console \[Version 5.1.2600\]",
    "",
    "ms0:\\>",
    "",
    "ms0:\\PSP\\GAME\\__SCE__ALMMO>"
  }

  local curr_line = 3
  local ypos = -3

  local linetimer = Timer.new()
  local chartimer = Timer.new()
  local b_timer = Timer.new()
  local b_interval = 300
  local blink = true
  local err

  chartimer:start()
  b_timer:start()

  while not Game.logo_skip do
    if chartimer:time() >= 45 then
      chartimer:reset()
      chartimer:start()
      lines[curr_line].num_dis = lines[curr_line].num_dis + 1
      if lines[curr_line].num_dis >= string.len(lines[curr_line].txt) then
        linetimer:start()
        lines[curr_line].num_dis = string.len(lines[curr_line].txt)
      end
    end

    if linetimer:time() >= lines[curr_line].pause then
      linetimer:reset()
      linetimer:stop()
      if curr_line < table.getn(lines) then
        curr_line = curr_line + 1
      else
        curr_line = table.getn(lines)+1
      end
    end
    
    if curr_line > table.getn(lines) then break end
    
    if b_timer:time() >= b_interval then
      b_timer:reset()
      b_timer:start()
      if blink then
        blink = false
      else
        blink = true
      end
    end

    ypos = -3

    screen:clear(black)

    print_array(3,5,white,start_lines,1,curr_line)

    for i=1,curr_line do
      cPrint(3,ypos,lines[i].txt,white,lines[i].num_dis,i==curr_line,blink)

      if curr_line == 3 then
        screen:fillRect(3, (curr_line*8)-8, 7, 7, black)
        textinput(3,curr_line*8,"       ","_",white,true,blink)
      end

      if curr_line == 5 then
        screen:fillRect(3, (curr_line*8)-8, 7, 7, black)
        textinput(3,curr_line*8,"                            ","_",white,true,blink)
      end

      ypos = ypos + 8
    end

    screen.waitVblankStart()
    screen:flip()
    System.powerTick()
    if start1() then
      Game.logo_skip = true
      break
    end
  end
end

function psudo_console_credits()
  local lines = {
    {txt = "",pause = 500,num_dis = 0,col = white},
    {txt = "Angelic Layer MMO Game Client Version " .. Game.version,pause = 2500,num_dis = 0},
    {txt = " A Dev Team X Productions",pause = 500,num_dis = 0},
    {txt = " Created By: alatnet (Dev Team X Founder)",pause = 500,num_dis = 0},
    {txt = "Special Thanks:",pause = 500,num_dis = 0},
    {txt = " - Shine (luaplayer)",pause = 500,num_dis = 0},
    {txt = " - Nevyn (luaplayer)",pause = 500,num_dis = 0},
    {txt = " - youresam (netlib)",pause = 500,num_dis = 0},
    {txt = " - 4000webs.com (Website and Database hosting)",pause = 500,num_dis = 0},
    {txt = "Official Website:",pause = 500,num_dis = 0},
    {txt = " almmo.4000webs.com",pause = 500,num_dis = 0},
    {txt = "",pause = 2500,num_dis = 0}
  }  --{txt = "",pause = 500,num_dis = 0},
  
  local curr_line = 1
  local ypos = -3

  local linetimer = Timer.new()
  local chartimer = Timer.new()
  local b_timer = Timer.new()
  local b_interval = 300
  local blink = true
  local err
  local BG = Image.load("PICS/Intro/Intro1.png")

  chartimer:start()
  b_timer:start()

  while not Game.logo_skip do
    if chartimer:time() >= 45 then
      chartimer:reset()
      chartimer:start()
      lines[curr_line].num_dis = lines[curr_line].num_dis + 1
      if lines[curr_line].num_dis >= string.len(lines[curr_line].txt) then
        linetimer:start()
        lines[curr_line].num_dis = string.len(lines[curr_line].txt)
      end
    end

    if linetimer:time() >= lines[curr_line].pause then
      linetimer:reset()
      linetimer:stop()
      if curr_line < table.getn(lines) then
        curr_line = curr_line + 1
      else
        curr_line = table.getn(lines)+1
      end
    end
    
    if curr_line > table.getn(lines) then break end
    
    if b_timer:time() >= b_interval then
      b_timer:reset()
      b_timer:start()
      if blink then
        blink = false
      else
        blink = true
      end
    end

    ypos = -3

    screen:clear(black)
    screen:blit(0,0,BG)

    for i=1,curr_line do
      cPrint(3,ypos,lines[i].txt,white,lines[i].num_dis,i==curr_line,blink)
      ypos = ypos + 8
    end

    screen.waitVblankStart()
    screen:flip()
    System.powerTick()
    if start1() then
      Game.logo_skip = true
      break
    end
  end
  --fade_2_black_alpha(Color.new(0,0,0,0))
  linetimer:stop()
  chartimer:stop()
  b_timer:stop()
end

function cPrint(xpos,ypos,txt,col,num_dis,selected,blink,img)
  local TTT = ""
  img = img or screen
  
  TTT = string.sub(txt, 1, num_dis)
  img:print(xpos, ypos, TTT, col)
  
  if selected then
    if blink then
      img:print(xpos, ypos,TTT .. "_", col)
    end
  end
end

psudo_console_loading()