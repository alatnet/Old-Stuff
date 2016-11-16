--[[ Define Colors ]]--
___COLOR1___ = Color.new(255, 255, 255, 255)
___COLOR2___ = Color.new(255, 255, 255, 128)

blueGrey = Color.new(215, 227, 227, 150)
grey = Color.new(214, 217, 217, 150)
lightGrey = Color.new(233, 233, 233, 250)
lightBlue = Color.new(222, 239, 243, 250)

___COLOR3___ = Color.new(255, 167, 192, 255)
___COLOR4___ = Color.new(213, 106, 136, 255)

brightOrange = Color.new(248, 88, 0, 255)
orangeBrown = Color.new(144, 80, 56, 255)
burntRed = Color.new(152, 0, 0, 255)
paleOrange = Color.new(232, 160, 128, 255)
darkBrown = Color.new(72, 40, 0, 255)

darkGreen = Color.new(62, 76, 31, 255)
midGreen = Color.new(76, 91, 43, 255)
khaki = Color.new(105, 114, 66, 255)
lightGreen = Color.new(128, 136, 88, 255)
mint = Color.new(146, 154, 106, 255)

brightRed = Color.new(255, 0, 0, 255)
midRed = Color.new(179, 17, 17, 255)
darkRed = Color.new(141, 9, 9, 255)

white = Color.new(255, 255, 255, 255)

lightBlue = Color.new(181, 244, 255, 255)
midBlue = Color.new(126, 197, 235, 255)
darkBlue = Color.new(77, 136, 225, 255)

--[[ Create Empty Images ]]--
RAIN = Image.createEmpty(7, 56)
STORM = Image.createEmpty(34, 64)
SNOW = Image.createEmpty(6, 6)
HAIL = Image.createEmpty(4, 4)
PETAL = Image.createEmpty(4, 4)
BLOOD_RAIN = Image.createEmpty(7, 56)
AUTUM_LEAF = {
  [1] = Image.createEmpty(8, 8),
  [2] = Image.createEmpty(8, 8),
  [3] = Image.createEmpty(8, 8),
  [4] = Image.createEmpty(8, 8)
}
GREEN_LEAF = {
  [1] = Image.createEmpty(8, 8),
  [2] = Image.createEmpty(8, 8),
  [3] = Image.createEmpty(8, 8),
  [4] = Image.createEmpty(8, 8),
  [5] = Image.createEmpty(8, 8),
  [6] = Image.createEmpty(8, 8),
  [7] = Image.createEmpty(8, 8),
  [8] = Image.createEmpty(8, 8),
  [9] = Image.createEmpty(8, 8),
  [10] = Image.createEmpty(8, 8),
  [11] = Image.createEmpty(8, 8),
  [12] = Image.createEmpty(8, 8),
  [13] = Image.createEmpty(8, 8)
}
ROSE = {
  [1] = Image.createEmpty(3, 3),
  [2] = Image.createEmpty(3, 3)
}
FEATHER = {
  [1] = Image.createEmpty(3, 3),
  [2] = Image.createEmpty(3, 3),
  [3] = Image.createEmpty(3, 3),
  [4] = Image.createEmpty(3, 3)
}
SPARKLE = {
  [1] = Image.createEmpty(7, 7),
  [2] = Image.createEmpty(7, 7),
  [3] = Image.createEmpty(7, 7),
  [4] = Image.createEmpty(7, 7),
  [5] = Image.createEmpty(7, 7),
  [6] = Image.createEmpty(7, 7),
  [7] = Image.createEmpty(7, 7)
}

--[[ Clear Images to transparant white ]]--
RAIN:clear(Color.new(256,256,256,0))
STORM:clear(Color.new(256,256,256,0))
SNOW:clear(Color.new(256,256,256,0))
HAIL:clear(Color.new(256,256,256,0))
PETAL:clear(Color.new(256,256,256,0))
BLOOD_RAIN:clear(Color.new(256,256,256,0))
for i=1,table.getn(AUTUM_LEAF) do
  AUTUM_LEAF[i]:clear(Color.new(256,256,256,0))
end
for i=1,table.getn(GREEN_LEAF) do
  GREEN_LEAF[i]:clear(Color.new(256,256,256,0))
end
for i=1,table.getn(ROSE) do
  ROSE[i]:clear(Color.new(256,256,256,0))
end
for i=1,table.getn(FEATHER) do
  FEATHER[i]:clear(Color.new(256,256,256,0))
end
for i=1,table.getn(SPARKLE) do
  SPARKLE[i]:clear(Color.new(256,256,256,0))
end

--[[ Draw Images ]]--
--RAIN--
for i=1,6 do
  --fillrect(RAIN, 6-i, i*8, 1, 8,  ___COLOR1___)
  RAIN:fillRect(6-i, i*8, 1, 8, ___COLOR1___)
end

--STORM--
for i=1,31 do
  STORM:fillRect(33-i, i*2, 1, 2, ___COLOR2___)
  STORM:fillRect(32-i, i*2, 1, 2, ___COLOR1___)
  STORM:fillRect(31-i, i*2, 1, 2, ___COLOR2___)
  --fillrect(STORM,33-i, i*2, 1, 2, ___COLOR2___)
  --fillrect(STORM,32-i, i*2, 1, 2, ___COLOR1___)
  --fillrect(STORM,31-i, i*2, 1, 2, ___COLOR2___)
