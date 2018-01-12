import ddf.minim.*;
import ddf.minim.analysis.*;

boolean isHealthyFace = false;
int healthFrame = 0;

int MAX_TIME = 60;
int timeFrame = MAX_TIME*60;//frames

int gamePoint =0;

int delayCounter = 0;

//int[] BPM = 105;
float[] BPM = {52.5, 52.5, 52.5, 52.5};
int bpmCounter = 0;
int tempoFrames;

boolean[] gameOppoState = {false, true, false, true};
int[] gameSpaceItemState = {3, 1, 3, 3};

int combo;

class BeatMaster{
  ArrayList <AttackItem> attackItems;
  int coldDown=60;
  float eRadius;
  
  BeatMaster(){
    
    beat = new BeatDetect();
    attackItems = new ArrayList <AttackItem> ();  
    ellipseMode(RADIUS);
    eRadius = 20;
  }
  
  void start(){
    combo=0;
    tempoFrames = floor(60*60/BPM[diaNpc]);
    println("Tempo: "+diaNpc);
  }
  
  void doAttack(){
    int ranSide = floor(random(0,4));
    int ranType;
    if(gameOppoState[diaNpc]){
      ranType = floor(random(0, 3));
    }else{
      ranType = floor(random(0, 2));
    }
    
    println(ranType);
    int ranSpace = floor(random(0,gameSpaceItemState[diaNpc]));
    attackItems.add( new AttackItem(ranSide, ranType, ranSpace));

  }
  
  void display(){
    if(!song[diaNpc].isPlaying ()|| delayCounter<130){
      delayCounter++;
      if(delayCounter>180){
        song[diaNpc].loop();
      }
    }else{
      if(bpmCounter == tempoFrames){
        doAttack();
        bpmCounter=0;
      }
      bpmCounter++;
    }
    
    for(int i=0; i< attackItems.size(); i++){
      attackItems.get(i).display();
      if(attackItems.get(i).isTooFar()){
        ironyMon.giveMeAMonster();
        ironyMon.showDamage();
        combo=0;
        attackItems.remove(i);
      }else if(attackItems.get(i).isCollidePad()){
        //hit item
        eRadius = 250;
        combo++;
        isHealthyFace =true;
        gamePoint++;
        attackItems.remove(i);
      }
    }
    
    //time counter
    fill(#f5c7f7);
    textSize(50);
    text(nf(floor(timeFrame/60), 2), 698, 85);
    if(combo>0){
      textSize(120);
      fill(245, 199, 247);  
      text("Combo: "+ combo, 0, 0);
      println(combo);
    }
    timeFrame--;
    
    if(timeFrame<=0){
      song[diaNpc].pause();
      timeFrame = MAX_TIME*60;
      gamePoint =0;
      gameState = GAME_MAP;
    }
    
    healthFrame++;
    if(healthFrame>30){
      isHealthyFace =false;
      healthFrame=0;
    }
    
    //life bar
    stroke(#74275C);
    strokeWeight(25);
    line(642.5, height-45, 642.5, height-45-min(560,gamePoint*10));
    
        
  }
  
  
  void drawEffect(){
    float a = map(eRadius, 20, 80, 60, 255);
    fill(255, 212, 128, a);
    //noFill();
    beat.detect(song[diaNpc].mix);
    if ( beat.isOnset() ){

    }
    
    stroke(#FFD480);
    strokeWeight(4);
    ellipse(310, 300, eRadius, eRadius);
    eRadius *= 0.85;
  }
  
  

}