function osk_check()
  OSK.sel = System.listDirectory(OSK.dir)
  table.remove(OSK.sel,1)
  table.remove(OSK.sel,1)
  table.insert (OSK.sel, {name="Back",size=0,directory=false})
  OSK.num = table.getn(OSK.sel)
  startupOSK()
end

function list_osk(xpos,ypos,cursor,col,selcol,start_index,stop_index,selection,img)
  img = img or screen
  local YY=ypos

  for i=start_index, stop_index do
    menuoption(xpos,YY,OSK.sel[i].name,cursor,col,selcol,i==selection,img)
    YY = YY + 9
    if i == OSK.num then break end
  end
end         

function use_osk(sel)
  OSK.curr = sel
  dofile(OSK.dir .. "/" .. OSK.sel[OSK.curr].name)
end

function display_curr_osk(xpos,ypos,col,img)
  img = img or screen
  img:print(xpos,ypos,"Using: " .. OSK.sel[OSK.curr].name,col)
end

function startupOSK()
  for i=1, OSK.num do
    if string.lower (OSK.sel[i].name) == string.lower (OSK.use) then
      OSK.curr = i
      break
    end
  end
end

function osk_menu()
  local cursor=1
  local num_list = 20
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

    if cursor==0 then
      cursor=OSK.num
    end
    if cursor==OSK.num+1 then
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
      if cursor == OSK.num then break end
      use_osk(cursor)
    end
    if triangle1() then break end

    screen:clear(Game.col.clear)
    screen:print(Game.titlepos.x,Game.titlepos.y,"Angelic Layer MMO",Game.col.txt)
    display_curr_osk(8,16,blue)
    list_osk(8,24,">",Game.col.txt,Game.col.sel,start_index,stop_index,cursor)
    screen:flip()
    screen.waitVblankStart()
  end
end

function Osk_textinput(char,str)
  if char == nil or char == "\n" or char == "\t"
    then return str
  elseif char == "\b" then
    return string.sub(str,1,string.len(str)-1)
  else
    return str .. char
  end
end

osk_check()