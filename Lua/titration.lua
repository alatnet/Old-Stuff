titrant = 32.3 --12.5
molarity = 0.1 --0.15
concentration = 25.0 --30.0

total = ((((titrant/1000)*molarity)/concentration)*1000)

while not Controls.read():start() do
  screen:clear(Color.new(255,255,255))
  screen:print(0,0, total, Color.new(0,0,0))
  screen.flip()
end