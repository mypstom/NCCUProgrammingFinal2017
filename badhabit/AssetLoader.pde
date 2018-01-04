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
int[][] npcPos = {
  //patient
  {650, 200},{1365, 395},{1128, 628},{388, 850},
  //oldman dog pass1 pass2
  {232, 230}, {855, 905}, {185, 965}, {1360, 935}
};

class AssetLoader{
  
  void loadAsset(){
    nameAsset();
    mapAsset();
    doctorAsset();
    mapNPC();
    kitAsset();
    pharmacyAsset();
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
    npcImg = new PImage[8];
    for(int i=0; i<npcImg.length; i++){
      npcImg[i] = loadImage("images/npc/npc"+i+".png");
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