function logo()
  for i=1, MUSIC.num do
    if string.lower (MUSIC.sel[i].name) == string.lower ("the_raising_fighting_spirit.xm") then  --"REWRITE.XM"
      MUSIC.curr = i
      break
    end
  end

  local IMG = {
    logo = {
      img = nil,
      x = 0,
      y = 0
    },
    logo_fade = {
      img = nil,
      x = 0,
      y = 0
    }
  }
  
  local ALPHA = {
    logo_fade = {
      val = 256,
      step = 4
    }
  }
  
  local FADE = {
    logo = "in",
  }
  
  local GUNDAM_W = {
    frame = {
      max = 6,
      curr = 1,
      x = 0,
      y = 0
    },
    width = 77,
    height = 104,
    x = -77,
    y = screen:height() - 104,
    anim = "P",
    speed = {
      W = {
        x = 5,
        y = 0
      },
      C = {
        x = 6,
        y = 0
      }
    },
    img = {
      W = nil,
      C = nil,
      S = nil
    }
  }

  IMG.logo.img = Image.load("logo/logo.png")
  IMG.logo_fade.img = Image.createEmpty(IMG.logo.img:width(),IMG.logo.img:height())
  GUNDAM_W.img.C = Image.load("logo/Gundam_Charge.png")
  GUNDAM_W.img.W = Image.load("logo/Gundam_Walk_Anim.png")
  GUNDAM_W.img.S = Image.load("logo/Gundam_Stand_Anim.png")

  IMG.logo.x = 0
  IMG.logo.y = screen:height()/2 - IMG.logo.img:height()/2
  IMG.logo_fade.x = IMG.logo.x
  IMG.logo_fade.y = IMG.logo.y

  local timer = Timer.new()
  local anim_timer = Timer.new()
  local interval = 1
  local anim_interval = 110
  local count = 0
  local count_max = 11
  local count_step = 1

  timer:start()
  if not Game.logo_skip then
    Music.playFile(MUSIC.dir .. "/" .. MUSIC.sel[MUSIC.curr].name, false)
    MUSIC.time.timer:start()
  end

  while not Game.logo_skip do
    screen:clear(white)
    IMG.logo_fade.img:clear(Color.new(256,256,256,ALPHA.logo_fade.val))
    screen:blit(IMG.logo.x,IMG.logo.y,IMG.logo.img)
    screen:blit(IMG.logo_fade.x,IMG.logo_fade.y,IMG.logo_fade.img)
    if GUNDAM_W.anim == "W" then
      screen:blit(GUNDAM_W.x, GUNDAM_W.y, GUNDAM_W.img.W, GUNDAM_W.frame.x, GUNDAM_W.frame.y, GUNDAM_W.width, GUNDAM_W.height)
    elseif GUNDAM_W.anim == "C" then
      screen:blit(GUNDAM_W.x, GUNDAM_W.y, GUNDAM_W.img.C, GUNDAM_W.frame.x, GUNDAM_W.frame.y, GUNDAM_W.width, GUNDAM_W.height)
    elseif GUNDAM_W.anim == "S" then
      screen:blit(GUNDAM_W.x, GUNDAM_W.y, GUNDAM_W.img.S, GUNDAM_W.frame.x, GUNDAM_W.frame.y, GUNDAM_W.width, GUNDAM_W.height)
    end
    screen.waitVblankStart()
    screen:flip()
    System.powerTick()

    if timer:time() >= interval then
      timer:reset()
      timer:start()
      if FADE.logo == "in" then ALPHA.logo_fade.val = ALPHA.logo_fade.val - ALPHA.logo_fade.step end
      if FADE.logo == "out" then ALPHA.logo_fade.val = ALPHA.logo_fade.val + ALPHA.logo_fade.step end
      if ALPHA.logo_fade.val <= -1 then
        ALPHA.logo_fade.val = 0
        FADE.logo = "pause"
        GUNDAM_W.anim = "W"
        anim_timer:start()
        timer:stop()
      end
      if ALPHA.logo_fade.val >= 257 then
        ALPHA.logo_fade.val = 256
        break
      end
    end

    if anim_timer:time() >= anim_interval then
      anim_timer:reset()
      anim_timer:start()

      if GUNDAM_W.anim == "W" then
        GUNDAM_W.frame.curr = GUNDAM_W.frame.curr + 1

        if GUNDAM_W.frame.curr > GUNDAM_W.frame.max then
          GUNDAM_W.frame.curr = 1
        end

        GUNDAM_W.frame.x = GUNDAM_W.width * (GUNDAM_W.frame.curr-1)
        GUNDAM_W.frame.y = 0

        if GUNDAM_W.x >= 35 then
          GUNDAM_W.anim = "S"
          GUNDAM_W.frame.x = 0
          GUNDAM_W.frame.y = 0
          GUNDAM_W.width = GUNDAM_W.img.S:width()/2
          GUNDAM_W.height = GUNDAM_W.img.S:height()
          GUNDAM_W.y = screen:height() - GUNDAM_W.height
          GUNDAM_W.frame.max = 2
          GUNDAM_W.frame.curr = 1
          anim_interval = 500
        end

        GUNDAM_W.x = GUNDAM_W.x + GUNDAM_W.speed.W.x
      elseif GUNDAM_W.anim == "S" then
        GUNDAM_W.frame.curr = GUNDAM_W.frame.curr + 1

        if GUNDAM_W.frame.curr > GUNDAM_W.frame.max then
          GUNDAM_W.frame.curr = 1
        end

        GUNDAM_W.frame.x = GUNDAM_W.width * (GUNDAM_W.frame.curr-1)
        GUNDAM_W.frame.y = 0

        count = count + count_step
        if count == count_max then
          GUNDAM_W.anim = "C"
          GUNDAM_W.frame.x = 0
          GUNDAM_W.frame.y = 0
          GUNDAM_W.width = GUNDAM_W.img.C:width()
          GUNDAM_W.height = GUNDAM_W.img.C:height()
          GUNDAM_W.y = screen:height() - GUNDAM_W.height
          anim_interval = 12
        end
      elseif GUNDAM_W.anim == "C" then
        GUNDAM_W.x = GUNDAM_W.x + GUNDAM_W.speed.C.x
        if GUNDAM_W.x >= screen:width() then
          GUNDAM_W.anim = "P"
          FADE.logo = "out"
          anim_timer:stop()
          timer:reset()
          timer:start()
        end
      end
    end
    if start1() then
      Game.logo_skip = true
      break
    end
  end
  timer:stop()
  IMG = nil
  ALPHA = nil
  FADE = nil
  GUNDAM_W = nil
end

logo()