ArrayList myCircles;
float ballSpeed = 2;

float x=0;

void setup() {
  size(1080, 720,P3D);
  background(255);
  smooth();
  myCircles = new ArrayList();
  myCircles.add(new Circle(random(width), random(height)));
}

void draw() {
  
  background(255);
  
  if (frameCount > 40*ballSpeed) {
    myCircles.add(new Circle(random(width), random(height)));
    if (ballSpeed > 0.5)
      ballSpeed -= 0.2;
    frameCount = 0;
  }

  for (int i=0; i < myCircles.size(); i++) {
    Circle myCircle = (Circle)myCircles.get(i);
    myCircle.drawCircle();
  }
  x++;
}

class Circle {
  PVector circle = new PVector(0, 0, 0);
  PVector sum = new PVector(0, 0, 0);
  float circleSize = random(10,20);
  int alph = 0;
  
  Circle(float tempX, float tempY) {
    circle.set(tempX, tempY, 0);
  }
  
  float bgc = random(255);
  float bgc1 = random(255);
  float bgc2 = random(255);
  
  void drawCircle() {
    fill(bgc,bgc1,bgc2, alph);
    //stroke(bgc,bgc1,bgc2, alph);
    //strokeWeight(15);
    noStroke();

    PVector mouse = new PVector(mouseX, mouseY, 0);
    mouse.sub(circle);
    mouse.mult(0.05);
    sum.add(mouse);
    sum.normalize();
    sum.mult(0.6);
    circle.add(sum);
    
    
    ellipse(circle.x, circle.y, circleSize, circleSize);
    //point(circle.x,circle.y,circle.z);
    strokeWeight(1);
    stroke(0,20);
    line(width/2,height/2,circle.x,circle.y);
    alph += 8;
  }
}
