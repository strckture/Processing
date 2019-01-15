/*Adio Visualizer by Pascal Struck,
creates different ellipses for audio visualization,
movement created by sin & cos*/

import processing.sound.*;              //import sound
Amplitude amp;                          //via amplitude
AudioIn in;
SoundFile file;

static final int NUM_DOTS = 27;         //variables parametrics

float t;
float up=0;
float down=255;
float speed;

float amplitude;

void setup() {
  background(20);
  size(500, 500);
  frameRate(60);
  colorMode(HSB, 255,255,255);
  
  amp = new Amplitude(this);            //soundamplitude setup
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
}

void draw() {
  background(20);
  translate(width/2, height/2);
  
  amplitude = amp.analyze();

  noStroke();                                         //center ellipse
  ellipse(0,0,20*amplitude*20,20*amplitude*20);
  
  if(up < 255 && down == 255){                        //two up & down counting variables
   up++;
   fill(up,up,255);
  } else if(up == 255 && down > 0){
   down--;
   fill(down,down,255);
  } else if(up > 0 && down == 0){
   up--;
   fill(up,up,255);
  } else if(up ==0 && down < 255){
   down++;
   fill(down,down,255);
  }
  
  for (int i = 0; i< NUM_DOTS; i+=2) {               //create moving ellipses
    ellipse(x1(t+i), y1(t+i), 5, 5);
  }
  t+= 0.5 + amplitude*10;
}

float x1(float t) {                                  //path functions
  return sin(t/10) *up/2;
}

float y1(float t) {
  return cos(t/10) *down/2;
}