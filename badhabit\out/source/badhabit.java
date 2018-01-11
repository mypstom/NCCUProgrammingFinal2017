import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 
import ddf.minim.analysis.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class badhabit extends PApplet {

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

public void setup(){
  
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


public void draw(){
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
      kitAction.display();
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




public void keyPressed(){
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


public void keyReleased(){
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
PImage map, colliderMap, pKey, spaceKey;
PImage nameBg1, nameBg2;
PImage[] nameWords;
PImage[] nameWordsDark;
char[] words = {'a', 'd', 'e', 'f', 'g', 'h', 'q', 'r', 's', 't', 'w', 'y'};
PImage doctor, doctorDown, doctorUp, doctorLeft, doctorRight;
PImage pharInfo, noMoney;
PImage[] npcImg, pharmacyImg;
PImage kit;
PImage[] kitDesc;
PImage[][] dialogs;

PImage[] pressPadInit;
PImage[] pressPadPress;
PImage[] atkItems;

int[][] npcPos = {
  //patient
  {650, 200},{1365, 395},{1128, 628},{388, 850},
  //oldman dog pass1 pass2
  {232, 230}, {855, 905}, {185, 965}, {1360, 935}
};

PImage[][] npcDesc;
int[] npcDescCount = {4, 6, 4, 6};

PImage playingBg;

class AssetLoader{
  
  public void loadAsset(){
    nameAsset();
    mapAsset();
    doctorAsset();
    mapNPC();
    mapNpcDialog();
    kitAsset();
    pharmacyAsset();
    gameDescAsset();
    gameMainAsset();
  }
  
  
  public void gameDescAsset(){
    npcDesc = new PImage[4][max(npcDescCount)];
    for(int i=0; i<4; i++){
      for(int j=0; j<npcDescCount[i]; j++){
        npcDesc[i][j] = loadImage("images/game/desc/des_"+i+"_"+j+".png");
      }
    }
    
  }
  
  public void gameMainAsset(){
    playingBg = loadImage("images/game/ingame/bg.png");
    
    pressPadInit = new PImage[4];
    pressPadPress = new PImage[4];
    atkItems = new PImage[4];
    for(int i=0; i<4;i++){
      pressPadInit[i] = loadImage("images/game/ingame/pressPad_init_"+i+".png");
      pressPadPress[i] = loadImage("images/game/ingame/pressPad_press_"+i+".png");
      atkItems[i] = loadImage("images/game/ingame/atk_"+i+".png");
    }
    
    
    
  }
  
  
  
  public void nameAsset(){
    nameBg1 = loadImage("images/start/name_bg.png");
    nameBg2 = loadImage("images/start/name_bg2.png");
    nameWords = new PImage[12];
    nameWordsDark = new PImage[12];
    for(int i=0; i<nameWords.length; i++){
      nameWords[i] = loadImage("images/start/name_"+ words[i] +".png");
      nameWordsDark[i] = loadImage("images/start/dialogue_"+ words[i] +".png");
    }
  }
  
  public void mapAsset(){
    map = loadImage("images/map/map_bg.png");
    colliderMap = loadImage("images/map/colliderMap.png");
    pKey = loadImage("images/map/map_p.png");
    spaceKey = loadImage("images/map/map_space.png");
  }
  
  public void kitAsset(){
    kit = loadImage("images/map/kit.png");
    kitDesc = new PImage[4];
    
    for(int i=0; i<4;i++){
      kitDesc[i] = loadImage("images/map/kit_druginfo_"+(i+1)+".png");
    }
    
  }
  
  public void doctorAsset(){
    doctorUp = loadImage("images/doctor/doctor_back.png");
    doctorDown = loadImage("images/doctor/doctor_front.png");
    doctorLeft = loadImage("images/doctor/doctor_left.png");
    doctorRight = loadImage("images/doctor/doctor_right.png");
    doctor = doctorRight;
  }
  
  public void mapNPC(){
    npcImg = new PImage[8];
    for(int i=0; i<npcImg.length; i++){
      npcImg[i] = loadImage("images/npc/npc"+i+".png");
    }
  }
  
  public void mapNpcDialog(){
    dialogs = new PImage[8][4];
    //load one pic
    for(int i=0; i<8;i++){
        if(i==4 || i==5) continue;
        String _filePath = "images/npc/dialog/dia_"+i+"_0.png";
        dialogs[i][0] = loadImage(_filePath);
    }
    //load dog and oldman
    for(int i=4; i<6;i++){
      for(int j=0; j<4;j++){
        if(i==5 && j==3) break;
        String _filePath = "images/npc/dialog/dia_"+i+"_"+j+".png";
        dialogs[i][j] = loadImage(_filePath);
      }
    }
    
  }
  
  public void pharmacyAsset(){
    pharmacyImg = new PImage[3];
    for(int i=0; i<pharmacyImg.length; i++){
      pharmacyImg[i] = loadImage("images/pharmacy/phar"+(i+1)+".png");
    }
    pharInfo = loadImage("images/pharmacy/pharInfo.png");
    noMoney = loadImage("images/pharmacy/pharNomoney.png");
    
  }
}
class AttackItem{
  float x;
  float y;
  PImage atkImg;
  int side;
  float speed=5;
  AttackItem(int side){
    this.side=side;
    if(side==0){
      this.x = 300;
      this.y=0;
      atkImg = atkItems[0];
    }else if(side==1){
      this.x = 600;
      this.y=272;
      atkImg = atkItems[1];
    }else if(side==2){
      this.x = 300;
      this.y=600;
      atkImg = atkItems[2];
    }else if(side==3){
      this.x = 0;
      this.y=272;
      atkImg = atkItems[3];
    }
  }
  
  public void display(){
    image(atkImg, x, y);
    if(side==0){
      y+=speed;
    }else if(side==1){
      x-=speed;
    }else if(side==2){
      y-=speed;
    }else if(side==3){
      x+=speed;
    }
  }

}






class BeatMaster{
  ArrayList <AttackItem> attackItems;
  int coldDown=60;
  float eRadius;
  
  BeatMaster(){
    
    beat = new BeatDetect();
    attackItems = new ArrayList <AttackItem> ();  
    ellipseMode(RADIUS);
    eRadius = 20;
  }
  
  public void start(){
    song.play();
  }
  
  public void doAttack(){

    attackItems.add( new AttackItem(floor(random(0,4))));

  }
  
  public void display(){
    
    float a = map(eRadius, 20, 80, 60, 255);
    //fill(255, 212, 128, a);
    noFill();
    beat.detect(song.mix);
    if ( beat.isOnset() ){
      if(coldDown>=60){
        doAttack();
        coldDown=0;
        println("GO!");
      }
      eRadius = 350;
    }
    
    stroke(0xffFFD480);
    strokeWeight(4);
    ellipse(310, 300, eRadius, eRadius);
    eRadius *= 0.85f;
    //if ( eRadius < 20 ) eRadius = 0;
    coldDown++;
    if(attackItems.size()>0){
      for(AttackItem atk : attackItems){
        atk.display();
      }
    }
  }


}
class Building extends Npc{

  Building(float x, float y, PImage img, int id){
    super(x, y, img, id);
  }
  
  public void update(){
    display();
  }
  
  public void display(){
    if(isCollide()!=-1){
      image(pKey, x, y-spaceKey.height*1.3f);
      if(key=='p'){
        gameState=2;
      }
    }
    
  }
  
  public void triggerEvent(){
    
  
  }
  

}
class Dialog{
  Dialog(){
  
  }
  
  public void display(){
    if(diaNpc==5){
      currentDialog = dogTimes;
    }
    image(dialogs[diaNpc][currentDialog], 0, 0);
  }
  
  public void keyPress(int _keyCode, int _key){
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
  public void keyRelease(int _keyCode, int _key){

    if(_key==ENTER||_key==RETURN){
      if(diaNpc<4){
        println("GO");
        gameState = GAME_INGAME;
      }
    }
    
  }
  

}
class KitAction{
  KitAction(){
  
  
  }
  
  public void display(){
    image(kit, 0, 0);
    util.showName(3);
    fill(255);
    textSize(35);
    text(zWater, 80, 370);
    text(xWater, 255, 370);
    text(cWater, 445, 370);
    text(vWater, 628, 370);
    fill(0xffE36C6A);
    text(money, 330, 240);
    
    if(currentDesc!=-1){
      image(kitDesc[currentDesc], 548, 42);
    }
  }
  public void keyPress(int _keyCode, int _key){
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
  public void keyRelease(int _keyCode, int _key){
    
  }

}
class Map{
  Map(){
  
  }
  
  public void display(){
    background(255);
    pushMatrix();
    translate(max(-800, min(0, -posX)), max(-600, min(0, -posY)));
    image(map, 0 ,0);
    
    for(int i=0; i < npc.length; i++){
      npc[i].update();
    }
    pharmacy.update();
    
    image(doctor, posX+80, posY+250);
    util.showName(2);
    moveControl.movePlayer();
    popMatrix();
  
  }
  
  public void keyPress(int _keyCode, int _key){
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
  public void keyRelease(int _keyCode, int _key){
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
float posX=0;
float posY=0;

boolean upState = false;
boolean downState = false;
boolean leftState = false;
boolean rightState = false;

class MoveControl{
  
  
  
  public void movePlayer(){
    
    //according to collider map
    int cUp_l = colliderMap.get(PApplet.parseInt(posX+80), PApplet.parseInt(-30+posY+250+doctor.height));
    int cUp_r = colliderMap.get(PApplet.parseInt(posX+80+40), PApplet.parseInt(-30+posY+250+doctor.height));
    int cDown = colliderMap.get(PApplet.parseInt(posX+80), PApplet.parseInt(10+posY+250+doctor.height));
    int cLeft = colliderMap.get(PApplet.parseInt(posX+80-10), PApplet.parseInt(posY+250+doctor.height));
    int cRight = colliderMap.get(PApplet.parseInt(posX+80+40+10), PApplet.parseInt(posY+250+doctor.height));

    //if map pixel relative to posX/posY is black
    //cancel move direction
    if(cUp_l < -10 || cUp_r <-10){
      upState=false;
    }
    if(cDown<-10 || posY+250+doctor.height> 1200){
      downState=false;
    }
    if(cLeft<-10  || posX+80<1){
      leftState=false;
    }
    if(cRight<-10|| posX+80>1599-doctor.width){
      rightState=false;
    }
    
    
    if(upState){
      posY-=10;
      doctor = doctorUp;
    }
    if(downState){
      posY+=10;
      doctor = doctorDown;
    }
    if(rightState){
      posX+=10;
      doctor = doctorRight;
    }
    if(leftState){
      posX-=10;
      doctor = doctorLeft;
    }
  
  }

}
class NameAction{
  NameAction(){
  
  
  }
  
  public void display(){
    if(nameSceneState==0){
      image(nameBg1, 0, 0);
      util.showName(1);
    }else{
      image(nameBg2, 0, 0);
    }
  }
  
  public void keyPress(int _keyCode, int _key){
    
  }
  public void keyRelease(int _keyCode, int _key){
    if(currentNameCount<MAX_NAME_COUNT){
      int tempWordIndex = util.findWords(PApplet.parseChar(_key));
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

class Npc{
  int id;
  float x;
  float y;
  PImage img;
  
  
  Npc(float x, float y, PImage img, int id){
    this.id = id;
    this.x = x;
    this.y = y;
    this.img = img;
    
  }
  
  public void update(){
    display();
  }
  
  public void display(){
      image(img, x, y);
      if(isCollide()!=-1){
        image(spaceKey, x, y-spaceKey.height*1.3f);  
      }
  }
  
  public int isCollide(){
    if(dist(posX+80+doctor.width/2, posY+250+doctor.height/2, x+img.width/2, y+img.height/2) <100){
      return id;
    }else{
      return -1;
    }
  
  }

}
class Pharmacy{
  
  Pharmacy(){
  
  
  }
  
  public void display(){
  
      image(pharmacyImg[pharmacyState], 0, 0);
      fill(0xff252C68);
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
  
  }
  
  public void keyPress(int _key){
    if(_key=='i'){
        isPharInfo = !isPharInfo;
      }
    
  }
  
  public void keyRelease(int _key){
  
    switch(pharmacyState){
        case PHAR_INIT:
          if(_key==ENTER){
            pharmacyState++;
            isPharInfo = false;
          }
          break;
        case PHAR_BUY:
          if(_key==ENTER){
            if(_money<=money){
              zWater=_zWater;
              xWater=_xWater;
              cWater=_cWater;
              vWater=_vWater;
              money=money-_money;
              pharmacyState++;
              isPharInfo = false;
            }
          }else if(_key=='z'){
            _zWater++; 
          }else if(_key=='x'){
            _xWater++; 
          }else if(_key=='c'){
            _cWater++; 
          }else if(_key=='v'){
            _vWater++; 
          }else if(_key==DELETE||_key==BACKSPACE){
            _zWater=0;
            _xWater=0;
            _cWater=0;
            _vWater=0;
          }
          _money = _zWater*40+_xWater*15+_cWater*15+_vWater*30;
          break;
        case PHAR_PAY:
          if(_key==ENTER){
            pharmacyState=PHAR_INIT;
            _zWater=0;
            _xWater=0;
            _cWater=0;
            _vWater=0;
            _money=0;
          }else if(_key==' '){
            gameState=GAME_MAP;
            pharmacyState=PHAR_INIT;
            isPharInfo = false;
          }
          
          
          break;
      
    }
  
  }
  

}

boolean[] padPressState = {false, false, false, false};
int[][] padPos = {{238, 186},{357, 227},{235, 348},{194, 227}};


class PressPad{
  
  
  PressPad(){
    
  }
  
  
  
  public void display(){
    for(int i=0; i<4; i++){
      if(padPressState[i]){
        image(pressPadInit[i], padPos[i][0], padPos[i][1]);
      }else{
        image(pressPadPress[i], padPos[i][0], padPos[i][1]);
      }
    }
  }
  
  public void keyPress(int _keyCode, int _key){
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
  public void keyRelease(int _keyCode, int _key){
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
class Util{

  public int findWords(char factor){
    for(int i=0; i< words.length;i++){
      if(words[i] == factor){
        return i;
      }
    }
    return -1;
  }
  
  
  public void showName(int where){
    if(where==1){
      for(int i=0;i<name.length;i++){
        if(name[i]!=' '){
          image(nameWords[findWords(name[i])], 430+ i*30, 165);
        }
      }
    }else if(where==2){
      for(int i=0;i<name.length;i++){
        if(name[i]!=' '){
          image(nameWords[findWords(name[i])], posX+ i*30+50, posY+200+250);
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

}
  public void settings() {  size(800, 600, P2D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "badhabit" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
