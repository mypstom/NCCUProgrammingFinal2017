class Dialog{
  Dialog(){
  
  }
  
  void display(){
    if(diaNpc==5){
      currentDialog = dogTimes;
    }
    image(dialogs[diaNpc][currentDialog], 0, 0);
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