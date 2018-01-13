
boolean[] padPressState = {false, false, false, false};
boolean padPressSpaceState = false;
int[][] padPos = {{238, 186},{357, 227},{235, 348},{194, 227}};
boolean isZWaterEffect = false;
boolean isXWaterEffect = false;
boolean isCWaterEffect = false;
boolean isVWaterEffect = false;
int currentEffect = -1;

class PressPad{
  
  
  PressPad(){
    
  }
  
  
  
  void display(){
    for(int i=0; i<4; i++){
      if(padPressState[i]){
          image(pressPadPress[i], padPos[i][0], padPos[i][1]);
      }else{
        if(currentEffect==-1){
          image(pressPadInit[i], padPos[i][0], padPos[i][1]);
        }else{
          image(pressPadEffect[i][currentEffect], padPos[i][0], padPos[i][1]);
        }
      }
    }
    
  }
  
  
  void displayFace(){
  
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
      case ' ':
        padPressSpaceState = true;
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
      case ' ':
        padPressSpaceState = false;
        break;
    }
    //use potion
    if(_key=='z'){
      if(zWater>0){
        zWaterEffect();
      }
    }else if(_key=='x'){
      if(xWater>0){
        xWaterEffect();
      }
    }else if(_key=='c'){
      if(cWater>0){
        cWaterEffect();
      }
    }else if(_key=='v'){
      if(vWater>0){
        vWaterEffect();
      }
    }
  }
  
  void zWaterEffect(){
    gamePoint+=20;
    isZWaterEffect = true;
    currentEffect=0;
    zWater--;
  }
  void xWaterEffect(){
    
    isXWaterEffect = true;
    currentEffect=1;
    xWater--;
    
  }
  void cWaterEffect(){
    frameRate(30);
    isCWaterEffect = true;
    currentEffect=2;
    cWater--;
    
  }
  void vWaterEffect(){
    
    isVWaterEffect = true;
    currentEffect=3;
    vWater--;
    
    
  }
  
  void initAllEffect(){
    frameRate(60);
    isZWaterEffect = false;
    isXWaterEffect = false;
    isCWaterEffect = false;
    isVWaterEffect = false;
  }
  
  
  
}