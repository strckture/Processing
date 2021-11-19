int n = 1000;

float[] m = new float[n];
float[] x = new float[n];
float[] y = new float[n];
float[] vx = new float[n];
float[] vy = new float[n];

float lapse = 0;

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

void setup() {
  size(1024, 768);
  fill(0, 20);
  reset();
}

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

void draw() {
  noStroke();
  rect(0, 0, width, height);

  for (int i = 0; i < n; i++) {
    float dx = mouseX - x[i];
    float dy = mouseY - y[i];

    float d = sqrt(dx*dx + dy*dy);
    if (d < 1) d = 1;
    
    float f = sin(d * 0.04) * m[i] / d;

    vx[i] = vx[i] * 0.5 + f * dx;
    vy[i] = vy[i] * 0.5 + f * dy;
  }

  for (int i = 0; i < n; i++) {
    x[i] += vx[i];
    y[i] += vy[i];

    if (x[i] < 0) x[i] = width;
    else if (x[i] > width) x[i] = 0;

    if (y[i] < 0) y[i] = height;
    else if (y[i] > height) y[i] = 0;

    if (m[i] < 0) stroke(2,245, 254); //firststroke
    else stroke(2,245, 254); // second stroke 
    
    
    strokeWeight(2);
    point(x[i], y[i]);
  }
}

void reset() {
  for (int i = 0; i < n; i++) {
    m[i] = randomGaussian() * 3;
    x[i] = random(width);
    y[i] = random(height);
  }
}
