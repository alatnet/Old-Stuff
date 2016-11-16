function Draw3D()
  Gu.start3d()  -- 3D Drawing Start

  -- clear screen
  Gu.clearDepth(0)
  Gu.clear(Gu.COLOR_BUFFER_BIT+Gu.DEPTH_BUFFER_BIT)

  -- setup projection and view matrices

  Gum.matrixMode(Gu.PROJECTION)
  Gum.loadIdentity()
  Gum.perspective(50, 16/9, 1, 1000)

  Gum.matrixMode(Gu.VIEW)
  Gum.loadIdentity()

--OBJECT-----------------------------------------------------------------------------
  if show.objectview=="on" then
    -- setup matrix for object
    Gum.matrixMode(Gu.MODEL)
    Gum.loadIdentity()
    Gum.translate(trans.x, trans.y, trans.z)
    Gum.rotateXYZ(rot.x*(Gu.PI/180),rot.y*(Gu.PI/180),rot.z*(Gu.PI/180))

    -- draw object without texture
    Gu.disable(Gu.TEXTURE_2D)
    Gum.drawArray(Gu.TRIANGLES, Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, object[show.objectindex])
  end

--WIREFRAME--------------------------------------------------------------------------
  if show.wireview=="on" then
    -- setup matrix for wireframe
    Gum.matrixMode(Gu.MODEL)
    Gum.loadIdentity()
    Gum.translate(trans.x, trans.y, trans.z)
    Gum.rotateXYZ(rot.x*(Gu.PI/180),rot.y*(Gu.PI/180),rot.z*(Gu.PI/180))

    -- draw wireframe without texture
    Gu.disable(Gu.TEXTURE_2D)
    Gum.drawArray(Gu.LINES, Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, wireframe[show.wireobject][show.wirelvl])
  end

--END POINTS--------------------------------------------------------------------------
  if show.endp=="on" and show.pointsview=="on" then
    -- setup matrix for end points
    Gum.matrixMode(Gu.MODEL)
    Gum.loadIdentity()
    Gum.translate(trans.x, trans.y, trans.z)
    Gum.rotateXYZ(rot.x*(Gu.PI/180),rot.y*(Gu.PI/180),rot.z*(Gu.PI/180))

    -- draw end points without texture
    Gu.disable(Gu.TEXTURE_2D)
    Gum.drawArray(Gu.POINTS, Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, points[show.pointsobject].endp)
  end

--EDGE POINTS------------------------------------------------------------------------
  if show.edgep=="on" and show.pointsview=="on" then
    -- setup matrix for edge points
    Gum.matrixMode(Gu.MODEL)
    Gum.loadIdentity()
    Gum.translate(trans.x, trans.y, trans.z)
    Gum.rotateXYZ(rot.x*(Gu.PI/180),rot.y*(Gu.PI/180),rot.z*(Gu.PI/180))

    -- draw edge points without texture
    Gu.disable(Gu.TEXTURE_2D)
    Gum.drawArray(Gu.POINTS, Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, points[show.pointsobject].edgep)
  end

--FACE POINTS------------------------------------------------------------------------
  if show.facep=="on" and show.pointsview=="on" then
    -- setup matrix for face points
    Gum.matrixMode(Gu.MODEL)
    Gum.loadIdentity()
    Gum.translate(trans.x, trans.y, trans.z)
    Gum.rotateXYZ(rot.x*(Gu.PI/180),rot.y*(Gu.PI/180),rot.z*(Gu.PI/180))

    -- draw face points without texture
    Gu.disable(Gu.TEXTURE_2D)
    Gum.drawArray(Gu.POINTS, Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, points[show.pointsobject].facep)
  end

--AXIS-------------------------------------------------------------------------------
  if show.axis=="on" then
    -- setup matrix for axis
    Gum.matrixMode(Gu.MODEL)
    Gum.loadIdentity()
    Gum.translate(trans.x, trans.y, trans.z)
    Gum.rotateXYZ(rot.x*(Gu.PI/180),rot.y*(Gu.PI/180),rot.z*(Gu.PI/180))

    -- draw axis without texture
    Gu.disable(Gu.TEXTURE_2D)
    Gum.drawArray(Gu.LINES, Gu.COLOR_8888+Gu.VERTEX_32BITF+Gu.TRANSFORM_3D, axis)
  end

  Gu.end3d()  -- 3D Drawing End
  
  if show.misc=="on" then
    --screen:print(x,y,txt,col.txt)
    screen:print(1,1,"Rotation X="..rot.x,col.txt)
    screen:print(1,9,"Rotation Y="..rot.y,col.txt)
    screen:print(1,17,"Rotation Z="..rot.z,col.txt)
    screen:print(1,25,"Translation Z="..trans.z,col.txt)
  end

  screen.waitVblankStart()
  screen.flip()
  screen:clear(col.clear)
