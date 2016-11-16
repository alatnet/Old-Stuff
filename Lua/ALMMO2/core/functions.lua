--*************************************************************************************************
-- Angelic Layer MMO (ALMMO) Lua Game
-- Coded by by alatnet
--*************************************************************************************************

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

function find_num_from_percent(max_num, percentage)
  local XXX = percentage * max_num
  local YYY = XXX / 100
  return YYY
end

function find_percent_from_num(max_num, num)
  local XXX = num * 100
  local YYY = XXX / max_num
  return YYY
end

function print_array(xpos,ypos,col,array,start_index,stop_index,img)
  img = img or screen
  local YY=ypos

  for i=start_index, stop_index do
    img:print(xpos, YY, array[i], col)
    YY = YY + 8
    if i == table.getn(array) then break end
  end
end


--[[ Print Functions ]]--
function gPrint(xpos,ypos,txt,col,img)
  local y = ypos
  local x = xpos
  local char = ""
  img = img or screen
  for i = 1, string.len(txt) do
    char = string.sub(txt, i, i)
    if char == "\n" then
      y = y + 8
      x = xpos
    elseif char ~= "\r" then
      img:print(x, y, char, col)
      x = x + 8
    end
  end
end

function gPrintln(xpos,ypos,txt,col,img)
  gPrint(xpos,ypos,txt .. "\n",col,img)
end


--[[ COROUTINES ]]--

--[[
function create_loadbar_icon_co()
  local co = coroutine.create(
    function (step)
      step = step or 1

      local loading_bar = {
        "[          ]",
        "[|         ]",
        "[||        ]",
        "[|||       ]",
        "[||||      ]",
        "[|||||     ]",
        "[||||||    ]",
        "[|||||||   ]",
        "[||||||||  ]",
        "[||||||||| ]",
        "[||||||||||]"
      }
      
      if step < 1 then step = 1 end
      if step > table.getn(loading_bar) then step = table.getn(loading_bar) end

      local curr = 1

      while true do
        curr = curr + step
        if curr >= table.getn(loading_bar) then
          curr = table.getn(loading_bar)
          break
        end
        coroutine.yield(loading_bar[curr])
      end

      coroutine.yield(loading_bar[curr])
    end
  )
  
  return co
end

function loadbar_co_reset_check(co)
  if coroutine.status (co) == "dead" then
    co = create_loadbar_icon_co()
  end

  return co
end
]]--

--[[ Fade Functions ]]--
function fade_2_black(col,fade_speed,count_max)
  col = col or Color.new(256,256,256)
  local cols = col:colors()
  local R = cols.r
  local G = cols.g
  local B = cols.b

  local count = 0
  count_max = count_max or 50
  fade_speed = fade_speed or 1

  if fade_speed < 1 then fade_speed = 1 end
  if count_max < 1 then count_max = 50 end

  while not start() do
    R = R - fade_speed
    G = G - fade_speed
    B = B - fade_speed

    if R <= 0 then R = 0 end
    if G <= 0 then G = 0 end
    if B <= 0 then B = 0 end
    if R==0 and G==0 and B==0 then count = count + 1 end

    if count == count_max then break end

    screen:clear(col)
    col = Color.new(R,G,B)
    screen.waitVblankStart()
    screen:flip()
  end
end

function fade_2_white(col,fade_speed,count_max)
  col = col or Color.new(256,256,256)
  local cols = col:colors()
  local R = cols.r
  local G = cols.g
  local B = cols.b

  local count = 0
  count_max = count_max or 50
  fade_speed = fade_speed or 1

  if fade_speed < 1 then fade_speed = 1 end
  if count_max < 1 then count_max = 50 end

  while not start() do
    R = R + fade_speed
    G = G + fade_speed
    B = B + fade_speed

    if R >= 256 then R = 256 end
    if G >= 256 then G = 256 end
    if B >= 256 then B = 256 end
    if R==256 and G==256 and B==256 then count = count + 1 end

    if count == count_max then break end

    screen:clear(col)
    col = Color.new(R,G,B)
    screen.waitVblankStart()
    screen:flip()
  end
end

