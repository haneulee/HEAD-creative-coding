void setup() {
  size(512, 512);
  background(255);
}

void draw(){
  
  //noStroke();
  //fill(0);
  int t = millis();
  int c = t%255;
  println(t);
  
  rectMode(CENTER);
  //rect(width/2,height/2,100,300);
  
  
  
  noStroke();
  fill(c);
  
  for(int i = 0; i < 4; i++){
    int m = i%2;
    //println("int i:",i);
    rect(i*110+90, height/2 + 40*m, 100, 300);
    //noFill();
    //strokeWeight(3);
    //stroke(255,0,0);
    //rect(i*150, height/2,100,300);
  }
  //noLoop();
  
  if(keyPressed){
    int h = hour();
    int m = minute();
    int s = second();
    println(h);
    save(h + ":" + m + ":" + s + ".png");
  }
}
