local back = Image.load("IMG/recherche full.png")
while true do
pad = Controls.read()
screen:clear(blanc)
Android:Barre()
screen:blit(0,26,back)
Android:Souris()

if curx >= 52 and curx <= 418 and cury >= 34 and cury <= 71 then
 if pad:cross() then
  search = System.startOSK("Rechercher","Recherche Google")
  Android:Google(search)
 end
end

if pad:circle() then
 Android:Quitter()
end

if pad:select() and not oldpad:select() then
 Android:Quitter()
end

oldpad = pad
screen.flip()
screen.waitVblankStart()
end
