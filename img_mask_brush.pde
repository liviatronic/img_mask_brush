//modifying existing sketch to work with recorded video and webcam

import processing.video.*;

Capture cam;
Movie mov;
PImage vr;
//PImage galaxy;
//PImage crystals;
PImage revealedImage;
PGraphics graphicMask1;
PGraphics graphicMask2;
int newFrame = 0;
int savedTime;
int totalTime = 6000;

void setup() {
  size(640, 480);
  
  //variable for counter
  savedTime = millis();
  
  //initialize Movie object
  mov = new Movie(this, "camera.mp4");
  //start movie playing
  mov.loop();
  
  //initialize the Capture object
  cam = new Capture(this, width, height);
  cam.start(); //start the capture device
  
  //load image
  vr = loadImage("vr-640.jpg");
  
  //variables for PGraphics
  graphicMask1 = createGraphics(width, height, JAVA2D);
  graphicMask2 = createGraphics(width, height, JAVA2D);
}


void draw() {
  //set the webcam as first image
  if (cam.available()) {
    cam.read();
  }
  image(cam, 0, 0, width, height);
  
  //set up counter
  int passedTime = millis() - savedTime;
  
  //draw the first mask shape
  graphicMask1.beginDraw();
  graphicMask1.noStroke();
  graphicMask1.ellipse(mouseX, mouseY, 80, 80);
  graphicMask1.endDraw();
  
  //draw the second mask shape
  graphicMask2.beginDraw();
  graphicMask2.noStroke();
  graphicMask2.ellipse(mouseX, mouseY, 100, 100);
  graphicMask2.endDraw();
  
  //show the first image
  mask2Reveal();
  
  //after the timer is up, show the second image
  if (passedTime > totalTime) {
    mask1Reveal();
  }
}



//load an image and mask it with the PGraphics shape 1
void mask1Reveal() {
  revealedImage = vr.get();
  revealedImage.mask(graphicMask1);
  image(revealedImage, 0, 0);
}

//load another image and mask it with the PGraphics shape 2
void mask2Reveal() {
  revealedImage = mov.get();
  revealedImage.mask(graphicMask2);
  image(revealedImage, 0, 0);
}

void movieEvent(Movie m) {
  m.read();
}
