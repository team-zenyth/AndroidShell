local Picture = {}
function Picture.load(path, rho) -- path : chemin de l'image, rho : rayon du cercle de rotation
 --- Creation d'une table self
 local self = {}
 self.img = Image.load(path) -- image
 self.rotation = {}
 self.rotation.rho = rho -- on stock le rayon
 self.rotation.theta = 0 -- on stock l'angle theta
 self.x = 0 -- on initialise le centre de rotation en X
 self.y = 0 -- on initialise le centre de rotation en Y
 -- Note: les valeurs changerons.
           
 return(self) -- on retourne la table pour utiliser la fonction comme cela : tab = Picture.load("img.png", 50)
end
     
function Picture.start(self, x, y, vitesse)
 -- self table déclarer : tab = Picture.load(...) ;
 -- x et y sont les coordonnées du centre de rotation.
 -- Vitesse : valeur de 1 à 10, plus c'est proche de 1 plus c'est rapide et inversement pour une vitesse égal à 10.
 self.rotation.theta = self.rotation.theta + 1/(10*vitesse)-- iteration de theta
 self.x = x+self.rotation.rho*math.cos(self.rotation.theta) -- Détermination de la nouvelle valeur de x;
 self.y = y+self.rotation.rho/2*math.sin(self.rotation.theta) -- Détermination de la nouvelle valeur de y;
 -- Ainsi le point aura pour trajectoire un cercle, et l'image aura un mouvement circulaire.
 ---
 screen:blit(self.x, self.y, self.img) -- On affiche l'image qui sera en rotation :)
end

local star = {}

function star.create(rho) -- rho : rayon du cercle de rotation
 --- Creation d'une table self
 local self = {}
 self.rotation = {}
 self.rotation.rho = rho -- on stock le rayon
 self.rotation.theta = math.random(1,90) -- on stock l'angle theta
 self.x = 0 -- on initialise le centre de rotation en X
 self.y = 0 -- on initialise le centre de rotation en Y
 return(self) -- on retourne la table pour utiliser la fonction comme cela : tab = Picture.load("img.png", 50)
end
     
function star.start(self, x, y, vitesse)
 -- x et y sont les coordonnées du centre de rotation.
 -- Vitesse : valeur de 1 à 10, plus c'est proche de 1 plus c'est rapide et inversement pour une vitesse égal à 10.
 self.rotation.theta = self.rotation.theta + 1/(10*vitesse)-- iteration de theta
 self.x = x+self.rotation.rho*math.cos(self.rotation.theta) -- Détermination de la nouvelle valeur de x;
 self.y = y+self.rotation.rho/2*math.sin(self.rotation.theta) -- Détermination de la nouvelle valeur de y;
 -- Ainsi le point aura pour trajectoire un cercle, et l'image aura un mouvement circulaire.
 ---
 screen:pixel(self.x, self.y,Color.new(255,255,255)) -- On affiche l'image qui sera en rotation :)
end

local Background = Image.load("res/black hole/bg.png")
local self = Picture.load("res/black hole/cloud.png",50)

etoile = {}
for i = 1, 70 do
 etoile[i] = {self = star.create(math.random(10,200)),vit = math.random(1,3)}
end

while true do
 screen:clear()
 screen:blit(0,26,Background)
 pad = Controls.read()
 if pad:cross() then break end
 Picture.start(self,220,120,2)
 for i = 1, 70 do
  star.start(etoile[i].self,240,120,etoile[i].vit)
 end
 screen.waitVblankStart()
 screen.flip()
end
