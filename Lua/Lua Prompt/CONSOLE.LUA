requireC "pad.lc"
requireC "osk/TwinTail.lc"
requireC "FPSCounter.lua"
--dofile "pad.lc"
--dofile "osk/TwinTail.lc"

Console = {
  commands = {
    {txt = "help", fn = "", help = "Display help", dhelp = {"Provides help information for Lua Prompt commands.","","HELP [command]","","    command - displays help information on that command."}}
  , {txt = "exit", fn = "", help = "Quits the Lua Prompt", dhelp = {"Quits the Lua Prompt."}}
  , {txt = "cls", fn = "", help = "Clears the screen", dhelp = {"Clears the screen."}}
  , {txt = "dir", fn = "", help = "Displays a list of files and subdirectories in a directory", dhelp = {"Displays a list of files and subdirectories in a directory.","","DIR [path]","","  [path]    Specifies directory to list."}}
  , {txt = "ls", fn = "", help = "Displays a list of files and subdirectories in a directory", dhelp = {"Displays a list of files and subdirectories in a directory.","","DIR [path]","","  [path]    Specifies directory to list."}}
  , {txt = "logout", fn = "", help = "Quits the Lua Prompt", dhelp = {"Quits the Lua Prompt."}}
  , {txt = "quit", fn = "", help = "Quits the Lua Prompt", dhelp = {"Quits the Lua Prompt."}}
  , {txt = "clear", fn = "", help = "Clears the screen", dhelp = {"Clears the screen."}}
  , {txt = "cd", fn = "", help = "Displays the name of or changes the current directory", dhelp = {"Displays the name of or changes the current directory.","","CHDIR [path]","CHDIR [..]","CD [path]","CD [..]","","  ..   Specifies that you want to change to the parent directory."}}
  , {txt = "chdir", fn = "", help = "Displays the name of or changes the current directory", dhelp = {"Displays the name of or changes the current directory.","","CHDIR [path]","CHDIR [..]","CD [path]","CD [..]","","  ..   Specifies that you want to change to the parent directory."}}
  , {txt = "lua", fn = "", help = "Executes a Lua File", dhelp = {"Executes a Lua File.","","Version: " .. string.sub(_VERSION,5),"","usage: lua [script]."}}
  , {txt = "color", fn = "", help = "Sets the default console foreground and background colors", dhelp = {"Sets the default console foreground and background colors.","","COLOR [attr]","","  attr        Specifies color attribute of console output","","Color attributes are specified by TWO hex digits -- the first","corresponds to the background; the second the foreground.  Each digit","can be any of the following values:","","    0 = Black       8 = Gray","    1 = Blue        9 = Light Blue","    2 = Green       A = Light Green","    3 = Aqua        B = Light Aqua","    4 = Red         C = Light Red","    5 = Purple      D = Light Purple","    6 = Yellow      E = Light Yellow","    7 = White       F = Bright White","","If no argument is given, this command restores the color to what it was","when Lua Prompt.  This value comes from the current console window.","","The COLOR command does nothing if an attempt is made to execute","the COLOR command with a foreground and background color that are the","same.","","Example: \"COLOR fc\" produces light red on bright white"}}
  , {txt = "ver", fn = "", help = "Displays the Lua Prompt version", dhelp = {"Displays the Lua Prompt version."}}
  , {txt = "time", fn = "", help = "Displays the system time", dhelp = {"Displays the system time."}}
  , {txt = "date", fn = "", help = "Displays the date", dhelp = {"Displays the date."}}
  , {txt = "osk", fn = "", help = "Displays the current OSK and lists other OSK's", dhelp = {"Displays the current OSK and lists other OSK's.","","usage: osk [num]","","    num - Use OSK assined to the number corresponding to it."}}
  , {txt = "echo", fn = "", help = "Displays messages", dhelp = {"Displays messages.","","  ECHO [message]"}}
  , {txt = "md", fn = "", help = "Creates a directory", dhelp = {"Creates a directory.","","MKDIR name","MD name"}}
  , {txt = "mkdir", fn = "", help = "Creates a directory", dhelp = {"Creates a directory.","","MKDIR name","MD name"}}
  , {txt = "cmd", fn = "", help = "Starts a new instance of Lua Prompt", dhelp = {"Starts a new instance of Lua Prompt."}}
  , {txt = "title", fn = "", help = "Sets the window title for the lua prompt window", dhelp = {"Sets the window title for the lua prompt window.","","TITLE [string]","","  string       Specifies the title for the lua prompt window."}}
--  , {txt = "rename", fn = "", help = "Renames a file or files.", dhelp = {"Renames a file or files.","","RENAME filename1 filename2.","REN filename1 filename2.","","Note that you cannot specify a path for your source or destination file."}}
--  , {txt = "ren", fn = "", help = "Renames a file or files.", dhelp = {"Renames a file or files.","","RENAME filename1 filename2.","REN filename1 filename2.","","Note that you cannot specify a path for your source or destination file."}}
--  , {txt = "", fn = "", help = "", dhelp = {}}
  },
  commands_dir = "bin",
  osk_dir = "OSK",
  osk_lst = {},
  osk_curr = 0,
  blink_spd = 300,
  orig_col = {
    BG = Color.new(0,0,0),
    FG = Color.new(256,256,256)
  },
  ORIG_DIR = System.currentDirectory(),
  VERSION = "0.2a",
  lua_ver = string.sub(_VERSION,5),
  USB = false,
  osk = Osk.new(),
  oskActive = false,
  b_timer = Timer.new(),
  blink = true,
  orig_title = "Lua Prompt",
  instance_num = 0
}

