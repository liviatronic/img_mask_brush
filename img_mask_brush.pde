import processing.video.*;
import com.hamoid.*;

Capture cam;
Movie mov1;
Movie mov2;
VideoExport videoExport;

PImage revealedImage;
PGraphics graphicMask;


void setup() {
  size(1280, 960, P2D);
  frameRate(30);
  
  //initialize VideoExport object
  videoExport = new VideoExport(this);
  videoExport.startMovie();
  
  //initialize Movie object
  mov1 = new Movie(this, "facecam1.mp4");
  //start movie playing
  mov1.loop();
  
  //initialize Movie object
  mov2 = new Movie(this, "facecam2.mp4");
  //start movie playing
  mov2.loop();
  
  //initialize Capture object
  cam = new Capture(this, width, height, "HD Pro Webcam C920", 30);
  cam.start(); //start the capture device
 
  //variable for PGraphics
  graphicMask = createGraphics(width, height, JAVA2D);
}


void draw() {
  //set the webcam as first image
  if (cam.available()) {
    cam.read();
  }
  
  //flip webcam so it acts like a mirror
  pushMatrix();   // just so nothing else is affected
  scale(-1, 1);
  image(cam, -cam.width, 0);
  popMatrix();
  
  makeMask();
  drawImg1();
  
////after the timer is up, show the second image
  if (mousePressed) {
    //NOW START OVER!
    makeMask();
    drawImg2();
  }
  
}


void makeMask() {
  //draw the mask shape into a PGraphics object
  graphicMask.beginDraw();
  graphicMask.noStroke();
  graphicMask.rect(mouseX, mouseY, 100, 100);
  graphicMask.endDraw();
}

//load an image and mask it with the PGraphics object
void drawImg1() {
  //draw the movie into a PImage object
  revealedImage = mov1.get();
  revealedImage.mask(graphicMask);
  image(revealedImage, 0, 0);
}

//load an image and mask it with the PGraphics object
void drawImg2() {
  revealedImage = mov2.get();
  revealedImage.mask(graphicMask);
  image(revealedImage, 0, 0);
  }

void movieEvent(Movie m) {
  m.read();
}
