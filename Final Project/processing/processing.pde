import processing.sound.*;
import processing.serial.*;


String myString = null;
Serial myPort;

int NUM_OF_VALUES = 4;   /** YOU MUST CHANGE THIS ACCORDING TO YOUR PROJECT **/
int[] sensorValues;      /** this array stores values from Arduino **/

heli h=new heli();
ArrayList<pillar> p= new ArrayList<pillar>();
Drop[] drops = new Drop[500]; 
ArrayList<bird> b= new ArrayList<bird>();


PImage HelicopterImage;
boolean end=false;
boolean intro=false;

int score;
int lastMillis = 0;


void setup() {
  size(1600, 800);
  setupSerial();
  for (int i = 0; i < drops.length; i++) { // we create the drops 
    drops[i] = new Drop();
  }
  p.add(new pillar());
  b.add(new bird());
}
void draw() {
  
  updateSerial();
  printArray(sensorValues);

  if (intro) {
    background(255);
    for (int i = 0; i < drops.length; i++) {
        drops[i].fall(); // sets the shape and speed of drop
        drops[i].show(); // render drop
      }
    fill(29, 231, 240);
    rect(width/8, height/4, width*6/8, height/2);
    fill(255, 138, 28);
    textAlign(CENTER);
    textSize(50);
    text("Chicken Little is Afraid of Sky Falling Down...", width/2, height/2);
    text("Step in to START", width/2, height/2+100);

    if (sensorValues[0]<20&&0<sensorValues[0]) {
      reset();
      intro=false;
    }
  } else {
    if (end) {
      background(0);
      stroke(60);
      textAlign(CENTER);
      textSize(80);
      fill(150, 156, 250);
      text("Score: "+score+"  Good Job!", width/2, height/2);
      stroke(30);
      textSize(30); 
      fill(255);
      text("click the mouse to restart", 300, 700);
      
      if (mousePressed) {
        reset();
      }
    } else { // game starts


      //drop code
      background(51, 70, 229); // background color in RGB color cordinates
      for (int i = 0; i < drops.length; i++) {
        drops[i].fall(); // sets the shape and speed of drop
        drops[i].show(); // render drop
      }


      // change this to use score 
      int m=0;
      score=(millis() - lastMillis)/100;
      m=millis();



      h.HelicopterImage= loadImage("chicken.png" );
      h.drawheli(h.x, h.y);
      h.moveX();

      //pillar code
      for (int i = 0; i<p.size(); i++) {
        p.get(i).drawPillar();
        p.get(i).movePillar();
        p.get(i).checkPosition(); 

        if (p.get(i).yPos<h.y+10 && p.get(i).yPos>h.y-10) {//=h.y
          if (h.x>p.get(i).xPos && h.x<p.get(i).xPos+p.get(i).xh) {
            end=true;
          } else {
            end=false;
          }
        }
        stroke(40);
        textAlign(CENTER);
        textSize(60);
        fill(150, 156, 250);
        text("Score" + score, 7*width/9, 1*height/3);

        if (millis()-p.get(i).time>5000) {
          p.remove(i);
        }
      }
      if (m%500<15) {
        p.add(new pillar());
      }

      println(b.size());
      //bird code
      for (int i = 0; i<b.size(); i++) {
        b.get(i).drawBird();
        b.get(i).moveBird();

        if (b.get(i).y<h.y+30 && b.get(i).y>h.y-30) {
          if (h.x>b.get(i).x-10 && h.x<b.get(i).x+10) {
            end=true;
          } else {
            end=false;
          }
        }
        if (millis()-b.get(i).time>8000) {
          b.remove(i);
        }
      }
      if (m%round(random(1000, 3000))<15) {
        b.add(new bird());
      }
    }
  }
}


void reset() {
  end=false;
  p= new ArrayList<pillar>();
  b= new ArrayList<bird>();
  h=new heli();
  intro=true;

  score = 0;
  lastMillis = millis();
}
void setupSerial() {
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[ 4 ], 9600);
  // WARNING!
  // You will definitely get an error here.
  // Change the PORT_INDEX to 0 and try running it again.
  // And then, check the list of the ports,
  // find the port "/dev/cu.usbmodem----" or "/dev/tty.usbmodem----" 
  // and replace PORT_INDEX above with the index number of the port.

  myPort.clear();
  // Throw out the first reading,
  // in case we started reading in the middle of a string from the sender.
  myString = myPort.readStringUntil( 10 );  // 10 = '\n'  Linefeed in ASCII
  myString = null;

  sensorValues = new int[NUM_OF_VALUES];
}



void updateSerial() {
  while (myPort.available() > 0) {
    myString = myPort.readStringUntil( 10 ); // 10 = '\n'  Linefeed in ASCII
    if (myString != null) {
      String[] serialInArray = split(trim(myString), ",");
      if (serialInArray.length == NUM_OF_VALUES) {
        for (int i=0; i<serialInArray.length; i++) {
          sensorValues[i] = int(serialInArray[i]);
        }
      }
    }
  }
}
