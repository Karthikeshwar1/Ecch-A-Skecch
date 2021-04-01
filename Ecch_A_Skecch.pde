int frameWidth = 110;
int x = 350;
int y = 350;
int tempX = 0;
int tempY = 0;
int incrementalSpeed = 0;
float knobIncrementalSpeed = 0.0;
float leftKnobRotation = 0.1;
float rightKnobRotation = 0.1;
boolean isUpPressed = false;
boolean isDownPressed = false;
boolean isRightPressed = false;
boolean isLeftPressed = false;
boolean isShiftPressed = false;
boolean isCtrlPressed = false;
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
  text("Etch A Sketch", 264, 664);
  fill(222, 184, 132);
  text("Etch A Sketch", 260, 660);
  
}

void draw() {
  
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
  translate(x, y);
  stroke(30, 30, 30);
  strokeWeight(2);
  point(0, 0);




  // Handle movement of the plotter/brush
  // and rotation of knobs
  if (isUpPressed && y > frameWidth+10) {
    y = y - (1 + incrementalSpeed);
    rightKnobRotation = rightKnobRotation + (0.01 + knobIncrementalSpeed);
  }
  if (isDownPressed && y < height-frameWidth-10) {
    y = y + (1 + incrementalSpeed);
    rightKnobRotation = rightKnobRotation - (0.01 + knobIncrementalSpeed);
  }
  if (isLeftPressed && x > frameWidth+10) {
    x = x - (1 + incrementalSpeed);
    leftKnobRotation = leftKnobRotation - (0.01 + knobIncrementalSpeed);
  }
  if (isRightPressed && x < width-frameWidth-10) {
    x = x + (1 + incrementalSpeed);
    leftKnobRotation = leftKnobRotation + (0.01 + knobIncrementalSpeed);
  }
  
  // Clearing the canvas
  if (keyPressed) {
    if (key == 'c') {
      pushMatrix();
      x = 110;
      y = 110;
      translate(0, 0);
      stroke(150, 150, 150);
      strokeWeight(7);
      fill(204, 204, 204);
      rect(0, 0, 630, 480, 25);
      x = 350;
      y = 350;
      popMatrix();
    }
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
      incrementalSpeed = 3;
      knobIncrementalSpeed = 0.03;
    }
    if (keyCode == CONTROL && isCtrlPressed == false) {
      isCtrlPressed = true;
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
      incrementalSpeed = 0;
      knobIncrementalSpeed = 0.0;
    }
    if (keyCode == CONTROL) {
      isCtrlPressed = false;
    }
  }

  // Save screenshot
  if (key == 's') {
    saveFrame("./screenshots/screenshot-####.jpg");
    javax.swing.JOptionPane.showMessageDialog(null, "Screenshot saved");
  }
    
}
