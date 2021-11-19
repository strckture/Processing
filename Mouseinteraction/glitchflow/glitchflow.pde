import gab.opencv.*;
import processing.video.*;
import java.awt.*;

OpenCV opencv;
Capture video;

int scl=4;

void setup() {
  size(1280, 768);
  //fullScreen();
  video = new Capture(this, width/scl, height/scl);
  opencv = new OpenCV(this, width/scl, height/scl);
  
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  video.start();  
  background(0);
}

void draw() {
  if (mousePressed){
    background(0);
  }
  opencv.loadImage(video);
  opencv.calculateOpticalFlow();
  
  scale(4);
  
  stroke(255);
  strokeWeight(.7);
  opencv.drawOpticalFlow();
  
}

void movieEvent(Movie m) {
  m.read();
}

void captureEvent(Capture c) {
  c.read();
}
