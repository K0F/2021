
Oscillator test;

float TEMPO = 88.7;
float FPS = 25.0;

void setup(){

  size(640,480,OPENGL);
  frameRate(FPS);

  ortho();

  test = new Oscillator();

}



void draw(){

  background(0);
  stroke(255);


  pushMatrix();
  translate(width/2,height/2,0);
  test.pre();
  for(int z=0;z<1000;z+=30){
    for(int y=0;y<1000;y+=30){
      for(int x=0;x<1000;x+=30){
        point(x,y,z);
      }
    }
  }
  test.post();
  popMatrix();

}


class Oscillator{
  double timer;
  double frac;
  float rad;
  PVector XY,YZ,XZ;
  PVector UP;
  int frame;
  float theta,phi;

  Oscillator(){
    frame=0;
    timer = 0.0;
    frac = 1.0/FPS;
    UP=new PVector(0,1,0);

    XY=new PVector(UP.x,UP.y);
    YZ=new PVector(UP.y,UP.z);
    XZ=new PVector(UP.x,UP.z);



  }

  void rotX(){
    XY.rotate(map(frame,0,FPS*(TEMPO/120.0),-PI,PI));
  }

  void calc(){
    rotX();
    XY.normalize();
    YZ.normalize();
    XZ.normalize();
    phi=acos(XY.dot(UP));
    theta=acos(XZ.dot(UP));

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
