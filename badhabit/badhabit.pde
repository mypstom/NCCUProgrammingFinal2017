MoveControl moveControl;
Npc[] npc = new Npc[8];

Building pharmacy;
final int PHAR_INIT=0, PHAR_BUY=1, PHAR_PAY=2;
int pharmacyState =PHAR_INIT;
boolean isPharInfo =false;
int money = 100;
int zWater=0, xWater=0, cWater=0, vWater=0;
//for shopping
int _money=0;
int _zWater=0, _xWater=0, _cWater=0, _vWater=0;
//for kit
int currentDesc = -1;

//for dialog
int diaNpc=-1;
int currentDialog=0;
int dogTimes=0;


final int GAME_START=0, GAME_NAME=1, GAME_MAP=2, GAME_KIT=3, GAME_DIALOG=4, GAME_PHARMACY=5, GAME_INGAME=6;
int gameState = GAME_NAME;


char[] name;
int currentNameCount=0;
int MAX_NAME_COUNT=5;
int nameSceneState=0;

void setup(){
  size(800, 600, P2D);
  AssetLoader loader = new AssetLoader();
  loader.loadAsset();
  moveControl = new MoveControl();
  for(int i=0; i<npc.length; i++){
    npc[i] = new Npc(npcPos[i][0], npcPos[i][1], npcImg[i], i);    
  }
  pharmacy = new Building(850, 200, npcImg[4], 9);
  name = new char[MAX_NAME_COUNT];
  for(int i=0;i<name.length;i++){
    name[i] = ' ';
  }
}


