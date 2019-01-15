import gab.opencv.*;
import processing.video.*;
import java.awt.*;

OpenCV opencv;
Capture video;

void setup() {
  size(640, 480);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  
  //opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  video.start();  
}

void draw() {
  background(0);
  scale(2);
  opencv.loadImage(video);
  opencv.calculateOpticalFlow();

  //image(video, 0, 0);
  //translate(video.width,0);
  stroke(0,0,255);
  opencv.drawOpticalFlow();
  
  PVector aveFlow = opencv.getAverageFlow();
  int flowScale = 50;
  
  stroke(255);
  strokeWeight(2);
  line(video.width/2, video.height/2, video.width/2 + aveFlow.x*flowScale, video.height/2 + aveFlow.y*flowScale);
}

void movieEvent(Movie m) {
  m.read();
}

void captureEvent(Capture c) {
  c.read();
}
