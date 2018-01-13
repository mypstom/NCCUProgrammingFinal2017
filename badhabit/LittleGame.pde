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

class LittleGame{
  
  LittleGame(){
  
  }
  
  void display(){
    image(littleBg, 0, 0);
    
    for(int i=0; i<4; i++){
      if(!littleBtn[i]){
        image(littleQuestion[currentQ][i], 285, 170+i*80);
      }else{
        image(littleQuestionActive[currentQ][i], 285, 170+i*80);
      }
    }
    if(isShowAns){
    }
  }
  //dogTimes
  
  void showAnswer(){
  
  }
  
  
  void keyPress(int _keyCode, int _key){

  }
    
  void keyRelease(int _keyCode, int _key){
    if(!isShowAns){
      if(_key=='a'){
        userAns =0;
        littleBtn[0] = true;
        isShowAns = true;
      }else if(_key=='b'){
        userAns =1;
        littleBtn[1] = true;
        isShowAns = true;
      }else if(_key=='c'){
        userAns =2;
        littleBtn[2] = true;
        isShowAns = true;
      }else if(_key=='d'){
        userAns =3;
        littleBtn[3] = true;
        isShowAns = true;
      }
    }else{
      if(_key==' '){
        for(int i=0; i<4; i++){
          littleBtn[i]=false;
        }
      }
    
    }
  }
}