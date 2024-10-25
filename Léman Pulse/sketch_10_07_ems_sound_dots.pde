import processing.sound.*;
import ddf.minim.*;
import peasy.*;

PImage img;
Table table, colorTable;
String colors[] = new String[10];
PFont font;

SoundFile file;
SoundFile voice;
Waveform waveform;
PeasyCam cam;
int stage = 1;
float maxZ = 2000;
float minZ = 100;
float camZ = maxZ; // 카메라 Z 위치 초기값
float camX, camY;
float amp = 0;
boolean isDelaying = false;
int delayDuration = 6000; // 10초 (밀리초 단위)
int lastTime = 0;

void setup() {
  //size(1000, 1000, P3D);
  fullScreen(P3D);
  cursor(CROSS);
  font = createFont("font.otf", 20);
  textFont(font);

  // 초기 이미지 및 사운드 파일 로드
  loadMedia(stage);

  // 색상 테이블 로드
  loadColorTable();
}

void draw() {
  background(0);
  lights();
  ambientLight(150, 150, 150);  // 전체적인 밝기 증가

  waveform.analyze();
  amp = map(camZ, minZ, maxZ, 1, 0);

  // 카메라 위치 및 방향 설정
  setCameraPosition();

  // 화면 요소 그리기
  drawRasterizeMap();
  drawNetwork();
  
  checkAudioDelay();
}

void checkAudioDelay() {
  if (!voice.isPlaying() && !isDelaying) {
    // 오디오가 끝났을 때 10초 딜레이 시작
    isDelaying = true;
    lastTime = millis(); // 현재 시간을 기록
  }
  
  // 10초가 지난 후 다시 오디오를 재생
  if (isDelaying && millis() - lastTime >= delayDuration) {
    if (!voice.isPlaying() && camZ <= 500) voice.play(); // 오디오 재생
    isDelaying = false; // 딜레이 상태 종료
  }
}

// 미디어 파일 로드
void loadMedia(int stage) {
  img = loadImage(stage + ".jpg");
  img.resize(displayWidth, displayHeight);

  if (file != null) {
    file.stop();
  }

  file = new SoundFile(this, stage + ".wav");
  file.loop();
  file.amp(amp);
  voice = new SoundFile(this, stage + "-voice.wav");

  waveform = new Waveform(this, 100); // sample count
  waveform.input(file);

  table = loadTable(stage + ".csv", "header");
}

// 색상 테이블 로드
void loadColorTable() {
  colorTable = loadTable("Lac Leman Colors.csv", "header");

  for (int i = 0; i < colorTable.getRowCount(); i++) {
    colors[i] = colorTable.getString(i, "HEX");
  }
}


void drawRasterizeMap() {
  img.loadPixels();
  noStroke();
  sphereDetail(3); // simplify spheres solids (so it's not so heavy)

  float tiles = map(camZ, minZ, maxZ, 500, 50);  // 타일 수 조정
  float tileSize = width / tiles;

  for (int x = 0; x < tiles; x++) {
    for (int y = 0; y < tiles; y++) {
      color c = img.get(int(x * tileSize), int(y * tileSize));
      float b = map(brightness(c), 0, 255, 1, 0);
      float z = map(b, 0, 1, -200, 200);  // 밝기를 기반으로 z값 설정
      int sample = int(map(y, 0, tiles, 0, 100));  // waveform 샘플 범위 조정
      float soundVal = map(waveform.data[sample], -0.5, 0.5, 0, 5);  // 사운드 데이터 매핑

      if (c != 0) {
        push();
        fill(c);

        // 사운드 및 시간에 따른 변화를 이용한 역동적인 움직임
        float timeFactor = millis() * 0.001;  // 시간 기반 변화
        float dynamicX = (x * tileSize + (soundVal * 10) - width / 2) + sin(timeFactor + x * 0.05) * 10;
        float dynamicY = (y * tileSize + (soundVal * 10) - height / 2) + cos(timeFactor + y * 0.05) * 10;
        float dynamicZ = z * soundVal + sin(timeFactor + (x + y) * 0.1) * 10;

        // 각 sphere의 위치 변동
        translate(dynamicX, dynamicY, dynamicZ);

        // sphere 크기 또한 역동적으로 변화
        float sphereSize = tileSize * 0.8 * (1 + sin(timeFactor + x * 0.1 + y * 0.1) * 0.5);
        sphere(sphereSize);

        pop();
      }
    }
  }
}


