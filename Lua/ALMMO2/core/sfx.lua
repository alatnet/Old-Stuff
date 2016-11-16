--*************************************************************************************************
-- Angelic Layer MMO (ALMMO) Lua Game
-- Coded by by alatnet
--*************************************************************************************************

function key_tone()
  if SFX.snd.key_tone.val == nil then load_key_sfx() end
  if Game.key_tone.val then
--    SFX.snd.key_tone.val:stop() -- if SFX.snd.key_tone.val:playing() then SFX.snd.key_tone.val:stop() end
    SFX.snd.key_tone.val:play()
  end
end


--[[ SFX Load ]]--
function load_game_sfx()
  local str = SFX.dir .. "/" .. SFX.snd.punch1.file
  SFX.snd.punch1.val = Sound.load(str,false)
  
  str = SFX.dir .. "/" .. SFX.snd.punch2.file
  SFX.snd.punch2.val = Sound.load(str,false)
end

function load_key_sfx()
  local str = SFX.dir .. "/" .. SFX.snd.key_tone.file
  SFX.snd.key_tone.val = Sound.load(str,false)
end

--[[ SFX Unload ]]--
function unload_game_sfx()
  SFX.snd.punch1.val = nil
  SFX.snd.punch2.val = nil
end

function unload_key_sfx()
  SFX.snd.key_tone.val = nil
end

--[[ Other ]]--
function toggle_key_tone()
  if Game.key_tone.val then
    Game.key_tone.val = false
    Game.key_tone.str = "Off"
  else
    Game.key_tone.val = true
    Game.key_tone.str = "On"
  end
end

SoundSystem.SFXVolume(SFX.vol)