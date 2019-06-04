local lettres = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
           "0","1","2","3","4","5","6","7","8","9",
           "+","-","#","!","*","?","&","<",">","_","/",
           "","","","","","","","","","","","","","À","ÿ","ö","Ò",
           "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"," ",
          }
         
local vert1 = Color.new(150,200,150)
local vert2 = Color.new(100,200,100)
local vert3 = Color.new(50,200,50)
local vert4 = Color.new(25,200,25)

local blanc = Color.new(255,255,255)
local y=math.random(0,272)
local yvit=math.random(1,10)
local x=math.random(0,47)*10

local y1=math.random(0,272)
local y1vit=math.random(1,10)
local x1=math.random(0,47)*10

local y2=math.random(0,272)
local y2vit=math.random(1,10)
local x2=math.random(0,47)*10

local y3=math.random(0,272)
local y3vit=math.random(1,10)
local x3=math.random(0,47)*10

local y4=math.random(0,272)
local y4vit=math.random(1,10)
local x4=math.random(0,47)*10

function Android:Fond()
y=y+yvit
y1=y1+y1vit
y2=y2+y2vit
y3=y3+y3vit
y4=y4+y4vit
if y>=272 then
  y=0
  yvit=math.random(1,10)
  x=math.random(0,47)*10
end
if y1>=272 then
  y1=0
  y1vit=math.random(1,10)
  x1=math.random(0,47)*10
end
if y2>=272 then
  y2=0
  y2vit=math.random(1,10)
  x2=math.random(0,47)*10
end
if y3>=272 then
  y3=0
  y3vit=math.random(1,10)
  x3=math.random(0,47)*10
end
if y4>=272 then
  y4=0
  y4vit=math.random(1,10)
  x4=math.random(0,47)*10
end
screen:clear(Color.new(0,5,0))
--1
screen:print(x,y-10,lettres[math.random(1,#lettres)],vert1)
screen:print(x,y-20,lettres[math.random(1,#lettres)],vert2)
screen:print(x,y-30,lettres[math.random(1,#lettres)],vert3)
screen:print(x,y-40,lettres[math.random(1,#lettres)],vert4)
screen:print(x,y,lettres[math.random(1,#lettres)],blanc)
screen:drawLine(x-2,y+10,x+6,y+10,blanc)
--2
screen:print(x1,y1-10,lettres[math.random(1,#lettres)],vert1)
screen:print(x1,y1-20,lettres[math.random(1,#lettres)],vert2)
screen:print(x1,y1-30,lettres[math.random(1,#lettres)],vert3)
screen:print(x1,y1-40,lettres[math.random(1,#lettres)],vert4)
screen:print(x1,y1,lettres[math.random(1,#lettres)],blanc)
screen:drawLine(x1-2,y1+10,x1+6,y1+10,blanc)
--3
screen:print(x2,y2-10,lettres[math.random(1,#lettres)],vert1)
screen:print(x2,y2-20,lettres[math.random(1,#lettres)],vert2)
screen:print(x2,y2-30,lettres[math.random(1,#lettres)],vert3)
screen:print(x2,y2-40,lettres[math.random(1,#lettres)],vert4)
screen:print(x2,y2,lettres[math.random(1,#lettres)],blanc)
screen:drawLine(x2-2,y2+10,x2+6,y2+10,blanc)
--4
screen:print(x3,y3-10,lettres[math.random(1,#lettres)],vert1)
screen:print(x3,y3-20,lettres[math.random(1,#lettres)],vert2)
screen:print(x3,y3-30,lettres[math.random(1,#lettres)],vert3)
screen:print(x3,y3-40,lettres[math.random(1,#lettres)],vert4)
screen:print(x3,y3,lettres[math.random(1,#lettres)],blanc)
screen:drawLine(x3-2,y3+10,x3+6,y3+10,blanc)
--5
screen:print(x4,y4-10,lettres[math.random(1,#lettres)],vert1)
screen:print(x4,y4-20,lettres[math.random(1,#lettres)],vert2)
screen:print(x4,y4-30,lettres[math.random(1,#lettres)],vert3)
screen:print(x4,y4-40,lettres[math.random(1,#lettres)],vert4)
screen:print(x4,y4,lettres[math.random(1,#lettres)],blanc)
screen:drawLine(x4-2,y4+10,x4+6,y4+10,blanc)
end
