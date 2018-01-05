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

}