function options_menu()
  local cursor=1
  local options = {
    "Music List",
    "OSK List",
    "WLAN Connections List",
    "Auto Login Options",
    "Themes", --
    "Save Settings",
    "Load Settings",
    "OK",
    "Cancel",
    "Default Settings"
  }
  
  local Prev_Settings = {
    Music_vol = MUSIC.vol,
    SFX_vol = SFX.vol,
    Music_mode = MUSIC.mode,
    Key_tone = Game.key_tone.val,
    OSK_curr = OSK.curr,
    NET_connect_curr = NET.connect.curr,
    THEME = THEMES.curr
  }

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

    if cursor==0 then cursor=table.getn(options)+4 end
    if cursor==table.getn(options)+5 then cursor=1 end

    if cursor==1 then
      if left() then
        MUSIC.vol = MUSIC.vol - 1
        if MUSIC.vol < 0 then MUSIC.vol = 0 end
        Music.volume(MUSIC.vol)
      end
      if right() then
        MUSIC.vol = MUSIC.vol + 1
        if MUSIC.vol > 128 then MUSIC.vol = 128 end   --VOLUME LIMIT
        Music.volume(MUSIC.vol)
      end
    end
    if cursor==2 then
      if left() then
        SFX.vol = SFX.vol - 1
        if SFX.vol < 0 then SFX.vol = 0 end
        SoundSystem.SFXVolume(SFX.vol)
      end
      if right() then
        SFX.vol = SFX.vol + 1
        if SFX.vol > 128 then SFX.vol = 128 end       --VOLUME LIMIT
        SoundSystem.SFXVolume(SFX.vol)
      end
    end

    screen:clear(Game.col.clear)
    screen:print(Game.titlepos.x,Game.titlepos.y,"Angelic Layer MMO",Game.col.txt)
    menuoption(8,16,"Music Volume: " .. find_percent_from_num(128, MUSIC.vol) .. "%",">",Game.col.txt,Game.col.sel,cursor==1)
    menuoption(8,24,"SFX Volume: " .. find_percent_from_num(128, SFX.vol) .. "%",">",Game.col.txt,Game.col.sel,cursor==2)
    menuoption(8,32,"Play Music: " .. MUSIC.modes[MUSIC.mode],">",Game.col.txt,Game.col.sel,cursor==3)
    menuoption(8,40,"Key Tone: " .. Game.key_tone.str,">",Game.col.txt,Game.col.sel,cursor==4)
    list_options(8,48,options,">",Game.col.txt,Game.col.sel,cursor-4)
    screen:flip()
    screen.waitVblankStart()

    if cross1() or circle1() then
      if cursor==3 then switch_music_modes() end
      if cursor==4 then toggle_key_tone() end
      if cursor==5 then music_menu() end
      if cursor==6 then osk_menu() end
      if cursor==7 then WLAN_Connect_Menu() end
      if cursor==8 then Auto_Login_Menu() end
      if cursor==9 then theme_menu() end
      if cursor==10 then save_settings() end
      if cursor==11 then
        dofile "Settings.ini"
        Prev_Settings.Music_vol = MUSIC.vol
        Prev_Settings.SFX_vol = SFX.vol
        Prev_Settings.Music_mode = MUSIC.mode
        Prev_Settings.Key_tone = Game.key_tone.val
        Prev_Settings.OSK_curr = OSK.curr
        use_theme_txt(THEMES.use)
        Prev_Settings.THEME = THEMES.curr
        use_osk(Prev_Settings.OSK_curr)
        use_wlan(Prev_Settings.NET_connect_curr)
        Music.volume(MUSIC.vol)
        SoundSystem.SFXVolume(SFX.vol)
        --load_sfx()
      end
      if cursor==12 then break end
      if cursor==13 then
        MUSIC.vol = Prev_Settings.Music_vol
        SFX.vol = Prev_Settings.SFX_vol
        MUSIC.mode = Prev_Settings.Music_mode
        Game.key_tone.val = Prev_Settings.Key_tone
        OSK.curr = Prev_Settings.OSK_curr
        NET.connect.curr = Prev_Settings.NET_connect_curr
        THEMES.curr = Prev_Settings.THEME
        use_osk(OSK.curr)
        use_wlan(NET.connect.curr)
        Music.volume(MUSIC.vol)
        SoundSystem.SFXVolume(SFX.vol)
        break
      end
      if cursor==14 then
        dofile "core/Default Settings.ini"
        Prev_Settings.Music_vol = MUSIC.vol
        Prev_Settings.SFX_vol = SFX.vol
        Prev_Settings.Music_mode = MUSIC.mode
        Prev_Settings.Key_tone = Game.key_tone.val
        Prev_Settings.OSK_curr = OSK.curr
        use_theme_txt(THEMES.use)
        Prev_Settings.THEME = THEMES.curr
        use_osk(OSK.curr)
        use_wlan(NET.connect.curr)
        Music.volume(MUSIC.vol)
        SoundSystem.SFXVolume(SFX.vol)
        --load_sfx()
      end
    end
    if triangle1() then
      MUSIC.vol = Prev_Settings.Music_vol
      SFX.vol = Prev_Settings.SFX_vol
      MUSIC.mode = Prev_Settings.Music_mode
      Game.key_tone.val = Prev_Settings.Key_tone
      OSK.curr = Prev_Settings.OSK_curr
      NET.connect.curr = Prev_Settings.NET_connect_curr
      use_osk(OSK.curr)
      use_wlan(NET.connect.curr)
      Music.volume(MUSIC.vol)
      SoundSystem.SFXVolume(SFX.vol)
      break
    end
  end
