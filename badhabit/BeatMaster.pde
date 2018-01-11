import ddf.minim.*;
import ddf.minim.analysis.*;

boolean isHealthyFace = false;
int healthFrame = 0;



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
    song[diaNpc].play();
  }
  
  void doAttack(){

    attackItems.add( new AttackItem(floor(random(0,4))));

  }
  
  void display(){
    
    
    
    for(int i=0; i< attackItems.size(); i++){
      attackItems.get(i).display();
      if(attackItems.get(i).isCollidePad()){
        isHealthyFace =true;
        
        attackItems.remove(i);
      }
    }
    
    healthFrame++;
    if(healthFrame>30){
      isHealthyFace =false;
      healthFrame=0;
    }
    
        
  }
  
  
  void drawEffect(){
    float a = map(eRadius, 20, 80, 60, 255);
    fill(255, 212, 128, a);
    noFill();
    beat.detect(song[diaNpc].mix);
    if ( beat.isOnset() ){
      if(coldDown>=60){
        doAttack();
        coldDown=0;
      }
      eRadius = 350;
    }
    
    stroke(#FFD480);
    strokeWeight(4);
    ellipse(310, 300, eRadius, eRadius);
    eRadius *= 0.85;
    //if ( eRadius < 20 ) eRadius = 0;
    coldDown++;
  }


}