
import oscP5.*;
import netP5.*;

boolean mirror = false;

OscP5 oscP5;
NetAddress myRemoteLocation;

boolean gentick = true;

boolean kruzidlo = true;
boolean inward = false;
float FPS = 30.0;
boolean RENDER = true;
float FRICTION = 0.35;
int NUM = 27;
int off = 24;
float SPEED = 160.0;
int numRiders = 1;
int connections = 21;


boolean savecsv = true;
int TOSAVE = 1000;

ArrayList oscill;
ArrayList riders;


float TS = (float)TOSAVE;

int mode = 0;

float tempo = 120.0/60.0/4.0;

void setup(){

  size(1080,1920,OPENGL);

  randomSeed(2021);
  noiseSeed(2021);

  oscill=new ArrayList();
  for(int i = 0 ; i < NUM;i++){
    oscill.add(new Oscill(i));

  }

  riders = new ArrayList();
  for(int i = 0; i < numRiders;i++){
    riders.add(new Rider(i,connections));
  }
  frameRate(FPS);
  textFont(createFont("Semplice Regular",8,false));

  oscP5 = new OscP5(this,10000);
}



void oscEvent(OscMessage theOscMessage) {
  println("got message");
  if(theOscMessage.checkAddrPattern("/ntk/tick")==true){
    for(int i = 0 ; i < oscill.size();i++){
      Oscill tmp = (Oscill)oscill.get(i);
      tmp.mutate();
    }
  }
  //mirror=!mirror;

}

void saveCSV(){

  println("Saving CSV");

  for(int i = 0 ; i < riders.size(); i++){
    Rider tmp = (Rider)riders.get(i);

   tmp.saveTXT(); 
  }


}


void draw(){

  background(0);


  if(frameCount>=TOSAVE){
    saveCSV();
    delay(2000);
    exit();

  }



  pushMatrix();
  translate(width/2-off*NUM/2,height-210);
  for(int i = 0 ; i < oscill.size();i++){
    Oscill tmp = (Oscill)oscill.get(i);
    tmp.tick();

  }
  popMatrix();

  for(int i = 0; i < numRiders;i++){
    Rider tmp = (Rider)riders.get(i);

    tmp.draw();
  }
  fill(255,50);
  text(nf(frameCount,6),20,20);

  if(RENDER)
    saveFrame("/mnt/ramdisk/frame######.png");

}





class Rider{

  PVector pos,acc,vel;
  ArrayList trail;
  float speed = SPEED;
  ArrayList active;
  float w[];
  int id;
  int steps = 0;
  int num;

  Rider(int _id,int _num){
    id=_id;
    num = _num;
    pos = new PVector(width/2,height/2);
    acc = new PVector(0,0);
    vel = new PVector(0,0);
    trail = new ArrayList();
    active = new ArrayList();

    connect();

  }

  void rewire(){
    int idx = (int)random(0,oscill.size()-1);
    Oscill tmp = (Oscill)oscill.get(idx);
    active.remove(0);
    active.add(tmp);

  }

  void connect(){
    w = new float[num];

    for(int i = 0 ;i < num;i++){
      int idx = (int)random(0,oscill.size()-1);
      Oscill tmp = (Oscill)oscill.get(idx);
      active.add(tmp);
      w[i] = pow(random(0,100)/400.0,2.0);
    }
  }


  void border(){
    if(pos.x>width)pos.x=pos.x-width;
    if(pos.x<0)pos.x=width-1+(width+pos.x);
    if(pos.y>height)pos.y=pos.y-height;
    if(pos.y<0)pos.y=height-1+(height+pos.y);
  }

