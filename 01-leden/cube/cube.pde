import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus


Grid grid;

float val = 0;

int dim = 10;
int siz = 20;

void setup(){
  
  size(1024,768,OPENGL);
  frameRate(60);
  myBus = new MidiBus(this, 2,1);
  ortho();
  grid = new Grid(dim,siz);
}

void draw(){
  background(0);
  strokeWeight(val/100.0+1);
  pushMatrix();
  translate(width/2-(dim*siz/2.0),height/2-(dim*siz/2.0),0);
  pushMatrix();
  rotateX(radians(35));
  rotateY(radians(45)+radians(frameCount));
  
  grid.draw();
  popMatrix();
  popMatrix();
  val=val*0.3;
}

void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
  val=255;
}

class Grid{

  int dim,siz;
  ArrayList nodes;
int c = 0;
  Grid(int _dim,int _siz){
    dim=_dim;
    siz=_siz;
    nodes = new ArrayList();
    for(int z = 0;z<dim;z++){
      for(int y = 0;y<dim;y++){
        for(int x = 0;x<dim;x++){
          nodes.add(new Node(c,x*siz,y*siz,z*siz));
c++;
        }
      }
    }
  }

  void draw(){
    for(int i = 0; i < nodes.size();i++){
      Node n  = (Node)nodes.get(i);
      n.draw();
    }

  }

}


class Node{
  PVector pos;
  int id;

  Node(int _id, int _x,int _y, int _z){
    id=id;
    pos = new PVector(_x,_y,_z);

  }

  void draw(){
    float X = noise(millis()/1000.0*id)*100.0;
    
    float Z = noise(millis()/3000.0*id)*100.0;
        float Y = noise(millis()/2000.0*id)*100.0;
    pushMatrix();
    translate(pos.x+X,pos.y+Y,pos.z);
    pushMatrix();
  rotateY(radians(45)+radians(frameCount)+id);
    stroke(255,150);
    noFill();
    //rect(0,0,10,10);
    box(X);
    popMatrix();
    popMatrix();
  }


}
