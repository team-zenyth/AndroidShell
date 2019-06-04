dofile("SYSTEM/wall statique.lua")
local fond = Image.load("wall/wallpaper/"..numero_wall..".jpg")
function Android:Fond()
screen:blit(0,15,fond)
end
