fond = Image.load("APPS/CALCULATRICE/fond.png")
nombre = ""
operation = " "

function virgule(string)
 for i = 1, #string do
  if string.sub(string,i,i) == "." then
   return true
  end
 end
end

while true do
 screen:clear()
 pad = Controls.read()

 screen:blit(0,15,fond)

 screen:fontPrint(big_font,480-#nombre*14,60,nombre,blanc)

 if pad:cross() and not oldpad:cross() then
  if curx < 120 then-- Colonne 1
   if cury > 91 and cury < 136 then
    nombre = nombre..7
   elseif cury > 136 and cury < 181 then
    nombre = nombre..4
   elseif cury > 181 and cury < 226 then
    nombre = nombre..1
   elseif cury > 226 and not virgule(nombre) then
    nombre = nombre.."."
   end
  elseif curx < 240 then-- Colonne 2
   if cury > 91 and cury < 136 then
    nombre = nombre..8
   elseif cury > 136 and cury < 181 then
    nombre = nombre..5
   elseif cury > 181 and cury < 226 then
    nombre = nombre..2
   elseif cury > 226 then
    nombre = nombre..0
   end
  elseif curx < 360 then-- Colonne 3
   if cury > 91 and cury < 136 then
    nombre = nombre..9
   elseif cury > 136 and cury < 181 then
    nombre = nombre..6
   elseif cury > 181 and cury < 226 then
    nombre = nombre..3
   elseif cury > 226 and operation ~= " " then
    if operation == "+" then
     nombre = tostring(tonumber(nombre)+oldNombre)
    elseif operation == "-" then
     nombre = tostring(oldNombre-tonumber(nombre))
    elseif operation == "*" then
     nombre = tostring(oldNombre*tonumber(nombre))
    elseif operation == "/" then
     nombre = tostring(oldNombre/tonumber(nombre))
    end
    operation = " "
    oldNombre = 0
   end
  else -- Colonne 4
   if cury > 66 and cury < 91 then
    nombre = string.sub(nombre,1,-2)
   elseif cury > 91 and cury < 136 and operation == " " then
    oldNombre = tonumber(nombre)
    nombre = ""
    operation = "/"
   elseif cury > 136 and cury < 181 and operation == " " then
    oldNombre = tonumber(nombre)
    nombre = ""
    operation = "*"
   elseif cury > 181 and cury < 226 and operation == " " then
    oldNombre = tonumber(nombre)
    nombre = ""
    operation = "-"
   elseif cury > 226 and operation == " " then
    oldNombre = tonumber(nombre)
    nombre = ""
    operation = "+"
   end
  end
 end

 if pad:select() and not oldpad:select() then
  break
 end

 Android:Barre()

 Android:Souris()

 screen:flip()
 screen.waitVblankStart()
 oldpad = pad
end
