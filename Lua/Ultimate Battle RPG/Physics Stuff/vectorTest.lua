dofile ("Vector3D.lc")

v1 = Vector3D.new(1,1,1)
v2 = Vector3D.new(2,2,2)
v3 = Vector3D.new(3,3,3)

f = Vector3D.new(1,0,0)

print("V1 = " .. v1:tostring())
print("V2 = " .. v2:tostring())
print("V3 = " .. v3:tostring())

print("F = " .. f:tostring())

print("V1 + V2 = " .. Vector3D.tostring(v1+v2))
print("V3 + F = " .. Vector3D.tostring(v3+f))
print("V1 + 4 = " .. Vector3D.tostring(v1+4))