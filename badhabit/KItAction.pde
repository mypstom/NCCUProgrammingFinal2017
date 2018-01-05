class KitAction{
  KitAction(){
  
  
  }
  
  void display(){
    image(kit, 0, 0);
    util.showName(3);
    fill(255);
    textSize(35);
    text(zWater, 80, 370);
    text(xWater, 255, 370);
    text(cWater, 445, 370);
    text(vWater, 628, 370);
    fill(#E36C6A);
    text(money, 330, 240);
    
    if(currentDesc!=-1){
      image(kitDesc[currentDesc], 548, 42);
    }
  }
  void keyPress(int _keyCode, int _key){
    if(_key=='z'){
      currentDesc=0;
    }else if(_key=='x'){
      currentDesc=1;
    }else if(_key=='c'){
      currentDesc=2;
    }else if(_key=='v'){
      currentDesc=3;
    }else if(_key==' '){
      gameState = GAME_MAP;
      currentDesc=-1;
    }
  }
  void keyRelease(int _keyCode, int _key){
    
  }

}