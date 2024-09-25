int[] values = {50,120,80,150,60,200,90};
int value = 50;
boolean flag = false;
float number = 3.13;
String myText = "hello";

void setup() {
 size(400,300);
 background(255);
 //println(2+2);
 //textSize(14);
 //stroke(0);
 //text(number, 100, 10);
 //println(values[0]);
 println(width, values.length, width/values.length);
 
}

int distance = 1;

void draw() {
  int widthVal = width/values.length;
  fill(0,0,255);
  noStroke();
  for (int i = 0; i < values.length; i++) {
    
    //line(distance * i, height, distance * i, values[i]);
    rect((distance + widthVal) * i, height - values[i], widthVal, values[i]);
    //distance += 2;
  }
  noLoop();
 
}
