--*************************************************************************************************
-- Angelic Layer MMO (ALMMO) Lua Game
-- Coded by by alatnet
--*************************************************************************************************

function MAIN()
  --[[ Required Files ]]--
  require "core/controls"    --always 1st
  require "core/colors"      --always 2nd
  require "core/variables"   --always 3rd (Posibly be converted to encripted form)
  dofile "core/Default Settings.ini"
  dofile "Settings.ini"

  --[[ On Screen Keyboard (OSK) ]]--
  dofile "core/osk.lua"
  dofile "core/pad.lc"
  dofile(OSK.dir .. "/" .. OSK.sel[OSK.curr].name)

  --[[ Various network communications between server-psp and psp-psp ]]--
  dofile "core/net.lua"          -- (Will be converted to encripted form)
  dofile "core/wlan.lua"
  dofile "core/server.lua"
  
  dofile "core/NET.login.lua"
  dofile "core/NET.server.lua"

  --[[ Other stuff ]]--
  dofile "core/functions.lua"    -- (Posibly be converted to encripted form)
  dofile "core/music.lua"
  dofile "core/sfx.lua"
  dofile "core/login.lua"
  dofile "core/options.lua"
  dofile "core/loader_icon.lua"
  dofile "core/themes.lua"
  
  Music.volume(128)

  dofile "core/console_loading.lua"

  if not Game.logo_skip then fade_2_white(black,3) end

  dofile "logo/logo.lua"
--  dofile "core/Intro.lua"

  if not Game.logo_skip then fade_2_black(white,2) end

  psudo_console_credits()
  
  Music.volume(MUSIC.vol)

  Music.stop()
  collectgarbage()
  dofile "core/MAIN_MENU.lua"
  Music.stop()
end

MAIN()
unload_variables()
collectgarbage()