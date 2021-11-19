import peasy.*;
import processing.video.*;
Capture video;

PeasyCam cam;

int mapWidth = 3954;
int mapHeight = 4086;

PVector[][] globe;
int total = 200;

void setup() {
  fullScreen(P3D);
  //this = this sketch
  cam = new PeasyCam(this, 500);
  colorMode(HSB);
  
  globe = new PVector[total+1][total+1];
  
  video = new Capture(this, width*3, height*3);
  video.start();
  
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
  background(0);
  float r = 200;
  for (int i = 0; i < total+1; i++) {
      float lat = map(i, 0, total, 0, PI);
    for (int j = 0; j < total+1; j++) {
      float lon = map(j, 0, total, 0, TWO_PI);
      float x = r * sin(lat) * cos(lon);
      float y = r * sin(lat) * sin(lon);
      float z = r * cos(lat);
      globe[i][j] = new PVector(x,y,z);
    }
  }
    //..und wird hier dann dargestellt
    for (int i = 0; i < total; i++) {

      beginShape(TRIANGLE_STRIP);
      texture(video);
      for (int j = 0; j < total+1; j++) {
        PVector v1 = globe[i][j];
        noStroke();
        vertex(v1.x, v1.y, v1.z, j*mapWidth/total, i*mapHeight/total);
        PVector v2 = globe[i+1][j];
        vertex(v2.x,v2.y,v2.z, j*mapWidth/total, (i+1)*mapHeight/total);
      }
    endShape();
  }
}
