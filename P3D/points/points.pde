//spacing

int linespacex= 20;
int linespacey= 20;
int linespacez= 20;

float distance=2;

float t=0;
float p=0;

void setup(){
  size(500,500, P3D);
  background(0);
  frameRate(60);
}

void draw(){
  background(0);
  
  translate(width/2, height/2);
  
  rotateX(radians(t));
  rotateY(radians(t));
  
  for(int x=0; x<linespacex; x++){
    for(int y=0; y<linespacey; y++){
      for(int z=0; z<linespacez; z++){
      stroke(50,255,200);
      rotateX(radians(-p));
      rotateY(radians(-p));
      point(y*distance, 250);
      }
    }
  }
  t += 1;
  p += 1;
}
  