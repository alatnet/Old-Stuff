--*************************************************************************************************
-- Angelic Layer MMO (ALMMO) Lua Game
-- Coded by by alatnet
--*************************************************************************************************

function music_check()
  MUSIC.sel = System.listDirectory(MUSIC.dir)
  table.remove(MUSIC.sel,1)
  table.remove(MUSIC.sel,1)
  table.insert (MUSIC.sel, {name="Back",size=0,directory=false})
  MUSIC.num = table.getn(MUSIC.sel)
end

function play_open_theme()
  for i=1, MUSIC.num do
    if string.lower (MUSIC.sel[i].name) == string.lower (MUSIC.theme.opening) then
      MUSIC.curr = i
      break
    end
  end
  Music.playFile(MUSIC.dir .. "/" .. MUSIC.sel[MUSIC.curr].name, false)
  resetTime()
end

function play_end_theme()
  for i=1, MUSIC.num do
    if string.lower (MUSIC.sel[i].name) == string.lower (MUSIC.theme.ending) then
      MUSIC.curr = i
      break
    end
  end
  Music.playFile(MUSIC.dir .. "/" .. MUSIC.sel[MUSIC.curr].name, false)
  resetTime()
end

function play_rand_music()
  MUSIC.curr = math.random(1,MUSIC.num-1)
  Music.playFile(MUSIC.dir .. "/" .. MUSIC.sel[MUSIC.curr].name, false)
  resetTime()
end

function play_inorder_music()
  MUSIC.curr = MUSIC.curr + 1
  if MUSIC.curr == MUSIC.num then MUSIC.curr = 0 end
  Music.playFile(MUSIC.dir .. "/" .. MUSIC.sel[MUSIC.curr].name, false)
  resetTime()
end

function list_music(xpos,ypos,cursor,col,selcol,start_index,stop_index,selection,img)
  img = img or screen
  local YY=ypos
  local num_cursor_char = string.len(cursor)

  for i=start_index, stop_index do
    if i==MUSIC.curr then
      if MUSIC.pause then
        img:print(xpos+(8*num_cursor_char), YY, MUSIC.sel[i].name .. " ||", Game.col.music.pause)
      elseif MUSIC.stop then
        img:print(xpos+(8*num_cursor_char), YY, MUSIC.sel[i].name .. " \[\]", Game.col.music.stop)
      else
        img:print(xpos+(8*num_cursor_char), YY, MUSIC.sel[i].name .. " >", Game.col.music.play)
      end
    end
    menuoption(xpos,YY,MUSIC.sel[i].name,cursor,col,selcol,i==selection,img)
--[[    if i==MUSIC.curr and i~=selection  then
      img:print(xpos+(8*num_cursor_char), YY, MUSIC.sel[i].name .. "<", Game.col.curr)
    end]]--
    YY = YY + 9
    if i == MUSIC.num then break end
  end
end

function play_song(song_num)
  Music.stop()
  Music.playFile(MUSIC.dir .. "/" .. MUSIC.sel[song_num].name,false)
  resetTime()
  MUSIC.curr = song_num
end

function display_curr_song(xpos,ypos,col,img)
  img = img or screen
  if MUSIC.stop then
    img:print(xpos,ypos,"Playing: Stopped!",col)
  elseif MUSIC.pause then
    img:print(xpos,ypos,"Playing: Paused!   Time: " .. getTime(),col)
  else
    img:print(xpos,ypos,"Playing: " .. MUSIC.sel[MUSIC.curr].name .. "   Time: " .. getTime(),col)
  end
end

function music_menu()
  local cursor=1
  local num_list = 25
  local start_index = 1
  local stop_index = num_list

  while true do
    play_music()
    if up1() then
      cursor=cursor-1
      key_tone()
    end
    if down1() then
      cursor=cursor+1
      key_tone()
    end
    --if left1() then cursor=cursor-num_list end
    --if right1() then cursor=cursor+num_list end

    if cursor<=0 then
      cursor=MUSIC.num
    end
    if cursor>=MUSIC.num+1 then
      cursor=1
    end

    if cursor > stop_index then
      start_index = start_index + num_list
      stop_index = stop_index + num_list
    end

    if cursor < start_index then
      start_index = start_index - num_list
      stop_index = stop_index - num_list
    end

    if cross1() or circle1() then
      if cursor == MUSIC.num then break end
      play_song(cursor)
      MUSIC.stop = false
    end
    if triangle1() then break end
    if square1() then
      Music.stop()
      MUSIC.stop = true
      MUSIC.pause = false
    end
    if start1() then
      if MUSIC.pause then
        MUSIC.pause = false
        Music.resume()
      elseif not MUSIC.pause and not MUSIC.stop then
        MUSIC.pause = true
        Music.pause()
      end
    end

    screen:clear(Game.col.clear)
    screen:print(Game.titlepos.x,Game.titlepos.y,"Angelic Layer MMO",Game.col.txt)
    display_curr_song(8,16,blue)
    list_music(8,24,">",Game.col.txt,Game.col.sel,start_index,stop_index,cursor)
    screen:flip()
    screen.waitVblankStart()
  end
end

function play_music()
  if not Music.playing() and not MUSIC.stop and not MUSIC.pause then
    if MUSIC.mode == 1 then
      play_rand_music()
    else
      play_inorder_music()
    end
  end
  getTime()
end

function switch_music_modes()
  if MUSIC.mode == 1 then
    MUSIC.mode = 2
  else
    MUSIC.mode = 1
  end
end


function getTime()
  if MUSIC.time.timer:time() >= 1000 then
    MUSIC.time.timer:reset()
    MUSIC.time.timer:start()
    MUSIC.time.sec = MUSIC.time.sec + 1
  end
  if MUSIC.time.sec == 60 then
    MUSIC.time.sec = 0
    MUSIC.time.min = MUSIC.time.min + 1
  end

  if MUSIC.time.sec < 10 then
    MUSIC.time.str = MUSIC.time.min .. ":0" .. MUSIC.time.sec
  else
    MUSIC.time.str = MUSIC.time.min .. ":" .. MUSIC.time.sec
  end
  
  if MUSIC.stop then resetTime() end
  if MUSIC.pause then
    pauseTime(true)
  else
    pauseTime(false)
  end

  return MUSIC.time.str
end

function resetTime()
  MUSIC.time.timer:reset()
  MUSIC.time.timer:start()
  MUSIC.time.min = 0
  MUSIC.time.sec = 0
end

function pauseTime(val)
  if val then
    MUSIC.time.timer:stop()
  else
    MUSIC.time.timer:start()
  end
end

music_check()
Music.volume(MUSIC.vol)