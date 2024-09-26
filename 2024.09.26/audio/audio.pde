import processing.sound.*;

FFT fft;
AudioIn in;
SoundFile file;
int bands = 512;
float[] spectrum = new float[bands];

void setup() {
  size(512, 360);
  background(255);
    
  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  // file = new SoundFile(this, "Oleva.wav");
  
  // start the Audio Input
  in.start();
  
  // file.play();

  // patch the AudioIn
  fft.input(in);
}      

void draw() { 
  background(255);
  fft.analyze(spectrum);

  for(int i = 0; i < bands; i++){
  // The result of the FFT is normalized
  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
  line( i * 8, height, i * 8, height - spectrum[i]*height*5 );
  } 
}
