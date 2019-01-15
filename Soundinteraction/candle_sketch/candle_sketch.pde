//if amp is 1 // amp is xx#

import processing.sound.*;
Amplitude amp;
AudioIn in;
SoundFile file;

float amplitude;
float eheight =100;
float ewidth =30;

float eheight2 =60;
float ewidth2 =20;

void setup(){
  size(500,500);
  background(100,100,255);
  
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
}

void draw(){
  background(166,199,253);
  
  amplitude = amp.analyze();
  noStroke();
  fill(200);
  rect(210,height/2,80,300,20);
  fill(241);
  rect(210,height/2,75,300,20);
  stroke(236);
  strokeWeight(2);
  line(width/2,height/2,width/2,220);
 
  translate(width/2,height/2);
  
  ewidth = ewidth - amplitude*1.5;
  eheight = eheight - amplitude*5;
  
  ewidth2 = ewidth2 - amplitude*1.5;
  eheight2 = eheight2 - amplitude*5;
  
  if (ewidth >0 && eheight>0 && ewidth2 >0 && eheight2>0){
    noStroke();
    fill(255,255,150,30);
    ellipse(0,-40,200+ewidth*5,200+ewidth*5);
    fill(255,100,100);
    ellipse(0+random(-2,2),-40+random(-2,2),ewidth,eheight);
    fill(255,255,100,150);
    ellipse(0+random(-2,2),-30+random(-2,2),ewidth2,eheight2);
    
    
  } else if (ewidth<=0 & eheight<=0){
    stroke(130,130,130);
    line(0,-30,0,0);
  }
  
}