red = Color.new(255, 0, 0)
green = Color.new(0, 255, 0)
blue = Color.new(0, 0, 255)
black = Color.new(0, 0, 0)
white = Color.new(255, 255, 255)
cyan = Color.new(100, 255, 255)
yellow = Color.new(255,255,0)
lblue = Color.new(0,255,255)
purple = Color.new(255,0,255)
gray = Color.new(64, 64, 64)
orange = Color.new(255,128,64)

col={
  clear=white,
  txt=black,
  txtsel=yellow,
  wf=black,
  axis={x=red,y=green,z=blue},
  object={
    {--[CUBE COLORS START]
      front=blue,
      back=yellow,
      left=red,
      right=green,
      top=orange,
      bottom=purple,
      endp=red,
      edgep=green,
      facep=yellow
    },--[CUBE COLORS END]
    {--[DIAMOND COLORS START]
      front_top=blue,
      front_bottom=orange,
      back_top=yellow,
      back_bottom=purple,
      left_top=red,
      left_bottom=cyan,
      right_top=green,
      right_bottom=lblue,
      endp=red,
      edgep=green,
      facep=yellow
    },--[DIAMOND COLORS END]
    {--[TRIMID COLORS START]
      triangle1=blue,
      triangle2=red,
      triangle3=green,
      triangle4=yellow,
      endp=red,
      edgep=green,
      facep=yellow
    },--[TRIMID COLORS END]
    {--[PYRAMID COLORS START]
      front=blue,
      back=yellow,
      left=red,
      right=green,
      bottom=purple,
      endp=red,
      edgep=green,
      facep=yellow
    }--[PYRAMID COLORS START]
  }
}