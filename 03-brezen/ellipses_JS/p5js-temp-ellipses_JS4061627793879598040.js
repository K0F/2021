var step, startR, R, addR, NUM, rotX, rotY, THICKNESS, TEMPO;

function setup() {
  step = 0.0667;
  startR = 60.0;
  R = 1.0;
  addR = 1.0;
  NUM = 5;
  rotX = [];
  rotY = [];
  THICKNESS = 3.0;
  TEMPO = 121.35/60.0/5.0;


  createCanvas(screen.width, screen.height, WEBGL);
  //saveFrames("render", "png", 5, 60);
}



function draw() {
  background(0);
  noFill();
  stroke(255, 200);
  R = startR;

  var time = millis();
  var PHASE = 0.0;


  for (var i = 0; i < NUM; i++) {

    R = ((startR+(i/NUM*startR)))+startR;
    rotY[i]=4.0 + (time*TEMPO/1000.0);
    rotX[i]=((TAU/NUM+0.0)*i)+(time*TEMPO/1000.0*TAU);
    push();
    translate(0, -startR);
    rotateX(rotX[i]);
    rotateY(rotY[i]);
    rotateZ(HALF_PI);

    beginShape();
    PHASE += TAU/(NUM+0.0);
    for (var f = 0; f < TAU; f+=step) {
      var x = cos(f)*R;
      var y = sin(f)*R;
      strokeWeight(pow((cos(((time*TEMPO)/1000.0*TAU) - f + PHASE)) +1.0, 1.1) * THICKNESS);
      vertex(x, y, 0);
    }
    endShape();
    pop();
  }
}
