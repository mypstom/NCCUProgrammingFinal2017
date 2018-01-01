float posX=0;
float posY=0;

boolean upState = false;
boolean downState = false;
boolean leftState = false;
boolean rightState = false;

class MoveControl{
  
  
  
  void movePlayer(){
    
    //according to collider map
    color cUp_l = colliderMap.get(int(posX+80), int(-30+posY+250+doctor.height));
    color cUp_r = colliderMap.get(int(posX+80+40), int(-30+posY+250+doctor.height));
    color cDown = colliderMap.get(int(posX+80), int(10+posY+250+doctor.height));
    color cLeft = colliderMap.get(int(posX+80-10), int(posY+250+doctor.height));
    color cRight = colliderMap.get(int(posX+80+40+10), int(posY+250+doctor.height));

    //if map pixel relative to posX/posY is black
    //cancel move direction
    if(cUp_l < -10 || cUp_r <-10){
      upState=false;
    }
    if(cDown<-10 || posY+250+doctor.height> 1200){
      downState=false;
    }
    if(cLeft<-10  || posX+80<1){
      leftState=false;
    }
    if(cRight<-10|| posX+80>1599-doctor.width){
      rightState=false;
    }
    
    
    if(upState){
      posY-=10;
      doctor = doctorUp;
    }
    if(downState){
      posY+=10;
      doctor = doctorDown;
    }
    if(rightState){
      posX+=10;
      doctor = doctorRight;
    }
    if(leftState){
      posX-=10;
      doctor = doctorLeft;
    }
  
  }

}