function fade_2_col(start_col,end_col,fade_speed,count_max)
  start_col = start_col or Color.new(256,256,256)
  local cols = start_col:colors()
  local SR = cols.r
  local SG = cols.g
  local SB = cols.b
  
  end_col = end_col or Color.new(0,0,0)
  local cols = end_col:colors()
  local ER = cols.r
  local EG = cols.g
  local EB = cols.b
  
  local col = Color.new(SR,SG,SB)

  local count = 0
  count_max = count_max or 50
  fade_speed = fade_speed or 1

  if fade_speed < 1 then fade_speed = 1 end
  if count_max < 1 then count_max = 50 end

  while not start() do
    if SR < ER then
      SR = SR + fade_speed
    else
      SR = ER
    end
    if SG < EG then
      SG = SG + fade_speed
    else
      SG = EG
    end
    if SB < EB then
      SB = SB + fade_speed
    else
      SB = EB
    end

    if SR > ER then
      SR = SR - fade_speed
    else
      SR = ER
    end
    if SG > EG then
      SG = SG - fade_speed
    else
      SG = EG
    end
    if SB > EB then
      SB = SB - fade_speed
    else
      SB = EB
    end

    if SR >= 256 then SR = 256 end
    if SG >= 256 then SG = 256 end
    if SB >= 256 then SB = 256 end
    if SR <= 0 then SR = 0 end
    if SG <= 0 then SG = 0 end
    if SB <= 0 then SB = 0 end

    if SR==ER and SG==EG and SB==EB then count = count + 1 end

    if count == count_max then break end

    screen:clear(col)
    col = Color.new(SR,SG,SB)
    screen.waitVblankStart()
    screen:flip()
  end
end

--[[
function fade_2_black_alpha(col,xpos,ypos,width,height,fade_speed,count_max)
  xpos = xpos or 0
  ypos = ypos or 0
  width = width or screen:width()
  height = height or screen:height()
  col = col or Color.new(0,0,0,0)
  local cols = col:colors()
  local R = cols.r
  local G = cols.g
  local B = cols.b
  local A = cols.a

  local fade_img = Image.createEmpty(width,height)

  local count = 0
  count_max = count_max or 50
  fade_speed = fade_speed or 1

  if fade_speed < 1 then fade_speed = 1 end
  if count_max < 1 then count_max = 50 end

  while not start() do
    R = R + fade_speed
    G = G + fade_speed
    B = B + fade_speed
    A = A + fade_speed

    if R >= 256 then R = 256 end
    if G >= 256 then G = 256 end
    if B >= 256 then B = 256 end
    if A >= 256 then A = 256 end
    if R==256 and G==256 and B==256 and A==256 then count = count + 1 end

    if count == count_max then break end

    fade_img:clear(col)
    col = Color.new(R,G,B,A)
    screen:blit(xpos,ypos,fade_img)
    screen.waitVblankStart()
    screen:flip()
  end
end
]]--

function fade_col_alpha_out(col,xpos,ypos,width,height,fade_speed,count_max)
  xpos = xpos or 0
  ypos = ypos or 0
  width = width or screen:width()
  height = height or screen:height()
  col = col or Color.new(0,0,0)
  local cols = col:colors()
  local R = cols.r
  local G = cols.g
  local B = cols.b
  local A = 0
  col = Color.new(R,G,B,A)

  local fade_img = Image.createEmpty(width,height)

  local count = 0
  count_max = count_max or 50
  fade_speed = fade_speed or 1

  if fade_speed < 1 then fade_speed = 1 end
  if count_max < 1 then count_max = 50 end
  
  screen:blit(0,0,screen)

  while not start() do
    A = A + fade_speed

    if A >= 256 then A = 256 end
    if A==256 then count = count + 1 end

    if count == count_max then break end

    fade_img:clear(col)
    col = Color.new(R,G,B,A)
    screen:blit(xpos,ypos,fade_img)
    screen.waitVblankStart()
    screen:flip()
  end
end

function fade_col_alpha_in(col,xpos,ypos,width,height,fade_speed,count_max)
  xpos = xpos or 0
  ypos = ypos or 0
  width = width or screen:width()
  height = height or screen:height()
  col = col or Color.new(0,0,0)
  local cols = col:colors()
  local R = cols.r
  local G = cols.g
  local B = cols.b
  local A = 256
  col = Color.new(R,G,B,A)

  local fade_img = Image.createEmpty(width,height)

  local count = 0
  count_max = count_max or 50
  fade_speed = fade_speed or 1

  if fade_speed < 1 then fade_speed = 1 end
  if count_max < 1 then count_max = 50 end
  
  screen:blit(0,0,screen)

  while not start() do
    A = A - fade_speed

    if A <= 0 then A = 0 end
    if A==0 then count = count + 1 end

    if count == count_max then break end

    fade_img:clear(col)
    col = Color.new(R,G,B,A)
    screen:blit(xpos,ypos,fade_img)
    screen.waitVblankStart()
    screen:flip()
  end
end