function Console.new(img)
  img = img or screen

  local c = setmetatable(
    {
      X = 0,
      Y = 8,
      SCR = img,
      Buff = {},
      curr_ln = 1,
      s_ln = 1,
      e_ln = 1,
      lns = 32,
      d_ln = 1,
      input = "",
      DIR = System.currentDirectory(),
      Prev_Input = {""},
      Prev_Input_Num = 1,
      GlobalState = {},
      LoadedState = {},
      SCROLLING = false,
      col = {
        BG = Color.new(0,0,0),
        FG = Color.new(256,256,256)
      },
      title="Lua Prompt",
      fps = FPSCounter.new()
    },
    {
      __index = Console
    }
  )
  
  for Key, Value in pairs(_G) do
    c.GlobalState[Key] = Value
  end
  if _LOADED ~= nil then
    for Key, Value in pairs(_LOADED) do
      c.LoadedState[Key] = Value
    end
  end
  
  c.b_timer:start()
  Console.instance_num = Console.instance_num+1

  return c
end

function Console:EXE(args)
  for i=1,table.getn(self.commands) do
    if self.commands[i].txt == args[1] then
      local fln = self.ORIG_DIR .. "/" .. self.commands_dir .. "/" .. self.commands[i].fn
      local func, err = loadfile(fln)
      if not func then
        self:println("Error Running Command:")
        self:println(" " .. err)
      else
        dofile(fln)
        return CmdFunc(self, args)
      end
    end
  end

  return "\'".. args[1] .."\' is not recognized as an internal or external command."
end

function Console:ParseInput()
  local arguments = {}
  local txt = ""
  local DQ = false

  for i=1,string.len(self.input) do
    if string.sub(self.input, i, i) == " " and not DQ then
      table.insert(arguments,txt)
      txt = ""
    elseif string.sub(self.input, i, i) == "\"" then
      if DQ then
        DQ = false
      else
        DQ = true
      end
    else
      txt = txt .. string.sub(self.input, i, i)
    end
  end

  table.insert(arguments,txt)
  table.insert(arguments,nil)

  return arguments
end

