--requireC("./dbgfunc.lua")

if requireC == nil then
  dofile("requireC.lua");
end

Global = {
  system = {
    dir = {
      main = "./System/",
      img = "Images/",
      sfx = "SFX/"
    },
    vol = {
      music = 128,
      sfx = 128
    },
    petals = nil,
    counter = nil,
    mouse = {
      spd = 30,
      cursor = nil
    },
    useKeyTone = true,
    displayFPS = true
  },
  sfx = {
    system = {
      keytone = nil,
      logon = nil,
      logoff = nil,
      notify = nil,
      batt = {
        low = nil,
        crit = nil
      }
    }
  },
  osk = {
    dir = "./OSK/",
    curr = "TwinTail.lc",
    list = {}
  },
  arenas = {
    dir = "./Arenas/",
    list = {}
  },
  characters = {
    dir = "./Characters/",
    list = {}
  },
  items = {
    dir = "./Items/",
    list = {}
  },
  wlan = {  -- Restructure for multiple webservers
    database = "progcomp.selfip.com", --"10.185.193.171",  --"192.168.1.100"
    php_pages = {
      path = "/UBRPG/php/psp/",
      login = "login.php",
      servers = "serverlist.php",
      setPlayer = "setPlayer.php",
      character = {
        set = "setCharacter.php",
        new = "newCharacter.php",
        delete = "deleteCharacter.php"
      }
    },
    useConfig = 1,
    offset = 0,
    configs = nil
  },
  data = {
    user = nil,
    chars = nil,
    servers = nil,
    arena = nil
  },
  draw = {},
  debug = {}
}

--[[ LOAD SYSTEM FILES ]]--
do
  local SystemLoadingList = {
    "Loading GUI.lc",
    "advancedDrawFuncs.lua",
    "extraFuncs.lua",
    "colors.lua",
    "Ctrl.lc",
    "FPSCounter.lua",
    "TrigArea.lua",
    "PAD.LC",
    "SystemFuncs.lc",
    "Attributes.lc",
    "Price.lc",
    "Item.lc",
    "AnimatedSprite.lc",
    "Char.lc",
    "TrigArea.lua",
    "JavaSrv.lc",
    "Label.lua",
    ------------------
    "AnimatedSprite3D.lc",
    "TrigArea3D.lua",
    "Mouse.lua",
    "TextField.lc",
    "TextField2.lua",
    "MsgBox.lc",
    "BAR.lc",
    "MENU.lc",
    "CommandMenu.lc",
    "Petals.lua",
    "TextArea.lc",
    ------------------
    "logo.lua",
    "MainMenu.lua",
    "OptionsMenu.lua",
    "OSKMenu.lua",
    "SoundMenu.lua",
    "DisplayMenu.lua",
    "LoginScreen.lua",
    "WlanConfigsMenu.lua",
    "WlanLogin.lua"
  }
  requireC (Global.system.dir.main .. "Loading GUI.lc")
  local loading = Loading_GUI.new(
   SystemLoadingList,
   "Loading System Files..."
  )
  loading:update()

  for i=2,table.getn(SystemLoadingList) do
    requireC (Global.system.dir.main .. SystemLoadingList[i])
    loading:update()
  end

  loading = nil
  SystemLoadingList = nil
end

--[[ LOAD SFX ]]--
do
  local SFXList = {
    "Key Tone1.wav",
    "Logon.wav",
    "Logoff.wav",
    "NOTIFY.wav",
    "Battery Low.wav",
    "Battery Critical.wav"
  }
  
  local VarList = {
    "keytone",
    "logon",
    "logoff",
    "notify"
  }
  
  local loading = Loading_GUI.new(
    SFXList,
    "Loading Sounds..."
  )
  
  for i=1,table.getn(SFXList)-2 do
    Global.sfx.system[VarList[i]] = Sound.load(Global.system.dir.main .. Global.system.dir.sfx .. SFXList[i])
    loading:update()
  end

  Global.sfx.system.batt.low = Sound.load(Global.system.dir.main .. Global.system.dir.sfx .. "Battery Low.wav")
  loading:update()

  Global.sfx.system.batt.crit = Sound.load(Global.system.dir.main .. Global.system.dir.sfx .. "Battery Critical.wav")
  loading:update()

  loading = nil
  SFXList = nil
  VarList = nil
end

--[[ LOAD CHARACTERS ]]--
do
  local tmp_dir = System.listDirectory(Global.characters.dir)
  table.remove(tmp_dir,1)
  table.remove(tmp_dir,1)

  local tmp_ary = {}

  for i=1,table.getn(tmp_dir) do
    table.insert(tmp_ary,tmp_dir[i].name)
  end

  local loading = Loading_GUI.new(tmp_ary,"Loading Character Files...")

  local func,err

  for i=1,table.getn(tmp_dir) do
    func,err = loadfile(Global.characters.dir .. tmp_dir[i].name .. "/Data.char")
    
    if func then
      func()
      Global.characters.addChar(tmp_dir[i].name,Global.characters.dir)
      Global.characters.addChar = nil
    end
    
    loading:update()
  end

  loading = nil
  tmp_dir = nil
  tmp_ary = nil
  func = nil
  err = nil
end
Global.characters.addChar = nil

