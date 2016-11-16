function Global.system.damageCalc(atk,acc,opDef,opEvd,opIsDefending)
  math.randomseed(os.time())
  atk = (((math.random(100) * acc)/100) * atk)  --/100
  
  if math.rand(1000) >= 900 then
    opDef = 0
  else
    opDef = (((math.random(100) * opEvd)/100) * opDef)/100

    if opIsDefending then
      opDef = opDef/math.rand(1,4)
    else
      opDef = opDef/math.rand(4,8)
    end
  end

  local dmg = math.ceil(atk - opDef)

  if dmg <= 0 then dmg = 1 end

  return dmg
end

function Global.system.specialDamageCalc(atk,acc,opDef,opEvd,element,opIsDefending)
  return Global.game.damageCalc(atk,acc,opDef,opEvd,opIsDefending) + math.ceil(element/4)
end