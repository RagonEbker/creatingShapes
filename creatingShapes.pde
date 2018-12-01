// Version 0.1
// Creates rectangles, saves them in an arrayList and writes it as a json object into a file
// save Maps with 's'
// Create a new shape by pressing '1'

int mode;     //Mode you are in, e.g. '1' for creating new shapes
int counter = 0;
int xCount = 0;
int yCount = 0;
int transSpeed = 5; //speed of translation
int cX = 0;
int cY = 0;
int realX = mouseX-xCount;
boolean changeWidth;
boolean changeHeight;
boolean transL;
boolean aLeft;
boolean aUp;
boolean aDown;
boolean aRight;


ArrayList<Integer> xses;
ArrayList<Integer> yses;
ArrayList<Integer> wses;
ArrayList<Integer> hses;

JSONObject jMap;



void setup() {
  size(1366, 700);
  xses = new ArrayList<Integer>();
  yses = new ArrayList<Integer>();
  wses = new ArrayList<Integer>();
  hses = new ArrayList<Integer>();
  jMap = new JSONObject();
  printArray(xses);
  //rectMode(CENTER);
}


void draw() {
  trans();
  background(255);
  if (hses != null) {
    for (int i = 0; i<hses.size(); i++) {
      rect(xses.get(i), yses.get(i), wses.get(i), hses.get(i));
    }
  }
  if (changeWidth) wses.set(wses.size()-1, abs(xses.get(xses.size()-1)-mouseX+xCount));
  if (wses.size()>0) text(xses.get(wses.size()-1) -mouseX, 100, 100);  //has to be overworked abs does not work correct
  if (changeHeight) hses.set(hses.size()-1,abs(yses.get(xses.size()-1)-mouseY+yCount) );
  if (hses.size()>0) text(xses.get(hses.size()-1) -mouseY, 150, 100);
  if (transL) translate(200, 0);
  
  pushStyle();
  fill(0);
  if (xses.size()>0) text(wses.get(0), 100 - xCount, 100 - yCount);
  text("Current realX and realY: " + (mouseX-xCount) + " " + (mouseY-yCount), 100 - xCount, 150 - yCount);
  text("Current xTransl: " + xCount, 100 - xCount, 200-yCount);
  text("Current yTransl: " + yCount, 100 - xCount, 230-yCount);
  popStyle();
}


void mouseClicked() {
  if (mode == 0) changeHeight = false;
  if (changeWidth) {
    changeWidth = false;
    changeHeight = true;
    mode = 0;
  }

  if (mode == 1) {
    xses.add(mouseX - xCount);
    yses.add(mouseY - yCount);
    wses.add(100);
    hses.add(100);
    changeWidth = true;
    mode = 0;
  }
  if (mode == 2) {
    xses.add(mouseX);
    yses.add(mouseY);
    wses.add(100);
    hses.add(100);
  }

  if (mode == 3) {
    transL = true;
  }
}

void keyPressed() {
  if (key == '1') mode = 1; //creating rectangle, first x and y, then width, then height
  if (key == '2') mode = 2;
  if (key == '3') mode = 3; //translating errything
  if (key =='0') export();
  if (keyCode == LEFT) aLeft = true;
  if (keyCode == RIGHT) aRight = true; 
  if (keyCode == UP) aUp = true; 
  if (keyCode == DOWN) aDown = true; 
  if (key == 's') {
    for (int i = 0; i<xses.size(); i++) {
      jMap.setString(i  + "", (xses.get(i)+round(wses.get(i)/2)) + " " + (yses.get(i)+round(hses.get(i)/2)) + " " + wses.get(i) + " " +hses.get(i));
    }
    saveJSONObject(jMap, "data/jMap.json");
  };
  if (key == BACKSPACE) {
    xses.remove(xses.size()-1);
    yses.remove(yses.size()-1);
    wses.remove(wses.size()-1);
    hses.remove(hses.size()-1);
  }
}

void keyReleased() {
  if (keyCode == LEFT) aLeft = false; 
  if (keyCode == RIGHT) aRight = false; 
  if (keyCode == UP) aUp = false; 
  if (keyCode == DOWN) aDown = false;
}

void export() {
}

void trans() {
  translate(xCount, yCount);
  if (aLeft) {  
    xCount += transSpeed;
  }
  if (aRight) {  
    xCount -= transSpeed;
  }
  if (aUp) {  
    yCount += transSpeed;
  }
  if (aDown) {  
    yCount -= transSpeed;
  }
}
