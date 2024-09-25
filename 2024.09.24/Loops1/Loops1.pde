int y = 0;
void setup () {
 size(500,500); 
}

void draw() {
  for (int y = 0; y < width; y = y + 25) {
    //line(0,y,width,height);
    //line(width,y,0,width);
    //line(0,0,width,y);
    //line(width,0,0,y);
    
    line(width/2,0,y,width/2);
    line(width/2,height,y,width/2);
    line(0,height/2,width/2,y);
    line(width,height/2,width/2,y);
    
    
  }
  
 
  noLoop();
  
}
