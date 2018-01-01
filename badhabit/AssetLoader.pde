PImage map, colliderMap, pKey, spaceKey;
PImage doctor, doctorDown, doctorUp, doctorLeft, doctorRight;
PImage[] npcImg, pharmacyImg;
int[][] npcPos = {
  //patient
  {650, 200},{1365, 395},{1128, 628},{388, 850},
  //oldman dog pass1 pass2
  {232, 230}, {855, 905}, {185, 965}, {1360, 935}
};

class AssetLoader{
  
  void loadAsset(){
    sceneAsset();
    loadDoctorAsset();
    mapNPC();
    pharmacyAsset();
  }
  
  void sceneAsset(){
    map = loadImage("images/map/map_bg.png");
    colliderMap = loadImage("images/map/colliderMap.png");
    pKey = loadImage("images/map/map_p.png");
    spaceKey = loadImage("images/map/map_space.png");
  }
  
  void loadDoctorAsset(){
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
  }
}