end

function menuoption(xpos,ypos,txt,cursor,num_cursor_char,col,selcol,selcondition)
  screen:print(xpos,ypos,txt,col)
  if selcondition then
    screen:print(xpos-(8*num_cursor_char),ypos,cursor .. txt,selcol)
  end
end

function ShowMenu()
  local showmenutxtypos=txtysp
  local smenupos=0
  screen:clear(col.clear)
  while true do
    showmenutxtypos=txtysp
    --screen:print(x,y,txt,col.txt)
    menuoption(8,showmenutxtypos,"3D Object=" .. show.object,">",1,col.txt,col.txtsel,smenupos==0)
    showmenutxtypos=showmenutxtypos+txtysp
    menuoption(8,showmenutxtypos,"Wireframe=" .. show.wire,">",1,col.txt,col.txtsel,smenupos==1)
    showmenutxtypos=showmenutxtypos+txtysp
    menuoption(8,showmenutxtypos,"Points Object=" .. show.points,">",1,col.txt,col.txtsel,smenupos==2)
    showmenutxtypos=showmenutxtypos+txtysp
    menuoption(8,showmenutxtypos,"End Points=" .. show.endp,">",1,col.txt,col.txtsel,smenupos==3)
    showmenutxtypos=showmenutxtypos+txtysp
    menuoption(8,showmenutxtypos,"Edge Points=" .. show.edgep,">",1,col.txt,col.txtsel,smenupos==4)
    showmenutxtypos=showmenutxtypos+txtysp
    menuoption(8,showmenutxtypos,"Face Points=" .. show.facep,">",1,col.txt,col.txtsel,smenupos==5)
    showmenutxtypos=showmenutxtypos+txtysp
    menuoption(8,showmenutxtypos,"Axis=" .. show.axis,">",1,col.txt,col.txtsel,smenupos==6)
    showmenutxtypos=showmenutxtypos+txtysp
    menuoption(8,showmenutxtypos,"Misc=" .. show.misc,">",1,col.txt,col.txtsel,smenupos==7)
    showmenutxtypos=showmenutxtypos+txtysp
    menuoption(8,showmenutxtypos,"GO BACK",">",1,col.txt,col.txtsel,smenupos==8)

    if smenupos<0 then
      smenupos=8
    elseif smenupos>8 then
      smenupos=0
    end
    if UP1() then
      smenupos=smenupos-1
    elseif DOWN1() then
      smenupos=smenupos+1
    end

    if CROSS1() then
      if smenupos==0 then
        if show.objectview=="off" then
          show.objectview="on"
        else
          if show.objectindex==1 then
            show.objectindex=2
          elseif show.objectindex==2 then
            show.objectindex=3
          elseif show.objectindex==3 then
            show.objectindex=4
          elseif show.objectindex==4 then
            show.objectindex=1
            show.objectview="off"
          end
        end
      elseif smenupos==1 then
        if show.wireview=="off" then
          show.wireview="on"
          show.wireobject=1
          show.wirelvl=1
        else
          if show.wireobject==1 then
            if show.wirelvl==1 then
              show.wirelvl=2
            elseif show.wirelvl==2 then
              show.wirelvl=1
              show.wireobject=2
            end
          elseif show.wireobject==2 then
            show.wireobject=3
          elseif show.wireobject==3 then
            show.wireobject=4
          elseif show.wireobject==4 then
            if show.wirelvl==1 then
              show.wirelvl=2
            elseif show.wirelvl==2 then
              show.wirelvl=1
              show.wireview="off"
            end
          end
        end
      elseif smenupos==2 then
        if show.pointsview=="on" then
          if show.pointsobject==1 then
            show.pointsobject=2
          elseif show.pointsobject==2 then
            show.pointsobject=3
          elseif show.pointsobject==3 then
            show.pointsobject=4
          elseif show.pointsobject==4 then
            show.pointsobject=1
            show.pointsview="off"
          end
        else
          show.pointsview="on"
          show.pointsobject=1
        end
      elseif smenupos==3 then
        if show.endp=="on" then
          show.endp="off"
        else
          show.endp="on"
        end
      elseif smenupos==4 then
        if show.edgep=="on" then
          show.edgep="off"
        else
          show.edgep="on"
        end
      elseif smenupos==5 then
        if show.facep=="on" then
          show.facep="off"
        else
          show.facep="on"
        end
      elseif smenupos==6 then
        if show.axis=="on" then
          show.axis="off"
        else
          show.axis="on"
        end
      elseif smenupos==7 then
        if show.misc=="on" then
          show.misc="off"
        else
          show.misc="on"
        end
      elseif smenupos==8 then
        break
      end
    elseif CIRCLE1() or START1() then
      break
    end

    if show.objectview=="on" then
     if show.objectindex==1 then
        show.object="Cube"
      elseif show.objectindex==2 then
        show.object="Diamond"
      elseif show.objectindex==3 then
        show.object="Trimid"
      elseif show.objectindex==4 then
        show.object="Pyramid"
      end
    else
      show.object="off"
    end
    
    if show.wireview=="on" then
      if show.wireobject==1 then
        if show.wirelvl==1 then
          show.wire="Cube Squares"
        elseif show.wirelvl==2 then
          show.wire="Cube Triangles"
        end
      elseif show.wireobject==2 then
        show.wire="Diamond Triangles"
      elseif show.wireobject==3 then
        show.wire="Trimid Triangles"
      elseif show.wireobject==4 then
        if show.wirelvl==1 then
          show.wire="Pyramid Squares"
        elseif show.wirelvl==2 then
          show.wire="Pyramid Triangles"
        end
      end
    else
      show.wire="off"
    end
    
    if show.pointsview=="on" then
      if show.pointsobject==1 then
        show.points="Cube"
      elseif show.pointsobject==2 then
        show.points="Diamond"
      elseif show.pointsobject==3 then
        show.points="Trimid"
      elseif show.pointsobject==4 then
        show.points="Pyramid"
      end
    else
      show.points="off"
    end

