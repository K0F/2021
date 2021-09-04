




float R = 100.0;


void setup() {
    size(1280,720,OPENGL);
    textFont(createFont("Semplice Regular",8,false),8);
}


void draw() {
    background(0);
    noFill();
    stroke(255,150);
    sphereDetail(24);

    pushMatrix();
    translate(width/2,height/2,0);
    rotateY(millis()/1000.0/24.0*TWO_PI*(-1.0));
    sphere(R);
    float vol = volume(R);
    float sur = surface(R);
    popMatrix();

// resetMatrix();
    translate(width/2,height/2,0);
    text("vol: "+vol+"px2\nsur: "+sur+"px3\nSA:V: "+pow(sur,-2.0)/pow(vol,-3.0),R,R);



}

float volume(float _r) {
    return (4.0 * PI * pow(_r,3.0))/3.0;
}

float surface(float _r) {
    return (4.0 * PI) * pow(_r,2.0);
}