end

--SNOW--
SNOW:fillRect(0, 1, 6, 4, ___COLOR2___)
SNOW:fillRect(1, 0, 4, 6, ___COLOR2___)
SNOW:fillRect(1, 2, 4, 2, ___COLOR1___)
SNOW:fillRect(2, 1, 2, 4, ___COLOR1___)
--fillrect(SNOW,0, 1, 6, 4, ___COLOR2___)
--fillrect(SNOW,1, 0, 4, 6, ___COLOR2___)
--fillrect(SNOW,1, 2, 4, 2, ___COLOR1___)
--fillrect(SNOW,2, 1, 2, 4, ___COLOR1___)

--HAIL--
HAIL:fillRect(1, 0, 2, 1, blueGrey)
HAIL:fillRect(0, 1, 1, 2, blueGrey)
HAIL:fillRect(3, 1, 1, 2, grey)
HAIL:fillRect(1, 3, 2, 1, grey)
HAIL:fillRect(1, 1, 2, 2, lightGrey)
--fillrect(HAIL,1, 0, 2, 1, blueGrey)
--fillrect(HAIL,0, 1, 1, 2, blueGrey)
--fillrect(HAIL,3, 1, 1, 2, grey)
--fillrect(HAIL,1, 3, 2, 1, grey)
--fillrect(HAIL,1, 1, 2, 2, lightGrey)
HAIL:pixel(1, 1, lightBlue)

--PETAL--
PETAL:fillRect(0, 3, 1, 1, ___COLOR3___)
PETAL:fillRect(1, 2, 1, 1, ___COLOR3___)
PETAL:fillRect(2, 1, 1, 1, ___COLOR3___)
PETAL:fillRect(3, 0, 1, 1, ___COLOR3___)
PETAL:fillRect(1, 3, 1, 1, ___COLOR4___)
PETAL:fillRect(2, 2, 1, 1, ___COLOR4___)
PETAL:fillRect(3, 1, 1, 1, ___COLOR4___)
--fillrect(PETAL,0, 3, 1, 1, ___COLOR3___)
--fillrect(PETAL,1, 2, 1, 1, ___COLOR3___)
--fillrect(PETAL,2, 1, 1, 1, ___COLOR3___)
--fillrect(PETAL,3, 0, 1, 1, ___COLOR3___)
--fillrect(PETAL,1, 3, 1, 1, ___COLOR4___)
--fillrect(PETAL,2, 2, 1, 1, ___COLOR4___)
--fillrect(PETAL,3, 1, 1, 1, ___COLOR4___)

--BLOOD RAIN--
for i=1,6 do
  BLOOD_RAIN:fillRect(6-i, i*8, 1, 8, darkRed)
  --fillrect(BLOOD_RAIN,6-i, i*8, 1, 8, darkRed)
end

--AUTUM LEAF--
--{1}--
AUTUM_LEAF[1]:pixel(5, 1, orangeBrown)
AUTUM_LEAF[1]:pixel(6, 1, brightOrange)
AUTUM_LEAF[1]:pixel(7, 1, paleOrange)
AUTUM_LEAF[1]:pixel(3, 2, orangeBrown)
AUTUM_LEAF[1]:fillRect(4, 2, 2, 1, brightOrange)
--fillrect(AUTUM_LEAF[1],4, 2, 2, 1, brightOrange)
AUTUM_LEAF[1]:pixel(6, 2, paleOrange)
AUTUM_LEAF[1]:pixel(2, 3, orangeBrown)
AUTUM_LEAF[1]:pixel(3, 3, brightOrange)
AUTUM_LEAF[1]:fillRect(4, 3, 2, 1, paleOrange)
--fillrect(AUTUM_LEAF[1],4, 3, 2, 1, paleOrange)
AUTUM_LEAF[1]:pixel(1, 4, orangeBrown)
AUTUM_LEAF[1]:pixel(2, 4, brightOrange)
AUTUM_LEAF[1]:pixel(3, 4, paleOrange)
AUTUM_LEAF[1]:pixel(1, 5, brightOrange)
AUTUM_LEAF[1]:pixel(2, 5, paleOrange)
AUTUM_LEAF[1]:pixel(0, 6, orangeBrown)
AUTUM_LEAF[1]:pixel(1, 6, paleOrange)
AUTUM_LEAF[1]:pixel(0, 7, paleOrange)

