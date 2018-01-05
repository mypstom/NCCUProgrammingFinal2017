import ddf.minim.*;
import ddf.minim.analysis.*;




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
    song.play();
  }
  
  void doAttack(){

    attackItems.add( new AttackItem(floor(random(0,4))));

  }
  
  void display(){
    
    float a = map(eRadius, 20, 80, 60, 255);
    //fill(255, 212, 128, a);
    noFill();
    beat.detect(song.mix);
    if ( beat.isOnset() ){
      if(coldDown>=60){
        doAttack();
        coldDown=0;
        println("GO!");
      }
      eRadius = 350;
    }
    
    stroke(#FFD480);
    strokeWeight(4);
    ellipse(310, 300, eRadius, eRadius);
    eRadius *= 0.85;
    //if ( eRadius < 20 ) eRadius = 0;
    coldDown++;
    if(attackItems.size()>0){
      for(AttackItem atk : attackItems){
        atk.display();
      }
    }
  }


}