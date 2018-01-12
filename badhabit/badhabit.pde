
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
IronyMonster ironyMon;

Minim minim;
BeatDetect beat;
SoundSwitcher soundSwitcher;
AudioPlayer[] song;
AudioPlayer sound_start;
AudioPlayer sound_name;
AudioPlayer sound_click;
AudioPlayer sound_map;
AudioPlayer sound_win;
AudioPlayer sound_lose;
AudioPlayer sound_little;
AudioPlayer sound_pharmacy;
AudioPlayer sound_pharmacy_pay;



final int GAME_START=0, GAME_NAME=1, GAME_MAP=2, GAME_KIT=3, GAME_DIALOG=4, GAME_PHARMACY=5, 
GAME_INGAME=6, GAME_PLAYING=7, GAME_RESULT=8, GAME_END=9, GAME_LITTLE=10;
int gameState = GAME_START;


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

//how many people do you help
boolean[] healthyState = {false, false, false, false};
//boolean[] healthyState = {true, true, true, true};

void setup(){
  frameRate(60);
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
  ironyMon = new IronyMonster();
  
  song = new AudioPlayer[4];
  
  minim = new Minim(this);
  soundSwitcher = new SoundSwitcher();
  for(int i=0; i<4; i++){
    song[i] = minim.loadFile("sound/game"+(i+1)+".mp3", 2048);
  }
  sound_start = minim.loadFile("sound/start.mp3", 2048);
  sound_name = minim.loadFile("sound/name.mp3", 2048);
  sound_click = minim.loadFile("sound/button_click.mp3", 2048);
  sound_map = minim.loadFile("sound/map.mp3", 2048);
  sound_win = minim.loadFile("sound/win.wav", 2048);
  sound_lose = minim.loadFile("sound/lose.wav", 2048);
  sound_little = minim.loadFile("sound/little_game.mp3", 2048);
  sound_pharmacy = minim.loadFile("sound/pharmacy.mp3", 2048);
  sound_pharmacy_pay = minim.loadFile("sound/pay_money.mp3", 2048);
  beatMaster = new BeatMaster();
  
  name = new char[MAX_NAME_COUNT];
  for(int i=0;i<name.length;i++){
    name[i] = ' ';
  }
  
  startVideo = new Movie(this, "startMG.MP4");
  endVideo = new Movie(this, "endMG.MP4");
  startVideo.play();
  
}




void draw(){
  background(0);
  switch(gameState){
    case GAME_START:
      image(startBg, 0, 0);
      float mt = startVideo.time();
      if(mt<=12&&!isStartVideoStop){
        image(startVideo, 0, 0);
      }else{
        if(!isStartVideoStop){
          isStartVideoStop = true;
          sound_start.loop();
          startVideo.stop();
        }
        image(startBg, 0, 0);
      }
      break;
    case GAME_NAME:
      soundSwitcher.switchSound(GAME_NAME);
      nameAction.display();
      break;
    case GAME_MAP:
      soundSwitcher.switchSound(GAME_MAP);
      mapAction.display();
      break;
    case GAME_KIT:
      kitAction.display();
      break;
    case GAME_DIALOG:
      dialogAction.display();
      break;
    case GAME_PHARMACY:
      soundSwitcher.switchSound(GAME_PHARMACY);
      pharmacyAction.display();
      break;
    case GAME_INGAME:
      
      image(npcDesc[diaNpc][currentDescIndex], 0, 0);
      
      break;
    case GAME_PLAYING:
      soundSwitcher.switchSound(GAME_PLAYING);
      image(playingBg, 0, 0);
      beatMaster.drawEffect();
      pressPad.display();
      beatMaster.display();
      pressPad.displayFace();
      ironyMon.display();
      
      
      
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
    case GAME_RESULT:
      soundSwitcher.switchSound(GAME_RESULT);
      if(isGameWin){
        image(resultWin[diaNpc], 0, 0);
      }else{
        image(resultLose[diaNpc], 0, 0);
      }
      break;
    case GAME_END:
      soundSwitcher.switchSound(GAME_END);
      image(endBg, 0, 0);
      float mt2 = endVideo.time();
      if(mt2<=13&&!isEndVideoStop){
        image(endVideo, 0, 0);
      }else{
        if(!isEndVideoStop){
          endVideo.stop();
          isEndVideoStop = true;
        }else{
          image(endBg, 0, 0);
        }
      }
      break;
    case GAME_LITTLE:
      soundSwitcher.switchSound(GAME_LITTLE);
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
  if(keyCode!=LEFT && keyCode!=RIGHT && keyCode!=UP && keyCode!=DOWN && gameState!=GAME_MAP && gameState!=GAME_PLAYING){
    soundSwitcher.click();
  }
  switch(gameState){
    case GAME_START:
      if(keyCode==ENTER || keyCode==RETURN){
        gameState = GAME_NAME;
        startVideo.stop();
      }
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
      if( key==ENTER || key==RETURN){
        if(currentDescIndex<npcDescCount[diaNpc]-1){
          currentDescIndex++;
        }else{
          gameState=GAME_PLAYING;
          beatMaster.start();
          currentDescIndex=0;
        }
      }else if(key==DELETE||key==BACKSPACE){
        if(currentDescIndex>0){
          currentDescIndex--;
        }else{
          currentDescIndex=0;
          gameState=GAME_MAP;
        }
      }
      break;
    case GAME_PLAYING:
      pressPad.keyRelease(keyCode, key);
      break;
    case GAME_RESULT:
      if(key==' '){
        gameState=GAME_MAP;
      }else{
        gameState=GAME_INGAME;
      }
      break;
    case GAME_END:
      if( key==ENTER || key==RETURN){
        endVideo.stop();
        isEndVideoStop = true;
        gameState=GAME_MAP;
      }
      break;
  }
}

void movieEvent(Movie m) {
  m.read();
}