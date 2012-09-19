// Color response: a dual task
// RYB v1.0

boolean started = false;
int w=800; int h=800;
int startingTime = millis();
int lastChangedTime = millis();
color gray = color(128, 128, 128); color red = color(255, 0, 0); color yellow = color(255, 255, 0); color blue = color(0, 0, 255);
color[] possibleColors = { red, yellow, blue };

color currentColor = gray;
color strokeColor = color(255,255,255);

// TODO randomSeed() to fixed constant
// TODO address color-blindness

void setup() {
  // TODO enter participant id here:  
  Date d = new Date();
  println("Setup for participant X began at time: " + d.getTime());
  
  size(w, h);
  background(255); // white
}

void draw() {
  if (started) {
    float nowSeconds = millis() / 1000.0; // time now
    float elapsed = nowSeconds - lastChangedTime/1000.0; // since last changed color
    if (elapsed >= 10.0) { // seconds    
      int randIndex = int(random(3));
      currentColor = possibleColors[randIndex]; // update!
    
      lastChangedTime = millis();
      println("Color # to " + (randIndex+1) + " at " + lastChangedTime);
    }
  
    background(255); // clear to white
    fill(currentColor);
    
    stroke(strokeColor); // black
    strokeWeight(12);
    ellipse(w/2, h/2, w/2, h/2);  
  }
}

void keyPressed() {
  if (started && key == '1' || key == '3' || key == '5') { // TODO refactor
    int keyIndex = (key - '1') / 2; // 1,3,5 -> 0,1,2
    strokeColor = possibleColors[keyIndex]; //color(0,0,0);
    println("User press " + (keyIndex+1) + " at " + millis());    
  }
  
  if (key == ' ') {
    if (!started) println("Spacebar -- begin experiment at " + millis());
    else println("Spacebar --- experiment ended at " + millis());
    started = !started;
  }    
}

void keyReleased() {
  if (started) {
    strokeColor = color(255,255,255);
  
    if (key == '1' || key == '3' || key == '5') {
      currentColor = gray; // TODO check if correct keypress?
    }
  }
}