--    screen.waitVblankStart()
    screen.flip()
    screen:clear(col.clear)
  end
end

function ColorMenu()
  local colmenutxtypos=txtysp
  local cmenupos=0
  screen:clear(col.clear)
  while true do
    colmenutxtypos=txtysp


    if cmenupos<0 then
      cmenupos=1
    elseif cmenupos>1 then
      cmenupos=0
    end

    if UP1() then
      cmenupos=cmenupos-1
    elseif DOWN1() then
      cmenupos=cmenupos+1
    end

    if CROSS1() then
    elseif CIRCLE1() or START1() then
      break
    end
--    screen.waitVblankStart()
    screen.flip()
    screen:clear(col.clear)
  end
end

function AutoSpin()
  local asmenutxtypos=txtysp
  local asmenupos=0
  screen:clear(col.clear)
  while true do
    asmenutxtypos=txtysp
    menuoption(8,asmenutxtypos,"AutoSpin=" .. autospin.status,">",1,col.txt,col.txtsel,asmenupos==0)
    asmenutxtypos=asmenutxtypos+txtysp
    menuoption(8,asmenutxtypos,"X Speed=" .. autospin.speed.x,">",1,col.txt,col.txtsel,asmenupos==1)
    asmenutxtypos=asmenutxtypos+txtysp
    menuoption(8,asmenutxtypos,"Y Speed=" .. autospin.speed.y,">",1,col.txt,col.txtsel,asmenupos==2)
    asmenutxtypos=asmenutxtypos+txtysp
    menuoption(8,asmenutxtypos,"Z Speed=" .. autospin.speed.z,">",1,col.txt,col.txtsel,asmenupos==3)
    
    if asmenupos<0 then
      asmenupos=3
    elseif asmenupos>3 then
      asmenupos=0
    end

    if UP1() then
      asmenupos=asmenupos-1
    elseif DOWN1() then
      asmenupos=asmenupos+1
    end

    if CROSS1() then
      if asmenupos==0 then
        if autospin.status=="off" then
          autospin.status="on"
        else
          autospin.status="off"
        end
      end
    elseif CIRCLE1() or START1() then
      break
    elseif LEFT1() then
      if asmenupos==1 then
        autospin.speed.x=autospin.speed.x-1
      elseif asmenupos==2 then
        autospin.speed.y=autospin.speed.y-1
      elseif asmenupos==3 then
        autospin.speed.z=autospin.speed.z-1
      end
    elseif RIGHT1() then
      if asmenupos==1 then
        autospin.speed.x=autospin.speed.x+1
      elseif asmenupos==2 then
        autospin.speed.y=autospin.speed.y+1
      elseif asmenupos==3 then
        autospin.speed.z=autospin.speed.z+1
      end
    end
