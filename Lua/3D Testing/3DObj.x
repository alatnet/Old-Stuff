Axis = {
  {Color.new(255,0,0),-15,0,0},
  {Color.new(255,0,0),15,0,0},
  {Color.new(0,255,0),0,-15,0},
  {Color.new(0,255,0),0,15,0},
  {Color.new(0,0,255),0,0,-15},
  {Color.new(0,0,255),0,0,15}
}

sW = screen:width()/2
sH = screen:height()/2

Screen_Boarder = {
  {Color.new(0,0,0),-sW,-sH,0},
  {Color.new(0,0,0),sW,-sH,0},

  {Color.new(0,0,0),-sW,sH,0},
  {Color.new(0,0,0),sW,sH,0},

  {Color.new(0,0,0),-sW,-sH,0},
  {Color.new(0,0,0),-sW,sH,0},

  {Color.new(0,0,0),sW,-sH,0},
  {Color.new(0,0,0),sW,sH,0},
-----------------------------------------------
  {Color.new(255,0,0),-sW-1,-sH-1,0},
  {Color.new(255,0,0),sW+1,-sH-1,0},

  {Color.new(255,0,0),-sW-1,sH+1,0},
  {Color.new(255,0,0),sW+1,sH+1,0},

  {Color.new(255,0,0),-sW-1,-sH-1,0},
  {Color.new(255,0,0),-sW-1,sH+1,0},

  {Color.new(255,0,0),sW+1,-sH-1,0},
  {Color.new(255,0,0),sW+1,sH-1,0},
-----------------------------------------------
  {Color.new(0,255,0),-sW+1,-sH+1,0},
  {Color.new(0,255,0),sW-1,-sH+1,0},

  {Color.new(0,255,0),-sW+1,sH-1,0},
  {Color.new(0,255,0),sW-1,sH-1,0},

  {Color.new(0,255,0),-sW+1,-sH+1,0},
  {Color.new(0,255,0),-sW+1,sH-1,0},

  {Color.new(0,255,0),sW-1,-sH+1,0},
  {Color.new(0,255,0),sW-1,sH-1,0}
}

Cube_Col = {  --Color.new(r,g,b,a)
  front = Color.new(160,0,0),
  back = Color.new(0,160,0),
  left = Color.new(0,0,160),
  right = Color.new(160,160,0),
  top = Color.new(160,0,160),
  bottom = Color.new(0,160,160)
}

Cube = {--[CUBE 3D SOLID START]
  --front
  --(Square 1 Triangle 1)
  {Cube_Col.front,-10,10,10},
  {Cube_Col.front,10,10,10},
  {Cube_Col.front,-10,-10,10},

  --(Square 1 Triangle 2)
  {Cube_Col.front,10,-10,10},
  {Cube_Col.front,-10,-10,10},
  {Cube_Col.front,10,10,10},
  --=====================
  --left
  --(Square 2 Triangle 1)
  {Cube_Col.left,-10,10,-10},
  {Cube_Col.left,-10,10,10},
  {Cube_Col.left,-10,-10,-10},

  --(Square 2 Triangle 2)
  {Cube_Col.left,-10,-10,10},
  {Cube_Col.left,-10,-10,-10},
  {Cube_Col.left,-10,10,10},
  --=====================
  --right
  --(Square 3 Triangle 1)
  {Cube_Col.right,10,10,10},
  {Cube_Col.right,10,10,-10},
  {Cube_Col.right,10,-10,10},

  --(Square 3 Triangle 2)
  {Cube_Col.right,10,-10,-10},
  {Cube_Col.right,10,-10,10},
  {Cube_Col.right,10,10,-10},
  --=====================
  --back
  --(Square 4 Triangle 1)
  {Cube_Col.back,10,10,-10},
  {Cube_Col.back,-10,10,-10},
  {Cube_Col.back,10,-10,-10},

  --(Square 4 Triangle 2)
  {Cube_Col.back,-10,-10,-10},
  {Cube_Col.back,10,-10,-10},
  {Cube_Col.back,-10,10,-10},
  --=====================
  --top
  --(Square 5 Triangle 1)
  {Cube_Col.top,-10,10,-10},
  {Cube_Col.top,10,10,-10},
  {Cube_Col.top,-10,10,10},

  --(Square 5 Triangle 2)
  {Cube_Col.top,10,10,10},
  {Cube_Col.top,-10,10,10},
  {Cube_Col.top,10,10,-10},
  --=====================
  --bottom
  --(Square 6 Triangle 1)
  {Cube_Col.bottom,-10,-10,10},
  {Cube_Col.bottom,10,-10,10},
  {Cube_Col.bottom,-10,-10,-10},

  --(Square 6 Triangle 2)
  {Cube_Col.bottom,10,-10,-10},
  {Cube_Col.bottom,-10,-10,-10},
  {Cube_Col.bottom,10,-10,10}
}