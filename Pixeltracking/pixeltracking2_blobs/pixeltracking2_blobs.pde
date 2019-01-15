import processing.video.*;

Capture video;
PImage prev;
color trackColor;

float threshold = 100;
float distThreshold = 25;

ArrayList<Blob> blobs = new ArrayList<Blob>();

void setup(){
  size(640,360);
 
  video = new Capture(this, width, height, 24);
  video.start();
  prev = createImage(video.width, video.height, RGB);
  noFill();
  trackColor = color(255,0,0);
}

void captureEvent(Capture video){
  prev.copy(video, 0,0, video.width, video.height, 0, 0, prev.width, prev.height);
  prev.updatePixels();
  video.read();
}

void keyPressed(){
  if (key == 'a'){
    distThreshold++;
  } else if (key == 'd'){
    distThreshold--;
  }
  println(distThreshold);
}

void draw(){
  video.loadPixels();
  image(video,0,0);
  
  blobs.clear();

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
        boolean found = false;
        for (Blob b : blobs){
          if (b.isNear(x,y)){
            b.add(x,y);
            found = true;
            break;
          }
        }
        if (!found){
          Blob b = new Blob(x,y);
          blobs.add(b);
        }
      }
    }
  }
  for (Blob b : blobs){
    if (b.size() > 00){
      b.show();
    }
  }
}

float distSq(float x1, float y1, float x2, float y2){
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) ;
  return d;
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2){
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1);
  return d;
}
