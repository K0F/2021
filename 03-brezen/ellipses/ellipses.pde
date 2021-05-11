

float step = 0.01;
float startR = 100.0;
float R = 5.0;
float addR = 5.0;
int NUM = 10;
float rotX[],rotY[];
float THICKNESS = 2.0;
float TEMPO = 121.35/60.0/5.0;


void setup(){
  size(640,480,OPENGL);
  rotX=new float[NUM];
  rotY=new float[NUM];

}



void draw(){
  background(0);
  noFill();
  stroke(255,120);
  R = startR;

  float time = millis();
  float PHASE = 0.0;

  for(int i = 0 ; i < NUM;i++){

    R+=addR;
    pushMatrix();
    translate(width/2,height/2);

    rotY[i]=TAU/4.0+TAU/10.0;
    rotX[i]=(TAU/(NUM+0.0)*i);
    rotateX(rotX[i]);
    rotateY(rotY[i]);
    beginShape();
    PHASE += TAU/(NUM+0.0);
    for(float f = 0; f < TAU ; f+=step){
      float x = cos(f)*R;
      float y = sin(f)*R;
      strokeWeight(pow((sin(((time*TEMPO)/1000.0*TAU) - f + PHASE)) +1.0,4.0) * THICKNESS);
      vertex(x,y);
    }
    endShape();
    popMatrix();
  }


}
