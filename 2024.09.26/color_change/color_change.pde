int t;

void setup() {
 size(360, 360); 
 colorMode(HSB, 360, 100, 100); // hue,saturation,brightness
 background(0);
 //strokeWeight(10);
}

void draw() {
  int m = round(millis()* 0.01);
  t = m%360;
  //background(t,100,100);
  noStroke();
  background(0);
  
  for(int i = 0; i < width; i++) {
    fill(i , 100, 100);
    circle(i, i, 50);
  }
  
  for(int i = width; i > 0; i--) {
    fill(i , 100, 100);
    circle(width - i, i, 50);
    //println(i);
  }
  //noLoop();
}
