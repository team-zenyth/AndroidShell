Android = {}

mois = {"janvier","fevrier","mars","avril","mai","juin","juillet","aout","septembre","octobre","novembre","decembre"}
mois = mois[System.getDate(2)]

alert_selector = 1

bleu = Color.new(51,181,229)
local bureau = 2--position bureau
local souris = Image.load("IMG/curseurs/"..curseur_choisis)
local option_selecteur = 1 -- selecteur menu bureau
curx = 240--]Position
cury = 136--] Souris
local menu_barre = Image.load("IMG/barre menu.png")
local menu_icon_1 = Image.load("IMG/menu.png")
local menu_icon_2 = Image.load("IMG/menu_vol.png")
local app_top = Image.load("IMG/applist-top.png")
local y_notif = 0
local message = Image.load("IMG/message.png")
local USBpic = Image.load("IMG/USB.png")
local Roboto = Font.load("System/Font/Roboto-Regular.ttf")
Roboto:setPixelSizes(16,16)
local option_norm = Image.load("IMG/option_norm.png")--]Barre
local option_sele = Image.load("IMG/option_sele.png")--]Options
local Alerte = Image.load("IMG/Question.png")
local Newname = Image.load("IMG/new-name.png")
local recherche = Image.load("IMG/recherche.png")
local horloge = Image.load("IMG/horloge.png")
--batterie
batterie = {}
for i = 1, 6 do 
 batterie[i]=Image.load("IMG/BAT/".. i-1 ..".png")
end

--local batcharg=Image.load("IMG/BAT/CHARGE.png")

function question (mess)
  System.message(mess, 1)
  return System.buttonPressed(0)
end

function Android.daemon()

end

--souris
function Android:Souris()
-- PAD
if math.abs(pad:analogY()) > sens_cur then
 cury = cury + pad:analogY() / sens_cur
end
if math.abs(pad:analogX()) > sens_cur then
 curx = curx + pad:analogX() / sens_cur
end
if curx > 479 then
 curx = 479
elseif curx < 0 then
 curx = 0
end
if cury > 271 then
 cury = 271
elseif cury < 0 then
 cury = 0
end
screen:blit(curx,cury,souris)
end
--fin
--barre
function Android:Barre()
 screen:fillRect(0,0,480,15)
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
 screen:fontPrint(small_font,445,12,H..":"..M,bleu)
 Android:Bat(433,1)
 Android:Notif()
end
--fin
--batterie
function Android:Bat(batx,baty)
 bat=System.powerGetBatteryLifePercent()
 for i = 0, 5 do
  if bat > i*20 and bat <= i*20 + 20 then
   screen:blit(batx,baty,batterie[i+1])
  end
 end
-- if System.powerIsPowerOnline() then
--  screen:blit(batx,baty,batcharg)
-- end
end
--fin
--Options
function Android:Options()
 screen:blit(130,146,option_norm)
 if option_selecteur == 1 then
  screen:blit(138,154,option_sele,8,8,204,39)
  if pad:cross() and not oldpad:cross() then
   dofile("APPS/Parametres/wall.lua")
  end
 elseif option_selecteur == 2 then
  screen:blit(138,193,option_sele,8,47,204,39)
  if pad:cross() and not oldpad:cross() then
   dofile("APPS/Parametres/applications.lua")
  end
 elseif option_selecteur == 3 then
  screen:blit(138,232,option_sele,8,86,204,39)
  if pad:cross() and not oldpad:cross() then
   dofile("APPS/Parametres/script.lua")
  end
 end
 if pad:down() and not oldpad:down() and option_selecteur < 3 then
  option_selecteur = option_selecteur + 1
 end
 if pad:up() and not oldpad:up() and option_selecteur > 1 then
  option_selecteur = option_selecteur - 1
 end
end
--fin
--Net
function Android:Net(www)
System.webbrowser("ms0:/psp/game/Android",www)
end
function Android:Google(x)
Android:Net("www.google.fr/search?q="..x)
end

-- MENU
dofile("SYSTEM/raccourci.lua")
function Android:Menu()
 screen:blit(0,218,menu_barre)
 if curx >= 220 and curx <= 260 and cury >= 227 and cury <= 267 then
  screen:blit(220,227,menu_icon_2)
  if pad:cross() and not oldpad:cross() then
   Android:Programs(0,15)
  end
 else
  screen:blit(220,227,menu_icon_1)
 end
  if curx >= 18 and curx <= 58 and cury >= 227 and cury <= 267 and pad:cross() and not oldpad:cross() then dofile("APPS/"..lien_1.action.."/script.lua") end
  if curx >= 118 and curx <= 158 and cury >= 227 and cury <= 267 and pad:cross() and not oldpad:cross() then dofile("APPS/"..lien_2.action.."/script.lua") end
  if curx >= 328 and curx <= 368 and cury >= 227 and cury <= 267 and pad:cross() and not oldpad:cross() then dofile("APPS/"..lien_3.action.."/script.lua") end
  if curx >= 425 and curx <= 465 and cury >= 227 and cury <= 267 and pad:cross() and not oldpad:cross() then dofile("APPS/"..lien_4.action.."/script.lua") end
  screen:blit(18,227,lien_1.icone)
  screen:blit(118,227,lien_2.icone)
  screen:blit(328,227,lien_3.icone)
  screen:blit(425,227,lien_4.icone)
