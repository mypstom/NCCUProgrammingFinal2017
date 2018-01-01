class AssetLoader{
  
  void loadAsset(){
    sceneAsset();
    loadDoctorAsset();
    
  }
  
  void sceneAsset(){
    map = loadImage("images/map_bg.png");
  
  }
  
  void loadDoctorAsset(){
    doctor = loadImage("images/doctor_front.png");
  }
}