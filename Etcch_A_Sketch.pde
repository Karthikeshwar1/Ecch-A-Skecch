int frameWidth = 110;
float plotterX = 350;
float plotterY = 350;
int windowX = 0, windowY = 0;
int windowXPrevFrame = 0, windowYPrevFrame = 0;
int movingWindowFrameCount = 0;
int staticWindowFrameCount = 0;
int staticWindowFrameCountOld = 0;
int numOfWindowShakes = 0;
int tempX = 0, tempY = 0;
float plotterSpeed = 0;
float knobSpeed = 0.0;
float leftKnobRotation = 0.1;
float rightKnobRotation = 0.1;
boolean isUpPressed = false;
boolean isDownPressed = false;
boolean isRightPressed = false;
boolean isLeftPressed = false;
boolean isShiftPressed = false;
boolean isCtrlPressed = false;
boolean isCPressed = false;
float plotterSpeedIncrement = 3;
float knobSpeedIncrement = 0.03;
float plotterSpeedDecrement = -0.7;
float knobSpeedDecrement = -0.007;
PFont font;

void setup() {
  // The red background/frame
  pushMatrix();
  size(850, 700);
  noStroke();
  fill(207, 0, 0);
  rect(0, 0, 850, 700);
  popMatrix();
  
  // Rectangle 1 for white border
  pushMatrix();
  translate(0, 0);
  stroke(240);
  strokeWeight(25);
  fill(255);
  rect(110, 110, 630, 480, 25);
  popMatrix();
  
  // Rectangle 2 for black border
  pushMatrix();
  translate(0, 0);
  stroke(10);
  strokeWeight(17);
  fill(255);
  rect(110, 110, 630, 480, 25);
  popMatrix();

  // The main canvas with gray border
  pushMatrix();
  translate(0, 0);
  stroke(150, 150, 150);
  strokeWeight(7);
  fill(204, 204, 204);
  rect(110, 110, 630, 480, 25);
  popMatrix();
  
  // Left knob shadow
  pushMatrix();
  stroke(120);
  strokeWeight(10);
  fill(240);
  ellipse(70, 640, 80, 80);
  popMatrix();
  
  // Right knob shadow
  pushMatrix();
  stroke(120);
  strokeWeight(10);
  fill(240);
  ellipse(780, 640, 80, 80);
  popMatrix();

  // Text with shadow
  font = loadFont("MaturaMTScriptCapitals-48.vlw");
  textFont(font); 
  textSize(48);
  fill(70);
  text("Etcch A Sketch", 264, 664);
  fill(222, 184, 132);
  text("Etcch A Sketch", 260, 660);
  
  

}

void draw() {
  
  // Get coordinates of the main window
  windowX = getWindowCoordinatesX();
  windowY = getWindowCoordinatesY();
  //print("x: " + windowX + " y: " + windowY + "\n");
  //print(frameCount);
  //println(movingWindowFrameCount + " " + staticWindowFrameCount + " " + numOfWindowShakes);
  
  // Check if the window is being shaken
  // Window is shaken if previous coordinates are different than current coordinates
  if (windowX != windowXPrevFrame || windowY != windowYPrevFrame) {
    movingWindowFrameCount++;
    staticWindowFrameCount = 0;
    // If window is moved for some frames, then increase number of shakes
    if (movingWindowFrameCount > 25) {
      numOfWindowShakes++;
      // Clear the screen if the window is shaken properly
      // This also makes sure the screen isn't erased
      // when the window is slightly moved
      if (numOfWindowShakes > 10) {
        stroke(150, 150, 150);
        strokeWeight(7);
        fill(204, 204, 204);
        rect(110, 110, 630, 480, 25);
      }
    }
  }
  // If previous and current coordinates are same, window is not being shaken
  else {
    movingWindowFrameCount = 0;
    staticWindowFrameCount++;
    // If window remains static for a while, then number of shakes is zero
    if (staticWindowFrameCount > 50) {
      numOfWindowShakes = 0;
    }
  }
  windowXPrevFrame = windowX;
  windowYPrevFrame = windowY;

  // Left knob
  pushMatrix();
  stroke(24);
  strokeWeight(3);
  fill(240);
  ellipse(70, 640, 80, 80);
  popMatrix();

  // Right knob
  pushMatrix();
  stroke(24);
  strokeWeight(3);
  fill(240);
  ellipse(780, 640, 80, 80);
  popMatrix();

  // Line on left knob
  pushMatrix();
  stroke(24);
  strokeWeight(3);
  fill(2);
  translate(70, 640);
  rotate(leftKnobRotation);
  line(0, -40, 0, 0);
  line(0, 0, 0, 40);
  popMatrix();

  // Line on right knob
  pushMatrix();
  stroke(24);
  strokeWeight(3);
  fill(2);
  translate(780, 640);
  rotate(rightKnobRotation);
  line(0, -40, 0, 0);
  line(0, 0, 0, 40);
  popMatrix();

  // The plotter/brush/cursor
  if (isCPressed) {
    // Clear the screen
    stroke(150, 150, 150);
    strokeWeight(7);
    fill(204, 204, 204);
    rect(110, 110, 630, 480, 25);
  } else {
    translate(plotterX, plotterY);
    stroke(30, 30, 30);
    strokeWeight(2);
    point(0, 0);
  }



  // Handle movement of the plotter/brush
  // and rotation of knobs
  if (isUpPressed &&plotterY > frameWidth+10) {
   plotterY =plotterY - (1 + plotterSpeed);
    rightKnobRotation = rightKnobRotation + (0.01 + knobSpeed);
  }
  if (isDownPressed &&plotterY < height-frameWidth-10) {
   plotterY =plotterY + (1 + plotterSpeed);
    rightKnobRotation = rightKnobRotation - (0.01 + knobSpeed);
  }
  if (isLeftPressed &&plotterX > frameWidth+10) {
   plotterX =plotterX - (1 + plotterSpeed);
    leftKnobRotation = leftKnobRotation - (0.01 + knobSpeed);
  }
  if (isRightPressed &&plotterX < width-frameWidth-10) {
   plotterX =plotterX + (1 + plotterSpeed);
    leftKnobRotation = leftKnobRotation + (0.01 + knobSpeed);
  }
  

}

