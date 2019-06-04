if System.doesFileExist("APPS/Apollo/librairie.txt") then
 dofile("librairie.txt")
else
 System.currentDirectory("ms0:/PSP/MUSIC/")
 table = System.listDirectory()
 index = {unknown = {titre = "Artiste Inconnu",{titre = "Album Inconnu"}}}
 for i = 1, #table do
  if table[i].folder then
   table.insert(index,1,{titre = table[i].name})
  else
   table.insert(index.unknown[2],2,{titre = table[i].name})
  end
 end
end

while true do
 pad = Controls.read()
 screen:clear()

 for i = 1, #index do
  screen:print(0,20 +i*10,index[i].titre,blanc)
 end
 if pad:select() and not oldpad:select() then
  break
 end

 Android:Barre()
 screen:flip()
 screen.waitVblankStart()
 oldpad = pad
end
