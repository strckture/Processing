/* visual terrain generator which reacts to audio 
by Pascal Struck
noise generated terrain and ellipses react to microphone inputs 
by using FFt and amplitude analysis
  */

import processing.sound.*;                  //soundlibrary import
Amplitude amp;                              //sound import
FFT fft;
AudioIn in;
SoundFile file;
float amplitude;
int bands = 512;
float[] spectrum = new float[bands];

int cols,rows;                             //variables setup
int scl = 20;
int w=800;
int h=900;

float flying =0;
float[][] terrain;                         //2d array for triangle grid


void setup(){
  size(500,500,P3D);                         //3d space setup
  background(15);
  frameRate(60);
  
  cols = w/ scl;                             //columns & rows spacing (scale)
  rows= h/scl;
  terrain = new float[cols][rows];           //define 2d array terrain (columns/rows)

  amp = new Amplitude(this);                 //sound setup
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
  
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  in.start();
  fft.input(in);
}


void draw(){
  amplitude = amp.analyze();
  flying -= 0.05+ amplitude;               //movingspeed
  
  float yoff =flying;                        //x and y offset -> z koordinate with noise function 
  for(int y=0; y < rows-1;y++){
    float xoff=0;
    for(int x=0; x < cols;x++){
      terrain[x][y] = map(noise(xoff,yoff),0, 1,-75,75);
      xoff+=0.2;
    }
    yoff+=0.2;
  }
  
  background(15);
  fft.analyze(spectrum);                    //FFt ellipses
  int lineh=300;
  int linepos=100; 
  for(int i = 0; i < 300; i++){
    noStroke();
    fill(255,255);
    ellipse(linepos+i,lineh-amplitude*60,2,1- spectrum[i]*height*5);
  }
 
  translate(width/2,height/2);
  rotateX(PI/3);                              //rotate the grid
  translate(-w/2,-h/2);
  
  for(int y=0; y < rows-1;y++){               //draw the grid with vertex() as a triangle_strip shape 
    beginShape(TRIANGLE_STRIP);
    for(int x=0; x < cols;x++){
      stroke(255,100,200, 65);
      noFill();
      vertex(x*scl, y*scl,terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  } 
}