  void compute(){
    speed=SPEED;
    vel.add(acc);

    //pos.x+=(round(pos.x%100)-50.0)/10.0;
    //pos.y+=(round(pos.y%100)-50.0)/10.0;

    pos.add(vel);
    vel.mult(FRICTION);
    acc.mult(0);

    int[] dX={-1,0,1,-1,0,1,-1,0,1};
    int[] dY={-1,-1,-1,0,0,0,1,1,1};

    for(int i = 0 ; i< active.size();i++){
      Oscill tmp = (Oscill)active.get(i);
      for(int ii = 0; ii < tmp.set.length;ii++){
        int set = tmp.set[ii];
        float val = tmp.val;
        acc.add(new PVector(
              (dX[ii])*set*(val-0.5)/speed,
              (dY[ii])*set*(val-0.5)/speed
              ));
      }
    }
    border();
    if(trail.size()>=TS)
      trail.remove(0);

    trail.add(new PVector(pos.x,pos.y));
    println(id+" "+trail.size());
  }


void saveTXT(){
    
    println("getting "+id+" with "+trail.size());
    String[] raw = new String[trail.size()];


    for(int ii = 0 ; ii < trail.size();ii++){

      PVector tmp2 = (PVector)trail.get(ii);
      raw[ii] = ""+tmp2.x+","+tmp2.y;
      println(raw[ii]);

    } 
    saveStrings("tracks/track_"+nf(id,4)+".txt",raw);
  }

  void draw(){
    noStroke();
    fill(255);
    PVector actual = new PVector(pos.x,pos.y);

    if(mirror)
      actual.x=width-pos.x;

    rect(actual.x-2,actual.y-2,4,4);
    text(nf(id,3),actual.x-8,actual.y-4);
    compute();
    noFill();
    pushStyle();
    strokeWeight(3);
    stroke(255,150);

    for(int i = 1 ; i < trail.size();i++){

      PVector tmp = (PVector)trail.get(i-1);
      PVector tmp1 = (PVector)trail.get(i);
      stroke(255,map(i,0,trail.size(),0,250));
      if(dist(tmp.x,tmp.y,tmp1.x,tmp1.y)<100)
        if(mirror)
          line(width-tmp.x,tmp.y,width-tmp1.x,tmp1.y);
        else
          line(tmp.x,tmp.y,tmp1.x,tmp1.y);
      tmp.x+=(tmp1.x-tmp.x)/3.0;
      tmp.y+=(tmp1.y-tmp.y)/3.0;
      //trail.set(i-1,tmp);
      if(kruzidlo){
        if(inward){
          tmp.x+=(width/2-tmp.x)/200.0+cos(frameCount/speed*TAU+i/TS)*pow(noise(frameCount/speed)*id*i/1000.0,1.3);
          tmp.y+=(height/2-tmp.y)/200.0+sin(frameCount/speed*TAU+i/TS)*pow(noise(frameCount/speed)*id*i/1000.0,1.3);

        }else{
          tmp.x-=(width/2-tmp.x)/200.0+cos(frameCount/speed*TAU+i/TS)*pow(noise(frameCount/speed)*id*i/1000.0,1.3);
          tmp.y-=(height/2-tmp.y)/200.0+sin(frameCount/speed*TAU+i/TS)*pow(noise(frameCount/speed)*id*i/1000.0,1.3);



        }
      }
    }  
    popStyle();
  }


}


class Oscill{
  float speed;
  float time;
  float phase;
  float x,y;
  float val;
  int id;
  int [] set;

  Oscill(int _id){
    id=_id;
    speed = tempo;// + random(-3.0,3.0)/600.0;
    time = 0;
    phase = random(0,TWO_PI*10.0)/10.0;
    set=new int[9];
    for(int i = 0 ; i < set.length;i++){
      set[i] = (int)random(255);
    }
  }

  void mutate(){
    set[4]+=(int)random(-25,25);
    set[4]=constrain(set[4],0,255);

    //right rotation
    int [] rot = {3,0,1,6,4,2,7,8,5};
    for(int i = 0 ; i < set.length;i++){
      set[i] = set[rot[i]];
    }


  }

  void tick(){

    if(frameCount%120==0 && gentick){
      mutate();
      for(int i = 0 ; i < riders.size();i++){
        Rider tmp = (Rider)riders.get(i);
        tmp.rewire();
      }
    }

    val = (sin(time*TWO_PI+phase)+1.0)/2.0;
    stroke(val*255.0);


    for(int i = 0 ; i < set.length;i++){
      fill(set[i]);
      rect((i/3)*5+(id*off),(i%3)*5,5,5);
    } 

    time+=speed/FPS;

  }


}
