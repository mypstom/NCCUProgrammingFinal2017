
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
  
  void update(){
    display();
  }
  
  void display(){
    if(id<4){
      if(healthyState[id]){
        //is healthy
        image(healthyNpc[id], x, y);
      }else{
        image(img, x, y);
      }
    }else{
      image(img, x, y);
    }
    if(isCollide()!=-1){
      image(spaceKey, x, y-spaceKey.height*1.3);  
    }
  }
  
  int isCollide(){
    if(dist(posX+80+doctor.width/2, posY+250+doctor.height/2, x+img.width/2, y+img.height/2) <100){
      return id;
    }else{
      return -1;
    }
  
  }

}