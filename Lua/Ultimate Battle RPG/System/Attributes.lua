Attributes = {
  TYPE1 = {
    HP = 1,
    SP = 2,
    NORM = 3,
    SPECIAL = 4,
    ELEMENT = 5
  },
  TYPE2 = {
    ATK = 1,
    DEF = 2,
    ACC = 3,
    EVD = 4,
    FIRE = 1,
    WATER = 2,
    WIND = 3,
    EARTH = 4,
    THUNDER = 5,
    LIGHT = 6,
    DARK = 7
  }
}

function Attributes:toString()
  return "Attributes:\n" .. "-HP" .. self.ATTRIBUTES[1] .. "\n" .. "-SP" .. self.ATTRIBUTES[2] .. "\n" .. "-Norm:\n" .. "--ATK" .. self.ATTRIBUTES[3][1] .. "\n" .. "--DEF" .. self.ATTRIBUTES[3][2] .. "\n" .. "--ACC" .. self.ATTRIBUTES[3][3] .. "\n" .. "--EVD" .. self.ATTRIBUTES[3][4] .. "\n" .. "-Special:\n" .. "--ATK" .. self.ATTRIBUTES[4][1] .. "\n" .. "--DEF" .. self.ATTRIBUTES[4][2] .. "\n" .. "--ACC" .. self.ATTRIBUTES[4][3] .. "\n" .. "--EVD" .. self.ATTRIBUTES[4][4] .. "\n" .. "-Element:\n" .. "--FIRE" .. self.ATTRIBUTES[5][1] .. "\n" .. "--WATER" .. self.ATTRIBUTES[5][2] .. "\n" .. "--WIND" .. self.ATTRIBUTES[5][3] .. "\n" .. "--EARTH" .. self.ATTRIBUTES[5][4] .. "\n" .. "--THUNDER" .. self.ATTRIBUTES[5][5] .. "\n" .. "--LIGHT" .. self.ATTRIBUTES[5][6] .. "\n" .. "--DARK" .. self.ATTRIBUTES[5][7] .. "\n"
end

function Attributes.new(hp,sp,atk,def,acc,evd,satk,sdef,sacc,sevd,fire,water,wind,earth,thunder,light,dark)
  hp = hp or 0
  sp = sp or 0
  atk = atk or 0
  def = def or 0
  acc = acc or 0
  evd = evd or 0
  satk = satk or 0
  sdef = sdef or 0
  sacc = sacc or 0
  sevd = sevd or 0
  fire = fire or 0
  water = water or 0
  wind = wind or 0
  earth = earth or 0
  thunder = thunder or 0
  light = light or 0
  dark = dark or 0

  local c = setmetatable(
    {
      ATTRIBUTES = {
        hp,   -- HP
        sp,   -- SP
        {    -- NORM
          atk,  -- ATK
          def,  -- DEF
          acc,  -- ACC
          evd   -- EVD
        },
        {    -- SPECIAL
          satk,  -- ATK
          sdef,  -- DEF
          sacc,  -- ACC
          sevd   -- EVD
        },
        {    -- ELEMENT
          fire,  -- FIRE
          water,  -- WATER
          wind,  -- WIND
          earth,  -- EARTH
          thunder,  -- THUNDER
          light,  -- LIGHT
          dark   -- DARK
        }
      }
    },
    {
      __index = Attributes,
      __tostring = Attributes["toString"]
    }
  )

  return c
end

function Attributes:getAttribute(type1,type2)
  type1 = type1 or 1
  type2 = type2 or -1

  if type2 == -1 then
    return self.ATTRIBUTES[type1]
  else
    return self.ATTRIBUTES[type1][type2]
  end
end

function Attributes:setAttribute(val,type1,type2)
  type1 = type1 or 1
  type2 = type2 or -1

  if type2 == -1 then
    self.ATTRIBUTES[type1] = val
  else
    self.ATTRIBUTES[type1][type2] = val
  end
end