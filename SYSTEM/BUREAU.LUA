local minuteur = Timer.new()
minuteur:stop()
minuteur:reset(0)

while true do
pad = Controls.read()
Android:Fond()
if bureau == 1 then
  Widget:Horloge(240,121,100)
elseif bureau == 2 then
 Widget.Google()
elseif bureau == 3 then
  Widget:Batterie(240,121)
end
Android:Menu()
Android:Barre()

-- FIN

if curx==479 and Options == false then
  bureau=bureau+1
  curx=1
elseif bureau>=4 then
  bureau=1
end

if curx==0 and Options == false then
  bureau=bureau-1
  curx=478
elseif bureau<=0 then
  bureau=3
end

if pad:triangle() and not oldpad:triangle() and help==false then
  help=true
elseif pad:triangle() and not oldpad:triangle() and help==true then
  help=false
end
if help == true then
 System.message("Aide\n"..
                "Pour changer de bureau, plaquez le curseur a un des cotes de l'ecran.\n"..
                "Les menus s'ouvrent par un clic.\n"..
                "Les menu rapides s'activent par la touche start.\n"..
                "Appuyez sur L pour verouiller l'appareil.",0)
 help = false
end

if pad:start() and not oldpad:start() and Options==false then
  Options=true
elseif pad:start() and not oldpad:start() and Options==true then
  Options=false
end
if Options==true then
  Android:Options()
end

if y_notif == 26 then
 Android:Date(5,18)
end

if pad:select() and not oldpad:select() then
 bureau = 2
end

if pad:l() then
 minuteur:start()
end

if minuteur:time() > 0 and minuteur:time() < 1000 and not pad:l() then
 minuteur:stop()
 minuteur:reset(0)
 veille = 1
 dofile("system/lock.lua")
elseif minuteur:time() >= 1000 then
 minuteur:stop()
 minuteur:reset(0)
end

Android:Souris()
oldpad = pad
screen.flip()
screen.waitVblankStart()
end
