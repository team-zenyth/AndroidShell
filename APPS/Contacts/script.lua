System.currentDirectory("ms0:/PSP/GAME/Android/APPS/Contacts [En cours]/liste")
local liste = System.listDirectory()

table.remove(liste,1)
table.remove(liste,1)

table.sort(liste, function(a,b) if a.dir == b.dir then return a.name:lower() < b.name:lower() else return a.dir end end)

System.currentDirectory("ms0:/PSP/GAME/Android")

local quitter = false

while true do
screen:clear()
pad = Controls.read()
Android:Barre()

for i=1, #liste do
 screen:fontPrint(font,10,40+i*50,liste[i].name,bleu)
end

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

screen.flip()
screen.waitVblankStart()
oldpad = pad
end
