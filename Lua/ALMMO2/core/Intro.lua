function INTRO()
  local timer = Timer.new()
  timer:start()
  
  while not start() do
    if timer:time() >= 85000 then break end   --30000  --REWRITE.XM = 218000  --the_raising_fighting_spirit.xm = 85000
    screen:clear(white)

    --screen:print(8,screen:height() - 16,"Song Time:" .. getTime(),black)
    screen.waitVblankStart()
    screen:flip()
  end
  timer:stop()
end

INTRO()