local flocon = Image.load("wall/res/flocon.png")

local x=math.random(0,24)*20
local y=math.random(0,272)

local x1=math.random(0,24)*20
local y1=math.random(0,272)

local x2=math.random(0,24)*20
local y2=math.random(0,272)

local x3=math.random(0,24)*20
local y3=math.random(0,272)

local x4=math.random(0,24)*20
local y4=math.random(0,272)

function Android:Fond()
if System.getTime(5) == "pm" and System.getTime(1) ~= "12" then
  H = System.getTime(1)
else
  H = System.getTime(1) - 12
end
HC = H*10
if y>=272 then
  y=0
  x=math.random(0,24)*20
end
if x<480 then
  x=x+math.random(-1,1)
end
if y<272 then
  y=y+math.random(-1,3)
end
if y1>=272 then
  y1=0
  x1=math.random(0,24)*20
end
if x1<480 then
  x1=x1+math.random(-1,1)
end
if y1<272 then
  y1=y1+math.random(-1,3)
end
if y2>=272 then
  y2=0
  x2=math.random(0,24)*20
end
if x2<480 then
  x2=x2+math.random(-1,1)
end
if y2<272 then
  y2=y2+math.random(-1,3)
end
if y3>=272 then
  y3=0
  x3=math.random(0,24)*20
end
if x3<480 then
  x3=x3+math.random(-1,1)
end
if y3<272 then
  y3=y3+math.random(-1,3)
end
if y4>=272 then
  y4=0
  x4=math.random(0,24)*20
end
if x4<480 then
  x4=x4+math.random(-1,1)
end
if y4<272 then
  y4=y4+math.random(-1,3)
end
screen:clear(Color.new(215-HC,215-HC,255-HC))
screen:blit(x,y,flocon)
screen:blit(x1,y1,flocon)
screen:blit(x2,y2,flocon)
screen:blit(x3,y3,flocon)
screen:blit(x4,y4,flocon)
end
