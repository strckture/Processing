class Beam{
  
 float x;
 float y;
 float z;
 float h;
 float d;
 
 float v;
 float op =200;
 
 Beam(){
   x = random(-2000,2000);
   y = random(-2000,2000);
   z = random(2000);
   
   h = random(10,40);
   d = random(80,600);
 }
 
 void update(){
   z-=20;
   if (z <= 0.0){
     reset();
   }
 }
 
 void reset(){
   x = random(-2000,2000);
   y = random(-2000,2000);
   z = 2000;
 }
 
 void display(){
  float offsetX = 100 *(x/z);
  float offsetY = 100 *(y/z);

  strokeWeight(1);
  fill(58,44,30);
  stroke(255);
  
  pushMatrix();
  translate(offsetX,offsetY,-z);
  //noFill();
  strokeWeight(1);
  stroke(0);
  box(h,h,d);
  fill(225,177,60);
  noStroke();
  box(h+0.5,6,d);
  popMatrix();
 }
}
