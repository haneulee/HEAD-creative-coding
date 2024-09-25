
import processing.video.*;

Capture video;
PImage img;

void setup() {
 size(400, 400);
 video = new Capture(this, 400, 400, 30);
 video.start();
 img = loadImage("satellite.png");
 image(img, 0, 0, width, height);
 
}


void captureEvent(Capture video) {
  video.read();
}

void draw() {
  if(video.available()) {
    video.read();
  }
  image(video, 0, 0, mouseX, mouseY);
  tint(mouseX+ mouseY, mouseX, mouseY, 3);
  //background(220);
  //line(width,height,0,0);
  //line(0, height, width, 0);
  //circle(width/2, height/2, 100);
  
  if (keyPressed) {
    save("me working on the hertzian landscape project.png");
  }
  
  if (frameCount > 100){
    noLoop();
  } //??
}