function Console:LoadCommands()
  local Sel = System.listDirectory(self.commands_dir)
  table.remove(Sel,1)
  table.remove(Sel,1)

  for idx,file in Sel do
    if file.directory then
      --table.insert(self.commands, "/" .. file.name)
    else
      local dot = 0

      for i=string.len(file.name),1,-1 do
        if string.sub(file.name, i, i) == "." then
          dot = i
          break
        end
      end

      local ext = string.lower(string.sub(file.name, dot+1))

      if ext == "lua" or ext == "lc" or ext == "lpc" then
        table.insert(self.commands, {txt = string.lower(string.sub(file.name, 1, dot-1)),fn = file.name,help = ""})
        dofile(self.commands_dir .. "/" .. file.name)
        CmdHelp(self)
      end
    end
  end

  local SortProc = function(a, b)
    return a.txt < b.txt
  end
  table.sort(self.commands, SortProc)
end

function Console:LoadOSK()
  local Sel = System.listDirectory(self.osk_dir)
  table.remove(Sel,1)
  table.remove(Sel,1)

  for idx,file in Sel do
    if file.directory then
      --table.insert(self.commands, "/" .. file.name)
    else
      local dot = 0

      for i=string.len(file.name),1,-1 do
        if string.sub(file.name, i, i) == "." then
          dot = i
          break
        end
      end

      local ext = string.lower(string.sub(file.name, dot+1))
      
      if string.lower(file.name) == "twintail.lc" then
        self.osk_curr = idx
      end

      if ext == "lua" or ext == "lc" then
        table.insert(self.osk_lst, {txt = string.sub(file.name, 1, dot-1),fn = file.name})
      end
    end
  end

  local SortProc = function(a, b)
    return a.txt < b.txt
  end
  table.sort(self.commands, SortProc)
end

function Console:SaveState()
  for Key, Value in pairs(_G) do
    self.GlobalState[Key] = Value
  end
  if _LOADED ~= nil then
    for Key, Value in pairs(_LOADED) do
      self.LoadedState[Key] = Value
    end
  end
end

function Console:RestoreState()
  _LOADED = {}
  for Key, Value in pairs(_G) do
    if Value ~= _G then
      _G[Key] = self.GlobalState[Key]
    end
  end
  for Key, Value in pairs(self.LoadedState) do
    _LOADED[Key] = Value
  end
  collectgarbage()
end

function Console:ExecLua(file)
  self:SaveState()
  local result,err = loadfile(System.currentDirectory() .. "/" .. file)
  if not result then
    self:println("Compile error:")
    self:println(" " .. err)
  else
    local OrgDir = System.currentDirectory()
    _LOADED = {}
    result, err = pcall(result)
    System.currentDirectory(OrgDir)
    self:RestoreState()
    if not result then
      self:println("Runtime error:")
      self:println(" " .. err)
    else
      self.USB = false
      System.usbDiskModeDeactivate()
      self:println("")
    end
  end
end

function Console:println(txt)
  table.insert (self.Buff,txt)
  self.curr_ln = self.curr_ln + 1
  self.d_ln = self.d_ln + 1
end

function Console:print(txt)
  self.Buff[self.curr_ln] = self.Buff[self.curr_ln] .. txt
end

function Console:StoreCommand()
  table.insert (self.Prev_Input,self.input)
  self.Prev_Input_Num = table.getn(self.Prev_Input)
end


--[[  Internal Commands Start  ]]--
function Console:Help(command)
  if command == nil then
    self:println("For more information on a specific command, type HELP command-name")

    for i=1,table.getn(self.commands) do
      self:println(self.commands[i].txt .. " - " .. self.commands[i].help)
    end
  else
    for i=1,table.getn(self.commands) do
      if self.commands[i].txt == command then
        for i2=1,table.getn(self.commands[i].dhelp) do
          self:println(self.commands[i].dhelp[i2])
        end
      end
    end
  end
  
  self:println("")
end

function Console:CLS()
  self.Buff = {}
  self.curr_ln = 0
  self.s_ln = 1
  self.e_ln = self.lns
  self.d_ln = -1
end

function Console:date()
  local time = os.time()

  local dateFields = os.date("*t", time)
  
  local Month = dateFields.month
  local Day = dateFields.day
  local Year = dateFields.year

  self:print("The current date is: " .. Month .. " " .. Day .. ", " .. Year)
  self:println("")
end

