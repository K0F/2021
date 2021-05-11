

String trigraph = "☰☱☲☳☴☵☶☷";
//                  0 1 2 3 4 5 6 7
//                  0 3 7 2 1 4 6 5
PVector dir[];
//int order[] = {0,3,7,2,1,4,6,5};
int order[] = {0,1,2,3,4,5,6,7};
int siz = 99;
float tempo = 0.8634;

void setup(){
  size(1024,768,OPENGL);
  //print(PFont.list());
  textFont(createFont("Ubuntu Mono Nerd",siz));
  frameRate(50);
  dir =  new PVector[8];

  dir[0] = new PVector(0,-1);
  dir[1] = new PVector(1,-1);
  dir[2] = new PVector(1,0);
  dir[3] = new PVector(1,1);
  dir[4] = new PVector(0,1);
  dir[5] = new PVector(-1,1);
  dir[6] = new PVector(-1,0);
  dir[7] = new PVector(-1,-1);
}


void draw(){
  background(5);

  pushMatrix();
  translate(width/2,height/2);
  rectMode(CENTER);
  //rotate(((frameCount%50)*TAU/50.0));
  //rect(0,0,10,10);
  for(int i = 0 ; i < dir.length ; i++){
    fill((sin( (1+((i+1)/(dir.length+0.0)) )*TAU*(millis()/1000.0*tempo))+1.0)*127.0 );
    text(trigraph.charAt(order[i]),dir[i].x*siz-siz/2.0+3,dir[i].y*siz-siz/2.0+siz*0.85);
  }
  popMatrix();
}
