import processing.sound.*;              //import sound
Amplitude amp;                          //via amplitude
AudioIn in;
SoundFile file;

int NUM=16;
int F;

float amplitude;

ArrayList joints=new ArrayList();

void setup() {
  //size(1000,1000);
  //size(450,800); // till dawn 1,58 -- stormzy 0.25
  fullScreen();
  noFill();
  stroke(255);
  
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
  
  colorMode(HSB);
}

void draw() {
  amplitude = amp.analyze();
  
  background(0);
  translate(width/2, height/2);

  F=frameCount;
  if (F%20==0) {
    joints.add(new Joint());
  }
  for (int i=0; i<joints.size(); i++) {
    Joint j = (Joint)joints.get(i);
    if (j.update()==false) {
      joints.remove(i);
    }
  }
  
  if (mousePressed){
    saveFrame("line-######.png");
  }
}


class Joint {
  float[] p;
  float dep;
  float f=random(255);

  Joint() {
    dep=0;
    p=new float[NUM];
    for (int i=0; i<NUM; i++) {
      float rad=TWO_PI/NUM*i;
      p[i]=noise((1-cos(rad))*0.5, (1-sin(rad))*0.5, F*0.001);
    }
  }

  boolean update() {
    strokeWeight(dep*0.02+amplitude*150);
    
    
    //stroke(255);
    
    stroke(f,150,255);
    
    //blue
    //stroke(0,0,f);
    
    beginShape();
    //fill(255,100,200);
    noFill();
    //fill(f,150,255);
    
    
    for (int i=0; i<NUM+2; i++) {
      float r=p[i%NUM];
      float rad=TWO_PI/NUM*i;
      float t=pow(dep, 1.4)*r;
      float x=cos(rad)*t;
      float y=sin(rad)*t;
      curveVertex(x, y);
    }
    
    endShape(CLOSE);
    //dep+=1;
    dep+=0.03+ amplitude*10;
    if (dep>height/2) {
      return false;
    }
    return true;
  }
}


//aero chord - boundless
