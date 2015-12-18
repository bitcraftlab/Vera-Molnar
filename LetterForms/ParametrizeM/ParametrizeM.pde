
  /////////////////////////////////////////
  //                                     //
  //  ReCoding Vera Molnar ...           //
  //                                     //
  //  >>> M <<< (parametrized)           //
  //                                     //
  /////////////////////////////////////////

  //  @bitcraftlab 12/2015 (Processing 3.0)


// horizontal grid size
float columns = 10;

// maximum stroke width
float maxStroke = 20;

// actual stroke width
float stroke = 5;

// switch background and foreground
float invert = 0;

// canvas width 
int w = 500;
int h = 500;

// parameter space
Params pspace = new Params(this,
  new Param("stroke", 1, maxStroke, 1),
  new Param("columns", 1, 20, 1),
  new Param("invert", 0, 1, 1)
);


////// CODE //////

void setup() {
  
  size(600, 600);
  noFill();
  
  // turn on debug info
  pspace.debug = true;

}

void draw() {
  
  // animate parameters with every frame
  pspace.animate();

  // background and foreground colors
  float fg = 255 * invert;
  float bg = 255 - fg;
  
  background(bg);

  // center canvas inside the window
  translate((width - w)/2, (height - h)/2);

  // draw canvas
  fill(bg); 
  noStroke(); 
  rect(0, 0, w, h);

  // draw letters
  stroke(fg); 
  noFill(); 
  strokeJoin(ROUND);

  // diameter of the tile
  float d = (w- maxStroke) / columns;

  // vertical grid size
  int rows = floor((h - maxStroke) / d);

  // offset to the origin of the grid
  float tx = maxStroke/2;
  float ty = (h - d * rows) / 2;

  // move to the orgin of the grid
  translate(tx, ty);

  // scale to grid
  scale(d);

  // adjust stroke weight
  strokeWeight(2*stroke/d);

  // draw the tiles
  for (int x = 0; x < columns; x++) {
    for (int y = 0; y < rows; y++) {

      // save current transformation
      pushMatrix();

      // move to the center of the letter
      translate(x, y); 
      scale(0.5); 
      translate(1, 1);

      // rotate it
      rotate(PI/2 * ((x + y) % 4));

      // draw the letter form
      beginShape();
      vertex(-1, +1);
      vertex(-1, -1);
      vertex( 0, 0);
      vertex(+1, -1);
      vertex(+1, +1);
      endShape();

      // restore transformation
      popMatrix();
    }
  }  
}