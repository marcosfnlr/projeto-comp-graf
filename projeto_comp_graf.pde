import processing.opengl.*;
void setup() {
  size(600, 400, OPENGL);
  perspective(PI/4, float(width)/float(height), 0.1, 100);
  noLights();
}

void draw() {
  background(0);
  noStroke();
  fill(255);
  directionalLight(128, 128, 128, 1, 0, 0);
  camera(0, 0, 10, 0, 0, 0, 0, 1, 0);
  sphere(2);
}
