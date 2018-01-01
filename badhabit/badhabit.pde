PImage map;
PImage doctor;

float posX=0;
float posY=0;

boolean upState = false;
boolean downState = false;
boolean leftState = false;
boolean rightState = false;

void setup(){
  size(800, 600, P2D);
  AssetLoader loader = new AssetLoader();
  loader.loadAsset();
  
}


void draw(){
  background(255);
  pushMatrix();
  
  
  translate(max(-800, min(0, -posX)), max(-600, min(0, -posY)));
  
  image(map, 0 ,0);
  
  
  image(doctor, posX+80, posY+250);
  popMatrix();
  
  
  
  
  if(upState){

    posY-=10;
  }
  if(downState){
    posY+=10;
  }
  if(rightState){
    posX+=10;
  }
  if(leftState){
    posX-=10;
  }
  
  
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