void draw(){
  switch(gameState){
    case GAME_START:
      
      
      break;
      
    case GAME_NAME:
      if(nameSceneState==0){
        image(nameBg1, 0, 0);
        showName(1);
      }else{
        image(nameBg2, 0, 0);
      }
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
      showName(2);
      moveControl.movePlayer();
      popMatrix();
      break;
    case GAME_KIT:
      image(kit, 0, 0);
      showName(3);
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
      break;
    case GAME_DIALOG:
      if(diaNpc==5){
        currentDialog = dogTimes;
      }
      image(dialogs[diaNpc][currentDialog], 0, 0);
      break;
    case GAME_PHARMACY:
      image(pharmacyImg[pharmacyState], 0, 0);
      fill(#252C68);
      textSize(30);
      text(money, 100, 60);
        
      if(pharmacyState==1){
        
        //water count
        fill(255);
        textSize(25);
        text(_zWater, 120, 350);
        text(_xWater, 190, 350);
        text(_cWater, 120, 440);
        text(_vWater, 190, 440);
        if(_money <= money){
          text(_money, 355, 517);
        }else{
          image(noMoney, 355, 503);
        }
        
        
        //water info
        if(isPharInfo){
          image(pharInfo, (width-pharInfo.width)/2, (height-pharInfo.height)/2);
        }
      }
      
      
      
      break;
  }

  
  
  
  

  
  
}




void keyPressed(){
  switch(gameState){
    case GAME_START:
      
      
      break;
      
    case GAME_NAME:
      
      
      break;
      
    case GAME_MAP:
      if(key=='p'){
        gameState = GAME_PHARMACY;
        _money=0;
        _zWater=0; 
        _xWater=0; 
        _cWater=0;
        _vWater=0;
      }else if(key=='k'){
        gameState = GAME_KIT;
      }else if(key==' '){
        
        for(int i=0; i < npc.length; i++){
          int colId = npc[i].isCollide();
          if(colId!=-1){
            diaNpc=colId;
            currentDialog=0;
            gameState = GAME_DIALOG;
          }
        }
        
      }
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
      
      break;
    case GAME_KIT:
      if(key=='z'){
        currentDesc=0;
      }else if(key=='x'){
        currentDesc=1;
      }else if(key=='c'){
        currentDesc=2;
      }else if(key=='v'){
        currentDesc=3;
      }else if(key==' '){
        gameState = GAME_MAP;
        currentDesc=-1;
      }
      break;
    case GAME_DIALOG:
      //is old man
      if(diaNpc==4){
        if(key==' '){
          if(currentDialog<3){
            currentDialog++;
          }else{
            gameState=GAME_MAP;
            currentDialog=0;
          }
        }
      }else if(diaNpc==5 &&( key==ENTER || key==RETURN)){
        //is dog
        if(dogTimes<2){
          dogTimes++;
        }
      }else{
        if(key==' '){
          gameState=GAME_MAP;
          currentDialog=0;
        }
      }
      break;
    case GAME_PHARMACY:
      if(key=='i'){
        isPharInfo = !isPharInfo;
      }
      
      break;
  }
}


void keyReleased(){
  switch(gameState){
    case GAME_START:
      
      
      break;
      
    case GAME_NAME:
      if(currentNameCount<MAX_NAME_COUNT){
        int tempWordIndex = findWords(char(key));
        if(tempWordIndex != -1){
          name[currentNameCount]=  words[tempWordIndex];
          currentNameCount++;
        }
      }
      if(keyCode==BACKSPACE || keyCode==DELETE){
        for(int i=0;i<name.length;i++){
          name[i] = ' ';
        }
        currentNameCount=0;
      }else if(keyCode==ENTER || keyCode==RETURN){
        if(nameSceneState==1){
          gameState = GAME_MAP;
        }
        nameSceneState = nameSceneState+1;
      }
      
      break;
      
    case GAME_MAP:
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
      break;
    case GAME_KIT:
      break;
    case GAME_DIALOG:
      if(key==ENTER||key==RETURN){
        if(diaNpc<4){
          println("GO");
          gameState = GAME_INGAME;
        }
      }
      
      break;
    case GAME_PHARMACY:
      
      switch(pharmacyState){
        case PHAR_INIT:
          if(key==ENTER){
            pharmacyState++;
            isPharInfo = false;
          }
          break;
        case PHAR_BUY:
          if(key==ENTER){
            if(_money<=money){
              zWater=_zWater;
              xWater=_xWater;
              cWater=_cWater;
              vWater=_vWater;
              money=money-_money;
              pharmacyState++;
              isPharInfo = false;
            }
          }else if(key=='z'){
            _zWater++; 
          }else if(key=='x'){
            _xWater++; 
          }else if(key=='c'){
            _cWater++; 
          }else if(key=='v'){
            _vWater++; 
          }else if(key==DELETE||key==BACKSPACE){
            _zWater=0;
            _xWater=0;
            _cWater=0;
            _vWater=0;
          }
          _money = _zWater*40+_xWater*15+_cWater*15+_vWater*30;
          break;
        case PHAR_PAY:
          if(key==ENTER){
            pharmacyState=PHAR_INIT;
            _zWater=0;
            _xWater=0;
            _cWater=0;
            _vWater=0;
            _money=0;
          }else if(key==' '){
            gameState=GAME_MAP;
            pharmacyState=PHAR_INIT;
            isPharInfo = false;
          }
          
          
          break;
      
      }
      
      break;
  }
}


int findWords(char factor){
  for(int i=0; i< words.length;i++){
    if(words[i] == factor){
      return i;
    }
  }
  return -1;
}


void showName(int where){
  if(where==1){
    for(int i=0;i<name.length;i++){
      if(name[i]!=' '){
        image(nameWords[findWords(name[i])], 430+ i*30, 165);
      }
    }
  }else if(where==2){
    for(int i=0;i<name.length;i++){
      if(name[i]!=' '){
        image(nameWords[findWords(name[i])], posX+ i*30+50, posY+200);
      }
    }
  }else if(where==3){
    for(int i=0;i<name.length;i++){
      if(name[i]!=' '){
        image(nameWordsDark[findWords(name[i])], 285+i*30, 135);
      }
    }
  }
}  