


PMatrix mat;
float L = 50;
float R = 50.0;
String symbols = "12345678";


void setup(){
  size(720,576,OPENGL);
  

}


void draw(){
  background(0);

  translate(width/2,height/2,0);
  translate(-R/2,-R/2,-R/2);

  pushMatrix();
  applyMatrix(mat);

  stroke(255,0,0);
  line(0,0,0,L,0,0);

  stroke(0,255,0);
  line(0,0,0,0,L,0);

  stroke(0,0,255);
  line(0,0,0,0,0,L);
  popMatrix();
}

void rotX(){


}
