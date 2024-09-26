color c1 = color(255, 0, 0);
color c2 = color(0,0,255);


void setup() {
  size(500, 500);
  background(0);
}


void draw() {
  int t = round(millis()*0.1);
  
  for(int i = 0; i < height; i++) {
    float inter = map(i, 0, height, 0, 1);
    color c = lerpColor(c1, c2, inter);
    stroke(c);
    line(0,(i+t)%height,height,(i+t)%height);
    
    //circle();
  }
 
}
