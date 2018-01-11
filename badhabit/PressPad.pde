
boolean[] padPressState = {false, false, false, false};
int[][] padPos = {{238, 186},{357, 227},{235, 348},{194, 227}};


class PressPad{
  
  
  PressPad(){
    
  }
  
  
  
  void display(){
    for(int i=0; i<4; i++){
      if(padPressState[i]){
        image(pressPadInit[i], padPos[i][0], padPos[i][1]);
      }else{
        image(pressPadPress[i], padPos[i][0], padPos[i][1]);
      }
    }
    imageMode(CENTER);
    if(isHealthyFace){
      image(npcFaceHappy[diaNpc], width/2-92, height/2);
    }else{
      image(npcFace[diaNpc], width/2-92, height/2);
    }
    imageMode(CORNER);
  }
  
  void keyPress(int _keyCode, int _key){
    switch(_keyCode){
      case LEFT:
        padPressState[3] = true;
        break;
      case RIGHT:
        padPressState[1] = true;
        break;
      case DOWN:
        padPressState[2] = true;
        break;
      case UP:
        padPressState[0]= true;
        break;
    }
    
  }
  void keyRelease(int _keyCode, int _key){
    switch(_keyCode){
      case LEFT:
        padPressState[3] = false;
        break;
      case RIGHT:
        padPressState[1] = false;
        break;
      case DOWN:
        padPressState[2] = false;
        break;
      case UP:
        padPressState[0] = false;
        break;
      
    }
  }

}