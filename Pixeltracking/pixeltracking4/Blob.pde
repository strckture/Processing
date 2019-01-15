class Blob {
  float minx;
  float miny;
  float maxx;
  float maxy;
  float x,y,w,h;
  float lerpX;
  float lerpY;
      
  Blob(float x, float y){
    minx = x;
    miny = y;
    maxx = x;
    maxy = y;
  }
  
  void show(){
    stroke(0);
    fill(trackColor);
    strokeWeight(2);
    
    //rectMode(CORNERS);
    //rect(minx, miny, maxx, maxy);
    
    lerpX = lerp(minx, maxx,0.5);
    lerpY = lerp(miny, maxy,0.5);
    
    ellipse(lerpX,lerpY,15,15);
  }
  
  void add(float x, float y){
    minx = min(minx, x);
    miny = min(miny, y);
    maxx = max(maxx, x);
    maxy = max(maxy, y); 
  }
  
  float size(){
    return (maxx-minx)*(maxy-miny);
  }
  
  boolean isNear(float x, float y){
    float cx = (minx + maxx) / 2;
    float cy = (miny + maxy) / 2;
    
    float d = distSq(cx,cy,x,y);
    if(d < distThreshold*distThreshold){
      return true;
    } else {
      return false;
    }
  }
}