function Console:time()
  local time = os.time()
  local dateFields = os.date("*t", time)

  local hour = dateFields.hour
  if hour > 12 then
    hour = hour - 12
  end
  if hour < 10 then
    hour = "0" .. hour
  end
  
  local min = dateFields.min
  if min < 10 then
    min = "0" .. min
  end
  
  local sec = dateFields.sec
  if sec < 10 then
    sec = "0" .. sec
  end
  self:println("The current time is: " .. hour .. ":" .. min .. ":" .. sec)
  self:println("")
end

function Console:color(attr)
  if attr == nil or string.len(attr) ~= 2 then
    self.col.BG = self.orig_col.BG
    self.col.FG = self.orig_col.FG
    return
  end

  local BG = string.lower(string.sub(attr, 1, 1))
  local FG = string.lower(string.sub(attr, 2, 2))
  
  if BG == FG then return end

  if BG == "0" then
    self.col.BG = Color.new(0, 0, 0)
  elseif BG == "1" then
    self.col.BG = Color.new(0, 0, 128)
  elseif BG == "2" then
    self.col.BG = Color.new(0, 128, 0)
  elseif BG == "3" then
    self.col.BG = Color.new(0,128,128)
  elseif BG == "4" then
    self.col.BG = Color.new(128, 0, 0)
  elseif BG == "5" then
    self.col.BG = Color.new(128,0,128)
  elseif BG == "6" then
    self.col.BG = Color.new(128,128,0)
  elseif BG == "7" then
    self.col.BG = Color.new(192, 192, 192)
  elseif BG == "8" then
    self.col.BG = Color.new(128, 128, 128)
  elseif BG == "9" then
    self.col.BG = Color.new(0,0,256)
  elseif BG == "a" then
    self.col.BG = Color.new(0,256,0)
  elseif BG == "b" then
    self.col.BG = Color.new(0,256,256)
  elseif BG == "c" then
    self.col.BG = Color.new(256,0,0)
  elseif BG == "d" then
    self.col.BG = Color.new(256,0,256)
  elseif BG == "e" then
    self.col.BG = Color.new(256,256,0)
  elseif BG == "f" then
    self.col.BG = Color.new(256,256,256)
  end
  
  if FG == "0" then
    self.col.FG = Color.new(0, 0, 0)
  elseif FG == "1" then
    self.col.FG = Color.new(0, 0, 128)
  elseif FG == "2" then
    self.col.FG = Color.new(0, 128, 0)
  elseif FG == "3" then
    self.col.FG = Color.new(0,128,128)
  elseif FG == "4" then
    self.col.FG = Color.new(128, 0, 0)
  elseif FG == "5" then
    self.col.FG = Color.new(128,0,128)
  elseif FG == "6" then
    self.col.FG = Color.new(128,128,0)
  elseif FG == "7" then
    self.col.FG = Color.new(192, 192, 192)
  elseif FG == "8" then
    self.col.FG = Color.new(128, 128, 128)
  elseif FG == "9" then
    self.col.FG = Color.new(0,0,256)
  elseif FG == "a" then
    self.col.FG = Color.new(0,256,0)
  elseif FG == "b" then
    self.col.FG = Color.new(0,256,256)
  elseif FG == "c" then
    self.col.FG = Color.new(256,0,0)
  elseif FG == "d" then
    self.col.FG = Color.new(256,0,256)
  elseif FG == "e" then
    self.col.FG = Color.new(256,256,0)
  elseif FG == "f" then
    self.col.FG = Color.new(256,256,256)
  end
end

function Console:VER()
  self:println("")
  self:println("Lua Based Command Prompt \[Version " .. self.VERSION .. "\]")
  self:println("")
end

function Console:OSK(num)
  if num == nil then
    self:println("Using: " .. self.osk_lst[self.osk_curr].txt)
    self:println("")
    for i=1,table.getn(self.osk_lst) do
      self:println(i .. ": " .. self.osk_lst[i].txt)
    end
    self:println("")
  else
    dofile(System.currentDirectory() .. "/" .. self.osk_dir .. "/" .. self.osk_lst[tonumber(num)].fn)
  end
