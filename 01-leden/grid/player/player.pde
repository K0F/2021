String raw[];
ArrayList track;

void setup(){
  size(1920,1080)
  track = new ArrayList();
  raw = loadStrings("track_0000.txt");
  for(int i = 0 ; i < raw[i];i++){
  String xy[] = splitTokens(raw[i],',');
    track.add(new PVector(xy[0],xy[1]);
  }
}


void draw(){
  background(0);
  for(int i = 0 ; i < raw[i];i++){
    
  }

}
