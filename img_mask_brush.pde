//using pixels to draw the background

import processing.video.*;

Capture cam;
Movie mov;
PImage vr;
PImage revealedImage;
PGraphics graphicMask1;
PGraphics graphicMask2;


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
  
  if (mouseDragged) {
    graphicMask1.beginDraw();
    graphicMask1.noStroke();
    graphicMask1.ellipse(mouseX, mouseY, 80, 80);
    graphicMask1.endDraw();
  }
  
  //draw the second mask shape
  //graphicMask2.beginDraw();
  //graphicMask2.noStroke();
  //graphicMask2.ellipse(mouseX, mouseY, 100, 100);
  //graphicMask2.endDraw();
  
  //show the first image
  mask1Reveal();
  
  //after the timer is up, show the second image
  //if (mousePressed) {
  //  mask1Reveal();
  //}
}



//load an image and mask it with the PGraphics shape 1
void mask1Reveal() {
  revealedImage = vr.get();
  revealedImage.mask(graphicMask1);
  image(revealedImage, 0, 0);
}

//load another image and mask it with the PGraphics shape 2
//void mask2Reveal() {
//  revealedImage = mov.get();
//  revealedImage.mask(graphicMask2);
//  image(revealedImage, 0, 0);
//}

void mouseReleased() {
  loadPixels();
  vr.loadPixels();
  vr.pixels = pixels;
  vr.updatePixels();
}

void movieEvent(Movie m) {
  m.read();
}
