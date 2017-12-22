PImage map;
PImage doctor;

float pX=80;
float pY=0;

boolean upState = false;
boolean downState = false;
boolean leftState = false;
boolean rightState = false;

void setup(){
  size(800, 600, P2D);
  map = loadImage("images/map_bg.png");
  doctor = loadImage("images/doctor_front.png");
}


void draw(){
  pushMatrix();
  translate(max(-pX, -1600), max(-pY,-800+doctor.height));
  image(map, 0 ,0);
  
  
  if(upState){
    pY-=10;
  }
  if(downState){
    pY+=10;
  }
  if(rightState){
    pX+=10;
  }
  if(leftState){
    if(pX>0) pX-=10;
  }
  
  image(doctor,pX,pY+201);
  popMatrix();
}


void keyPressed(){
  if(key==CODED){
    switch(keyCode){
      case LEFT:
        
      leftState = true;
      break;
      case RIGHT:
        
      rightState = true;
      break;
      case DOWN:
        
      downState = true;
      break;
      case UP:
        
      upState = true;
    }
  }
}

void keyReleased(){
  if(key==CODED){
    switch(keyCode){
      case LEFT:
      leftState = false;
      break;
      case RIGHT:
      rightState = false;
      break;
      case DOWN:
      downState = false;
      break;
      case UP:
      upState = false;
      break;
    }
  }
}