void keyPressed() {

  if (key == CODED) {
    if (keyCode == UP && isUpPressed == false) {
      isUpPressed = true;
    }
    if (keyCode == DOWN && isDownPressed == false) {
      isDownPressed = true;
    }
    if (keyCode == LEFT && isLeftPressed == false) {
      isLeftPressed = true;
    }
    if (keyCode == RIGHT && isRightPressed == false) {
      isRightPressed = true;
    }
    if (keyCode == SHIFT && isShiftPressed == false) {
      isShiftPressed = true;
      plotterSpeed = plotterSpeedIncrement;
      knobSpeed = knobSpeedIncrement;
    }
    if (keyCode == CONTROL && isCtrlPressed == false) {
      isCtrlPressed = true;
      plotterSpeed = plotterSpeedDecrement;
      knobSpeed = knobSpeedDecrement;
    }
  } else {
    if (key == 'w' && isUpPressed == false) {
      isUpPressed = true;
    }
    if (key == 's' && isDownPressed == false) {
      isDownPressed = true;
    }
    if (key == 'a' && isLeftPressed == false) {
      isLeftPressed = true;
    }
    if (key == 'd' && isRightPressed == false) {
      isRightPressed = true;
    }
    else if (key == 'c' && isCPressed == false) {
      isCPressed = true;
    }
  }
  
}

void keyReleased() {

  if (key == CODED) {
    if (keyCode == UP) {
      isUpPressed = false;
    }
    if (keyCode == DOWN) {
      isDownPressed = false;
    }
    if (keyCode == LEFT) {
      isLeftPressed = false;
    }
    if (keyCode == RIGHT) {
      isRightPressed = false;
    }
    if (keyCode == SHIFT) {
      isShiftPressed = false;
      plotterSpeed = 0;
      knobSpeed = 0.0;
    }
    if (keyCode == CONTROL) {
      isCtrlPressed = false;
      plotterSpeed = 0;
      knobSpeed = 0.0;
    }
  } else {
    
    if (key == 'w') {
      isUpPressed = false;
    }
    if (key == 's') {
      isDownPressed = false;
    }
    if (key == 'a') {
      isLeftPressed = false;
    }
    if (key == 'd') {
      isRightPressed = false;
    }
    // Save screenshot
    else if (key == 't') {
      saveFrame("./screenshots/screenshot-####.jpg");
      javax.swing.JOptionPane.showMessageDialog(null, "Screenshot saved");
    }
    else if (key == 'c') {
      isCPressed = false;
    }
    else if (key == 'i') {
      javax.swing.JOptionPane.showMessageDialog(null, "Use arrow keys to move\nHold down shift/ctrl to increase/decrease speed\nT - screenshot\nC (or shake the window) - Clear screen");
    }
  }
    
}



// Find x-coordinate of the main window
int getWindowCoordinatesX(){

  int locX = 0;
  // Check if renderer is JAVA2D
  if(surface instanceof processing.awt.PSurfaceAWT){
    java.awt.Frame frame = ( (processing.awt.PSurfaceAWT.SmoothCanvas) ((processing.awt.PSurfaceAWT)surface).getNative()).getFrame();
    java.awt.Point point = frame.getLocationOnScreen();
    locX = (int)point.getX();
    //print("java2d");
  }
  
  return locX;
}

// FindplotterY-coordinate of the main window
int getWindowCoordinatesY(){

  int locY = 0;
  // Check if renderer is JAVA2D
  if(surface instanceof processing.awt.PSurfaceAWT){
    java.awt.Frame frame = ( (processing.awt.PSurfaceAWT.SmoothCanvas) ((processing.awt.PSurfaceAWT)surface).getNative()).getFrame();
    java.awt.Point point = frame.getLocationOnScreen();
    locY = (int)point.getY();
  }
  
  return locY;
}
