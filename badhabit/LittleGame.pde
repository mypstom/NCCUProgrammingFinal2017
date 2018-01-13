/*
PImage[][] littleQuestion;
PImage[][] littleQuestionActive;
PImage[] littleQuestionText;
PImage[] littleQuestionAns;
PImage littleWin;
PImage littleLose;
PImage littleBg;
*/

int littleState = 0;
int currentQ = 0;
boolean[] littleBtn = {false, false, false, false};
boolean isShowAns = false;
int userAns = -1;
int userCorrectCount = 0;
int[] littleAns = {3,4,1,2,3,1,3,2,4,2};

class LittleGame{
  
  LittleGame(){
  
  }
  
  void display(){
    if(littleState==0){
      image(littleBg, 0, 0);
      fill(#dbbce1);
      textSize(50);
      if(dogTimes==1){
        text(currentQ+1 , 105, 110);
      }else{
        text(currentQ+1-4 , 105, 110);
      }
      text(userCorrectCount , 105, 250);
      
      image(littleQuestionText[currentQ], 230, 65);
      for(int i=0; i<4; i++){
        if(!littleBtn[i]){
          image(littleQuestion[currentQ][i], 265, 170+i*80);
        }else{
          image(littleQuestionActive[currentQ][i], 265, 170+i*80);
        }
      }
      
      if(isShowAns){
        image(littleQuestionAns[currentQ], 525, 165);
        image(littleV, 265, 170+(littleAns[currentQ]-1)*80);
      }
    }else if(littleState==1){
      
      image(littleWin, 0, 0);
      fill(#192659);
      textSize(60);
      text(userCorrectCount , 600, 280);
      
      
    }else if(littleState==2){
      
      image(littleLose, 0, 0);
      fill(#192659);
      textSize(60);
      text(userCorrectCount , 600, 280);
      
      
    }
    
  }
  //dogTimes
  
  void showAnswer(){
  
  }
  
  void checkPass(){
    if(userCorrectCount>3){
      littleState =1;
      money+=40;
      sound_little.pause();
      sound_win.play();
    }else{
      sound_little.pause();
      sound_lose.play();
      littleState =2;
      money+=40;
    }
  }
  
  void keyPress(int _keyCode, int _key){

  }
    
  void keyRelease(int _keyCode, int _key){
    if(_key==' '){
      if(littleState!=0){
        userCorrectCount=0;
        gameState = GAME_MAP;
        littleState=0;
      }
    }
    if(!isShowAns){
      if(_key=='a'){
        checkAns(0);
      }else if(_key=='b'){
        checkAns(1);
      }else if(_key=='c'){
        checkAns(2);
      }else if(_key=='d'){
        checkAns(3);
        
      }
    }else{
      if(_key==' '){
        
        if(littleState==0){
          
          for(int i=0; i<4; i++){
            littleBtn[i]=false;
          }
          isShowAns = false;
          currentQ++;
          if(dogTimes==1){
            if(currentQ==6){
              checkPass();
              currentQ=4;
            }
          }else{
            if(currentQ==10){
              checkPass();
            }
          }
        }else{
          userCorrectCount=0;
          gameState = GAME_MAP;
        }
      }    
    }
  }
  
  void checkAns(int index){
    userAns =index;
    littleBtn[index] = true;
    isShowAns = true;
    if((userAns+1)==littleAns[currentQ]){
      userCorrectCount++;
    }else{
    
    }
  
  }
}