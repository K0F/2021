



int numPoints = 10;
Trun [] series;
Follower agent;




class Follower{
    PVector pos;
    Turn dest;

    Follower(){

             dest = series[0];
            pos = new PVector(dest.pos.x,dest.pos.y);
    }

    void move(){
        pos.x = lerp
    }


}

class Turn{
    float angle;
    float len;
    PVector pos;

    Turn(float _angle,float _x, float _y,float _len){
        angle=_angle;
        pos = new PVector(_x,_y);

    }



}


void setup(){

    size(640,480);
    series = new Turn[numPoints];
    for(int i = 0 ; i < numPoints;i++){
        series[i] = random(-PI,PI); 
    }
    agent = new Agent();
}


void draw(){
     background(0);




}
