import processing.video.*;

PImage map, mapFinish, colliderMap, pKey, spaceKey;
PImage nameBg1, nameBg2;
PImage[] nameWords;
PImage[] nameWordsDark;
char[] words = {'a', 'd', 'e', 'f', 'g', 'h', 'q', 'r', 's', 't', 'w', 'y'};
PImage doctor, doctorDown, doctorUp, doctorLeft, doctorRight;
PImage pharInfo, noMoney;
PImage[] npcImg, healthyNpc, pharmacyImg;
PImage kit;
PImage[] kitDesc;
PImage[][] dialogs;

PImage[] pressPadInit;
PImage[] pressPadPress;
PImage[][] pressPadEffect;
PImage[][] atkItems;
PImage[] atkItemsOpposite;
PImage[][] atkItemsSpace;

PImage[] npcFace;
PImage[] npcFaceHappy;

int[][] npcPos = {
  //patient
  {650, 200},{1365, 395},{1128, 628},{388, 850},
  //oldman dog pass1 pass2
  {232, 230}, {855, 905}, {185, 965}, {1360, 935}
};

PImage[][] npcDesc;
int[] npcDescCount = {4, 6, 4, 6};

PImage[][] ironyMonster;
PImage[][] ironyMonsterDia;
PImage damageImg;

PImage[] resultWin;
PImage[] resultLose;

PImage playingBg;

PImage startBg;
Movie startVideo;
boolean isStartVideoStop = false;

PImage endBg;
Movie endVideo;
boolean isEndVideoStop = false;



class AssetLoader{
  
  void loadAsset(){
    startAsset();
    nameAsset();
    mapAsset();
    doctorAsset();
    mapNPC();
    mapNpcDialog();
    kitAsset();
    pharmacyAsset();
    gameDescAsset();
    gameMainAsset();
    gameResult();
    endAsset();
  }
  
  void startAsset(){
    startBg = loadImage("images/startGame/start.png");
  }
  
  void endAsset(){
    endBg = loadImage("images/end/end.png");
  }
  
  void gameDescAsset(){
    npcDesc = new PImage[4][max(npcDescCount)];
    for(int i=0; i<4; i++){
      for(int j=0; j<npcDescCount[i]; j++){
        npcDesc[i][j] = loadImage("images/game/desc/des_"+i+"_"+j+".png");
      }
    }
    
  }
  
  void gameMainAsset(){
    playingBg = loadImage("images/game/ingame/bg.png");
    damageImg = loadImage("images/game/ingame/damage.png");
    
    pressPadInit = new PImage[4];
    pressPadPress = new PImage[4];
    pressPadEffect = new PImage[4][4];
    
    atkItems = new PImage[3][4];
    atkItemsOpposite = new PImage[4];
    atkItemsSpace = new PImage[4][3];
    ironyMonster = new PImage[4][4];
    ironyMonsterDia = new PImage[4][4];
    
    npcFace = new PImage[4];
    npcFaceHappy = new PImage[4];
    
    for(int i=0; i<4;i++){
      pressPadInit[i] = loadImage("images/game/ingame/pressPad_init_"+i+".png");
      pressPadPress[i] = loadImage("images/game/ingame/pressPad_press_"+i+".png");
      
      atkItemsOpposite[i] = loadImage("images/game/ingame/opposite_"+i+".png");
      npcFace[i] = loadImage("images/game/ingame/gameFace"+(i+1)+"_cry.png");
      npcFaceHappy[i] = loadImage("images/game/ingame/gameFace"+(i+1)+"_smile.png");
      for(int j=0; j< gameSpaceItemState[i];j++){
        atkItemsSpace[i][j] = loadImage("images/game/ingame/space"+i+"_"+j+".png");
      }
      for(int j=0; j< 4;j++){
        ironyMonster[i][j] = loadImage("images/game/ingame/irony"+i+"_"+j+".png");
        ironyMonsterDia[i][j] = loadImage("images/game/ingame/irony"+i+"_"+j+"_s.png");
        pressPadEffect[i][j] = loadImage("images/game/ingame/pressPad_effect_"+i+"_"+j+".png");
        if(i!=3){
          atkItems[i][j] = loadImage("images/game/ingame/atk_"+i+"_"+j+".png");
        }
      }
    }
  }
  
  void gameResult(){
    resultWin = new PImage[4];
    resultLose = new PImage[4];
    for(int i=0; i<4; i++){
      resultWin[i] = loadImage("images/game/result/winGame"+(i+1)+".png");
      resultLose[i] = loadImage("images/game/result/loseGame"+(i+1)+".png");
    }
  }
  
  
  void nameAsset(){
    nameBg1 = loadImage("images/start/name_bg.png");
    nameBg2 = loadImage("images/start/name_bg2.png");
    nameWords = new PImage[12];
    nameWordsDark = new PImage[12];
    for(int i=0; i<nameWords.length; i++){
      nameWords[i] = loadImage("images/start/name_"+ words[i] +".png");
      nameWordsDark[i] = loadImage("images/start/dialogue_"+ words[i] +".png");
    }
  }
  
  void mapAsset(){
    map = loadImage("images/map/map_bg.png");
    mapFinish = loadImage("images/map/map_bg_light.png");
    colliderMap = loadImage("images/map/colliderMap.png");
    pKey = loadImage("images/map/map_p.png");
    spaceKey = loadImage("images/map/map_space.png");
  }
  
  void kitAsset(){
    kit = loadImage("images/map/kit.png");
    kitDesc = new PImage[4];
    
    for(int i=0; i<4;i++){
      kitDesc[i] = loadImage("images/map/kit_druginfo_"+(i+1)+".png");
    }
    
  }
  
  void doctorAsset(){
    doctorUp = loadImage("images/doctor/doctor_back.png");
    doctorDown = loadImage("images/doctor/doctor_front.png");
    doctorLeft = loadImage("images/doctor/doctor_left.png");
    doctorRight = loadImage("images/doctor/doctor_right.png");
    doctor = doctorRight;
  }
  
  void mapNPC(){
    healthyNpc = new PImage[4];
    npcImg = new PImage[8];
    for(int i=0; i<npcImg.length; i++){
      npcImg[i] = loadImage("images/npc/npc"+i+".png");
    }
    for(int i=0; i<4;i++){
      healthyNpc[i] = loadImage("images/npc/npc_healthy_"+i+".png");
    }
  }
  
  void mapNpcDialog(){
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
  
  void pharmacyAsset(){
    pharmacyImg = new PImage[3];
    for(int i=0; i<pharmacyImg.length; i++){
      pharmacyImg[i] = loadImage("images/pharmacy/phar"+(i+1)+".png");
    }
    pharInfo = loadImage("images/pharmacy/pharInfo.png");
    noMoney = loadImage("images/pharmacy/pharNomoney.png");
    
  }
}