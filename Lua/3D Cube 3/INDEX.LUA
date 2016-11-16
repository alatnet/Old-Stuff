dofile "COLORS.LUA"
screen:clear(col.clear)
dofile "controls.lua"
dofile "3DObj.x"
dofile "functions.lua"

screenshotnum=1

rot={
  x=0,
  y=0,
  z=0
}

autospin={
  status="off",
  speed={
    x=1,
    y=1,
    z=1
  }
}

trans={
  x=0,
  y=0,
  z=-10
}

show={
  object="Cube",
  objectview="on",
  objectindex=1,
  wire="off",
  wireview="off",
  wireobject=1,
  wirelvl=1,
  points="off",
  pointsview="off",
  pointsobject=1,
  endp="off",
  edgep="off",
  facep="off",
  axis="off",
  misc="off"
}

axis={
  {col.axis.y,0,-5,0},
  {col.axis.y,0,5,0},
  {col.axis.x,-5,0,0},
  {col.axis.x,5,0,0},
  {col.axis.z,0,0,-5},
  {col.axis.z,0,0,5},
}

txtxsp=8
txtysp=8

while true do
  Draw3D()
  Controls3D()
  Rotation_Check()
  if START1() then
    if MainMenu()=="QUIT" then
      break
    end
  end
end

screen:clear()
object=nil
Box01=nil
Logo=nil
wireframe=nil
points=nil