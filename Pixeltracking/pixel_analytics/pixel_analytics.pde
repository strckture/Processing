import processing.video.*;
Capture video;

PFont font;

void setup(){
  size(1024,640);
  background(255);
  
  font = loadFont ("Helvetica-Light-12.vlw");
  textFont(font);
  
  video = new Capture(this, width*3, height*3);
  video.start();
}

void captureEvent(Capture video) {
  video.read();
}

void draw(){ 
  image(video,150,height/4, 530,320);
  
  color c1 = get(width/2,height/4);
  color c2 = get(width/2,240);
  color c3 = get(width/2,320);
  color c4 = get(width/2,400);
  
  //float colors[] = {c1,c2,c3,c4};
  
  /*for (int i =0; i<4;i++){
    fill(colors[i]);
    noStroke();
    rect(690, 160+i*20, 80, 80);
  }*/
    
  
  fill(c1);
  noStroke();
  rect(690, height/4, 80, 80);
  fill(c2);
  rect(690,240, 80, 80);
  fill(c3);
  rect(690,320, 80, 80);
  fill(c4);
  rect(690,400, 80, 80);
  
  fill(255);
  rect(770,0,500,700);
  
  fill(10);
  textAlign(CENTER);
  text(c1,800, 200);
  textAlign(CENTER);
  text(c2,800, 280);
  textAlign(CENTER);
  text(c3,800, 360);
  textAlign(CENTER);
  text(c4,800, 440);
  
  if (mousePressed){
    saveFrame("screenshot-####.png");
    background(255);
  }
}
