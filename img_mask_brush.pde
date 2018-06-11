//modifying to use arrays for storing mouse position history

import processing.video.*;

Capture cam;
Movie mov;
PImage vr;

PImage revealedImage;
PGraphics graphicMask1;
PGraphics graphicMask2;

int num = 5;
int[] x = new int[num];
int[] y = new int[num];
int indexPosition = 0;


void setup() {
  size(640, 480);
  
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
  
  //draw the first mask shape
  x[indexPosition] = mouseX;
  y[indexPosition] = mouseY;
  indexPosition = (indexPosition + 1) % num;
  graphicMask1.beginDraw();
  graphicMask1.noStroke();
  for (int i = 0; i < num; i++) {
    int pos = (indexPosition + 1) % num;
    float radius = 80;
    graphicMask1.ellipse(x[pos], y[pos], radius, radius);
  }
  graphicMask1.endDraw();
  
  //draw the second mask shape
  x[indexPosition] = mouseX;
  y[indexPosition] = mouseY;
  indexPosition = (indexPosition + 1) % num;
  graphicMask2.beginDraw();
  graphicMask2.noStroke();
  for (int i = 0; i < num; i++) {
    int pos = (indexPosition + 1) % num;
    float radius = 20;
    graphicMask2.ellipse(x[pos], y[pos], radius, radius);
  }
  graphicMask2.endDraw();
  
  //show the first image
  mask1Reveal();
  
  if(mousePressed) {
    mask2Reveal();
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
