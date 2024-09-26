
void setup() {
 size(360, 360); 
 colorMode(HSB, 360, 100, 100); // hue,saturation,brightness
 background(0);
 strokeWeight(10);
}

void draw() {
  //for(int i = 0; i < width; i++) {
  //  stroke(i, 100, 100); // hsb
  //  line(i, 0, i, height);
  //}
  
}

void mouseDragged() {
  stroke(mouseX, 100, 100);
  line(pmouseX, pmouseY, mouseX, mouseY);
}