end

--[[
function Console:Rename(old,new)
  if old == nil or new == nil then
    self:println("The syntax of the command is incorrect.")
    return
  else
    System.rename(old, new)
  end
  self:println("")
end
]]--

function Console:MKDIR(name)
  if name == nil then
    self:println("The syntax of the command is incorrect.")
    return
  else
    System.createDirectory(name)
  end
end

--[[
function Console:DEL(names)
  if table.getn(names) == nil then
    self:println("The syntax of the command is incorrect.")
    return
  else
    System.removeFile(name)
  end
end 
]]--

function Console:LoadF(name)
  if name == nil then return end
  if name == ""  then return end
  for Data in io.lines(name) do
    local l = string.len(Data)
    local ln = 1
    for i=1, l do
      local c = string.sub(Data, i, i)
      if c == "\r" then
        c = ""
      elseif c == "\t" then
        c = "  "
      elseif c == "\"" then
        c = "\""
      end
      if i == 60 * ln then
        self:println(c)
        ln = ln + 1
      else
        self:print(c)
      end
    end
    self:println("")
  end
end
--[[  Internal Commands End  ]]--

function Console:NewLn()
  self:print(self.input)
  local args = {}

  if self.input ~= "" then
    self:StoreCommand()
    args = self:ParseInput()

    if args[1] == "cls" or args[1] == "clear" then
      self:CLS()
    elseif args[1] == "date" then
      self:date()
    elseif args[1] == "time" then
      self:time()
    elseif args[1] == "exit" or args[1] == "logout" or args[1] == "quit" then
      return "exit"
    elseif args[1] == "ms0:" then
      System.currentDirectory("ms0:/")
      self.DIR = System.currentDirectory()
      self:println("")
    else --execute command
      if args[1] == "help" then
        self:Help(args[2])
      elseif args[1] == "osk" then
        self:OSK(args[2])
      elseif args[1] == "dir" or args[1] == "ls" then
        if args[2] == nil then
          local DIRDIR = System.listDirectory()

          local SortProc = function(a, b)
            if a.directory == b.directory then return a.name < b.name end
            return a.directory
          end
          table.sort(DIRDIR, SortProc)

          for index, file in DIRDIR do
            if not file.directory then
              self:println(file.name)
            else
              self:println(file.name .. "/")
            end
          end
          self:println("")
        else
          local DIRDIR = System.listDirectory(System.currentDirectory() .. "/" .. args[2])

          local SortProc = function(a, b)
            if a.directory == b.directory then return a.name < b.name end
            return a.directory
          end
          table.sort(DIRDIR, SortProc)

          for index, file in DIRDIR do
            if not file.directory then
              self:println(file.name)
            else
              self:println(file.name .. "/")
            end
          end
          self:println("")
        end
      elseif args[1] == "cd" or args[1] == "chdir" then
        if args[2] == nil then
          self:println(System.currentDirectory())
        elseif args[2] == "ms0:/" then
          System.currentDirectory("ms0:/")
          self.DIR = System.currentDirectory()
        else
          System.currentDirectory(System.currentDirectory() .. "/" .. args[2])
          self.DIR = System.currentDirectory()
        end
      elseif args[1] == "lua" then
        if args[2] == nil then
          self:println("The syntax of the command is incorrect.")
        else
          self:ExecLua(args[1])
          self:RestoreState()
        end
      elseif args[1] == "color" then
        self:color(args[2])
      elseif args[1] == "echo" then
        for i=2,table.getn(args) do
          self:print(args[i] .. " ")
        end
      elseif args[1] == "ver" then
        self:VER()
--      elseif args[1] == "rename" or args[1] == "ren" then
--        self:Rename(args[2],args[3])
      elseif args[1] == "md" or args[1] == "mkdir" then
        self:MKDIR(args[2])
      elseif args[1] == "cmd" then
        local CMD = self.new()
        CMD:Init()
      elseif args[1] == "title" then
        self.title = ""
        if args[2] ~= nil then
          for i=2,table.getn(args)-1 do
            self.title = self.title .. args[i] .. " "
          end
        end
      elseif args[1] == "load" then
        self:LoadF(args[2])
      else
        local ret = self:EXE(args)
        if ret ~= nil then
          self:println(ret)
        end
      end

      self:println("")
    end
  end

  self.input = ""
  self:println(self.DIR .. ">")

  return ""
