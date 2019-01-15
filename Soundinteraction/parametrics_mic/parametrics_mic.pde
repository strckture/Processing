import processing.sound.*;
Amplitude amp;
AudioIn in;
SoundFile file;

static final int NUM_LINES = 15;

float t;
float op = 0;
float fullop = 255;
float amplitude;

void setup() {
  background(20);
  size(600, 600);
  frameRate(60);

  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
}

void draw() {
  background(20);
  stroke(150, 150, 255, 200*amplitude*300);
  strokeWeight(3);

  amplitude = amp.analyze();
  

  translate(width/2, height/2);
  for (int i = 0; i< NUM_LINES; i++) {
    line(x1(t + i), y1(t + i), x2(t +i ), y2(t +i));
  }
  t+= 0.1 + amplitude*25;
}

float x1(float t) {
  return sin(t/10) * 100 + sin(t/ 5) * 20;
}

float y1(float t) {
  return cos(t/10) * 100 + sin(-t / 2) * 20;
}

float x2(float t) {
  return sin(t/10) * 200 + cos(t/ 3) * 2;
}

float y2(float t) {
  return cos(t/20) * 200 + cos(t/ 10) * 30;
}