end
-- fin
local Folders = 0
function Android:Programs(x,y)
app_menu_state = true
local select = 1
local ligne = 0
 while app_menu_state do
 screen:clear()
 pad = Controls.read()
 screen:blit(x,y,app_top)
 screen:blit(x,y+37,app_list)
 
 if pad:cross() then
  for i = 1, math.ceil(#Apps/8) do
   for j = 1, #Apps-(i-1)*8 do
    if curx > j * 60 - 50 + x and curx < j * 60 - 10 + x and cury > i*60-50+y+37 and cury < i*60-10+y+37 then
     exec = coroutine.create(function() dofile("APPS/"..Apps[j+(i-1)*8].name.."/script.lua") end)
     test,erreur = coroutine.resume(exec) -- Retourne l'erreur
     if not test then
      screen:clear()
      screen.flip()
      log_file = io.open(adresse.."/Error Log/"..System.getDate(1).."."..System.getDate(2).."."..System.getDate(3).." "..System.getTime(1).."."..System.getTime(2).."."..System.getTime(3)..".log","w")
      log_file:write(erreur)
      log_file:close()
      System.message("Erreur enregistree dans le dossier Error Log",0)
     end
     app_menu_state = false
    end
   end
  end
 end
 if pad:circle() then app_menu_state = false end
 Android:Barre()
 Android:Souris()
 oldpad = pad
 screen.flip()
 screen.waitVblankStart()
 end
end

-- NOTIF

function Android:Notif()
 screen:fillRect(0,0,480,y_notif,noir)
 if pad:cross() and not oldpad:cross() and y_notif == 272 and cury >= 257  then
  notif_up = true
  notif_down = false
 end
 if notif_up == true then
  y_notif=y_notif-10
 end
 if y_notif <= 0 then
  y_notif = 0
  notif_up = false
 end
 if pad:cross() and not oldpad:cross() and cury <= 15 and y_notif == 0 then
  notif_down = true
  notif_up = false
 end
 if notif_down == true then
  y_notif = y_notif+10
 end
 if y_notif == 272 then
  notif_down = false
 end
 if y_notif > 272 then
   y_notif = 272
 end
end

Widget = {}
-- Widget Google
function Widget:Google()
 screen:blit(20,30,recherche)
 if curx >= 20 and curx <= 460 and cury >= 30 and cury <= 60 and menu_ok == false and y_notif <= -240 and Options == false then
  if pad:cross() then
   search = System.startOSK("","Google")
   if search ~= "" then
    Android:Google(search)
   end
  end
 end
end

-- WIDGET

function DrawRayon(x, y, radius, angle, color)
   pi = math.pi
   step = 2/(radius*radius*0.5)
   a = x-radius*math.cos(math.rad(-90-angle))
   b = y+radius*math.sin(math.rad(-90-angle))
   screen:drawLine(x, y, a, b, color)
end
--radius = 100
function Widget:Horloge(x,y)
--marquage
screen:blit(x-100,y-100,horloge)
--heure
DrawRayon(x, y, 50, System.getTime(1)/12*360+System.getTime(2)/60, blanc)
DrawRayon(x+1, y, 50, System.getTime(1)/12*360+System.getTime(2)/60, blanc)
DrawRayon(x, y+1, 50, System.getTime(1)/12*360+System.getTime(2)/60, blanc)
DrawRayon(x-1, y, 50, System.getTime(1)/12*360+System.getTime(2)/60, blanc)
DrawRayon(x, y-1, 50, System.getTime(1)/12*360+System.getTime(2)/60, blanc)
--minutes
DrawRayon(x, y+0.5, 75, System.getTime(2)*6+System.getTime(3)/10, blanc)
DrawRayon(x, y, 75, System.getTime(2)*6+System.getTime(3)/10, blanc)
DrawRayon(x+0.5, y, 75, System.getTime(2)*6+System.getTime(3)/10, blanc)
DrawRayon(x, y-0.5, 75, System.getTime(2)*6+System.getTime(3)/10, blanc)
DrawRayon(x-0.5, y, 75, System.getTime(2)*6+System.getTime(3)/10, blanc)
end

function Widget:Batterie(x,y)
screen:fillRect(x-51,y-6,102,12,noir)
screen:fillRect(x-50,y-5,System.powerGetBatteryLifePercent(),10,bleu)
end

local Alerte_sel_pic = Image.createEmpty(107,32)
Alerte_sel_pic:clear(Color.new(51,181,229,80))

function Android:Alerte(titre,texte,bouton_1,bouton_2)
screen:blit(133,77,Alerte)
screen:fontPrint(big_font,140,110,titre,bleu)
screen:fontPrint(small_font,140,147,texte,blanc)
if pad:right() then
 alert_selector = 2
elseif pad:left() then
 alert_selector = 1
end
if pad:cross() and not oldpad:cross() then
 return alert_selector
end
screen:blit(26+alert_selector*107,163,Alerte_sel_pic)
screen:fontPrint(small_font,140,180,bouton_1,blanc)
screen:fontPrint(small_font,247,180,bouton_2,blanc)
end

function Android:NewName(titre,texte,fond)
local selection = 0
origin_texte = texte
while true do
pad = Controls.read()
screen:clear()
screen:blit(0,0,fond)
if pad:right() then
 selection = 3
elseif pad:left() then
 selection = 2
elseif pad:up() then
 selection = 1
elseif pad:down() then
 selection = 2
end

screen:blit(133,77,Newname)
if selection == 1 then
 if pad:cross() and not oldpad:cross() then texte = System.startOSK(texte,titre) end
else
screen:blit(26+selection*107-107,163,Alerte_sel_pic)
if pad:cross() and not oldpad:cross() and selection == 2 then break end
if pad:cross() and not oldpad:cross() and selection == 3 then texte = origin_texte break end
end
screen:fontPrint(big_font,140,110,titre,bleu)
screen:fontPrint(small_font,145,147,texte,blanc)
screen:fontPrint(small_font,140,180,"OK",blanc)
screen:fontPrint(small_font,247,180,"Annuler",blanc)
screen.flip()
screen.waitVblankStart()
olpad = pad
end
return texte
end
