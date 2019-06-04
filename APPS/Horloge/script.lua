local clock = Font.load("System/Font/AndroidClock_Solid.ttf")
clock:setPixelSizes(60,60)

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

masque = Image.createEmpty(480,257)
masque:clear(Color.new(0,0,0,0))

while true do
 Android:Fond()
 pad = Controls.read()

 screen:blit(0,15,masque)
 screen:fontPrint(clock,240-70,100,H..":"..M,blanc)
 screen:fontPrint(small_font,280-string.len(date(System.getDate(3),System.getDate(2),System.getDate(1))..System.getDate(3)..mois)*2,125,date(System.getDate(3),System.getDate(2),System.getDate(1))..System.getDate(3)..mois,blanc)

 if pad:select() and not oldpad:select() and quitter==false then
  quitter=true
 elseif pad:select() and not oldpad:select() and quitter==true then
  quitter=false
 end
 if quitter == true then
  if Android:Alerte("Quitter?","Voulez-vous vraiment quitter?","Annuler","Quitter") == 2 then
   System.currentDirectory("ms0:/PSP/GAME/ANDROID/")
   quitter = false
   break
  elseif Android:Alerte("Quitter?","Voulez-vous vraiment quitter?","Annuler","Quitter") == 1 then
   quitter = false
  end
 end

 Android:Barre()
 Android:Souris()
 screen:flip()
 screen.waitVblankStart()
 oldpad = pad
end
