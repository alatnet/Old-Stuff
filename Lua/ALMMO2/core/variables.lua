--*************************************************************************************************
-- Angelic Layer MMO (ALMMO) Lua Game
-- Coded by by alatnet
--*************************************************************************************************

-- Global Variables
Game = {
  logo_skip = false;
  col = {
    clear = black,
    txt = lblue,
    sel = purple,
    music = {
      play = green,
      pause = yellow,
      stop = red
    },
    osk = {
      BgColor  = dgray,
      FgColor  = black,
      SelColor = Color.new(200,255,200)
    }
  },
  titlepos = {
    x = 2,
    y = 2
  },
  key_tone = {
    val = true,
    str = "On"
  },
  version = "1.0"
}

-- OSK Specific Variables
OSK = {
  dir = "osk",
  use = "TwinTail.LC",
  curr = 1,
  sel = nil,
  num = 0
}

-- Network Specific Variables
NET = {
  username = "",
  password = "",
  ip = nil,
  server_port = 13,
  auto_login = {
    val = false,
    str = "No",
    username = "",
    password = "",
  },
  error = {
    display = false,
    str = ""
  },
  connect = {
    sel = nil,
    curr = 1
  },
  databases = {
    login = "10.185.194.21",
    serverlist = "10.185.194.21"
  },
  servers = {
    sel = nil,
    curr = 1
  }
}

--[[  status = {
    curr = 1,
    sel = {
      "Disconnected",
      "Initilizing",
      "Connecting",
      "Sending/Recieving"
    }
  },]]--


-- Music Specific Variables
MUSIC = {
  dir = "music",
  sel = nil,
  num = 0,
  curr = 1,
  theme = {
    opening = "Be My Angel.xm",
    ending = "The Starry Sky.xm"
  },
  vol = 128,
  mode = 1,
  modes = {
    "Randomly",
    "Inorder"
  },
  stop = false,
  pause = false,
  time = {
    timer = Timer.new(),
    min = 0,
    sec = 0,
    str = ""
  }
}

-- Sound FX Specific Variables
SFX = {
  dir = "sfx",
  sel = nil,
  vol = 128,
  num = 0,
  snd = {
    punch1 = {
      file = "punch1.wav",
      val = nil
    },
    punch2 = {
      file = "punch2.wav",
      val = nil
    },
    key_tone = {
      file = "key tone3.wav",
      val = nil
    }
  }
}

-- Themes Specific Variables
THEMES = {
  dir = "COLORSET",
  sel = nil,
  num = nil,
  curr = 1,
  use = "DEFAULT.Scheme"
}

function unload_variables()
  Game = nil
  OSK = nil
  NET = nil
  MUSIC = nil
  SFX = nil
  THEMES = nil
end