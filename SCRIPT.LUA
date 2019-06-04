System.setHigh()

--  ______________________  --
--/|----------------------|\--
--||* Made by Psgarsenal *||--
--||*    Team  Zenyth    *||--
--||*~~~~~~~~~~~~~~~~~~~~*||--
--||* bendermix.free.fr/ *||--
--\|______________________|/--
--  ----------------------  --

dofile("eslib.lua")

blanc = Color.new(255,255,255)
gris = Color.new(25,25,25)
noir = Color.new(0,0,0)
bureau = 2--position bureau
option_selecteur = 1
adresse = System.currentDirectory()
font = Font.load("System/Font/Roboto-Regular.ttf")
font:setPixelSizes(16,16)
big_font = Font.load("System/Font/Roboto-Regular.ttf")
big_font:setPixelSizes(24,26)
small_font = Font.load("System/Font/Roboto-Regular.ttf")
small_font:setPixelSizes(13,13)
xsmall_font = Font.load("System/Font/Roboto-Regular.ttf")
xsmall_font:setPixelSizes(10,10)
dofile("SYSTEM/option.lua")
System.currentDirectory("APPS")
Apps = System.listDirectory()
table.remove(Apps,1)
table.remove(Apps,1)
table.sort(Apps, function(a,b) if a.dir == b.dir then return a.name:lower() < b.name:lower() else return a.dir end end)
app_list = Image.createEmpty(480,257)
app_list:clear(noir)

local x = 10
local y = 10
for i = 1, #Apps do
 if x > 480 then x = 10 y = y+60 end
 icone = Image.load(Apps[i].name.."/icon.png")
 if icone:width() ~= 40 or icone:height() ~= 40 then
  icone = Image.resize(icone,40,40)
 end
 app_list:blit(x,y,icone)
 app_list:fontPrint(xsmall_font,x+20-#Apps[i].name*2,y+55,Apps[i].name,blanc)
 x = x + 60
end

System.currentDirectory(adresse)

screen:clear()
screen.flip()

screen:clear()

mask = Image.load("IMG/BOOT/mask.png")
shine = Image.load("IMG/BOOT/shine.png")

for i = 1,960 do
 screen:clear()
 screen:fillRect(112,104,256,64,Color.new(96,128,128))
 screen:blit(i-240,104,shine)
 screen:blit(i-720,104,shine)
 screen:blit(112,104,mask)
 screen:fillRect(0,104,112,64,noir)
 screen:fillRect(368,104,112,64,noir)
 screen.flip()
end
image = nil
boot = nil
screen:clear()
screen.flip()

Options=false
dofile("SYSTEM/fonctions.lua")
dofile("SYSTEM/option.lua")
dofile("wall/"..wall_choisis)

veille = 0
dofile("system/lock.lua")
dofile("system/bureau.lua")
