class AttackItem{
  float x;
  float y;
  PImage atkImg;
  int side;
  float speed=2;
  
  int type;
  int space;
  AttackItem(int side, int type, int space){
    //side 0:up, 1:right, 2:down, 3:left
    this.type=type;
    this.space=space;
    this.side=side;
    if(side==0){
      this.x = 285;
      this.y=0;
      
    }else if(side==1){
      this.x = 600;
      this.y=274;
      
    }else if(side==2){
      this.x = 285;
      this.y=600;
      
    }else if(side==3){
      this.x = 0;
      this.y=274;
      
    }
    if(type==2){
      atkImg = atkItemsOpposite[side];
    }else if(type==0){
      if(diaNpc!=3){
        atkImg = atkItems[diaNpc][side];
      }else{
        int r = floor(random(0,2));
        if(r==0){
          atkImg = atkItems[0][side];
        }else{
          atkImg = atkItems[1][side];
        }
      }
    }else if(type==1){
      atkImg = atkItemsSpace[diaNpc][space];
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
        
        if(isVWaterEffect){
          if(padPressState[0]||padPressState[1]||padPressState[2]||padPressState[3]||padPressSpaceState){
            if(this.x+this.atkImg.width > padPos[i][0] && padPos[i][0]+pressPadInit[i].width > this.x
            && this.y+this.atkImg.height > padPos[i][1] && padPos[i][1]+pressPadInit[i].height > this.y){
              return true;
            }
          }
        }
        
        if(type==0){
          if(padPressState[i]){
            if(this.x+this.atkImg.width > padPos[i][0] && padPos[i][0]+pressPadInit[i].width > this.x
            && this.y+this.atkImg.height > padPos[i][1] && padPos[i][1]+pressPadInit[i].height > this.y){
              return true;
            }
          }
        }else if(type==2){
          if(padPressState[(i+2)%4]){
            //if is opposite type, it must trigger the another side btn, and verify current side collides
            if(this.x+this.atkImg.width > padPos[i][0] && padPos[i][0]+pressPadInit[i].width > this.x
            && this.y+this.atkImg.height > padPos[i][1] && padPos[i][1]+pressPadInit[i].height > this.y){
              return true;
            }
          }
        }else if(type==1){
          if(padPressSpaceState){
            if(this.x+this.atkImg.width > padPos[i][0] && padPos[i][0]+pressPadInit[i].width > this.x
            && this.y+this.atkImg.height > padPos[i][1] && padPos[i][1]+pressPadInit[i].height > this.y){
              return true;
            }
          }
        }
      }
    }
    return false;
  }

  boolean isTooFar(){//when user miss
    if(side==0){
      y+=speed;
      if(y>height/2){
        return true;
      }
    }else if(side==1){
      x-=speed;
      if(x<width/2-92){
        return true;
      }
    }else if(side==2){
      y-=speed;
      if(y<height/2){
        return true;
      }
    }else if(side==3){
      x+=speed;
      if(x>width/2-92){
        return true;
      }
    }
    return false;
  }
}