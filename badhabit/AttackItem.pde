class AttackItem{
  float x;
  float y;
  PImage atkImg;
  int side;
  float speed=5;
  AttackItem(int side){
    //side 0:up, 1:right, 2:down, 3:left
    this.side=side;
    if(side==0){
      this.x = 290;
      this.y=0;
      atkImg = atkItems[0];
    }else if(side==1){
      this.x = 600;
      this.y=274;
      atkImg = atkItems[1];
    }else if(side==2){
      this.x = 290;
      this.y=600;
      atkImg = atkItems[2];
    }else if(side==3){
      this.x = 0;
      this.y=274;
      atkImg = atkItems[3];
    }
  }
  
  void display(){
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

  boolean isCollidePad(){
    
    //AABB maxX1 > minX2 && maxX2 > minX1 && maxY1 > minY2 && maxY2 > minY1
    for(int i=0; i<4; i++){
      if(side==i){
        if(padPressState[i]){
          if(this.x+this.atkImg.width > padPos[i][0] && padPos[i][0]+pressPadInit[i].width > this.x
          && this.y+this.atkImg.height > padPos[i][1] && padPos[i][1]+pressPadInit[i].height > this.y){
            return true;
          }
        }
      }
    }
    
  
    return false;
  }
}