function list_servers(xpos,ypos,cursor,col,selcol,start_index,stop_index,selection,img)
  img = img or screen
  local YY = ypos + 9
  local num_cursor_char = string.len(cursor)

  img:print(xpos,ypos,"Server Name \[# of ppl/# of ppl max/# of games\]",col)

  for i=start_index, stop_index do
    if i == table.getn(NET.servers.sel) then
      menuoption(xpos,YY,NET.servers.sel[i].name,cursor,col,selcol,i==selection,img)
    else
      menuoption(xpos,YY,NET.servers.sel[i].name .. "\[" .. NET.servers.sel[i].num_ppl .. "/" .. NET.servers.sel[i].max_ppl .. "/" .. NET.servers.sel[i].num_games .. "\]",cursor,col,selcol,i==selection,img)
    end
    YY = YY + 9
    if i == table.getn(NET.servers.sel) then break end
  end
end

function servers_menu()
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
      cursor=table.getn(NET.servers.sel)
    end
    if cursor>=table.getn(NET.servers.sel)+1 then
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
      if cursor == table.getn(NET.servers.sel) then break end
    end
    if triangle1() then break end
    if start1() then
    end

    screen:clear(Game.col.clear)
    screen:print(Game.titlepos.x,Game.titlepos.y,"Angelic Layer MMO",Game.col.txt)
    list_servers(8,16,">",Game.col.txt,Game.col.sel,start_index,stop_index,cursor)
    screen:flip()
    screen.waitVblankStart()
  end
end

function server_list_working()
  local spinner = loader_icon.new()
--  local retrieve_server_list = create_retrieve_server_list_co()
  local interface = NET.server.new()
  local status = true
  local status2 = true
  local ret = 99
  local icon = ""

  while ret == 99 do
    icon = spinner:update()

    if ret == 99 then
--      status,ret = coroutine.resume(retrieve_server_list)
      ret = interface:update()
    end

    screen:clear(Game.col.clear)
    screen:print(Game.titlepos.x,Game.titlepos.y,"Angelic Layer MMO",Game.col.txt)
    screen:print(8,16,"Retrieving Server List..." .. icon,Game.col.txt)
    screen:flip()
    screen.waitVblankStart()
  end
  if ret == 0 then
    while true do
      screen:clear(Game.col.clear)
      screen:print(Game.titlepos.x,Game.titlepos.y,"Angelic Layer MMO",Game.col.txt)
      screen:print(8,16,"Server List Retrieval Successful!",green)
      screen:print(8,32,"Press a button to Continue.",green)
      screen:print(0,50,ret,red)
      screen:flip()
      screen.waitVblankStart()
      if buttons1() then break end
    end
    servers_menu()
  else
    while true do
      screen:clear(Game.col.clear)
      screen:print(Game.titlepos.x,Game.titlepos.y,"Angelic Layer MMO",Game.col.txt)
      screen:print(8,16,"Server List Retrieval Failed!",red)
      display_net_error(16,24)
      screen:print(8,32,"Press a button to Continue.",red)
      screen:flip()
      screen.waitVblankStart()
      if buttons1() then break end
    end
  end
end