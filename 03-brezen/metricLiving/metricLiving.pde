

MidiThread timer;
int mode = 0;
int cycle = 10;
int bar = 24;

char[][] lists;
char set[] = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','r','s','t','v','w','x','y','z'};


void setup(){
  size(320,240);
  delay(1000);
  cycle = set.length;
  timer = new MidiThread(120.0);
  textFont(createFont("Semplice Regular", 8, false));
  timer.setPriority(Thread.NORM_PRIORITY+2); 

  timer.start();

  lists=new char[cycle][set.length];
  for(int ii = 0 ; ii < cycle;ii++){
    for(int i = 0 ; i < lists.length;i++){
      lists[ii][i] = set[i];
    }
  }
}


void draw(){

  timer.setbpm(120.0);

  switch(mode){
    case 0:
      break;
    case 1:
      break;
    case 2:
      break;
    case 3:
      break;
    case 4:
      break;
    case 5:
      break;
    case 6:
      break;
    case 7:
      break;
    case 8:
      break;
    case 9:
      break;
  }

  background(0);

  for(int i = 0 ; i < set.length;i++){
    if(i==mode){
   fill(255);
    text(lists[i][timer.nth%(set.length-1)],width/2-100+mode*6,height/2);
    }else{
    fill(128);
    text(lists[0][i],width/2-100+i*6,height/2);
   }
  }

}



// also shutdown the midi thread when the applet is stopped
public void stop() {
  if (timer!=null) timer.isActive=false;
  super.stop();
}

void keyReleased(){
  timer.reset();
}

class MidiThread extends Thread {

  long previousTime;
  boolean isActive=true;
  double interval;
  int beat = 0;
  int nth = 0;
  double bpm;

  MidiThread(double _bpm) {
    bpm=_bpm;
    // interval currently hard coded to quarter beats
    interval = 1000.0 / (bpm / 60.0);


    reset();
  }

  void reset(){
     previousTime=System.nanoTime();
  }

  void run() {
    try {
      while(isActive) {
        // calculate time difference since last beat & wait if necessary
        interval = 1000.0 / (bpm / 60.0); 
        double timePassed=(System.nanoTime()-previousTime)*1.0e-6;
        while(timePassed<interval) {
          timePassed=(System.nanoTime()-previousTime)*1.0e-6;
        }
        // insert your midi event sending code here
        println(System.nanoTime()+", "+timePassed+"ms, mode: "+mode+" "+nf(nth,2)+"th");
        nth = beat%bar;
        beat++;
        // calculate real time until next beat
        long delay=(long)(interval-(System.nanoTime()-previousTime)*1.0e-6);
        previousTime=System.nanoTime();
        if(delay>0)
          Thread.sleep(delay);
        else
          Thread.sleep(10);


        if(beat%24==0){
          mode++;
          if(mode>9)
            mode=0;
        }
      }

    } 
    catch(InterruptedException e) {
      println("force quit...");
    }
  }
  void setbpm(double _bpm){
    bpm=_bpm;
  }
} 
