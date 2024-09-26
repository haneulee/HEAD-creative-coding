PImage waterfall;
int x_pitch = 5;
int y_pitch = 5;

void setup() {
  //size(600, 394); // size need to be same with the original image
  size(400, 400); 
  //waterfall = loadImage("waterfall.png");//satellite
  waterfall = loadImage("test.png");
  waterfall.loadPixels();
  
  color(HSB, 360, 100, 100);
  
}

void draw() {
  background(0);
  noStroke();
  int t = round(millis()*0.1);
  
  
  for(int i = 0; i < height; i += y_pitch) {
    for(int j = 0; j < width; j += x_pitch) {
      color c = waterfall.pixels[(i+t)%height*width+j];
      //color c = waterfall.pixels[(j+t)%height*width+i];
      //color c = waterfall.pixels[i*width+j];
      float b = brightness(c);
      //println(b);
      b = map(b,0,360,0,x_pitch);
      
      //if (j >= mouseX - 10 && j <= mouseX + 10 && i >= mouseY - 10 && i <= mouseY + 10) {
      //if (j == mouseX && i == mouseY) {
      //  fill(255,0,0);
      //  //ellipse(j,i,20,20);
      //} else {
      //  fill(100,b,100);
      //  //ellipse(j,i,b,b);
      //}
      
      //println(c,b);
      fill(100,b,100);
      ellipse(j,i,b,b);
      
      //println(j,mouseX, i, mouseY);
      
      
    }
  }
}

void mouseMoved() {
  
  
}
