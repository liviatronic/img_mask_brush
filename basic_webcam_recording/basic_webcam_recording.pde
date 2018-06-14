import processing.video.*;
import com.hamoid.*;

Capture cam;
VideoExport videoExport;

// Press 'q' to finish saving the movie and exit.


void setup() {
  size(1280, 960);
  
  frameRate(30);
    
  //initialize Capture object
  cam = new Capture(this, width, height, "HD Pro Webcam C920", 30);
  cam.start(); //start the capture device

  videoExport = new VideoExport(this, "camera.mp4", cam);
  videoExport.startMovie();
}


void draw() {
  if (cam.available()) {
    cam.read();
  }
  
  //flip webcam so it acts like a mirror
  pushMatrix();   // just so nothing else is affected
  scale(-1, 1);
  image(cam, -cam.width, 0);
  popMatrix();
 
  videoExport.saveFrame();
}


void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}