end

function Console:DrawBuff()
  if not self.SCROLLING then
    if (((string.len(self.Buff[self.curr_ln]..self.input)*8)+8)+self.X) > self.SCR:width() then self.X = self.X - 8 end
    if (((string.len(self.Buff[self.curr_ln]..self.input)*8)+8)+self.X) < self.SCR:width() and self.X ~= 0 then self.X = self.X + 8 end
  end

  print_array(self.X-8,self.Y,self.col.FG,self.Buff,self.s_ln,self.e_ln,self.SCR)

  textinput((string.len(self.Buff[self.curr_ln])*8)+self.X,(self.d_ln*8)+self.Y,self.input,"_",self.col.FG,true,self.blink,self.SCR)

  if self.b_timer:time() >= self.blink_spd then
    self.b_timer:reset()
    self.b_timer:start()
    if self.blink then
      self.blink = false
    else
      self.blink = true
    end
  end

  if not self.SCROLLING then
    if self.curr_ln > self.e_ln then
      self.s_ln = self.s_ln + self.lns
      self.e_ln = self.e_ln + self.lns
      self.d_ln = self.d_ln - self.lns
    end
  end
end

function Console:DrawInfoBar()
  local xpos = 0
  local ypos = self.SCR:height()-8
  local strUSB = ""
  local strBATT = ""
  
  local pwrOnline = System.powerIsPowerOnline()
  local BattExist = System.powerIsBatteryExist()
  local BattCharg = System.powerIsBatteryCharging()
  local LowBatt = System.powerIsLowBattery()

  if BattExist then
    if pwrOnline then
      if BattCharg then
        strBATT = "Chargeing"
      else
        strBATT = "External"
      end
    elseif LowBatt then
      strBATT = "LOW BATTERY!  " .. System.powerGetBatteryLifePercent() .. "%"
    else
      strBATT = System.powerGetBatteryLifePercent() .. "%"
    end
  elseif pwrOnline then
    strBATT = "External"
  end

  self.SCR:fillRect(xpos, ypos, screen:width(), 8, self.col.FG)
  self.SCR:print(xpos+1, ypos,"Power: " .. strBATT .. "    lines: " .. table.getn(self.Buff), self.col.BG)

  if self.SCROLLING then
    self.SCR:print(screen:width()-8, ypos,"S", self.col.BG)
  end

  if self.USB then
    self.SCR:print(screen:width()-16, ypos,"U", self.col.BG)
  end
end

function Console:DrawTitleBar()
  local xpos = 0
  local ypos = 0

  self.SCR:fillRect(xpos, ypos, screen:width(), 8, self.col.FG)
  self.SCR:print(xpos+1, ypos,self.instance_num .. ": " .. self.title, self.col.BG)
end

function Console:Draw()
  self:DrawBuff() 
  self:DrawInfoBar()
  self:DrawTitleBar()
end

