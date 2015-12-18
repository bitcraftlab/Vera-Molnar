
  /////////////////////////////////////////
  //                                     //
  //       Vera Molnar Slideshow         //
  //                                     //
  /////////////////////////////////////////
  
  //  @bitcraftlab 12/2015 (Processing 3.0)


// wait  milliseconds between slides
int wait_millis = 1000;

// time when the last image was shown
int start_time = -wait_millis;

// are we running the show?
boolean paused = false;

// slide to pick
int pick = -1;

// array to store image file pointers
File[] files;

// where the slides are
String slidesFolder;

// current image
PImage slide;

void setup() {
  
  // screen size
  
  // Processing 2.0
  // size(displayWidth, displayHeight);
  
  // Processing 3.0
  fullScreen();
  
  // get images from the download sketch
  slidesFolder = sketchPath("") + "/../Download/images";
  
  // get list of images
  files = new File(slidesFolder).listFiles();
  
}


void draw() {
  
  // is it time to show a new slide?
  if(millis() - start_time > wait_millis && !paused) {
    
    // reset clock
    start_time = millis();
    
    // show the next slide
    background(0);
    next();
  
  }
  
  
  stroke(64);
  
  if(paused) {
    // line at the top of the page
    line(0, 0, width, 0); 
  } else {
    // progressing line at the top of the page
    line(0, 0, width * (millis() - start_time) / wait_millis, 0);
  }
  
}

void keyPressed() {
  switch(keyCode) {
    
    case ' ':
      paused = !paused;
      break;
      
    case LEFT:
    case UP:
      prev();
      break;
      
    case RIGHT:
    case DOWN:
      next();
      break;
      
  }
}

void prev() {
  pick = (pick +  files.length -1) % files.length; 
  show();
}

void next() {
  pick = (pick + 1) % files.length; 
  show();
}

void show() {
  
  slide = loadImage(files[pick].getAbsolutePath()); 
  
  // scale image to the max
  float zoom = min(float(width) / slide.width, float(height) / slide.height);
  
  // calculate new image dimensions
  int w = int(zoom * slide.width);
  int h = int(zoom * slide.height);
  
  // center the image
  int dx = (width - w) / 2;
  int dy = (height - h) / 2;
  
  // show it
  image(slide, dx, dy, w, h);
  
}