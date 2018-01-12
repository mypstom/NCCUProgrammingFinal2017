class Map{
  Map(){
  
  }
  
  void display(){
    background(255);
    pushMatrix();
    translate(max(-800, min(0, -posX)), max(-600, min(0, -posY)));
    if(!isEndVideoStop){//is game finished
      image(map, 0 ,0);
    }else{
      image(mapFinish, 0 ,0);
    }
    
    for(int i=0; i < npc.length; i++){
      npc[i].update();
    }
    pharmacy.update();
    
    image(doctor, posX+80, posY+250);
    util.showName(2);
    moveControl.movePlayer();
    popMatrix();
  
  }
  
  void keyPress(int _keyCode, int _key){
    if(_key=='p'&& pharmacy.isCollide()!=-1){
      gameState = GAME_PHARMACY;
      _money=0;
      _zWater=0; 
      _xWater=0; 
      _cWater=0;
      _vWater=0;
    }else if(_key=='k'){
      gameState = GAME_KIT;
    }else if(_key==' '){
      
      for(int i=0; i < npc.length; i++){
        int colId = npc[i].isCollide();
        if(colId!=-1){
          diaNpc=colId;
          currentDialog=0;
          gameState = GAME_DIALOG;
        }
      }
      
    }
    switch(_keyCode){
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
  void keyRelease(int _keyCode, int _key){
    switch(_keyCode){
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