--[[ LOAD ARENAS ]]--
do
  local tmp_dir = System.listDirectory(Global.arenas.dir)
  table.remove(tmp_dir,1)
  table.remove(tmp_dir,1)

  local tmp_ary = {}

  for i=1,table.getn(tmp_dir) do
    table.insert(tmp_ary,tmp_dir[i].name)
  end

  local loading = Loading_GUI.new(tmp_ary,"Loading Arena Files...")

  local func,err

  for i=1,table.getn(tmp_dir) do
    func,err = loadfile(Global.arenas.dir .. tmp_dir[i].name .. "/Data.arn")
    if func then
      func()
      Global.arenas.addArena(tmp_dir[i].name,Global.arenas.dir)
      Global.arenas.addArena = nil
    end
    loading:update()
  end

  loading = nil
  tmp_dir = nil
  tmp_ary = nil
  func = nil
  err = nil
end
Global.arenas.addArena = nil

--[[ SETUP SYSTEM ]]--
do
  local loading = Loading_GUI.new(
    {
      "GFX",
      "Wlan",
      "OSK",
      "Sound"
    },
    "Setting Up System..."
  )
  --[[ Setup GFX ]]--                                                            (img,NumV,NumH,NumPetals,AnimSpdMin,AnimSpdMax,DCTMin,DCTMax)
  Global.system.petals = Petals.new(Global.system.dir.main .. Global.system.dir.img .. "SakuraSmall.png",2,4,10,50,100)    --15
  Global.system.counter = FPSCounter.new()
  Global.system.mouse.cursor = Mouse.new(Mouse.Images.arrow)
  Global.system.mouse.cursor:Pos(((screen:width()/2)-(Global.system.mouse.cursor:Image():width()/2)),((screen:height()/2)-(Global.system.mouse.cursor:Image():height()/2)))
  
  function Global.draw.s()
    Ctrl:Update()
    
    Global.draw.advancedClear(LightSkyBlue)
    
    screen:clear(LightSkyBlue)
    
    Gu.disable(Gu.DEPTH_TEST)
    
    Global.system.petals:Draw()
  end

  function Global.draw.e()
    Global.system.mouse.cursor:Draw()
    if Global.system.displayFPS then screen:print(2,2,"FPS: " .. Global.system.counter:update(),black) end
    screen.waitVblankStart()
    screen.flip()
    Global.system.mouse.cursor:Move(math.ceil(Ctrl:AX()/Global.system.mouse.spd),math.ceil(Ctrl:AY()/Global.system.mouse.spd))
  end
  
  function Global.system.buildTrigAreaList(menu)
    local list = {}
    local YY = 9

    for i=1,menu:numOptions() do
      table.insert(list,TrigArea.new(((screen:width()/2)-(menu:width()/2)),((screen:height()/2)-(menu:height()/2))+YY,menu:width(),9))
      YY = YY + 9
    end

    return list
  end

  function Global.system.getCursorFromTrigAreaList(list,mx,my,mhx,mhy)
    local cursor = 0
    for i=1,table.getn(list) do
      if list[i]:inArea(mx+mhx,my+mhy) then
        cursor = i
        break
      end
    end

    if Ctrl:Up1() then
      if Global.system.useKeyTone then Global.sfx.system.keytone:play() end
      if cursor == 1 or cursor == 0 then
        cursor = table.getn(list)
      else
        cursor = cursor - 1
      end
      local ta_pos_x,ta_pos_y = list[cursor]:Pos()
      local ta_size_w,ta_size_h = list[cursor]:Size()
      Global.system.mouse.cursor:Pos(ta_pos_x + ta_size_w/2,ta_pos_y + ta_size_h/2)
    elseif Ctrl:Down1() then
      if Global.system.useKeyTone then Global.sfx.system.keytone:play() end
      if cursor == table.getn(list) or cursor == 0 then
        cursor = 1
      else
        cursor = cursor + 1
      end
      local ta_pos_x,ta_pos_y = list[cursor]:Pos()
      local ta_size_w,ta_size_h = list[cursor]:Size()
      Global.system.mouse.cursor:Pos(ta_pos_x + ta_size_w/2,ta_pos_y + ta_size_h/2)
    end

    return cursor
  end
  loading:update()
  
  --[[ Setup WLAN ]]--
  Wlan.init()
  Global.wlan.configs = Wlan.getConnectionConfigs()
  Wlan.term()
  
  function Global.wlan.strip_header(str)
    local startIndex, endIndex = string.find(str, "\r\n\r\n")
    if endIndex then
      return string.sub(str, endIndex+1)
    end
    return str
  end
  loading:update()

  --[[ Setup OSK ]]--
  local osk_dir = System.listDirectory(Global.osk.dir)
  table.remove(osk_dir,1)
  table.remove(osk_dir,1)

  for i=1,table.getn(osk_dir) do
    table.insert (Global.osk.list,osk_dir[i].name)
  end
  table.insert (Global.osk.list,"Back")
  dofile(Global.osk.dir .. Global.osk.curr)
  loading:update()
  
  --[[ Setup Sound ]]--
  SoundSystem.SFXVolume(Global.system.vol.sfx)
  Music.volume(Global.system.vol.music)
  loading:update()

  loading = nil
end

--[[ Execute ]]--
math.randomseed(os.time())
LOGO()

LOGO = nil

--[[
do
  local TFTest = TextField2.new()
  
  TFTest:setText("TestTestTest")

  while not Ctrl:Start1() do
    Global.draw.s()
    TFTest:Draw(240-(TFTest:width()/2),136-(TFTest:height()/2),true)
    Global.draw.e()

    if Ctrl:LeftHold() or Ctrl:Left1() then
      TFTest:moveCursor("l")
    elseif Ctrl:RightHold() or Ctrl:Right1() then
      TFTest:moveCursor("r")
    elseif Ctrl:Up1() then
      TFTest:addChar("x")
    elseif Ctrl:Down1() then
      TFTest:removeChar()
    end
  end
end
]]--

--Global.system.petals:add(5)
MainMenu()
Wlan.term()