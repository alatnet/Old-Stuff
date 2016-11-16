function theme_check()
  THEMES.sel = System.listDirectory(THEMES.dir)
  table.remove(THEMES.sel,1)
  table.remove(THEMES.sel,1)
  THEMES.num = table.getn(THEMES.sel)
  startupTHEMES()
  table.insert (THEMES.sel, {name="OK",size=0,directory=false})
  table.insert (THEMES.sel, {name="Cancel",size=0,directory=false})
  THEMES.num = THEMES.num + 2
  dofile (THEMES.dir .. "/" .. THEMES.use)
end

function startupTHEMES()
  local SortProc = function(a, b)
    if a.directory == b.directory then return a.name < b.name end
    return a.directory
  end
  table.sort(THEMES.sel, SortProc)
  
  for i=1, THEMES.num do
    if string.lower (THEMES.sel[i].name) == string.lower ("default.scheme") then
      THEMES.curr = i
      break
    end
  end
end

function list_themes(xpos,ypos,cursor,col,selcol,start_index,stop_index,selection,img)
  img = img or screen
  local YY=ypos
  
  for i=start_index, stop_index do
    menuoption(xpos,YY,THEMES.sel[i].name,cursor,col,selcol,i==selection,img)
    YY = YY + 9
    if i == THEMES.num then break end
  end
end

function display_curr_theme(xpos,ypos,col,img)
  img = img or screen
  img:print(xpos,ypos,"Using: " .. THEMES.sel[THEMES.curr].name,col)
end

function use_theme(val)
  dofile (THEMES.dir .. "/" .. THEMES.sel[val].name)
  THEMES.curr = val
end

function use_theme_txt(val)
  for i=1, THEMES.num do
    if string.lower (THEMES.sel[i].name) == string.lower (val) then
      THEMES.use = THEMES.sel[i].name
      THEMES.curr = i
      break
    end
  end

  dofile (THEMES.dir .. "/" .. THEMES.sel[THEMES.curr].name)
end

function theme_menu()
  local cursor=1
  local num_list = 25
  local start_index = 1
  local stop_index = num_list
  local prev_theme = THEMES
  local prev = THEMES.curr

  while true do
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
      cursor=THEMES.num
    end
    if cursor>=THEMES.num+1 then
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
      if cursor == THEMES.num-1 then break end
      if cursor == THEMES.num then
        use_theme(prev)
        THEMES = prev_theme
        break
      end
      use_theme(cursor)
    end
    if triangle1() then
      use_theme(prev)
      THEMES = prev_theme
      break
    end

    screen:clear(Game.col.clear)
    screen:print(Game.titlepos.x,Game.titlepos.y,"Angelic Layer MMO",Game.col.txt)
    display_curr_theme(8,16,blue)
    list_themes(8,24,">",Game.col.txt,Game.col.sel,start_index,stop_index,cursor)
    screen:flip()
    screen.waitVblankStart()
  end
end

theme_check()