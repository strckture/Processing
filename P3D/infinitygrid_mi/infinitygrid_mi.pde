float tilesize=150;
float size=16;


void setup(){
  size(1280, 768, P3D);
  smooth();
}

void draw(){
  
  background(20);
  camera(mouseX, mouseY, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  translate(width/2, height/2, 0);
  
  noFill();
  for (float x = -size/2; x <= size/2; x++) {
    for (float y = -size/2; y <= size/2; y++) {
      for (float z = -size/2; z <= size/2; z++) {
        pushMatrix();    
        stroke(0, 255, 0, map(dist(x, y, z, x*300, y*650, z*450), 0, 20/2*200, 50, 0));
        translate(x*tilesize, y*tilesize, z*tilesize);
        box(tilesize);
        popMatrix();
      }
    }
  }
}
