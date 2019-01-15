import processing.video.*;
Capture video;

PImage prev;
PFont font;

//threshold variable
float threshold = 70;

float motionX = 0;
float motionY = 0;
float lerpX = 0;
float lerpY = 0;

float countmin = 2500;

int op1 = 0;
int op2 = 0;

void setup(){
  size(640,360);
  video = new Capture(this, width, height, 24);
  video.start();

  //creating previous pixel image for smoother performance
  prev = createImage(640,360, RGB); //*size adaptation
  noFill(); //?

  font = loadFont("AvenirNext-MediumItalic-35.vlw");
  textFont(font);
}

void captureEvent(Capture video){
  //using previous picture for more usable pixels
  prev.copy(video, 0,0, video.width, video.height, 0, 0, prev.width, prev.height);
  prev.updatePixels();
  video.read();
}

void keyPressed(){
  if (keyCode == UP){
    threshold = threshold+2;
  } else if (keyCode == DOWN){
    threshold = threshold-2;
  } else if (keyCode == ' '){
    countmin = 3300;
  } else if (keyCode == ','){
    countmin = 2300;
  }
}

void draw(){
  video.loadPixels();
  prev.loadPixels();

  //image(video,0,0);

  fill(1);
  rect(0,0,width,height);

  float avgX = 0;
  float avgY = 0;

  int count = 0;

  loadPixels();
  //searching every pixel for color change (movement)
  for(int x=0; x < video.width; x++){
    for(int y=0; y < video.height; y++){
      //track the wanted pixels
      int loc = x + y * video.width;

      //create arrys with the location of searched pixels
      color currentColor1 = video.pixels[loc];
      float r1 = red(currentColor1);
      float g1 = green(currentColor1);
      float b1 = blue(currentColor1);
      //[backup array] location of pixels from previous frame
      color prevColor1 = prev.pixels[loc];
      float r2 = red(prevColor1);
      float g2 = green(prevColor1);
      float b2 = blue(prevColor1);

      //finds change in pixels and distance between those
      float d = distSq(r1, g1, b1, r2 ,g2, b2);

      if (d > threshold*threshold){
        avgX += x;
        avgY += y;
        count++;
      }
        /*pixels[loc] = color(255);
      } else {
        pixels[loc] = color(0);
      }*/
    }
  }
  updatePixels();


  if (count > countmin){
    motionX = avgX / count;
    motionY = avgY /count;
  }
  lerpX = lerp(lerpX, motionX, 0.58);
  lerpY = lerp(lerpY, motionY, 0.58);
  //fill(#18FF0D);
  //strokeWeight(2);
  //stroke(0);
  //ellipse(lerpX, lerpY, 30,30);

  //---------------------------------------------------

  if(lerpX > width/2 - 30){
    op1 = op1+10;
    noStroke();
    fill(255,0,0,op1);
    rect(0,0,width/2, height);
  } else {
    op1 = 0;
  }

  if(lerpX < width/2 + 30){
    op2 = op2+10;
    noStroke();
    fill(0,0,255,op2);
    rect(width/2,0,width/2,height);
  } else {
    op2 = 0;
  }

  fill(1);
  textAlign(CENTER);
  text("left", width/4, height/2);
  text("right", width/4 * 3, height/2);

  //---------------------------------------------------

  //println(lerpX);
  //println(op1);
  //println(op2);
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2){
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1);
  return d;
}
