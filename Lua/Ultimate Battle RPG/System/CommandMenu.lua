requireC(Global.system.dir.main .. "MENU.lua")

CommandMenu = {
  COMMAND = 1,
  SPECIALS = 2,
  PROJECTILES = 3,
  ITEMS = 4
}

Command = {
  ATTACK = 1,
  SPECIALS = 2,
  PROJECTILES = 3,
  ITEMS = 4,
  SLOT1 = 1,
  SLOT2 = 2,
  SLOT3 = 3,
  SLOT4 = 4
}

function CommandMenu.new(specials,projectiles,items)
  specials = specials or {"        ","        ","        ","        "}
  projectiles = projectiles or {"           ","           ","           ","           "}
  items = items or {"     ","     ","     ","     "}
  
  local c = setmetatable(
    {
      menus = {
        MENU.new({"Attack","Specials","Projectiles","Items"},"Command",">",false),
        MENU.new(specials,"Specials",">",false),
        MENU.new(projectiles,"Projectiles",">",false),
        MENU.new(items,"Items",">",false)
      },
      SPECIALS = specials,
      ITEMS = items,
      PROJECTILES = projectiles,
      curr = 1
    },
    {
      __index = CommandMenu
    }
  )

  return c
end

function CommandMenu:Remove(menu,slot)
  if menu == CommandMenu.SPECIALS then
    self.SPECIALS[slot] = "        "
    self.menus[self.curr]:Update(self.SPECIALS)
  elseif menu == CommandMenu.PROJECTILES then
    self.PROJECTILES[slot] = "           "
    self.menus[self.curr]:Update(self.PROJECTILES)
  elseif menu == CommandMenu.ITEMS then
    self.ITEMS[slot] = "     "
    self.menus[self.curr]:Update(self.ITEMS)
  end
end

function CommandMenu:Update(menu,slot,val)
  if menu == CommandMenu.SPECIALS then
    self.SPECIALS[slot] = val
    self.menus[self.curr]:Update(self.SPECIALS)
  elseif menu == CommandMenu.PROJECTILES then
    self.PROJECTILES[slot] = val
    self.menus[self.curr]:Update(self.PROJECTILES)
  elseif menu == CommandMenu.ITEMS then
    self.ITEMS[slot] = val
    self.menus[self.curr]:Update(self.ITEMS)
  end
end

function CommandMenu:ChangeMenu(menu)
  self.menus[self.curr]:ResetCursorPos()
  self.curr = menu
end

function CommandMenu:width()
  return self.menus[self.curr]:width()
end

function CommandMenu:height()
  return self.menus[self.curr]:height()
end

function CommandMenu:numCommands()
  return self.menus[self.curr]:numOptions()
end

function CommandMenu:moveCursor(direction)
  return self.menus[self.curr]:moveCursor(direction)
end

function CommandMenu:CurrCommand()
  return self.menus[self.curr]:CursorPos()
end

function CommandMenu:draw(x,y,s)
  s = s or screen
  
  self.menus[self.curr]:Draw(x,y,nil,s)
end