class fruit{
  float x,y;
  PImage fruit;
  fruit(){
    x=random(width);
    y=0;
  }
  void drawFruit(){
    image(fruit,x,y,60,60);
  }






}