function Console:Disp()
  if not self.oskActive and not self.SCROLLING then
    if up1() then
      self.Prev_Input_Num = self.Prev_Input_Num - 1
      if self.Prev_Input_Num == 0 then
        self.Prev_Input_Num = 1
      end
      self.input = self.Prev_Input[self.Prev_Input_Num]
    elseif down1() then
      self.Prev_Input_Num = self.Prev_Input_Num + 1
      if self.Prev_Input_Num == table.getn(self.Prev_Input)+1 then
        self.Prev_Input_Num = table.getn(self.Prev_Input)
      end
      self.input = self.Prev_Input[self.Prev_Input_Num]
    end
    
    if cross1() then
      if self:NewLn() == "exit" then return "exit" end
    end
  end
  
  if triangle1() and not self.oskActive then
    if self.USB then
      self.USB = false
      System.usbDiskModeDeactivate()
    else
      self.USB = true
      System.usbDiskModeActivate()
    end
  end

  if self.SCROLLING then
    if up() then
      if self.s_ln ~= 1 then
        self.s_ln = self.s_ln - 1
        self.e_ln = self.e_ln - 1
        self.d_ln = self.d_ln + 1
      end
    end
    if down() then
      if self.d_ln ~= 0 then
        self.s_ln = self.s_ln + 1
        self.e_ln = self.e_ln + 1
        self.d_ln = self.d_ln - 1
      end
    end
    if right() then
      self.X = self.X - 8
    end
    if left() then
      if self.X ~= 0 then self.X = self.X + 8 end
    end
    
    if AX() >= 100 then
      self.X = self.X - 16
    elseif AX() <= -99 then
      if self.X ~= 0 then self.X = self.X + 16 end
      if self.X > 0 then self.X = 0 end
    end
    
    if AY() >= 100 then
      if self.d_ln ~= 0 then
        self.s_ln = self.s_ln + 2
        self.e_ln = self.e_ln + 2
        self.d_ln = self.d_ln - 2
      end
    elseif AY() <= -99 then
      if self.s_ln ~= 1 then
        self.s_ln = self.s_ln - 2
        self.e_ln = self.e_ln - 2
        self.d_ln = self.d_ln + 2
      end
      
      if self.s_ln <= 0 then
        self.s_ln = self.s_ln + 1
        self.e_ln = self.e_ln + 1
        self.d_ln = self.d_ln - 1
      end
    end
    
    --[[
    self.X = self.X + AX(30)
    if self.X > 0 then self.X = 0 end
    
    if self.d_ln ~= 0 then
      local YY = AY(40)
      self.s_ln = self.s_ln + YY
      self.e_ln = self.e_ln + YY
      self.d_ln = self.d_ln - YY
    end
    if self.s_ln <= 0 then
      self.s_ln = self.s_ln + 1
      self.e_ln = self.e_ln + 1
      self.d_ln = self.d_ln - 1
    end
    ]]--
  end

  if not self.oskActive then
    if square1() then
      if self.SCROLLING then
        self.SCROLLING = false
      else
        self.SCROLLING = true
      end
    end
  end
  
  self:Draw()

  --[[ OSK ]]--
  Pad:Update()
  if not self.oskActive and not self.SCROLLING then
    if Pad.tR1 then
      self.oskActive = true
      self.osk = Osk.new()
    end
  end

  if self.oskActive then
    local In, cont = self.osk:Update()
    local new_ln = false
    local TXT = ""
    local YYY = 0
    
    if self.d_ln >= 8 then
      YYY = 0
    else
      YYY = self.SCR:height()-40
    end

    self.osk:Draw(self.SCR:width()-72,YYY,self.SCR)
    self.input,new_ln = Osk_textinput(In,self.input)

    if new_ln then
      if self:NewLn() == "exit" then return "exit" end
    end

    if not cont then self.oskActive = false end
  end

  return ""
end

function Console:flip()
  local fps = self.fps:update()
  screen:print(screen:width() - (string.len(fps)*8), 0, fps, self.col.BG)
  
  screen.waitVblankStart()
  screen:flip()
end

function Console:Load()
  self:LoadCommands()
  self:LoadOSK()
end

function Console:Init()
  self.Buff = {
    "Lua Based Command Prompt \[Version " .. self.VERSION .. "\]",
    "  Lua Version: " .. self.lua_ver,
    "",
    self.DIR .. ">"
  }

  self.curr_ln = table.getn(self.Buff)
  self.s_ln = 1
  self.e_ln = self.lns
  self.d_ln = self.curr_ln-1

  while not start1() do
    self.SCR:clear(self.col.BG)
    if self:Disp() == "exit" then break end
    self:flip()
  end
  Console.instance_num = Console.instance_num-1
end


--[[ MAIN ROUTINE ]]--
do
  System.usbDiskModeDeactivate()
  local CONSOLE = Console.new()
  CONSOLE:Load()
  CONSOLE:Init()
end