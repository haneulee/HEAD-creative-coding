void setup() {
 size(500, 500);
 //frameRate(10);
 background(0, 0, 200);
}

int x = 0;
int y = 0;
int tile = 40;

void draw() {
  float random_number = random(1);
  //line(0,0,20,20);
  //line(20,0,40,20);
  //line(40,0,60,20);
  stroke(255,255,255);
  strokeWeight(3);
  //strokeJoin(MITER);
  //strokeCap(PROJECT);
  
  noFill();
  
  
 // if (random_number < 0.5) {
 //   println("yes");
 //   //line(x, y, x+tile, y+tile);
 //   arc(x, y, tile, tile, 0, PI);
 //} else {
 //   println("no");
 //   //line(x, y+tile, x+tile, y);
 //   arc(x, y, tile, tile, PI, TWO_PI);
 // }
  
  //rect(x,y, tile, tile);
  if (random_number < 0.5) {
    arc(x+tile, y, tile, tile, HALF_PI, PI);
    arc(x, y+tile, tile, tile, HALF_PI+PI, TWO_PI);
  } else {
    arc(x, y, tile, tile, 0, HALF_PI);
    arc(x+tile, y+tile, tile, tile, PI, HALF_PI+PI);
  }
  
  //if (random_number < 0.2) {
  //  println("yes");
  //  //line(x, y, x+tile, y+tile);
  //  arc(x, y, tile, tile, 0, HALF_PI);
  //} if (random_number > 0.2 && random_number < 0.4) {
  //  arc(x, y, tile, tile, HALF_PI, PI);
  //} if (random_number > 0.4 && random_number < 0.6) {
  //  arc(x, y, tile, tile, PI,TWO_PI);
  //} else {
  //  println("no");
  //  //line(x, y+tile, x+tile, y);
  //  arc(x, y, tile, tile, TWO_PI, 0);
  //}
  
  x = x + tile;
  if (x > width) {  
    y = y + tile;
    x = 0;
  }
  
  if (keyPressed){
    save("tile.png");
   
  }
  
}
