class Dialog{
  Dialog(){
  
  }
  
  void display(){
    if(diaNpc==5){
      currentDialog = dogTimes;
    }
    
    boolean _gameState = true;
    for(boolean _temp: healthyState){
      if(_temp==false){
        _gameState=false;
      }
    }
    if(_gameState&&diaNpc==4){//game is finish
      endVideo.play();
      gameState=GAME_END;
    }else{
      image(dialogs[diaNpc][currentDialog], 0, 0);
    }
    if(diaNpc==4&&currentDialog==0){
      util.showName(4);
    }
  }
  
  void keyPress(int _keyCode, int _key){
    //is old man
    if(diaNpc==4){
      if(_key==' '){
        if(currentDialog<3){
          currentDialog++;
        }else{
          gameState=GAME_MAP;
          currentDialog=0;
        }
      }
    }else if(diaNpc==5 &&( _key==ENTER || _key==RETURN)){
      //is dog
      if(dogTimes<2){
        dogTimes++;
        gameState=GAME_LITTLE;
      }
    }else{
      if(_key==' '){
        gameState=GAME_MAP;
        currentDialog=0;
      }
    }
  }
  void keyRelease(int _keyCode, int _key){

    if(_key==ENTER||_key==RETURN){
      if(diaNpc<4){
        gameState = GAME_INGAME;
      }
    }
    
  }
  

}