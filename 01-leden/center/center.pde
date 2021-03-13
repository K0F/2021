
void setup(){
  size(1920,1080,OPENGL);
  frameRate(30);
}


void draw(){
  background(0);

  float amp = noise(millis()/1000.0);
  float l = noise(millis()/1000.0)*amp*1000;

  stroke(255);
  strokeWeight(10);

  pushMatrix();
  translate(width/2,height/2);
  rotate(millis()/1500.0*TAU);
  translate(-width/2,-height/2);
  line(width/2-l,height/2,width/2+l,height/2);
  popMatrix();
}
