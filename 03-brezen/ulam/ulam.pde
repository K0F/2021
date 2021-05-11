

//kofian spiral
/*
26 27 28 29 30   
25 10 11 12 13   
24  9  2  3 14   
23  8  1  4 15   
22  7  6  5 16   
21 20 19 18 17   

26 27 28 29 30   
25 10 11 12 13   
24  9  2  3 14   
23  8  1  4 15   
22  7  6  5 16   
21 20 19 18 17   

*/


int lx,ly,rx,ry;

int lsideStep = 0;
int lstepSize = 1;

int rsideStep = 0;
int rstepSize = 1;

int step = 0;
char ldir = 'd';
char rdir = 'd';

void setup(){
  size(320,320);
  
  rx=width/3*2;
  ry=height/2;

  lx=width/3;
  ly=height/2;


  createFont("Semplice Regular",6,false); 
background(0);
}


void draw(){
  moveR();
  step++;
  //moveL();
  //step++;

  if(step%2==0)
  fill(255);
  else
  fill(#ffcc00);

text(step,rx*6,ry*6);
//  point(lx,ly);
//  point(rx,ly);
}


void moveR(){
  //lol how do i move in a spiral?
  if(rdir == 'd')
  {
    ry+=1;
    if(rsideStep > rstepSize)
    {
      rsideStep = 0;
      rdir = 'l';
    }
  }
  else if(rdir == 'u')
  {
    ry-=1;

    if(rsideStep > rstepSize)
    {
      rsideStep = 0;
      rdir = 'r';

    }


  }
  else if(rdir == 'l')
  {    
    rx-=1;
    if(rsideStep > rstepSize)
    {
      rsideStep = 0;
      rdir = 'u';
      rstepSize += 1;
    }

  }
  else if(rdir == 'r')
  {
    rx+=1;
    if(rsideStep > rstepSize)
    {
      rstepSize += 1;
      rsideStep = 0;
      rdir = 'd';
    }

  }
  rsideStep++;
}


void moveL(){
  //lol how do i move in a spiral?
  if(ldir == 'd')
  {
    ly+=1;
    if(lsideStep > lstepSize)
    {
      lsideStep = 0;
      ldir = 'r';
    }
  }
  else if(ldir == 'u')
  {
    ly-=1;

    if(lsideStep > lstepSize)
    {
      lsideStep = 0;
      ldir = 'l';

    }


  }
  else if(ldir == 'l')
  {    
    lx-=1;
    if(lsideStep > lstepSize)
    {
      lsideStep = 0;
      ldir = 'd';
      lstepSize += 1;
    }

  }
  else if(ldir == 'r')
  {
    lx+=1;
    if(lsideStep > lstepSize)
    {
      lstepSize += 1;
      lsideStep = 0;
      ldir = 'u';
    }

  }
  lsideStep++;
}


