FX = {}
function FX.music(type)
end

function FX.pic(image)
screen:clear()
screen:blit(240-image:width()/2,136-image:height()/2,image)
screen.flip()
while not Controls.read():circle() do
end
end

function FX.font()
end

function FX.menu()
 local menu = {"Renommer","Copier","Coller","Supprimer","Nouveau Dossier","Annuler",sel = 1}
 oldpad = pad
 while 1 do
  pad = Controls.read()
  screen:clear(gris)
  for i = 1, #menu do
   screen:fontPrint(font,10,15+40*i,menu[i],i == menu.sel and blanc or bleu)
  end
  if pad:down() and not oldpad:down() and menu.sel < #menu then
   menu.sel = menu.sel + 1
  end
  if pad:up() and not oldpad:up() and menu.sel > 1 then
   menu.sel = menu.sel - 1
  end
  if pad:cross() and not oldpad:cross() then
   if menu.sel == 1 then
    System.rename(Fichiers[math.ceil((cury+y)/20)].name,System.startOSK(Fichiers[math.ceil((cury+y)/20)].name,"Renommer"))
   end
   if menu.sel == 2 then
    adresseCopier = System.currentDirectory().."/"..Fichiers[math.ceil((cury+y)/20)].name
   end
   if menu.sel == 3 then
    if adresseCopier ~= 0 then
     System.copyFile(adresseCopier,System.currentDirectory(),0)
    end
   end
   if menu.sel == 4 then
    if not Fichiers[math.ceil((cury+y)/20)].directory then
     System.removeFile(Fichiers[math.ceil((cury+y)/20)].name)
    else
     FX.removeFolder(Fichiers[math.ceil((cury+y)/20)].name)
    end
   end
   break
  end
  screen.flip()
  oldpad = pad
 end
end

function FX.removeFolder(dossier)
System.currentDirectory(dossier)
local table = System.listDirectory()
for i = 3, #table do
 if table[i].folder then
  FX.removeFolder(table[i].name)
 else
  System.removeFile(table[i].name)
 end
end
System.currentDirectory("..")
System.removeDirectory(dossier)
end

function FX.text()
 while 1 do
  screen:clear(gris)
  pad = Controls.read()
  if pad:cross() and oldpad:cross() then
   if math.abs(pad:analogY()) > sens_cur then
    pos_txty = pos_txty - pad:analogY() / sens_cur
   end
  end
  for i = 1, #texte_ do
   screen:print(pos_txtx,pos_txty * (i-1),texte_[i],blanc)
  end
  Android:Barre()
  Android:Souris()
  screen.flip()
 oldpad = pad
 end
end

adresseCopier = 0
local icone_dossier = Image.load("APPS/File Explorer/icones/dossier.png")
local icone_parent  = Image.load("APPS/File Explorer/icones/dossier sup.png")
local icone_musique = Image.load("APPS/File Explorer/icones/musique.png")
local icone_image   = Image.load("APPS/File Explorer/icones/image.png")
local icone_police  = Image.load("APPS/File Explorer/icones/police.png")
local icone_texte   = Image.load("APPS/File Explorer/icones/texte.png")
local icone_binaire = Image.load("APPS/File Explorer/icones/executable.png")
local icone_html    = Image.load("APPS/File Explorer/icones/html.png")
local icone_autre   = Image.load("APPS/File Explorer/icones/fichier.png")

System.currentDirectory("ms0:")
Fichiers = System.listDirectory()
table.sort(Fichiers, function(a,b) if a.directory == b.directory then return a.name:lower() < b.name:lower() else return a.directory end end)

y = -15
local quitter = false
local timer = Timer.new()
timer:stop()
timer:reset(0)
rouge = Color.new(229,51,51)

while 1 do
pad = Controls.read()
screen:clear(gris)

if Fichiers[1].name == "." then
 table.remove(Fichiers,1)
end

if y > #Fichiers*20-260 then
 y = #Fichiers*20-260
end

if y < -15 then
 y = -15
end

for i = 1, #Fichiers do
screen:drawLine(10,i*20-y,470,i*20-y,blanc)
if Fichiers[i].name == ".." then
 if lang == "FR" then
  screen:print(20,i*20-14-y,"Dossier parent",blanc)
 else
  screen:print(20,i*20-14-y,"Parent folder",blanc)
 end
else
 screen:print(20,i*20-14-y,Fichiers[i].name,blanc)
end

if Fichiers[i].directory then
 if Fichiers[i].name == ".." then
  screen:blit(0,i*20-20-y,icone_parent)
 else
  screen:blit(0,i*20-20-y,icone_dossier)
 end
