import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

PImage[] slideshow = new PImage [5];
int count;

int timer;

int hOffset;
int w = 1280;
int h = 720;

void setup() {
  //fullScreen();
  size(1280,720);
  video = new Capture(this, width/4, height/4);
  opencv = new OpenCV(this, width/4, height/4);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);

  video.start();
  
  for (int i = 0; i < slideshow.length; i++){
      slideshow[i] = loadImage("angel"+i+".png");
  }
  
  smooth(2);
  hOffset = 0;
}

void draw() {
  background(30);
  
   if (count>4){
    count=0;
  } else if(count<0){
    count=0;
  }
  image(slideshow[count],0,0,width,height);
  
  randomFilter();
  
  getSetGlitch3();
  elementGlitch2();
  elementGlitch4();
  
  scale(4);
  opencv.loadImage(video);
  Rectangle[] faces = opencv.detect();
  
  if (faces.length==0){
    timer++;
  } else {
    timer=0;
    fill(0,255,0);
    noStroke();
    //ellipse(10,10,5,5);
  }
  if (timer == 10){
    count ++; 
  }
  
  //println(faces.length);
  
  //faceoutline
   /*rect
  noFill();
  stroke(0, 255, 0);
  strokeWeight(1);
  for (int i = 0; i < faces.length; i++) {
    //println(faces[i].x + "," + faces[i].y);
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }*/
  
}

void captureEvent(Capture c) {
  c.read();
}

void getSetGlitch3() {
  loadPixels();  
  for (int i=0; i<12; i++) {
    int x = r(w);
    int y = r(h);
    set(x + r(50) - 1, y + r(3) - 1, get(x, y, r(65), r(10)));
  }
}
 
void elementGlitch2() {
  if (frameCount % (r(250) + 1) == 0) {
    int lineDensity = int(noise(frameCount) * width);
    for (int i=0; i<700*1.5; i+=lineDensity) {
      stroke(0);
      strokeWeight(1);
      line(0, i, i, 0);
    }
  }
}

void elementGlitch4() {
  if (frameCount % 10 == 0) {
    int x = r(20);
    int y = r(20);
    int wi = r(w/2);
    int he = r(h/3);
    PImage el = get(x, y, wi, he);
    
    int offsetx = r(w - wi);
    int offsety = r(h - he);
    
    int[] filters = new int[14];
    filters[0] = BLEND; 
    filters[1] = ADD;
    filters[2] = SUBTRACT;
    filters[3] = LIGHTEST;
    filters[4] = DARKEST;
    filters[5] = DIFFERENCE;
    filters[6] = EXCLUSION;
    filters[7] = MULTIPLY;
    filters[8] = SCREEN;
    filters[9] = OVERLAY;
    filters[10] = HARD_LIGHT;
    filters[11] = SOFT_LIGHT;
    filters[12] = DODGE;
    filters[13] = BURN;
    
    int rndfilter = r(14);
    
    blend(el, 0, 0, wi, he, offsetx, offsety, wi, he, filters[rndfilter]);
  }
}

int r(int a){
  return int(random(a));
}

void randomFilter() {
  int rnd = 2 + r(50);
  if (rnd <= 7) {
    filter(BLUR, 1 + r(6));
  } else if (rnd > 7 && rnd <= 13) {
    filter(POSTERIZE, 2 + r(200));
  } else if (rnd > 13 && rnd <= 20) {
    filter(DILATE);
  } else if (rnd > 20 && rnd <= 25 ) {
    filter(ERODE);
  } else if (rnd > 25 && rnd <= 28) {
    filter(GRAY);
  }
}

void keyPressed(){
  if (keyCode == UP){
    count++;
  } else if (keyCode == DOWN){
   count--;
  }
}