void drawNetwork() {
  for (TableRow row : table.rows()) {
    float x = row.getFloat("CurrentLongitude");
    float value = row.getFloat("RSSI");
    float xPos = mapLongitude(x);
    float yPos = map(value, -113, 0, 0, -height);
    float zPos = map(value, -113, 0, 0, 300);
    String hexColor = getColors(value);
    float alpha = int(map(camZ, minZ, maxZ, 255, 0));

    push();
    fill(unhex(hexColor.substring(1, 3)), unhex(hexColor.substring(3, 5)), unhex(hexColor.substring(5, 7)), alpha);
    textSize(20);

    // 텍스트 위치로 이동
    translate(xPos, yPos, zPos);

    // 카메라가 있는 방향으로 텍스트 회전 (빌보딩 효과)
    PVector camPosition = new PVector(camX, camY, camZ);
    PVector textPosition = new PVector(xPos, yPos, zPos);

    // 텍스트가 카메라를 향하도록 회전
    PVector dir = PVector.sub(camPosition, textPosition);
    float angleX = atan2(dir.y, dir.z); // X축에 대한 회전 각도
    float angleY = atan2(dir.x, dir.z); // Y축에 대한 회전 각도

    rotateX(angleX);
    rotateY(angleY);

    // 텍스트 그리기
    text(row.getString("SSID"), 0, 0);

    pop();
  }
}


// 경도에 따라 xPos를 매핑
float mapLongitude(float x) {
  float min = -width/2 + 10;
  float max = width/2 - 10;
  if (stage == 1) {
    return map(x, 6.164255737, 6.166790466, min, max);
  } else if (stage == 2) {
    return map(x, 6.1510, 6.155567729, min, max);
  } else {
    return map(x, 6.1553, 6.159, min, max);
  }
}

String getColors(float strength) {
  if (strength <= -90) return colors[1];
  if (strength <= -80) return colors[2];
  if (strength <= -70) return colors[3];
  if (strength <= -60) return colors[4];
  if (strength <= -50) return colors[5];
  if (strength <= -40) return colors[6];
  if (strength <= -30) return colors[7];
  if (strength <= -20) return colors[8];
  if (strength <= -10) return colors[9];
  return "#ff0000";
}

//void keyPressed() {
//  stage = (stage == 3) ? 1 : stage + 1; // 스테이지 순환

//  // 미디어 파일 다시 로드
//  loadMedia(stage);
//}

void mouseClicked() {
  if (camZ >= 1200) {
    stage = (stage == 3) ? 1 : stage + 1; // 스테이지 순환
    // 미디어 파일 다시 로드
    loadMedia(stage);
  }

  // save image, TODO: print screen
  //if (mouseButton == RIGHT) {
  if (mouseButton == 3) {
    save("Léman Pulse - A digital journey " + day() + "_" + month() + " " + hour() + "." + minute() + "." + second() + ".png");
  }
}

//// 마우스 휠을 이용한 줌 인/아웃 기능
//void mouseWheel(MouseEvent event) {
//  camZ += event.getCount() * 10; // 스크롤 방향에 따라 카메라 Z 위치 조정
//  camZ = constrain(camZ, minZ, maxZ); // 카메라 Z 위치를 제한 (100 ~ 1000)
//  file.amp(map(camZ, minZ, maxZ, 1, 0));
//}

// 마우스 휠을 이용한 줌 인/아웃 기능
void mouseDragged(MouseEvent event) {
  camZ = constrain(camZ, minZ, maxZ); // 카메라 Z 위치를 제한 (100 ~ 1000)
  if (mouseY>height/2) {
    camZ += event.getCount() * 10; // 스크롤 방향에 따라 카메라 Z 위치 조정
  } else if (mouseY<height/2) {
    camZ -= event.getCount() * 10; // 스크롤 방향에 따라 카메라 Z 위치 조정
  }
  file.amp(amp);

  if (!voice.isPlaying() && camZ <= 600) {
    if (!isDelaying) voice.play();
  } else if (voice.isPlaying() && camZ > 600) {
    voice.stop();
  }
}

// 카메라 위치 및 방향 설정
void setCameraPosition() {
  camX = (mouseX - width / 2) * 1;  // 스케일을 0.5로 조정
  camY = (mouseY - height / 2) * 1; // 스케일을 0.5로 조정

  camera(camX, camY, camZ, // 카메라 위치
    0, 0, 0, // 화면 중앙을 바라보도록 설정
    0, 1, 0);         // 수직 방향 설정
}
