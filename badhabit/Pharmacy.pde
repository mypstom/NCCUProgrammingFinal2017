class Pharmacy{
  
  Pharmacy(){
  
  
  }
  
  void display(){
  
      image(pharmacyImg[pharmacyState], 0, 0);
      fill(#252C68);
      textSize(30);
      text(money, 100, 60);
        
      if(pharmacyState==1){
        
        //water count
        fill(255);
        textSize(25);
        text(_zWater, 120, 350);
        text(_xWater, 190, 350);
        text(_cWater, 120, 440);
        text(_vWater, 190, 440);
        if(_money <= money){
          text(_money, 355, 517);
        }else{
          image(noMoney, 355, 503);
        }
        
        
        //water info
        if(isPharInfo){
          image(pharInfo, (width-pharInfo.width)/2, (height-pharInfo.height)/2);
        }
      }
  
  }
  
  void keyPress(int _key){
    if(_key=='i'){
        isPharInfo = !isPharInfo;
      }
    
  }
  
  void keyRelease(int _key){
  
    switch(pharmacyState){
        case PHAR_INIT:
          if(_key==ENTER){
            pharmacyState++;
            isPharInfo = false;
          }
          break;
        case PHAR_BUY:
          if(_key==ENTER){
            if(_money<=money){
              zWater+=_zWater;
              xWater+=_xWater;
              cWater+=_cWater;
              vWater+=_vWater;
              money=money-_money;
              pharmacyState++;
              isPharInfo = false;
            }
          }else if(_key=='z'){
            _zWater++; 
          }else if(_key=='x'){
            _xWater++; 
          }else if(_key=='c'){
            _cWater++; 
          }else if(_key=='v'){
            _vWater++; 
          }else if(_key==DELETE||_key==BACKSPACE){
            _zWater=0;
            _xWater=0;
            _cWater=0;
            _vWater=0;
          }
          _money = _zWater*40+_xWater*15+_cWater*15+_vWater*30;
          break;
        case PHAR_PAY:
          if(_key==ENTER){
            pharmacyState=PHAR_INIT;
            _zWater=0;
            _xWater=0;
            _cWater=0;
            _vWater=0;
            _money=0;
          }else if(_key==' '){
            gameState=GAME_MAP;
            pharmacyState=PHAR_INIT;
            isPharInfo = false;
          }
          
          
          break;
      
    }
  
  }
  

}