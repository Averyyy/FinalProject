class bird{
  float x,y,spX,spY;
  long time;
  bird(){
    x=random(0,width);
    y=100;
    spX=random(-5,5);
    spY=random(-5,5);
  }
  void drawBird(){
    stroke(171,185,19);
    strokeWeight(12);
    fill(0);
    ellipse(x,y,30,20);
  }
  void moveBird(){
    x=x+spX;
    y=y+spY;
  }
    
  
  
  
  
}