end

function save_settings()
  local str = ""
  file = io.open("Settings.ini","w")

  file:write("-- Global Variables\n")

  if Game.key_tone.val then
    str = "true"
  else
    str = "false"
  end

  file:write("Game.key_tone.val = " .. str .."\n")
  file:write("Game.key_tone.str = \"" .. Game.key_tone.str .."\"\n")

  file:write("\n-- OSK Specific Variables\n")
  --file:write("OSK.dir = \"" .. OSK.dir .."\"\n")
  file:write("OSK.use = \"" .. OSK.use .."\"\n")
  file:write("OSK.curr = " .. OSK.curr .."\n")
  
  file:write("\n-- Network Specific Variables\n")

  if NET.auto_login.val then
    str = "true"
  else
    str = "false"
  end

  file:write("NET.auto_login.val = " .. str .."\n")
  file:write("NET.auto_login.str = \"" .. NET.auto_login.str .."\"\n")
  file:write("NET.auto_login.username = \"" .. NET.auto_login.username .."\"\n")
  file:write("NET.auto_login.password = \"" .. NET.auto_login.password .."\"\n")
  
  file:write("\n-- Music Specific Variables\n")
  --file:write("MUSIC.dir = \"" .. MUSIC.dir .."\"\n")
  --file:write("MUSIC.theme.opening = \"" .. MUSIC.theme.opening .."\"\n")
  --file:write("MUSIC.theme.ending = \"" .. MUSIC.theme.ending .."\"\n")
  file:write("MUSIC.vol = " .. MUSIC.vol .."\n")
  file:write("MUSIC.mode = " .. MUSIC.mode .."\n")
  
  file:write("\n-- Sound FX Specific Variables\n")
  --file:write("SFX.dir = \"" .. SFX.dir .."\"\n")
  file:write("SFX.vol = " .. SFX.vol .."\n")
  --file:write("SFX.snd.punch1.file = \"" .. SFX.snd.punch1.file .."\"\n")
  --file:write("SFX.snd.punch2.file = \"" .. SFX.snd.punch2.file .."\"\n")
  --file:write("SFX.snd.key_tone.file = \"" .. SFX.snd.key_tone.file .."\"\n")
  
  file:write("\n-- Themes Specific Variables\n")
  file:write("THEMES.use = \"" .. THEMES.sel[THEMES.curr].name .."\"\n")
  
  --file:write(" = " .. ? .."\n")
  file:close()
end