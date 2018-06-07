PImage vr;
PImage galaxy;
PImage crystals;
PImage revealedImage;
PGraphics graphicMask1;
PGraphics graphicMask2;
int savedTime;
int totalTime = 3000;

void setup() {
  size(800, 640);
  
  //variable for counter
  savedTime = millis();
  
  //load images
  galaxy = loadImage("galaxy.jpg");
  vr = loadImage("vr.jpg");
  crystals = loadImage("crystals.jpg");
  
  //variables for PGraphics
  graphicMask1 = createGraphics(width, height, JAVA2D);
  graphicMask2 = createGraphics(width, height, JAVA2D);
}

void draw() {
  //set the first image you will see (will appear as the top layer, even though it's actually the background)
  background(vr);
  
  //set up counter
  int passedTime = millis() - savedTime;
  
  //draw the first mask shape
  graphicMask1.beginDraw();
  graphicMask1.noStroke();
  graphicMask1.ellipse(mouseX, mouseY, 100, 100);
  graphicMask1.endDraw();
  
  //draw the second mask shape (smaller brush size)
  graphicMask2.beginDraw();
  graphicMask2.noStroke();
  graphicMask2.ellipse(mouseX, mouseY, 10, 10);
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
  revealedImage = crystals.get();
  revealedImage.mask(graphicMask1);
  image(revealedImage, 0, 0);
}

//load another image and mask it with the PGraphics shape 2
void mask2Reveal() {
  revealedImage = galaxy.get();
  revealedImage.mask(graphicMask2);
  image(revealedImage, 0, 0);
}
