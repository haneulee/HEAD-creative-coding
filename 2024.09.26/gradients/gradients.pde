int Y_AXIS = 1;
int X_AXIS = 2;
color c1, c2, c3;
int tileSize = 20;

void setup() {
  size(1280, 720);

  //define colors
  c1 = color(0, 0, 255);
  c2 = color(255, 0, 0);
  c3 = color(0, 255, 0);
}

void draw() {
  
  int t = round(millis()*0.1);

  //setGradient(0, 0, width/2, height/2, c1, c2, X_AXIS);
  //setGradient(width/2, 0, width/2, height/2, c2, c1, Y_AXIS);
  //setGradient(0, height/2, width/2, height/2, c1, c3, Y_AXIS);
  //setGradient(width/2, height/2, width/2, height/2, c1, c3, X_AXIS);
  
  for (int i = 0; i < width; i += tileSize){
    for (int j = 0; j < height; j += tileSize) {
      float r = random(0,1);
      if (r < 0.5) setGradient(i,j,tileSize,tileSize,c1,c2,X_AXIS);
      if (r > 0.5 && r < 0.75) setGradient(i,j,tileSize,tileSize,c1,c3,Y_AXIS);
      if (r > 0.75) setGradient(i,j,tileSize,tileSize,c1,c2,Y_AXIS);
    }
  }
  noLoop();
  
  if(keyPressed){
    save("gradients.png");
  }
  
}

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis) {

  noFill();

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
      //fill(c);
      //ellipse(x,i,x+w,x+w);
    }
  }  
  else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
      //fill(c);
      //ellipse(i,y,y+h,y+h);
    }
  }
}
