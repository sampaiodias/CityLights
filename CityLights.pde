/*
 * Lucas Sampaio Dias
 * Copyright (c) 2019.
 * Instituto de Informática (UFG)
 * Creative Commons Attribution 4.0 International License.
 */

PImage city;
PImage sprite;
int minLight = 240;
ArrayList<Spawner> spawners = new ArrayList<Spawner>();

void setup() {
  size(590, 332, P2D);
  city = loadImage("city1.jpg");
  sprite = loadImage("particle.png");
  
  for(int x = 0; x < 590; x++) {
    for(int y = 0; y < 332; y++) {
      color c = city.get(x, y);
      if(isRed(c) || isYellow(c) || isWhite(c)) {
        ParticleSystem ps = new ParticleSystem(10, c);
        Spawner s = new Spawner();
        s.ps = ps;
        s.posX = x;
        s.posY = y;
        spawners.add(s);
      }
    }
  }
  
  // Writing to the depth buffer is disabled to avoid rendering
  // artifacts due to the fact that the particles are semi-transparent
  // but not z-sorted.
  hint(DISABLE_DEPTH_MASK);
}

void draw() {
 image(city, 0, 0);
 for(Spawner s : spawners) {
  s.ps.update();
  s.ps.display();
  s.ps.setEmitter(s.posX, s.posY);
 }
}

class Spawner {
  int posX, posY;
  ParticleSystem ps;
}

boolean isRed(color c) {
  return (red(c) > minLight && green(c) > 150 && blue(c) < 150);
}

boolean isYellow(color c) {
  return (red(c) > minLight && green(c) < 150 && blue(c) < 150);
}

boolean isWhite(color c) {
  return (red(c) > minLight && green(c) > minLight && blue(c) > minLight);
}
