int[][] ironyPostion = {{-15, 365}, {-15, -65}, {365, -65}, {365, 365}};
int[][] ironyDiaPostion = {{400, 400}, {20, 365}, {20, 20}, {400, 20}};

int monsterLifeTime=0;
int damageLifeTime=0;
int ranMonPos;
int ranMonDiaPos;
class IronyMonster{
  IronyMonster(){}
  void display(){
    if(monsterLifeTime>0){
      image(ironyMonster[diaNpc][ranMonPos], ironyPostion[ranMonPos][0], ironyPostion[ranMonPos][1]);
      image(ironyMonsterDia[diaNpc][ranMonDiaPos], ironyDiaPostion[ranMonDiaPos][0], ironyDiaPostion[ranMonDiaPos][1]);
      monsterLifeTime--;
    }
    if(damageLifeTime>0){
      image(damageImg, 0, 0);
      damageLifeTime--;
    }
  }
  void giveMeAMonster(){
    ranMonPos = floor(random(0,4));
    ranMonDiaPos = ranMonPos;
    monsterLifeTime = 180;
  }
  
  
  void showDamage(){
    damageLifeTime = 15;
  }
}