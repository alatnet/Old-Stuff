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
  local XX=xpos
  local TXT = ""

  for i=start_index, stop_index do
    TXT = array[i]
    for i2=0,string.len(TXT) do
      char=string.sub(TXT,i2,i2)
      img:print(XX, YY, char, col)
      XX = XX + 8
    end
    YY = YY + 8
    XX = xpos
    if i == table.getn(array) then break end
  end
end

function Osk_textinput(char,str)
  if char == nil or char == "\t"
    then return str,false
  elseif char == "\b" then
    return string.sub(str,1,string.len(str)-1),false
  elseif char == "\n" then
    return str, true
  else
    return str .. char,false
  end
end