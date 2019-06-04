while 1 do
screen:clear(Color.new(255,255,255))
pad = Controls.read()

screen:print(2,132,"Appuyez sur X pour effacer les logs d'erreur.")

if pad:cross() and not oldpad:cross() then
 System.currentDirectory("Error Log")
 table = System.listDirectory()
 for i = 3,# table do
  System.removeFile(table[i].name)
 end
 System.currentDirectory(adresse)
end

Android:Barre()
screen.flip()
screen.waitVblankStart()
oldpad = pad
end
