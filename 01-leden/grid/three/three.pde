


void setup(){
  (320,240,OPENGL);
}


void draw(){
  stroke(255,150);
  noFill();
  background(0);
  translate(width/2,height/2,0);
  rotateZ(millis()/1000.0);
  rotateX(millis()/1000.0);
  translate(-width/2,-height/2,0);
  ellipse(width/2,height/2,100,100);
}
