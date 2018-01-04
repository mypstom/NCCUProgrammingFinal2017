class NameAction{
  NameAction(){
  
  
  }
  
  void display(){
    if(nameSceneState==0){
      image(nameBg1, 0, 0);
      util.showName(1);
    }else{
      image(nameBg2, 0, 0);
    }
  }
  
  void keyPress(int _keyCode, int _key){
    
  }
  void keyRelease(int _keyCode, int _key){
    if(currentNameCount<MAX_NAME_COUNT){
      int tempWordIndex = util.findWords(char(_key));
      if(tempWordIndex != -1){
        name[currentNameCount]=  words[tempWordIndex];
        currentNameCount++;
      }
    }
    if(_keyCode==BACKSPACE || _keyCode==DELETE){
      for(int i=0;i<name.length;i++){
        name[i] = ' ';
      }
      currentNameCount=0;
    }else if(_keyCode==ENTER || _keyCode==RETURN){
      if(nameSceneState==1){
        gameState = GAME_MAP;
      }
      nameSceneState = nameSceneState+1;
    }
  }
  
}