--{2}--
AUTUM_LEAF[2]:pixel(3, 0, brightOrange)
AUTUM_LEAF[2]:pixel(7, 0, brightOrange)
AUTUM_LEAF[2]:pixel(3, 1, orangeBrown)
AUTUM_LEAF[2]:pixel(4, 1, burntRed)
AUTUM_LEAF[2]:pixel(6, 1, brightOrange)
AUTUM_LEAF[2]:pixel(0, 2, paleOrange)
AUTUM_LEAF[2]:pixel(1, 2, brightOrange)
AUTUM_LEAF[2]:pixel(2, 2, orangeBrown)
AUTUM_LEAF[2]:pixel(3, 2, burntRed)
AUTUM_LEAF[2]:pixel(4, 2, orangeBrown)
AUTUM_LEAF[2]:pixel(5, 2, brightOrange)
AUTUM_LEAF[2]:fillRect(1, 3, 3, 1, orangeBrown)
AUTUM_LEAF[2]:fillRect(4, 3, 2, 1, brightOrange)
--fillrect(AUTUM_LEAF[2],1, 3, 3, 1, orangeBrown)
--fillrect(AUTUM_LEAF[2],4, 3, 2, 1, brightOrange)
AUTUM_LEAF[2]:pixel(6, 3, orangeBrown)
AUTUM_LEAF[2]:pixel(2, 4, burntRed)
AUTUM_LEAF[2]:fillRect(3, 4, 3, 1, brightOrange)
--fillrect(AUTUM_LEAF[2],3, 4, 3, 1, brightOrange)
AUTUM_LEAF[2]:pixel(6, 4, burntRed)
AUTUM_LEAF[2]:pixel(7, 4, darkBrown)
AUTUM_LEAF[2]:pixel(1, 5, orangeBrown)
AUTUM_LEAF[2]:fillRect(2, 5, 2, 1, brightOrange)
--fillrect(AUTUM_LEAF[2],2, 5, 2, 1, brightOrange)
AUTUM_LEAF[2]:pixel(4, 5, orangeBrown)
AUTUM_LEAF[2]:pixel(5, 5, burntRed)
AUTUM_LEAF[2]:fillRect(1, 6, 2, 1, brightOrange)
AUTUM_LEAF[2]:fillRect(4, 6, 2, 1, burntRed)
--fillrect(AUTUM_LEAF[2],1, 6, 2, 1, brightOrange)
--fillrect(AUTUM_LEAF[2],4, 6, 2, 1, burntRed)
AUTUM_LEAF[2]:pixel(0, 7, brightOrange)
AUTUM_LEAF[2]:pixel(5, 7, darkBrown)

--{3}--
AUTUM_LEAF[3]:pixel(7, 1, paleOrange)
AUTUM_LEAF[3]:pixel(6, 2, paleOrange)
AUTUM_LEAF[3]:pixel(7, 2, orangeBrown)
AUTUM_LEAF[3]:pixel(5, 3, paleOrange)
AUTUM_LEAF[3]:pixel(6, 3, brightOrange)
AUTUM_LEAF[3]:pixel(4, 4, paleOrange)
AUTUM_LEAF[3]:pixel(5, 4, brightOrange)
AUTUM_LEAF[3]:pixel(6, 4, orangeBrown)
AUTUM_LEAF[3]:fillRect(2, 5, 2, 1, paleOrange)
--fillrect(AUTUM_LEAF[3],2, 5, 2, 1, paleOrange)
AUTUM_LEAF[3]:pixel(4, 5, brightOrange)
AUTUM_LEAF[3]:pixel(5, 5, orangeBrown)
AUTUM_LEAF[3]:pixel(1, 6, paleOrange)
AUTUM_LEAF[3]:fillRect(2, 6, 2, 1, brightOrange)
--fillrect(AUTUM_LEAF[3],2, 6, 2, 1, brightOrange)
AUTUM_LEAF[3]:pixel(4, 6, orangeBrown)
AUTUM_LEAF[3]:pixel(0, 7, paleOrange)
AUTUM_LEAF[3]:pixel(1, 7, brightOrange)
AUTUM_LEAF[3]:pixel(2, 7, orangeBrown)

--{4}--
AUTUM_LEAF[4]:pixel(3, 0, brightOrange)
AUTUM_LEAF[4]:pixel(7, 0, brightOrange)
AUTUM_LEAF[4]:pixel(3, 1, orangeBrown)
AUTUM_LEAF[4]:pixel(4, 1, burntRed)
AUTUM_LEAF[4]:pixel(6, 1, brightOrange)
AUTUM_LEAF[4]:pixel(0, 2, paleOrange)
AUTUM_LEAF[4]:pixel(1, 2, brightOrange)
AUTUM_LEAF[4]:pixel(2, 2, orangeBrown)
AUTUM_LEAF[4]:pixel(3, 2, burntRed)
AUTUM_LEAF[4]:pixel(4, 2, orangeBrown)
AUTUM_LEAF[4]:pixel(5, 2, brightOrange)
AUTUM_LEAF[4]:fillRect(1, 3, 3, 1, orangeBrown)
AUTUM_LEAF[4]:fillRect(4, 3, 2, 1, brightOrange)
--fillrect(AUTUM_LEAF[4],1, 3, 3, 1, orangeBrown)
--fillrect(AUTUM_LEAF[4],4, 3, 2, 1, brightOrange)
AUTUM_LEAF[4]:pixel(6, 3, orangeBrown)
AUTUM_LEAF[4]:pixel(2, 4, burntRed)
AUTUM_LEAF[4]:fillRect(3, 4, 3, 1, brightOrange)
--fillrect(AUTUM_LEAF[4],3, 4, 3, 1, brightOrange)
AUTUM_LEAF[4]:pixel(6, 4, burntRed)
AUTUM_LEAF[4]:pixel(7, 4, darkBrown)
AUTUM_LEAF[4]:pixel(1, 5, orangeBrown)
AUTUM_LEAF[4]:fillRect(2, 5, 2, 1, brightOrange)
--fillrect(AUTUM_LEAF[4],2, 5, 2, 1, brightOrange)
AUTUM_LEAF[4]:pixel(4, 5, orangeBrown)
AUTUM_LEAF[4]:pixel(5, 5, burntRed)
AUTUM_LEAF[4]:fillRect(1, 6, 2, 1, brightOrange)
AUTUM_LEAF[4]:fillRect(4, 6, 2, 1, burntRed)
--fillrect(AUTUM_LEAF[4],1, 6, 2, 1, brightOrange)
--fillrect(AUTUM_LEAF[4],4, 6, 2, 1, burntRed)
AUTUM_LEAF[4]:pixel(0, 7, brightOrange)
AUTUM_LEAF[4]:pixel(5, 7, darkBrown)

