float x=0;
float y=0;
float cyheight=50;
float alpha=0;
float beta=0;
float gamma=0;


void setup(){
  size(500,500,P3D);
  background(20);
}

void draw(){
  background(20);
  
  spotLight(240, 240, 255, width/2, height/2, 400, 0, 0, -1, PI/8, 0);
  
  translate(width/2, height/2);
  
  map(mouseX,0,100,0,width);
  map(mouseY,0,100,0,height);
  //rotateX(x);
  //rotateY(y);
  rotateX(1);
  
  if (mousePressed && mouseX>190 && mouseX<305 && mouseY>180 && mouseY<250){
    cyheight=35;
    ////////////////////////backgroundchange
    /*alpha =random(100);
    beta =random(100);
    gamma =random(100);*/
    ///////////////////////ellipsescolor
    for (int i =0; i< 20; i++){
      translate(-width/2, -height/2);
      rotateX(-1);
      fill(random(255),random(255),random(255),255);
      ellipse(random(500),random(500),20,20);
      translate(width/2, height/2);
      rotateX(-0.25673);
    }
  } else {
    cyheight=50;
  }
  
  //fill(255);
  //ellipse(0,0,200+frameCount,200+frameCount);
  //background(alpha,beta,gamma);
  
  noStroke();
  fill(255,0,0);
  drawCylinder(360,50,cyheight);
  
  //translate(0,0,0);
  fill(255);
  drawCylinder(360,60,30);
  
  translate(0,0,-60);
  fill(150);
  box(150);
  
  //println(x);
  
  if (keyPressed){
   if (key== 'w'){
      x+=0.01;
    } else if (key== 'a'){
      y-=0.01;
    } else if (key== 's'){
      x-=0.01;
    } else if (key== 'd'){
      y+=0.01;
    }
  }
}

void drawCylinder(int sides, float r, float h){
    float angle = 360 / sides;
    //float halfHeight = h / 2;
    // draw top shape
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, -h );    
    }
    endShape(CLOSE);
    // draw bottom shape
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, h );    
    }
    endShape(CLOSE);
    
    // draw body
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
      float x = cos( radians( i * angle ) ) * r;
      float y = sin( radians( i * angle ) ) * r;
      vertex( x, y, h);
      vertex( x, y, -h);    
    }
    endShape(CLOSE); 
  } 
