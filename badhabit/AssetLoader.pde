PImage map, colliderMap;
PImage doctor, doctorDown, doctorUp, doctorLeft, doctorRight;

class AssetLoader{
  
  void loadAsset(){
    sceneAsset();
    loadDoctorAsset();
    
  }
  
  void sceneAsset(){
    map = loadImage("images/map_bg.png");
    colliderMap = loadImage("images/colliderMap.png");
  }
  
  void loadDoctorAsset(){
    doctorUp = loadImage("images/doctor/doctor_back.png");
    doctorDown = loadImage("images/doctor/doctor_front.png");
    doctorLeft = loadImage("images/doctor/doctor_left.png");
    doctorRight = loadImage("images/doctor/doctor_right.png");
    doctor = doctorRight;
  }
}