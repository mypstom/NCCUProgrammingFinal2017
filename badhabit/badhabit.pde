MoveControl moveControl;
Npc[] npc = new Npc[8];
Building pharmacy;
final int PHAR_INIT=0, PHAR_BUY=1, PHAR_PAY=2;
int pharmacyState =0;
final int GAME_START=0, GAME_MAP=1, GAME_PHARMACY=2;
int gameState = 1;

void setup(){
  size(800, 600, P2D);
  AssetLoader loader = new AssetLoader();
  loader.loadAsset();
  moveControl = new MoveControl();
  for(int i=0; i<npc.length; i++){
    npc[i] = new Npc(npcPos[i][0], npcPos[i][1], npcImg[i], i);    
  }
  pharmacy = new Building(850, 200, npcImg[4], 9);

}


void draw(){
  switch(gameState){
    case GAME_START:
      break;
      
    case GAME_MAP:
      background(255);
      pushMatrix();
      
      
      translate(max(-800, min(0, -posX)), max(-600, min(0, -posY)));
      image(map, 0 ,0);
      
      for(int i=0; i < npc.length; i++){
        npc[i].update();
      }
      pharmacy.update();
      
      image(doctor, posX+80, posY+250);
      moveControl.movePlayer();
      
      popMatrix();
      break;
    case GAME_PHARMACY:
      image(pharmacyImg[pharmacyState], 0, 0);
      //if(==ENTER){
      //  pharmacyState+=1;
      //}
      break;
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