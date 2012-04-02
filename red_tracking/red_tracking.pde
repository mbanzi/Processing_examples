/**
 * Brightness Tracking 
 * by Daniel Shiffman.  
 * 
 * Tracks the brightest pixel in the video.
 * Click the mouse to select a different color. 
 * 
 * Created 2 May 2005
 * modified to track bright red
 */

import processing.video.*;

// Variable for capture device
Capture video;
color trackColor;
boolean imageFlag = false;
boolean printImage = false;
int w = 400;
int h = 300;


void setup()
{
  background(255);
  size(w , h);
  frameRate(25);
  colorMode(RGB,255,255,255,100);
  // Using the default capture device
  video = new Capture(this, w, h, 12);
  trackColor = color(255,0,0); // Start off tracking for white
  //noFill();
  smooth();
  strokeWeight(10.0);
  stroke(0);
}

void captureEvent(Capture camera)
{
  camera.read();
}

void draw()
{
  //background(255);
  //loadPixels();

  // Draw the video image on the background
  if (imageFlag) {
    image(video,0,0);
  }
  // Local variables to track the color
  float closestDiff = 500.0f;
  int closestX = 0;
  int closestY = 0;
  // Begin loop to walk through every pixel
  for ( int x = 0; x < video.width; x++) {
    for ( int y = 0; y < video.height; y++) {
      int loc = x + y*video.width;
      // What is current color
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor); 
      float g1 = green(currentColor); 
      float b1 = blue(currentColor);
      float r2 = red(trackColor);   
      float g2 = green(trackColor);   
      float b2 = blue(trackColor);
      // Using euclidean distance to compare colors
      float d = dist(r1,g1,b1,r2,g2,b2);
      //float d = dist(r1,0,0,r2,0,0); 
      // If current color is more similar to tracked color than
      // closest color, save current location and current difference
      if (d < closestDiff) {
        //println(closestDiff);
        closestDiff = d;
        closestX = x;
        closestY = y;
      }
    }
  }
  // Draw a circle at the tracked pixel
  if (closestDiff < 120) {
    if (imageFlag) {
      point(closestX,closestY);
    } 
    else {
      point(400-closestX,closestY);
    }
  }

  if (printImage) {
    saveFrame("image-######.jpg"); 
    printImage = false;
  }


}

void mousePressed() {
  // Save color where the mouse is clicked in trackColor variable
  //int loc = mouseX + mouseY*video.width;
  //trackColor = video.pixels[loc];

}

void keyPressed() {  
  if (keyCode == ENTER) {
    printImage = true;
  }  
  if (key == 'e') {
    if (imageFlag) {
      imageFlag = false;
      background(255);
    } 
    else {
      imageFlag = true;
    } 
  }
}

