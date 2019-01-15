import processing.video.*;
//colorsearch


Capture video;
PImage prev;
color trackColor;

float threshold = 170;

void setup(){
  size(640,360);
 
  video = new Capture(this, width, height, 24);
  video.start();
  prev = createImage(video.width, video.height, RGB);
  noFill();
  //trackColor = color(#34AAA1); //flasche 
  //trackColor = color(#C3F000); //marker #E9FF00#C3F000
  //trackColor = color(20); // schwarz
  //trackColor = color(#FFE2A7); //skin?
  trackColor = color(255,0,0); // rot
}

void captureEvent(Capture video){
  prev.copy(video, 0,0, video.width, video.height, 0, 0, prev.width, prev.height);
  prev.updatePixels();
  video.read();
}

void draw(){
  video.loadPixels();
  image(video,0,0);
  
  //threshold = map(mouseX, 0, width, 0, 100);
  
  //fill(100);
  //noStroke();
  //rect(0,0,640,360);
  float avgX = 0;
  float avgY = 0;
  
  int count = 0;
  
  for(int x=0; x < video.width; x++){
    for(int y=0; y < video.height; y++){
      
      int loc = x + y * video.width;
      
      color currentColor1 = video.pixels[loc];
      
      float r1 = red(currentColor1);
      float g1 = green(currentColor1);
      float b1 = blue(currentColor1);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);
      
      float d = distSq(r1, g1, b1, r2 ,g2, b2);
      
      if (d< threshold*threshold){
        stroke(255);
        strokeWeight(1);
        point(x,y);
        avgX += x;
        avgY += y;
        count++;  
      }
    }
  }
  if (count > 0){
    avgX = avgX / count;
    avgY = avgY /count;
    
    fill(trackColor);
    strokeWeight(2);
    stroke(0);
    ellipse(avgX, avgY, 20,20);
  } 
  //print(threshold);
}


float distSq(float x1, float y1, float z1, float x2, float y2, float z2){
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1);
  return d;
}