--GREEN LEAF--
--{1}--
GREEN_LEAF[1]:pixel(1, 0, darkGreen)
GREEN_LEAF[1]:pixel(1, 1, midGreen)
GREEN_LEAF[1]:pixel(2, 1, darkGreen)
GREEN_LEAF[1]:pixel(2, 2, khaki)
GREEN_LEAF[1]:pixel(3, 2, darkGreen)
GREEN_LEAF[1]:pixel(4, 2, khaki)
GREEN_LEAF[1]:fillRect(2, 3, 3, 1, midGreen)
--fillrect(GREEN_LEAF[1],2, 3, 3, 1, midGreen)
GREEN_LEAF[1]:pixel(5, 3, khaki)
GREEN_LEAF[1]:fillRect(2, 4, 2, 1, midGreen)
--fillrect(GREEN_LEAF[1],2, 4, 2, 1, midGreen)
GREEN_LEAF[1]:pixel(4, 4, darkGreen)
GREEN_LEAF[1]:pixel(5, 4, lightGreen)
GREEN_LEAF[1]:pixel(6, 4, khaki)
GREEN_LEAF[1]:pixel(3, 5, midGreen)
GREEN_LEAF[1]:pixel(4, 5, darkGreen)
GREEN_LEAF[1]:pixel(5, 5, khaki)
GREEN_LEAF[1]:pixel(6, 5, lightGreen)
GREEN_LEAF[1]:pixel(4, 6, midGreen)
GREEN_LEAF[1]:pixel(5, 6, darkGreen)
GREEN_LEAF[1]:pixel(6, 6, lightGreen)
GREEN_LEAF[1]:pixel(6, 7, khaki)

--{2}--
GREEN_LEAF[2]:fillRect(1, 1, 1, 2, midGreen)
GREEN_LEAF[2]:fillRect(2, 2, 2, 1, khaki)
--fillrect(GREEN_LEAF[2],1, 1, 1, 2, midGreen)
--fillrect(GREEN_LEAF[2],2, 2, 2, 1, khaki)
GREEN_LEAF[2]:pixel(4, 2, lightGreen)
GREEN_LEAF[2]:fillRect(2, 3, 2, 1, darkGreen)
GREEN_LEAF[2]:fillRect(4, 3, 2, 1, lightGreen)
--fillrect(GREEN_LEAF[2],2, 3, 2, 1, darkGreen)
--fillrect(GREEN_LEAF[2],4, 3, 2, 1, lightGreen)
GREEN_LEAF[2]:pixel(2, 4, midGreen)
GREEN_LEAF[2]:pixel(3, 4, darkGreen)
GREEN_LEAF[2]:pixel(4, 4, khaki)
GREEN_LEAF[2]:fillRect(5, 4, 2, 1, lightGreen)
--fillrect(GREEN_LEAF[2],5, 4, 2, 1, lightGreen)
GREEN_LEAF[2]:pixel(3, 5, midGreen)
GREEN_LEAF[2]:pixel(4, 5, darkGreen)
GREEN_LEAF[2]:pixel(5, 5, khaki)
GREEN_LEAF[2]:pixel(6, 5, lightGreen)
GREEN_LEAF[2]:pixel(5, 6, darkGreen)
GREEN_LEAF[2]:fillRect(6, 6, 2, 1, khaki)
--fillrect(GREEN_LEAF[2],6, 6, 2, 1, khaki)

--{3}--
GREEN_LEAF[3]:pixel(1, 1, darkGreen)
GREEN_LEAF[3]:fillRect(1, 2, 2, 1, midGreen)
--fillrect(GREEN_LEAF[3],1, 2, 2, 1, midGreen)
GREEN_LEAF[3]:pixel(2, 3, midGreen)
GREEN_LEAF[3]:pixel(3, 3, darkGreen)
GREEN_LEAF[3]:pixel(4, 3, midGreen)
GREEN_LEAF[3]:fillRect(2, 4, 2, 1, midGreen)
--fillrect(GREEN_LEAF[3],2, 4, 2, 1, midGreen)
GREEN_LEAF[3]:pixel(4, 4, darkGreen)
GREEN_LEAF[3]:pixel(5, 4, lightGreen)
GREEN_LEAF[3]:pixel(3, 5, midGreen)
GREEN_LEAF[3]:pixel(4, 5, darkGreen)
GREEN_LEAF[3]:fillRect(5, 5, 2, 1, khaki)
GREEN_LEAF[3]:fillRect(4, 6, 2, 1, midGreen)
--fillrect(GREEN_LEAF[3],5, 5, 2, 1, khaki)
--fillrect(GREEN_LEAF[3],4, 6, 2, 1, midGreen)
GREEN_LEAF[3]:pixel(6, 6, lightGreen)
GREEN_LEAF[3]:pixel(6, 7, khaki)

