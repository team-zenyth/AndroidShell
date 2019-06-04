local verrou = Image.load("SYSTEM/lockscreen/verrou.png")
local fin = Image.load("SYSTEM/lockscreen/fin.png")
local cercle = Image.load("SYSTEM/lockscreen/cercle.png")
local photo = Image.load("SYSTEM/lockscreen/photo.png")
clock = Font.load("System/Font/AndroidClock_Solid.ttf")
local click = false
local ending = false
clock:setPixelSizes(60,60)

function date(jour, mois, annee)
 if mois <=2 then
  mois = mois + 12
 end
 if lang == "FR" then
  s_jours = { "ven. ", "sam. ", "dim. ", "lun. ", "mar. ", "mer. ", "jeu. " }
 else
  s_jours = { "thu. ", "sat. ", "sun. ", "mon. ", "tue. ", "wed. ", "fri. " }
 end
 local j = (jour + 2*mois + ((3*(mois + 1))/5) + annee + (annee/4) - (annee/100) + (annee/400) + 2) % 7
 return s_jours[math.ceil(j)]
end

if lang == "FR" then
 if System.getDate(2) == 1 then
  mois = " janvier"
 elseif System.getDate(2) == 2 then
  mois = " fevrier"
 elseif System.getDate(2) == 3 then
  mois = " mars"
 elseif System.getDate(2) == 4 then
  mois = " avril"
 elseif System.getDate(2) == 5 then
  mois = " mai"
 elseif System.getDate(2) == 6 then
  mois = " juin"
 elseif System.getDate(2) == 7 then
  mois = " juillet"
 elseif System.getDate(2) == 8 then
  mois = " aout"
 elseif System.getDate(2) == 9 then
  mois = " septembre"
 elseif System.getDate(2) == 10 then
  mois = " octobre"
 elseif System.getDate(2) == 11 then
  mois = " novembre"
 elseif System.getDate(2) == 12 then
  mois = " decembre"
 else
  mois = " erreur"
 end
else
 if System.getDate(2) == 1 then
  mois = " january"
 elseif System.getDate(2) == 2 then
  mois = " february"
 elseif System.getDate(2) == 3 then
  mois = " march"
 elseif System.getDate(2) == 4 then
  mois = " april"
 elseif System.getDate(2) == 5 then
  mois = " may"
 elseif System.getDate(2) == 6 then
  mois = " june"
 elseif System.getDate(2) == 7 then
  mois = " july"
 elseif System.getDate(2) == 8 then
  mois = " august"
 elseif System.getDate(2) == 9 then
  mois = " septembre"
 elseif System.getDate(2) == 10 then
  mois = " octobre"
 elseif System.getDate(2) == 11 then
  mois = " novembre"
 elseif System.getDate(2) == 12 then
  mois = " decembre"
 else
  mois = " error"
 end
end

if veille == 1 then
 Mp3me.stop()
 Mp3me.load("SOUNDS/Lock.mp3")
 Mp3me.play()
 shine = Image.createEmpty(480,272)
 shine:clear(Color.new(255,255,255,50))

 for i = 1, 13 do
  screen:blit(0,0,shine)
  screen:fillRect(0,0,480,i*12,noir)
  screen:fillRect(0,272-i*12,480,i*12,noir)
  screen.flip()
 end
 System.suspend()
end

base = Image.load("SYSTEM/lockscreen/cercle.png")
base:blit(0,0,verrou)

while true do
pad = Controls.read()
Android:Fond()
Android:Barre()

if System.getTime(5) == "pm" and System.getTime(1) ~= "12" then
 H = System.getTime(1) + 12
elseif System.getTime(1) < 10 then
 H = "0"..System.getTime(1)
else
 H = System.getTime(1)
end

if System.getTime(2) < 10 then
 M = "0"..System.getTime(2)
else
 M = System.getTime(2)
end

screen:fontPrint(clock,240,70,H..":"..M,blanc)
screen:fontPrint(font,280,95,date(System.getDate(3),System.getDate(2),System.getDate(1))..System.getDate(3)..mois,blanc)

if pad:cross() and curx >= 190 and curx <= 290 and cury >= 120 and cury <= 220 then
 click = true
end
if not pad:cross() then
 click = false
 if ending == true then
  break
 end
end
if click == true then
 screen:blit(50,120,photo)
 if ending == true then
  screen:blit(330,120,fin)
 else
  screen:blit(330,120,verrou)
  screen:blit(curx-50,cury-50,cercle)
 end
 if curx-50 >= 300 and curx-50 <= 360 and cury-50 >= 90 and cury-50 <= 150 then
  ending = true
 else
  ending = false
 end
else
 screen:blit(190,120,base)
end
Android:Souris()
oldpad = pad
screen.flip()
screen.waitVblankStart()
end
Mp3me.stop()
Mp3me.load("SOUNDS/unlock.mp3")
Mp3me.play()
