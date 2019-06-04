function date(jour, mois, annee)
 if mois <=2 then
  mois = mois + 12
 end
 local s_jours = { "sam. ", "dim. ", "lun. ", "mar. ", "mer. ", "jeu. ", "ven. " }
 local j = (jour + 2*mois + ((3*(mois + 1))/5) + annee + (annee/4) - (annee/100) + (annee/400) + 2) % 7
 return s_jours[math.ceil(j)]
end

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

dofile("SYSTEM/lockscreen/code.lua")

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

screen:fontPrint(font,280,125,current,blanc)


Android:Souris()
oldpad = pad
screen.flip()
screen.waitVblankStart()
end