else
 extension = string.upper(string.sub(Fichiers[i].name,-3))
 if extension == "MP3" or extension == "OGG" then
  screen:blit(1,i*20-19-y,icone_musique)
 elseif extension == "JPG" or extension == "PNG" or extension == "BMP" then
  screen:blit(1,i*20-19-y,icone_image)
 elseif extension == "TTF" then
  screen:blit(1,i*20-19-y,icone_police)
 elseif extension == "TXT" or extension == "INI" then
  screen:blit(1,i*20-19-y,icone_texte)
 elseif extension == "LUA" or extension == "PBP" then
  screen:blit(1,i*20-19-y,icone_binaire)
 else
  screen:blit(1,i*20-19-y,icone_autre)
 end
end

end

if pad:cross() and oldpad:cross() then
 if math.abs(pad:analogY()) > sens_cur then
  y = y - pad:analogY() / sens_cur
 end
end

if pad:cross() and not oldpad:cross() and math.abs(pad:analogY()) < sens_cur and math.ceil((cury+y)/20) <= #Fichiers then
timer = timer.new()
timer:start()
end

if not pad:cross() and timer:time() > 0 and timer:time() < 1000 then
-- Dossiers et fichiers
 if cury > 15 and cury < 250 then
  if Fichiers[math.ceil((cury+y)/20)].directory then
   System.currentDirectory(Fichiers[math.ceil((cury+y)/20)].name)
   Fichiers = System.listDirectory()
   table.sort(Fichiers, function(a,b) if a.directory == b.directory then return a.name:lower() < b.name:lower() else return a.directory end end)
   Partie = 1
   selector = 1
  else
   extension = string.upper(string.sub(Fichiers[math.ceil((cury+y)/20)].name,-3))
   if extension == "MP3" then
    Mp3me.load(Fichiers[math.ceil((cury+y)/20)].name)
    Mp3me.play()
    FX.Music(1)
   end
   if extension == "OGG" then
    Ogg.load(Fichiers[math.ceil((cury+y)/20)].name)
    Ogg.play()
    FX.Music(2)
   end
   if extension == "JPG" or extension == "PNG" then
    FX.pic(Image.load(Fichiers[math.ceil((cury+y)/20)].name))
   end
   if extension == "TTF" then
    sma_police_preview = Font.load(Fichiers[math.ceil((cury+y)/20)].name)
    sma_police_preview:setPixelSizes(10,10)
    med_police_preview = Font.load(Fichiers[math.ceil((cury+y)/20)].name)
    med_police_preview:setPixelSizes(15,15)
    big_police_preview = Font.load(Fichiers[math.ceil((cury+y)/20)].name)
    big_police_preview:setPixelSizes(20,20)
    font_size = 2
    FX.font()
   end
   if extension == "TXT" or extension == "INI" or extension == "LOG" then
    document = io.open(Fichiers[math.ceil((cury+y)/20)].name,"r")
    lignes = 1
    texte_ = {}
    for line in document:lines() do
     texte_[lignes] = line
     lignes = lignes + 1
    end
    document:close()
    pos_txty = 20
    pos_txtx = 0
    FX.text()
   end
   if extension == "LUA" then
    if question("Lancer le script lua?") == 1 then
     dofile(System.currentDirectory().."/"..Fichiers[math.ceil((cury+y)/20)].name)
    end
   end
   if extension == "PBP" then
    if question("Lancer le PBP?") == 1 then
     System.runeboot(System.currentDirectory().."/"..Fichiers[math.ceil((cury+y)/20)].name)
    end
   end
  end
 end
 timer:stop()
 timer:reset(0)
end

if pad:cross() and timer:time() > 0 then
 screen.circle(curx,cury,10-timer:time()/100,blanc)
end

if timer:time() > 1000 then
 timer:stop()
 timer:reset()
 FX.menu()
end

screen:fillRect(0,260,480,12,rouge)
screen:fillRect(System.getFreeSpace("ms0:")/System.getTotalSize("ms0:")*480,260,480-System.getFreeSpace("ms0:")/System.getTotalSize("ms0:")*480,12,bleu)
screen:fontPrint(xsmall_font,2,269,100-math.floor(System.getFreeSpace("ms0:")/System.getTotalSize("ms0:")*100).."% de la MS occupes",blanc)
Android:Barre()

if pad:select() and not oldpad:select() then
 break
end

Android:Souris()
screen:flip()
screen.waitVblankStart()
oldpad = pad
end
-- Retour au dossier Android
System.currentDirectory(adresse)
