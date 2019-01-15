import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

int gridSize = 100;

int scl=4;
int w=1280;
int h=768;

float c=20;

float cx;
float cy;
float cz;

float lerpX;
float lerpY;
float lerpZ;

void setup() {
  size(1280, 768,P3D);
  //size(960, 640,P3D);
  //fullScreen(P3D);
  
  video = new Capture(this, w/scl, h/scl);
  opencv = new OpenCV(this, w/scl, h/scl);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  
  video.start();
  smooth();
}

void draw() {
  //scale(2);
  opencv.loadImage(video);
  background(255);
  //image(video, 0, 0 );
  
  pointLight(c,c,c,1500,400,900);
  pointLight(c,c,c,-100,400,900);
  pointLight(c,c,c,width/2,900,900);
  pointLight(c,c,c,width/2,0,900);
  
  spotLight(255, 255, 255, 950, 258, 300, -1, 0, 0, PI/2, 2);
  
  ////////////////////////////////////////////////
  
  pushMatrix();
  
  //spotLight(255, 255, 255, 950, 258, 300, -1, 0, 0, PI/2, 2);
  
  //---------------default cam-------------------//
  //camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  //---------------------------------------------//
  
  lerpX= lerp(lerpX,cx,0.3);
  lerpY= lerp(lerpY,cy,0.3);
  lerpZ= lerp(lerpZ,cz,0.1);
  
  //camera(width-cx*2, cy*2, (height/2.0) / tan(PI*30.0 / 180.0),width-cx*2, cy*2, 0, 0, 1, 0);
  //camera(width-cx*2, cy*2, (height/2.0) / tan(PI*30.0 / 180.0),width/2.0, height/2.0, 0, 0, 1, 0);
  camera(width-lerpX*scl, lerpY*scl, (height/1.5-lerpZ*2.5) / tan(PI*30.0 / 180.0),width/2.0, height/2.0, 0, 0, 1, 0);
  //camera(lerpX*scl, lerpY*scl, (height/1.5-lerpZ*2.5) / tan(PI*30.0 / 180.0),width/2.0, height/2.0, 0, 0, 1, 0);
  
  translate(width/2, height/2,-100);
  
  fill(200);
  
  noStroke();
  box(width+10,height+10,5000);
  
  fill(255,0,0);
  box(100);
  
  translate(0, 0, -100);
  
  strokeWeight(1);
  stroke(100,255,100);
  
  /*for(int i = -width/2; i <width/2; i+=gridSize) {
    for(int j = -600; j < height/2; j+=gridSize) {
      int y = 200;
      line(i,          y, j,           i+gridSize, y, j          );
      line(i+gridSize, y, j,           i+gridSize, y, j+gridSize );
      line(i+gridSize, y, j+gridSize,  i,          y, j+gridSize );
      line(i,          y, j,           i,          y, j+gridSize );
    }
  }*/
  popMatrix();
  
  ////////////////////////////////////////////////

  //stroke(0);
  strokeWeight(1);
  Rectangle[] faces = opencv.detect();
  scale(scl);
  
  for (int i = 0; i < faces.length; i++) {
    //rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    cx= (faces[i].x+(faces[i].x+faces[i].width))/2;
    cy= (faces[i].y+(faces[i].y+faces[i].height))/2;
    cz= faces[i].width;
    //ellipse(cx,cy,5,5);
  }
}

void captureEvent(Capture c) {
  c.read();
}
