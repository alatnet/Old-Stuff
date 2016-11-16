--*************************************************************************************************
-- Angelic Layer MMO (ALMMO) Lua Game
-- Coded by by alatnet
--*************************************************************************************************

function MAIN_MENU()
  local cursor=1
  local options = {
    "Login",
    "Update",
    "Options",
    "Quit"
  }

  play_open_theme()

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

    if cursor==0 then cursor=table.getn(options) end
    if cursor==table.getn(options)+1 then cursor=1 end

    screen:clear(Game.col.clear)
    screen:print(Game.titlepos.x,Game.titlepos.y,"Angelic Layer MMO",Game.col.txt)
    list_options(8,16,options,">",Game.col.txt,Game.col.sel,cursor)
    screen:flip()
    screen.waitVblankStart()
    
    if cross1() or circle1() or start1() then
      if cursor==1 then
        if NET.auto_login.val then
          login_working()
          shutdownWlan()
        else
          login_menu()
        end
      end
      if cursor==2 then
      end
      if cursor==3 then
        options_menu()
      end
      if cursor==4 then
        break  --os.exit(0)
      end
    end
    if triangle1() then break end  --os.exit(0)
  end
end

MAIN_MENU()