--{4}--
GREEN_LEAF[4]:fillRect(0, 3, 1, 2, darkGreen)
--fillrect(GREEN_LEAF[4],0, 3, 1, 2, darkGreen)
GREEN_LEAF[4]:pixel(1, 4, midGreen)
GREEN_LEAF[4]:pixel(2, 4, khaki)
GREEN_LEAF[4]:pixel(3, 4, lightGreen)
GREEN_LEAF[4]:pixel(4, 4, darkGreen)
GREEN_LEAF[4]:pixel(7, 4, midGreen)
GREEN_LEAF[4]:pixel(1, 5, darkGreen)
GREEN_LEAF[4]:pixel(2, 5, midGreen)
GREEN_LEAF[4]:pixel(3, 5, lightGreen)
GREEN_LEAF[4]:pixel(4, 5, mint)
GREEN_LEAF[4]:pixel(5, 5, lightGreen)
GREEN_LEAF[4]:pixel(6, 5, khaki)
GREEN_LEAF[4]:pixel(7, 5, midGreen)
GREEN_LEAF[4]:fillRect(2, 6, 2, 1, midGreen)
--fillrect(GREEN_LEAF[4],2, 6, 2, 1, midGreen)
GREEN_LEAF[4]:pixel(4, 6, lightGreen)
GREEN_LEAF[4]:pixel(5, 6, khaki)
GREEN_LEAF[4]:pixel(6, 6, midGreen)

--{5}--
GREEN_LEAF[5]:pixel(6, 2, midGreen)
GREEN_LEAF[5]:pixel(7, 2, darkGreen)
GREEN_LEAF[5]:fillRect(4, 3, 2, 1, midGreen)
--fillrect(GREEN_LEAF[5],4, 3, 2, 1, midGreen)
GREEN_LEAF[5]:pixel(6, 3, khaki)
GREEN_LEAF[5]:pixel(2, 4, darkGreen)
GREEN_LEAF[5]:fillRect(3, 4, 2, 1, khaki)
--fillrect(GREEN_LEAF[5],3, 4, 2, 1, khaki)
GREEN_LEAF[5]:pixel(5, 4, lightGreen)
GREEN_LEAF[5]:pixel(6, 4, khaki)
GREEN_LEAF[5]:pixel(1, 5, midGreen)
GREEN_LEAF[5]:pixel(2, 5, khaki)
GREEN_LEAF[5]:pixel(3, 5, lightGreen)
GREEN_LEAF[5]:pixel(4, 5, mint)
GREEN_LEAF[5]:pixel(5, 5, midGreen)
GREEN_LEAF[5]:pixel(2, 6, darkGreen)
GREEN_LEAF[5]:fillRect(3, 6, 2, 1, midGreen)
--fillrect(GREEN_LEAF[5],3, 6, 2, 1, midGreen)

--{6}--
GREEN_LEAF[6]:fillRect(6, 2, 2, 1, midGreen)
GREEN_LEAF[6]:fillRect(4, 3, 2, 1, midGreen)
--fillrect(GREEN_LEAF[6],6, 2, 2, 1, midGreen)
--fillrect(GREEN_LEAF[6],4, 3, 2, 1, midGreen)
GREEN_LEAF[6]:pixel(6, 3, khaki)
GREEN_LEAF[6]:pixel(3, 4, midGreen)
GREEN_LEAF[6]:pixel(4, 4, khaki)
GREEN_LEAF[6]:pixel(5, 4, lightGreen)
GREEN_LEAF[6]:pixel(6, 4, mint)
GREEN_LEAF[6]:pixel(1, 5, midGreen)
GREEN_LEAF[6]:pixel(2, 5, khaki)
GREEN_LEAF[6]:fillRect(3, 5, 2, 1, mint)
--fillrect(GREEN_LEAF[6],3, 5, 2, 1, mint)
GREEN_LEAF[6]:pixel(5, 5, lightGreen)
GREEN_LEAF[6]:pixel(2, 6, midGreen)
GREEN_LEAF[6]:pixel(3, 6, khaki)
GREEN_LEAF[6]:pixel(4, 6, lightGreen)

--{7}--
GREEN_LEAF[7]:fillRect(6, 1, 1, 2, midGreen)
GREEN_LEAF[7]:fillRect(4, 2, 2, 1, midGreen)
GREEN_LEAF[7]:fillRect(6, 2, 1, 2, darkGreen)
GREEN_LEAF[7]:fillRect(3, 3, 2, 1, midGreen)
--fillrect(GREEN_LEAF[7],6, 1, 1, 2, midGreen)
--fillrect(GREEN_LEAF[7],4, 2, 2, 1, midGreen)
--fillrect(GREEN_LEAF[7],6, 2, 1, 2, darkGreen)
--fillrect(GREEN_LEAF[7],3, 3, 2, 1, midGreen)
GREEN_LEAF[7]:pixel(5, 3, khaki)
GREEN_LEAF[7]:pixel(2, 4, midGreen)
GREEN_LEAF[7]:pixel(3, 4, khaki)
GREEN_LEAF[7]:pixel(4, 4, lightGreen)
GREEN_LEAF[7]:pixel(5, 4, midGreen)
GREEN_LEAF[7]:pixel(1, 5, midGreen)
GREEN_LEAF[7]:pixel(2, 5, khaki)
GREEN_LEAF[7]:fillRect(3, 5, 2, 1, midGreen)
--fillrect(GREEN_LEAF[7],3, 5, 2, 1, midGreen)
GREEN_LEAF[7]:pixel(1, 6, darkGreen)
GREEN_LEAF[7]:pixel(2, 6, midGreen)

