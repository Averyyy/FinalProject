class pillar {
  float xPos=0;
  float yPos=0;
  float xh;
  float spY=2;
  long time;
  int score;
  pillar() {
    xh=round(random(1500));
    yPos=5;
    xPos=random(-100,width);
    time=millis();
  }
  void drawPillar() {
    stroke(255);
    strokeWeight(15);
    line(xPos, yPos, xPos+xh, yPos);
    
  }
  void movePillar(){
    spY+=0.4;
    yPos=yPos+spY;
    
  }
  void checkPosition(){
    if(xPos>h.y){
      score++;
  }
}
}
