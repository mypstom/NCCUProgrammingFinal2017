class Building extends Npc{

  Building(float x, float y, PImage img, int id){
    super(x, y, img, id);
  }
  
  void update(){
    display();
  }
  
  void display(){
    if(isCollider()){
      image(pKey, x, y-spaceKey.height*1.3);
      if(key=='p'){
        gameState=2;
      }
    }
    
  }
  
  void triggerEvent(){
    
  
  }
  

}