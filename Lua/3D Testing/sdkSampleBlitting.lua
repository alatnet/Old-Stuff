function simpleBlit(sx,sy,sw,sh,dx,dy)
  local verts = {
    {sx,sy,dx,dy,0},
    {sx+sw,sy+sh,dx+sw,dy+sh,0}
  }
  Gum.drawArray(Gu.SPRITES,Gu.TEXTURE_16BIT+GU_VERTEX_16BIT+GU_TRANSFORM_2D,verts)
end

function advancedBlit(sx,sy,sw,sh,dx,dy,slice)
  local Start = sx
  local End = sx+sw
  local Dx = dx
  local Width

  while Start<End do
    if (Start+slice)<End then
      Width=slice
    else
      Width=End-Start
    end
    
    local verts = {
      {Start,sy,Dx,dy,0},
      {Start+Width,sy+sh,Dx+Width,dy+sh,0}
    }
    
    Gum.drawArray(Gu.SPRITES,Gu.TEXTURE_16BIT+GU_VERTEX_16BIT+GU_TRANSFORM_2D,verts)

    Start=Start+slice
    Dx=Dx+slice
  end
end