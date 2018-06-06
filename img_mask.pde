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
  savedTime = millis();
  galaxy = loadImage("galaxy.jpg");
  vr = loadImage("vr.jpg");
  crystals = loadImage("crystals.jpg");
  graphicMask1 = createGraphics(width, height, JAVA2D);
  graphicMask2 = createGraphics(width, height, JAVA2D);
}

void draw() {
  background(vr);
  int passedTime = millis() - savedTime;
  
  graphicMask1.beginDraw();
  graphicMask1.noStroke();
  graphicMask1.ellipse(mouseX, mouseY, 100, 100);
  graphicMask1.endDraw();
  
  graphicMask2.beginDraw();
  graphicMask2.noStroke();
  graphicMask2.ellipse(mouseX, mouseY, 100, 100);
  graphicMask2.endDraw();
  
  mask2Reveal();
  
  if (passedTime > totalTime) {
    mask1Reveal();
  }
  
}

void mask1Reveal() {
  revealedImage = crystals.get();
  revealedImage.mask(graphicMask1);
  image(revealedImage, 0, 0);
}

void mask2Reveal() {
  revealedImage = galaxy.get();
  revealedImage.mask(graphicMask2);
  image(revealedImage, 0, 0);
}