--    screen.waitVblankStart()
    screen.flip()
    screen:clear(col.clear)
  end
end

function MainMenu()
  local menupos=0
  local mainmenutxtypos=txtysp
  screen:clear(col.clear)
  while true do
    mainmenutxtypos=txtysp
    --screen:print(x,y,txt,col.txt)
    menuoption(8,mainmenutxtypos,"Show",">",1,col.txt,col.txtsel,menupos==0)
    mainmenutxtypos=mainmenutxtypos+txtysp
    menuoption(8,mainmenutxtypos,"AutoSpin",">",1,col.txt,col.txtsel,menupos==1)
    mainmenutxtypos=mainmenutxtypos+txtysp
    menuoption(8,mainmenutxtypos,"EXIT MENU",">",1,col.txt,col.txtsel,menupos==2)
    mainmenutxtypos=mainmenutxtypos+txtysp
    menuoption(8,mainmenutxtypos,"QUIT PROGRAM",">",1,col.txt,col.txtsel,menupos==3)

    if UP1() then
      menupos=menupos-1
    elseif DOWN1() then
      menupos=menupos+1
    end

    if CROSS1() then
      if menupos==0 then
        ShowMenu()
      elseif menupos==1 then
        AutoSpin()
      elseif menupos==2 then
        return "EXIT"
      elseif menupos==3 then
        return "QUIT"
      end
    elseif CIRCLE1() or START1() then
      return "EXIT"
    end

    if menupos<0 then
      menupos=3
    elseif menupos>3 then
      menupos=0
    end

--    screen.waitVblankStart()
    screen.flip()
    screen:clear(col.clear)
  end
end

function Controls3D()
  AnalogY=Controls.read():analogY()
  AnalogX=Controls.read():analogX()

  if autospin.status=="on" then
    rot.x=rot.x+autospin.speed.x
    rot.y=rot.y+autospin.speed.y
    rot.z=rot.z+autospin.speed.z
  else
    if UP() then
      rot.x=rot.x-1
    end
    if DOWN() then
      rot.x=rot.x+1
    end

    if LEFT() then
      rot.y=rot.y-1
    end
    if RIGHT() then
      rot.y=rot.y+1
    end

    if LTRIG() then
    rot.z=rot.z-1
    end
    if RTRIG() then
      rot.z=rot.z+1
    end

--Stick Y Pos------------------------------------------------------------------------
    if AnalogY>=20 and AnalogY<99 then
      rot.x=rot.x+3
    end
    if AnalogY>=99 and AnalogY<=127 then
      rot.x=rot.x+6
    end

--Stick Y Neg------------------------------------------------------------------------
    if AnalogY<=-21 and AnalogY>-100 then
      rot.x=rot.x-3
    end
    if AnalogY<=-100 and AnalogY>=-128 then
      rot.x=rot.x-6
    end

--Stick X Pos------------------------------------------------------------------------
    if AnalogX>=20 and AnalogX<99 then
      rot.y=rot.y+3
    end
    if AnalogX>=99 and AnalogX<=127 then
      rot.y=rot.y+6
    end

--Stick X Neg------------------------------------------------------------------------
    if AnalogX<=-21 and AnalogX>-100 then
    rot.y=rot.y-3
    end
    if AnalogX<=-100 and AnalogX>=-128 then
      rot.y=rot.y-6
    end
  end
  if TRIANGLE1() then
    trans.z=trans.z+1
  end
  if CROSS1() then
    trans.z=trans.z-1
  end
  if SELECT1() then
    screen:save(screenshotnum .. ".png")
    while not START1() do
      screen:print(8,8,"SCREENSCHOT SAVED AS: " .. screenshotnum .. ".png",col.txt)
      screen:print(8,16,"Press Start to continue.",col.txt)
      screen.waitVblankStart()
      screen.flip()
      screen:clear(col.clear)
    end
    screenshotnum=screenshotnum+1
  end
end

function Rotation_Check()
 if rot.x>=360 then
     rot.x=0
  end
  if rot.x<=-1 then
     rot.x=359
  end
  if rot.y>=360 then
     rot.y=0
  end
  if rot.y<=-1 then
     rot.y=359
  end
  if rot.z>=360 then
     rot.z=0
  end
  if rot.z<=-1 then
     rot.z=359
  end
end