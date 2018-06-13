import processing.video.*;
import com.hamoid.*;

Capture cam;
PImage galaxy;
PImage vr;
PImage revealedImage;
PGraphics graphicMask;

int[] xpos = new int[50];
int[] ypos = new int[50];

int savedTime;
int totalTime = 6000;


void setup() {
  size(640, 480);
  
  //variable for counter
  savedTime = millis();
  
  //initialize Capture object
  cam = new Capture(this, width, height, "HD Pro Webcam C920", 30);
  cam.start(); //start the capture device
  
  //load images
  vr = loadImage("vr-640.jpg");
  galaxy = loadImage("galaxy-640.jpg");
  
  //variable for PGraphics
  graphicMask = createGraphics(width, height, JAVA2D);
  
  //initialize all elements of each array to zero
  for (int i = 0; i < xpos.length; i++) {
    xpos[i] = 0;
    ypos[i] = 0;
  }
}


void draw() {
  //set the webcam as first image
  if (cam.available()) {
    cam.read();
  }
  
  //set up counter
  int passedTime = millis() - savedTime;
  
  //flip webcam so it acts like a mirror
  pushMatrix();   // just so nothing else is affected
  scale(-1, 1);
  image(cam, -cam.width, 0);
  popMatrix();
  
  makeMask();
  drawImg1();
  
//after the timer is up, show the second image
  if (passedTime > totalTime) {
    //NOW START OVER!
    makeMask();
    drawImg2();
  }
  
}


void makeMask() {
  //draw the mask shape into a PGraphics object
  graphicMask.beginDraw();
  graphicMask.noStroke();
  graphicMask.ellipse(mouseX, mouseY, 30, 30);
  graphicMask.endDraw();
}

//load an image and mask it with the PGraphics object
void drawImg1() {
  revealedImage = vr.get();
  revealedImage.mask(graphicMask);
  image(revealedImage, 0, 0);
}

//load an image and mask it with the PGraphics object
void drawImg2() {
  revealedImage = galaxy.get();
  revealedImage.mask(graphicMask);
  image(revealedImage, 0, 0);
  }
