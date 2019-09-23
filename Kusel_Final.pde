//Madeleine Kusel
//Spring 2019
//ARST 285 Final


//Queasycam is a FPS camera that I am using for this project. 
import queasycam.*;
boolean mouseClicky = false;
PVector camera;
PVector camera1;
QueasyCam cam;
boolean print =false;
int y;
int z = 0;
int a = 0;
int b = 0;
float angle;
float angle1;
int radiusRect;
int radius;
int dif1;
int dif2;
int count;
int const1;
int const2;
int countrange;
color temp;
int zconst;
//These color schemes are designed to look like early 2000s desktop backgrounds.
color bl[] = {#FF0DCF, #6A05EB, #0138FF, #0CCAEB, #0DFF7E};
color pi[] = {#FFC829, #E87E1E, #FF4A2E, #9C1E78, #9321FF};
color yl[] = {#FFF633, #88E82E, #40FF5C, #2EE8AF, #3BD4FF};
color gr[] = {#510DFF, #0943EB, #00C8FF, #0CE89F, #12FF2B};
//initial color
color cl[] = bl;

PVector camera3;

void setup() {
  background(0);
  stroke(255);
  size(1200, 600, P3D);
  createUI();
  //initializing the camera
  camera = new PVector(width/2, height/4, 100); 
  cam = new QueasyCam(this);
  cam.speed = 3;              // default is 3
  cam.sensitivity = .5;      // default is 2
  cam.position = camera;
  cam.speed = 10;
  reset();
}
//This function resets things to their original state and moves the camera around. 
//It is called every time the mouse is clicked
void reset() {
  //radius rect positions the camera at a semi-random spot in 3D space.
  // count range decides how many lines we will draw each loop through.
  
  radiusRect = int(random(80.0, 160.0));
  countrange = int(random(1, 3));
  camera3 = new PVector(radiusRect, radiusRect, 0);
  cam.position = camera3;
  y = 0;
  z = 0;
  angle = 0;
  angle1 = 0;
  zconst = 0;
  dif1 = int(random(1.0, 10.0));
  dif2 = 11 - dif1;
}

//here's the UI!
void createUI() {
  println("Welcome to Madeleine's drawing tool!");
  println("When you are ready please click to begin!");
  println("The mouse will control the movement of the camera, please move it gently.");
  println("Also, the direction of the mouse is inverted with what you see on the screen");
  println("Here are what the following keys do:");
  println("Z: changes color scheme, P: saves current screen as PNG");
  println("B: redraws background, and lets you choose starting position!");
  println("To start a new composition, click!");
}

//the actual drawing: features the key presses and the drawing actually occurs in the draw loop
void draw() {
  strokeWeight(random(1, 3));
  radius = radiusRect;

  //when we press b, we are able to reframe the compositon
  if (keyPressed && key == 'b') {
    background(0);
    noFill();
    box(800);
  }
  count = countrange;
  //each time we press "Z", the color scheme changes
  if (keyPressed && key == 'z') {
    if (cl == bl) {
      cl = pi;
    } else if (cl == pi) {
      cl = yl;
    } else if (cl == yl) {
      cl = gr;
    } else {
      cl = bl;
    }
  }
  int j = 0;
  int yconst = 0;
  translate(width/2, height/2, 0);

  //here's the loop where the lines are drawn.
  //We use sin and cos to create these shapes.
  while (j < count) {
    stroke(cl[0]);
    line(0, yconst, 7*zconst/5, radius*cos(angle), yconst + radius*sin(angle), 7*zconst/5);
    stroke(cl[1]);
    line(radius*cos(angle), yconst + radius*sin(angle), 7*zconst/5, radius*cos(angle*dif1), yconst +radius*(sin(angle*dif1)), 7*zconst/5);
    stroke(cl[2]);
    line(radius*cos(angle*dif1), yconst + radius*(sin(angle*dif1)), 7*zconst/5, 
      radius*cos(angle*dif2), yconst + radius*sin(angle*dif2), 7*zconst/5);
    stroke(cl[3]);
    line(radius*cos(angle*dif2), yconst + radius*sin(angle*dif2), 7*zconst/5, 0, yconst, 7*zconst/5);
    rotate(angle1);
    angle = angle + .014;
    angle1 = angle1 + .014;
    j++;
  }
  zconst++;
  ///after a long time, we will just automatically reset so that the program doesn't crash
  if (zconst == 1500) {
    background(255);
    background(0);
    noFill();
    reset();
    box(800);
  }
  //how to save as a jpg!
  if (print) {
    saveFrame("swirls.png");
    print = false;
  }
}
//the reset I previously described
void mousePressed() {
  background(0);
  noFill();
  reset();
  box(800);
}
//more support for printing
void keyPressed() {
  if (keyPressed && key == 'p' && print) {
    print = false;
  } else if (keyPressed && key =='p') {
    print = true;
  }
}
