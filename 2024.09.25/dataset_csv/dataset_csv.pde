
Table table;

void setup() {
  size(500, 500);
  background(255);
  
  //table = loadTable("data_synth.csv", "header");
  //int size = width/100;
  
  //for (TableRow row : table.rows()) {
  //  // Get the columsn from CSV
  //  float x = row.getFloat("x");
  //  float y = row.getFloat("y");
  //  float value = row.getFloat("value");
    
  //  noStroke();
  //  fill(value * 2,10,value * 2);
  //  rect(x * size,y * size,size,size);
  //}
}


void draw() {
  table = loadTable("data_synth.csv", "header");
  int size = width/100;
  String print = "";
  int xPos = 0;
  int yPos = 0;
  
  for (TableRow row : table.rows()) {
    // Get the columsn from CSV
    float x = row.getFloat("x");
    float y = row.getFloat("y");
    float value = row.getFloat("value");
    
    noStroke();
    if (x * size < mouseX && mouseX < (x * size) + size && y * size < mouseY && mouseY < (y * size) + size) {
      fill(255,0,0);
      println("x:" + x + ", y:" + y + ", value:" + value);
      print = "x:" + x + ", y:" + y + ", value:" + value;
    } else {
      fill(value * 2,10,value * 2);
    }
    rect(x * size,y * size,size,size);
    
    
  }
  
  
  //noLoop();
  
  fill(255,0,0);
  text(print, mouseX - 20, mouseY - 20);
  
  
  if (keyPressed) {
    save("dataSet.png");
  }
}
