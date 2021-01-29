
Oscillator test;

float TEMPO = 88.7;
float FPS = 25.0;

void setup(){

  size(1280,720,OPENGL);
  frameRate(FPS);

  ortho();

  test = new Oscillator();

}



void draw(){


  noFill();
  stroke(255,150);

  background(0);
  noFill();
  stroke(255, 150);
  int siz = 2;
  float len = 4.0;
  pushMatrix();
  rotateY(radians(millis() / 33.0));
  rotateX(radians(millis() / 33.0));
  translate(width/2,height/2,0);
  scale(30.0);
  for (int z = 0; z <= len; z++) {
    for (int y = 0; y <= len; y++) {
      for (int x = 0; x <= len; x++) {
        push();
        float nn = noise(x / 10.0 + millis() / 10000.0, y / 10.0 + millis() / 10000.0, z / 10.0 + millis() / 10000.0);
        translate(x * siz - (siz * len / 2), y * siz - (siz * len / 2), z * siz - (siz * len / 2));
        rotateX(nn * TWO_PI * 3.0);
        rotateY(y);
        rotateZ(z);
        box(siz / len);
        popMatrix();
      }
    }
  }
  pop();

}


class Oscillator{
  double timer;
  double frac;
  float rad;
  PVector dir;
  PVector UP;
  int frame;
  float theta,phi;

  Oscillator(){
    frame=0;
    timer = 0.0;
    frac = 1.0/FPS;
    UP=new PVector(0,1,0);

    dir=new PVector(random(-100,100),random(-100,100),random(-100,100));
    dir.normalize();



  }

  void rotX(){
  }

  void calc(){
  }

  void frame(){
    frame+=frac;
    calc();
  }

  void pre(){
    pushMatrix();
    rotateX(phi);
    rotateY(theta);
  }

  void post(){
    popMatrix();

  }


}
