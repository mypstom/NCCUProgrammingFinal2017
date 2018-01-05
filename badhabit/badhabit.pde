MoveControl moveControl;
Npc[] npc = new Npc[8];

Building pharmacy;
final int PHAR_INIT=0, PHAR_BUY=1, PHAR_PAY=2;

//for pharmacy
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
int diaNpc=0;
int currentDialog=0;
int dogTimes=0;

//in game
int currentDescIndex=0;
PressPad pressPad;

Minim minim;
AudioPlayer song;
BeatDetect beat;




final int GAME_START=0, GAME_NAME=1, GAME_MAP=2, GAME_KIT=3, GAME_DIALOG=4, GAME_PHARMACY=5, 
GAME_INGAME=6, GAME_PLAYING=7;
int gameState = GAME_NAME;


char[] name;
int currentNameCount=0;
int MAX_NAME_COUNT=5;
int nameSceneState=0;


Map mapAction;
Pharmacy pharmacyAction;
Util util;
NameAction nameAction;
Dialog dialogAction;
KitAction kitAction;
BeatMaster beatMaster;

void setup(){
  size(800, 600, P2D);
  AssetLoader loader = new AssetLoader();
  loader.loadAsset();
  moveControl = new MoveControl();
  util = new Util();
  for(int i=0; i<npc.length; i++){
    npc[i] = new Npc(npcPos[i][0], npcPos[i][1], npcImg[i], i);    
  }
  pharmacy = new Building(850, 200, npcImg[4], 9);
  pharmacyAction = new Pharmacy();
  
  mapAction = new Map();
  nameAction = new NameAction();
  dialogAction = new Dialog();
  kitAction = new KitAction();
  
  pressPad = new PressPad();
  
  
  minim = new Minim(this);
  song = minim.loadFile("music1.mp3", 2048);
  beatMaster = new BeatMaster();
  
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
      nameAction.display();
      break;
    case GAME_MAP:
      mapAction.display();
      break;
    case GAME_KIT:
      break;
    case GAME_DIALOG:
      dialogAction.display();
      break;
    case GAME_PHARMACY:
      pharmacyAction.display();
      break;
    case GAME_INGAME:
      image(npcDesc[diaNpc][currentDescIndex], 0, 0);
      
      break;
    case GAME_PLAYING:
    
      image(playingBg, 0, 0);
      
      beatMaster.display();
      pressPad.display();
      
      
      
      //water
      fill(255);
      textSize(35);
      float startY = 310;
      float startX = 710;
      text(zWater, startX, startY);
      text(xWater, startX, startY+20+50);
      text(cWater, startX, startY+40+100);
      text(vWater, startX, startY+60+150);
      
      
      break;
  }

}




void keyPressed(){
  switch(gameState){
    case GAME_START:
      break; 
    case GAME_MAP:
      mapAction.keyPress(keyCode, key);
      break;
    case GAME_KIT:
      kitAction.keyPress(keyCode, key);
      break;
    case GAME_DIALOG:
      dialogAction.keyPress(keyCode, key);
      break;
    case GAME_PHARMACY:
      pharmacyAction.keyPress(key);
      break;
    case GAME_PLAYING:
      pressPad.keyPress(keyCode, key);
      break;
  }
}


void keyReleased(){
  switch(gameState){
    case GAME_START:
      break;
    case GAME_NAME:
      nameAction.keyRelease(keyCode, key);      
      break;
    case GAME_MAP:
      mapAction.keyRelease(keyCode, key);
      break;
    case GAME_KIT:
      break;
    case GAME_DIALOG:
      dialogAction.keyRelease(keyCode, key);
      break;
    case GAME_PHARMACY:
      pharmacyAction.keyRelease(key);
      break;
    case GAME_INGAME:
      
      if(currentDescIndex<npcDescCount[diaNpc]-1){
        currentDescIndex++;
      }else{
        gameState=GAME_PLAYING;
        beatMaster.start();
        currentDescIndex=0;
      }
      break;
    case GAME_PLAYING:
      if(key==' '){
        beatMaster.doAttack();
      }
      pressPad.keyRelease(keyCode, key);
      break;
  }
}