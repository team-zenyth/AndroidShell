local data =  {}
local offset = {}

local quitter=false

icone = Image.load("APPS/Game/fond.png")
fond = Image.load("APPS/Game/back.png")

function convertHexaDec(word,mode)
  local offset = ""
  local result = 0
  local number = 0
  local n = 0
  if mode == nil then
    for i = 4 , 1 , -1 do
      offset = offset..string.format("%X",word:byte(i))
    end
  else
    offset = word
  end
  for i = #offset , 1 , -1 do
    if offset:sub(i,i) == "A" then
      number = 10
    elseif offset:sub(i,i) == "B" then
      number = 11
    elseif offset:sub(i,i) == "C" then
      number = 12
    elseif offset:sub(i,i) == "D" then
      number = 13
    elseif offset:sub(i,i) == "E" then
      number = 14
    elseif offset:sub(i,i) == "F" then
      number = 15
    else
      number = offset:sub(i,i)
    end
    result = result + number*16^n
    n = n + 1
  end
  return result
end

function convertDecHexa(dec)
  local hex = ""
  local result = ""
  while dec > 15 do
    tmp = dec-(math.floor(dec/16))*16
    hex = string.format("%X",tmp)..hex
    dec = math.floor(dec/16);
  end
  hex = string.format("%X",dec)..hex
  for i = #hex , 7 do
    hex = "0"..hex
  end
  for i = 8 , 1 , -2 do
    result = result..string.char(convertHexaDec(hex:sub(i-1,i),1))
  end
  return result
end

System.currentDirectory("ms0:/PSP/GAME/")
liste = System.listDirectory()

table.remove(liste,1)
table.remove(liste,1)


table.sort(liste, function(a,b) if a.dir == b.dir then return a.name:lower() < b.name:lower() else return a.dir end end)

local i = 1
while i < #liste do
 if liste[i].name == ".android" then
  table.remove(liste , i )
  i = i - 1
 elseif not liste[i].directory then
  table.remove(liste , i )
  i = i - 1
 end
 i = i + 1
end

local selecteur = 1

System.currentDirectory("ms0:/PSP/GAME/.Android")

function readeboot()

local eboot = io.open("ms0:/PSP/GAME/"..liste[selecteur].name.."/eboot.pbp","rb")
if not eboot then
 error("L'eboot \""..liste[selecteur].name.."\" n'existe pas")
end

local ident = eboot:read(4)
if ident:byte(1)..ident:byte(2)..ident:byte(3)..ident:byte(4) ~= "0806680"  then
 error("L'eboot \""..liste[selecteur].name.."\" n'est pas valide")
end

data.size = eboot:seek("end")

-- Offsets
eboot:seek("set",8)
for i = 1, 8 do
 offset[i] = convertHexaDec(eboot:read(4))
end

-- Icon0

if offset[2] ~= offset[3] then
 eboot:seek("set",offset[2])
 local image = eboot:read(offset[3]-offset[2])
 data.icon0 = Image.loadFromMemory(image)
end

-- Pic1
if offset[5] ~= offset[6] then
 eboot:seek("set",offset[5])
 local image = eboot:read(offset[6]-offset[5])
 data.pic1 = Image.loadFromMemory(image)
else
 data.pic1 = nil
end

end

readeboot()

while true do
 pad = Controls.read()
 screen:clear(blanc)

 if data.pic1 ~= nil then
  screen:blit(0,0,data.pic1)
 else
  screen:blit(0,15,fond)
 end

 if pad:up() and not oldpad:up() then
  selecteur = selecteur - 1
  readeboot()
 end

 if pad:down() and not oldpad:down() then
  selecteur = selecteur + 1
  readeboot()
 end

 if pad:r() and not oldpad:r() then
  System.runeboot("ms0:/PSP/GAME/"..liste[selecteur].name.."/eboot.pbp")
 end

 Android:Barre()
 screen:print(2,2,selecteur.."/"..#liste,bleu)

 screen:blit(140-icone:width()/2,149-icone:height()/2,icone)
 if data.icon0 ~= nil then
  screen:blit(140-data.icon0:width()/2,149-data.icon0:height()/2,data.icon0)
 end

if lang == "FR" then
 screen:fontPrint(font,10,260,"Appuyez sur R pour lancer l'eboot.",bleu)
else
 screen:fontPrint(font,10,260,"Press R to start the eboot.",bleu)
end

if pad:select() and not oldpad:select() and quitter==false then
 quitter=true
elseif pad:select() and not oldpad:select() and quitter==true then
 quitter=false
end

if quitter == true then
 if lang == "FR" then
  if Android:Alerte("Quitter?","Voulez-vous vraiment quitter?","Annuler","Quitter") == 2 then
   quitter = false
   break
  elseif Android:Alerte("Quitter?","Voulez-vous vraiment quitter?","Annuler","Quitter") == 1 then
   quitter = false
  end
 else
  if Android:Alerte("Quit?","Are you sure you want to close the app?","Cancel","Quit") == 2 then
   quitter = false
   break
  elseif Android:Alerte("Quit?","Are you sure you want to quit?","Cancel","Quit") == 1 then
   quitter = false
  end
 end
end

oldpad = pad
screen.flip()
screen.waitVblankStart()
end
