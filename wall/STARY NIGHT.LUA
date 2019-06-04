etoile = {}
for i = 1, 20 do
etoile[i] = {x = math.random(1,479),y = math.random(26,271)}
end
for i = 21, 40 do
etoile[i] = {x = math.random(1,479),y = math.random(26,271)}
end

local color_val_1 = 0
local up_1 = true
local color_val_2 = 255
local up_2 = false
function Android:Fond()
screen:clear(Color.new(12,12,25))
--CLIGNOTEMENT
if color_val_1 < 255 and up_1 == true then
color_val_1 = color_val_1 + 5
elseif color_val_1 > 0 and up_1 == false then
color_val_1 = color_val_1 - 5
elseif color_val_1 >= 255 then
up_1 = false
elseif color_val_1 <= 0 then
up_1 = true
end
color_1 = Color.new(color_val_1,color_val_1,color_val_1)
--CLIGNOTEMENT 2
if color_val_2 < 255 and up_2 == true then
color_val_2 = color_val_2 + 5
elseif color_val_2 > 0 and up_2 == false then
color_val_2 = color_val_2 - 5
elseif color_val_2 >= 255 then
up_2 = false
elseif color_val_2 <= 0 then
up_2 = true
end
color_2 = Color.new(color_val_2,color_val_2,color_val_2)


if color_val_1 <= 0 then
 for i = 1 , 20 do
  etoile[i].x = math.random(1,479)
  etoile[i].y = math.random(26,271)
 end
end

if color_val_2 <= 0 then
 for i = 21 , 40 do
  etoile[i].x = math.random(1,479)
  etoile[i].y = math.random(26,271)
 end
end

for i = 1 , 20 do
 screen:pixel(etoile[i].x,etoile[i].y,color_1)
end
for i = 21 , 40 do
 screen:pixel(etoile[i].x,etoile[i].y,color_2)
end
end
