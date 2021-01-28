


void setup(){

  size(640,480,OPENGL);


  ortho();

}



void draw(){

  background(0);
  stroke(255);
  pushMatrix();
  rotateZ(radians(35));
  rotateY(radians(35));
  pushMatrix();
   translate(width/2,height/2,0);
 for(int z=0;z<1000;z+=30){
    for(int y=0;y<1000;y+=30){
      for(int x=0;x<1000;x+=30){
        point(x,y,z);
      }
    }
  }
  popMatrix();
  popMatrix();

}
