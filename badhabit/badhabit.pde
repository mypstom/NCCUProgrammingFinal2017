MoveControl moveControl;
Npc[] npc = new Npc[8];

void setup(){
  size(800, 600, P2D);
  AssetLoader loader = new AssetLoader();
  loader.loadAsset();
  moveControl = new MoveControl();
  for(int i=0; i<npc.length; i++){
    npc[i] = new Npc(npcPos[i][0], npcPos[i][1], npcImg[i]);    
  }

}


void draw(){
  background(255);
  pushMatrix();
  
  
  translate(max(-800, min(0, -posX)), max(-600, min(0, -posY)));
  image(map, 0 ,0);
  
  for(int i=0; i < npc.length; i++){
    npc[i].update();
  }
  
  image(doctor, posX+80, posY+250);
  popMatrix();
  
  
  
  moveControl.movePlayer();

  
  
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
        
        break;
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