--{8}--
GREEN_LEAF[8]:pixel(6, 1, midGreen)
GREEN_LEAF[8]:fillRect(4, 2, 3, 2, midGreen)
--fillrect(GREEN_LEAF[8],4, 2, 3, 2, midGreen)
GREEN_LEAF[8]:pixel(3, 3, darkGreen)
GREEN_LEAF[8]:pixel(2, 4, darkGreen)
GREEN_LEAF[8]:pixel(3, 4, midGreen)
GREEN_LEAF[8]:fillRect(4, 4, 2, 1, khaki)
--fillrect(GREEN_LEAF[8],4, 4, 2, 1, khaki)
GREEN_LEAF[8]:pixel(1, 5, darkGreen)
GREEN_LEAF[8]:pixel(2, 5, midGreen)
GREEN_LEAF[8]:fillRect(3, 5, 2, 1, lightGreen)
--fillrect(GREEN_LEAF[8],3, 5, 2, 1, lightGreen)
GREEN_LEAF[8]:pixel(2, 6, midGreen)
GREEN_LEAF[8]:pixel(3, 6, lightGreen)

--{9}--
GREEN_LEAF[9]:fillRect(6, 1, 1, 2, midGreen)
GREEN_LEAF[9]:fillRect(4, 2, 2, 1, midGreen)
GREEN_LEAF[9]:fillRect(6, 2, 1, 2, darkGreen)
GREEN_LEAF[9]:fillRect(3, 3, 2, 1, midGreen)
--fillrect(GREEN_LEAF[9],6, 1, 1, 2, midGreen)
--fillrect(GREEN_LEAF[9],4, 2, 2, 1, midGreen)
--fillrect(GREEN_LEAF[9],6, 2, 1, 2, darkGreen)
--fillrect(GREEN_LEAF[9],3, 3, 2, 1, midGreen)
GREEN_LEAF[9]:pixel(5, 3, khaki)
GREEN_LEAF[9]:pixel(2, 4, midGreen)
GREEN_LEAF[9]:pixel(3, 4, khaki)
GREEN_LEAF[9]:pixel(4, 4, lightGreen)
GREEN_LEAF[9]:pixel(5, 4, midGreen)
GREEN_LEAF[9]:pixel(1, 5, midGreen)
GREEN_LEAF[9]:pixel(2, 5, khaki)
GREEN_LEAF[9]:fillRect(3, 5, 2, 1, midGreen)
--fillrect(GREEN_LEAF[9],3, 5, 2, 1, midGreen)
GREEN_LEAF[9]:pixel(1, 6, darkGreen)
GREEN_LEAF[9]:pixel(2, 6, midGreen)

--{10}--
GREEN_LEAF[10]:fillRect(6, 2, 2, 1, midGreen)
GREEN_LEAF[10]:fillRect(4, 3, 2, 1, midGreen)
--fillrect(GREEN_LEAF[10],6, 2, 2, 1, midGreen)
--fillrect(GREEN_LEAF[10],4, 3, 2, 1, midGreen)
GREEN_LEAF[10]:pixel(6, 3, khaki)
GREEN_LEAF[10]:pixel(3, 4, midGreen)
GREEN_LEAF[10]:pixel(4, 4, khaki)
GREEN_LEAF[10]:pixel(5, 4, lightGreen)
GREEN_LEAF[10]:pixel(6, 4, mint)
GREEN_LEAF[10]:pixel(1, 5, midGreen)
GREEN_LEAF[10]:pixel(2, 5, khaki)
GREEN_LEAF[10]:fillRect(3, 5, 2, 1, mint)
--fillrect(GREEN_LEAF[10],3, 5, 2, 1, mint)
GREEN_LEAF[10]:pixel(5, 5, lightGreen)
GREEN_LEAF[10]:pixel(2, 6, midGreen)
GREEN_LEAF[10]:pixel(3, 6, khaki)
GREEN_LEAF[10]:pixel(4, 6, lightGreen)

--{11}--
GREEN_LEAF[11]:pixel(6, 2, midGreen)
GREEN_LEAF[11]:pixel(7, 2, darkGreen)
GREEN_LEAF[11]:fillRect(4, 3, 2, 1, midGreen)
--fillrect(GREEN_LEAF[11],4, 3, 2, 1, midGreen)
GREEN_LEAF[11]:pixel(6, 3, khaki)
GREEN_LEAF[11]:pixel(2, 4, darkGreen)
GREEN_LEAF[11]:fillRect(3, 4, 2, 1, khaki)
--fillrect(GREEN_LEAF[11],3, 4, 2, 1, khaki)
GREEN_LEAF[11]:pixel(5, 4, lightGreen)
GREEN_LEAF[11]:pixel(6, 4, khaki)
GREEN_LEAF[11]:pixel(1, 5, midGreen)
GREEN_LEAF[11]:pixel(2, 5, khaki)
GREEN_LEAF[11]:pixel(3, 5, lightGreen)
GREEN_LEAF[11]:pixel(4, 5, mint)
GREEN_LEAF[11]:pixel(5, 5, midGreen)
GREEN_LEAF[11]:pixel(2, 6, darkGreen)
GREEN_LEAF[11]:fillRect(3, 6, 2, 1, midGreen)
--fillrect(GREEN_LEAF[11],3, 6, 2, 1, midGreen)

