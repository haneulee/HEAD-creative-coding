void setup() {
  size(500, 500);
  background(0);
}

void draw() {
  stroke(255);
  strokeWeight(1);
  noFill();
  
  //point(20, 20);
  
  for(int i = 0; i < width; i+=25) {
    for(int j = 0; j < height; j+=25) {
      //point(i, j);
  float tileSize = random(1,20);
      ellipse(i+12.5,j+12.5,tileSize,tileSize);
    }
  }
  noLoop();
}
