import processing.sound.*;
Amplitude amp;
AudioIn in;
SoundFile file;

float amplitude;

float i=0;
float t=0;
float move=0;
float movez=0;
float moveup=0;
color bg = color(15);
float[][] terrain; 
int op=0;
float widen=26;


void setup() {
  size (700, 700, P3D);
  background(10);
  frameRate(60);
  
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);

  terrain = new float[80][80];
  
  print("Controls://///////////");
  print("W, A: rotate X axis/////");
  print("S,D: rotate Y axis/////");
  print("SPACE,,: increase/decrease amplitude/////");
  print("1,2,3,4: change background color/////");
  print("UP, DOWN: adds/subtracts 100 to amplitude/////");
  
  //file = new SoundFile(this, "untitledprocessing.mp3");
  //file.play();
}

void keyPressed(){
  if (keyCode == UP){
    i+=100;
  } else if (keyCode == DOWN){
    i-=100;
  } else if (keyCode == '1'){
    bg = color(150,50,50);
  } else if (keyCode == '2'){
    bg = color(50,150,50);
  } else if (keyCode == '3'){
    bg = color(50,50,150);
  } else if (keyCode == '4'){
    bg = color(15);
  } 
}

void draw() {
  amplitude = amp.analyze();
  
  
  if(op<255){
    op+=10;
  } else if(op>=255){
    op=0;
  }
   
  float fly =0;
  fly -=0.05+ t/5;
  float yoff = fly;
  for (int y=0; y < 80-1; y++) {
    float xoff=0;
    for (int x=0; x < 80; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, 0-i, 0+i);
      xoff+=0.2;
    }
    yoff+=0.2;
  }
 
 map(mouseX,0,100,0,700);
 map(mouseY,0,100,0,700);
 
  if (i<0){
    background(15);
    stroke(255,0+mouseY,mouseX,op);
  } else {
    background(bg);
    stroke(0+mouseX,0+mouseY,255, 10+amplitude*50);
  }

  strokeWeight(1+amplitude*20);
  translate(width/2.7, height/2+moveup);
  rotateX(PI/2.3+movez/30);
  rotateZ(PI/2+move/30);
  translate(-width/2, -height/2);

  for (int x= 0; x< 22; x++) {
    beginShape(TRIANGLE_STRIP);
    for (int y=0; y< widen; y++) {
      noFill();
      //vertex(x*20, y*20, terrain[x][y]);
      vertex(x*27,(y+1)*19,terrain[x][y+1]);
    }
    endShape();
    noCursor();
  }  
  t+=0.04;
  if (keyPressed){
    if (key == ' '){
      i+=2;
    } else if (key== ','){
      i-=2;
    } else if (key== 'a'){
      move+=0.2;
    } else if (key== 'd'){
      move-=0.2;
    } else if (key== 'w'){
      movez+=0.2;
    } else if (key== 's'){
      movez-=0.2;
    } else if (key== 'q'){
      moveup+=1;
    } else if (key== 'e'){
      moveup-=1;
      
    } else if (key== 'y'){
      widen+=1;
    } else if (key== 'x'){
      widen-=1;
    }
  }
  if (widen==60){
    widen-=60;
  }
  
  //saveFrame("output/frame_#####.png");
}


///song go to sleep - bearson