--{12}--
GREEN_LEAF[12]:fillRect(0, 3, 1, 2, darkGreen)
--fillrect(GREEN_LEAF[12],0, 3, 1, 2, darkGreen)
GREEN_LEAF[12]:pixel(1, 4, midGreen)
GREEN_LEAF[12]:pixel(2, 4, khaki)
GREEN_LEAF[12]:pixel(3, 4, lightGreen)
GREEN_LEAF[12]:pixel(4, 4, darkGreen)
GREEN_LEAF[12]:pixel(7, 4, midGreen)
GREEN_LEAF[12]:pixel(1, 5, darkGreen)
GREEN_LEAF[12]:pixel(2, 5, midGreen)
GREEN_LEAF[12]:pixel(3, 5, lightGreen)
GREEN_LEAF[12]:pixel(4, 5, mint)
GREEN_LEAF[12]:pixel(5, 5, lightGreen)
GREEN_LEAF[12]:pixel(6, 5, khaki)
GREEN_LEAF[12]:pixel(7, 5, midGreen)
GREEN_LEAF[12]:fillRect(2, 6, 2, 1, midGreen)
--fillrect(GREEN_LEAF[12],2, 6, 2, 1, midGreen)
GREEN_LEAF[12]:pixel(4, 6, lightGreen)
GREEN_LEAF[12]:pixel(5, 6, khaki)
GREEN_LEAF[12]:pixel(6, 6, midGreen)

--{13}--
GREEN_LEAF[13]:pixel(1, 1, darkGreen)
GREEN_LEAF[13]:fillRect(1, 2, 2, 1, midGreen)
--fillrect(GREEN_LEAF[13],1, 2, 2, 1, midGreen)
GREEN_LEAF[13]:pixel(2, 3, midGreen)
GREEN_LEAF[13]:pixel(3, 3, darkGreen)
GREEN_LEAF[13]:pixel(4, 3, midGreen)
GREEN_LEAF[13]:fillRect(2, 4, 2, 1, midGreen)
--fillrect(GREEN_LEAF[13],2, 4, 2, 1, midGreen)
GREEN_LEAF[13]:pixel(4, 4, darkGreen)
GREEN_LEAF[13]:pixel(5, 4, lightGreen)
GREEN_LEAF[13]:pixel(3, 5, midGreen)
GREEN_LEAF[13]:pixel(4, 5, darkGreen)
GREEN_LEAF[13]:fillRect(5, 5, 2, 1, khaki)
GREEN_LEAF[13]:fillRect(4, 6, 2, 1, midGreen)
--fillrect(GREEN_LEAF[13],5, 5, 2, 1, khaki)
--fillrect(GREEN_LEAF[13],4, 6, 2, 1, midGreen)
GREEN_LEAF[13]:pixel(6, 6, lightGreen)
GREEN_LEAF[13]:pixel(6, 7, khaki)

--ROSE--
--{1}--
ROSE[1]:fillRect(1, 0, 2, 1, brightRed)
ROSE[1]:fillRect(0, 1, 1, 2, brightRed)
ROSE[1]:fillRect(1, 1, 2, 2, midRed)
--fillrect(ROSE[1],1, 0, 2, 1, brightRed)
--fillrect(ROSE[1],0, 1, 1, 2, brightRed)
--fillrect(ROSE[1],1, 1, 2, 2, midRed)
ROSE[1]:pixel(2, 2, darkRed)

--{2}--
ROSE[2]:pixel(0, 1, midRed)
ROSE[2]:pixel(1, 1, brightRed)
ROSE[2]:fillRect(1, 2, 1, 2, midRed)
--fillrect(ROSE[2],1, 2, 1, 2, midRed)

--FEATHER--
--{1}--
FEATHER[1]:pixel(0, 2, white)
FEATHER[1]:pixel(1, 2, grey)
FEATHER[1]:pixel(2, 1, grey)

--{2}--
FEATHER[2]:pixel(0, 0, white)
FEATHER[2]:pixel(0, 1, grey)
FEATHER[2]:pixel(1, 2, grey)

--{3}--
FEATHER[3]:pixel(2, 0, white)
FEATHER[3]:pixel(1, 0, grey)
FEATHER[3]:pixel(0, 1, grey)

--{4}--
FEATHER[4]:pixel(2, 2, white)
FEATHER[4]:pixel(2, 1, grey)
FEATHER[4]:pixel(1, 0, grey)

--SPARKLE--
--{1}--
SPARKLE[1]:pixel(3, 3, darkBlue)

--{2}--
SPARKLE[2]:fillRect(3, 2, 1, 3, darkBlue)
SPARKLE[2]:fillRect(2, 3, 3, 1, darkBlue)
--fillrect(SPARKLE[2],3, 2, 1, 3, darkBlue)
--fillrect(SPARKLE[2],3, 2, 1, 3, darkBlue)
SPARKLE[2]:pixel(3, 3, midBlue)

--{3}--
SPARKLE[3]:pixel(1, 1, darkBlue)
SPARKLE[3]:pixel(5, 1, darkBlue)
SPARKLE[3]:pixel(2, 2, midBlue)
SPARKLE[3]:pixel(4, 2, midBlue)
SPARKLE[3]:pixel(3, 3, lightBlue)
SPARKLE[3]:pixel(2, 4, midBlue)
SPARKLE[3]:pixel(4, 4, midBlue)
SPARKLE[3]:pixel(1, 5, darkBlue)
SPARKLE[3]:pixel(5, 5, darkBlue)

