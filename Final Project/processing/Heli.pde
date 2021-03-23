class heli {
  float x, y, spX, spY;
  PImage HelicopterImage;

  heli() {
    x=350;
    y=450;
  }
  void drawheli(float x, float y) {
    fill(255);
    image(HelicopterImage, x, y, 60, 60);
  }
  void moveX() {
    if (sensorValues[2]<0) { // move left
      float value=abs(abs(sensorValues[1])-90);
      float m=map(value, 0, 25, 0, 20);
      if (x>0&&x<1590) {
        x=x+m;
      } else {
        x=1590;
      }
      //yaxis
      if (sensorValues[3]>0) {
        float valuez=abs(abs(sensorValues[3])-20);
        float o=map(valuez, 0, 30, 0,15 );

        if (y>0&&y<height) {
          y+=o;
        } else {
          y=10;
        }}
        
        if (sensorValues[3]<0) {
          float valuezw=abs(abs(sensorValues[3])-20);
          float ow=map(valuezw, 0, 30, 0, 15);
          if (y>0&&y<height) {
            y-=ow;
          } else {
            y=height-20;
          }
        }
      }
    


    if (sensorValues[2]>0) { // move right
      float value=abs(abs(sensorValues[1])-88);
      float n=map(value, 0, 20, 0, 20);
      if (x>0&&x<1590) {
        x=x-n;
      } else {
        x=5;
      }
      //yaxis
      if (sensorValues[3]>0) {
        float valuez=abs(abs(sensorValues[3])-20);
        float o=map(valuez, 0, 30, 0, 15);

        if (y>0&&y<height) {
          y+=o;
        } else {
          y=10;
        }
      }
      if (sensorValues[3]<0) {
        float valuez=abs(abs(sensorValues[3])-20);
        float o=map(valuez, 0, 30, 0, 15);
        if (y>0&&y<height) {
          y-=o;
        } else {
          y=height-40;
        }
      }
    }
    print("x"+x);
  }
}
