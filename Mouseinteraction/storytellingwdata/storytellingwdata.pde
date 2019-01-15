float si;
float f=100;
float value=0.01;

void setup(){
 size(1080,720);
 background(10);
 frameRate(60);
 colorMode(HSB,100,100,100);
}

void draw() {
  if (mousePressed){
    fill(100,0,30);
    noStroke();
    ellipse(mouseX,mouseY,30,30);
  }
  
  if (mouseX == pmouseX && mouseY == pmouseY){
    si+=0.3;
    fill(100,0,100);
    noStroke();
    ellipse(mouseX,mouseY,si,si);
  } else {
    si = 2;
  }
  
  f = f - value;
  
  if (f > 100 || f < 0){
    value= value * -1;
  }
  stroke(f,100,100);
  strokeWeight(1.5);
  line(mouseX, mouseY, pmouseX, pmouseY);
}