--{4}--
SPARKLE[4]:fillRect(3, 1, 1, 5, darkBlue)
SPARKLE[4]:fillRect(1, 3, 5, 1, darkBlue)
SPARKLE[4]:fillRect(3, 2, 1, 3, midBlue)
SPARKLE[4]:fillRect(2, 3, 3, 1, midBlue)
--fillrect(SPARKLE[4],3, 1, 1, 5, darkBlue)
--fillrect(SPARKLE[4],1, 3, 5, 1, darkBlue)
--fillrect(SPARKLE[4],3, 2, 1, 3, midBlue)
--fillrect(SPARKLE[4],2, 3, 3, 1, midBlue)
SPARKLE[4]:pixel(3, 3, lightBlue)

--{5}--
SPARKLE[5]:fillRect(2, 2, 3, 3, midBlue)
SPARKLE[5]:fillRect(3, 2, 1, 3, darkBlue)
SPARKLE[5]:fillRect(2, 3, 3, 1, darkBlue)
--fillrect(SPARKLE[5],2, 2, 3, 3, midBlue)
--fillrect(SPARKLE[5],3, 2, 1, 3, darkBlue)
--fillrect(SPARKLE[5],2, 3, 3, 1, darkBlue)
SPARKLE[5]:pixel(3, 3, lightBlue)
SPARKLE[5]:pixel(1, 1, darkBlue)
SPARKLE[5]:pixel(5, 1, darkBlue)
SPARKLE[5]:pixel(1, 5, darkBlue)
SPARKLE[5]:pixel(5, 1, darkBlue)

--{6}--
SPARKLE[6]:fillRect(2, 1, 3, 5, darkBlue)
SPARKLE[6]:fillRect(1, 2, 5, 3, darkBlue)
SPARKLE[6]:fillRect(2, 2, 3, 3, midBlue)
SPARKLE[6]:fillRect(3, 1, 1, 5, midBlue)
SPARKLE[6]:fillRect(1, 3, 5, 1, midBlue)
SPARKLE[6]:fillRect(3, 2, 1, 3, lightBlue)
SPARKLE[6]:fillRect(2, 3, 3, 1, lightBlue)
--fillrect(SPARKLE[6],2, 1, 3, 5, darkBlue)
--fillrect(SPARKLE[6],1, 2, 5, 3, darkBlue)
--fillrect(SPARKLE[6],2, 2, 3, 3, midBlue)
--fillrect(SPARKLE[6],3, 1, 1, 5, midBlue)
--fillrect(SPARKLE[6],1, 3, 5, 1, midBlue)
--fillrect(SPARKLE[6],3, 2, 1, 3, lightBlue)
--fillrect(SPARKLE[6],2, 3, 3, 1, lightBlue)
SPARKLE[6]:pixel(3, 3, white)

--{7}--
SPARKLE[7]:fillRect(2, 1, 3, 5, midBlue)
SPARKLE[7]:fillRect(1, 2, 5, 3, midBlue)
SPARKLE[7]:fillRect(3, 0, 1, 7, darkBlue)
SPARKLE[7]:fillRect(0, 3, 7, 1, darkBlue)
SPARKLE[7]:fillRect(2, 2, 3, 3, lightBlue)
SPARKLE[7]:fillRect(3, 2, 1, 3, midBlue)
SPARKLE[7]:fillRect(2, 3, 3, 1, midBlue)
--fillrect(SPARKLE[7],2, 1, 3, 5, midBlue)
--fillrect(SPARKLE[7],1, 2, 5, 3, midBlue)
--fillrect(SPARKLE[7],3, 0, 1, 7, darkBlue)
--fillrect(SPARKLE[7],0, 3, 7, 1, darkBlue)
--fillrect(SPARKLE[7],2, 2, 3, 3, lightBlue)
--fillrect(SPARKLE[7],3, 2, 1, 3, midBlue)
--fillrect(SPARKLE[7],2, 3, 3, 1, midBlue)
SPARKLE[7]:pixel(3, 3, white)

--[[ Save Images ]]--
RAIN:save("RAIN.png")
STORM:save("STORM.png")
SNOW:save("SNOW.png")
HAIL:save("HAIL.png")
PETAL:save("PETAL.png")
BLOOD_RAIN:save("BLOOD_RAIN.png")
for i=1,table.getn(AUTUM_LEAF) do
  AUTUM_LEAF[i]:save("AUTUM_LEAF" .. i .. ".png")
end
for i=1,table.getn(GREEN_LEAF) do
  GREEN_LEAF[i]:save("GREEN_LEAF" .. i .. ".png")
end
for i=1,table.getn(ROSE) do
  ROSE[i]:save("ROSE" .. i .. ".png")
end
for i=1,table.getn(FEATHER) do
  FEATHER[i]:save("FEATHER" .. i .. ".png")
end
for i=1,table.getn(SPARKLE) do
  SPARKLE[i]:save("SPARKLE" .. i .. ".png")
end

RAIN = nil
STORM = nil
SNOW = nil
HAIL = nil
PETAL = nil
BLOOD_RAIN = nil
AUTUM_LEAF = nil
GREEN_LEAF = nil
ROSE = nil
FEATHER = nil
SPARKLE = nil