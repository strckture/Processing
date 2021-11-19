import processing.svg.*;
boolean record;

Beam[] beams = new Beam[100]; 

void setup(){
  size(800,800,P3D);
  background(236,54,17);
  for(int i=0; i<100; i++){
    beams[i] = new Beam();
  }
}

void draw(){
  if (record) {
    beginRaw(SVG, "output####.svg");
  }
  background(236,54,17);
  translate(0.5*width, 0.5*height);
  for(int i=0; i<100; i++){
    beams[i].update();
    beams[i].display();
  }
  camera(mouseX, mouseY, (height/2) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  noCursor();
  if (record) {
    endRaw();
    record = false;
  }
}

void keyPressed() {
  if (key == 'r') {
    record = true;
  }
}
