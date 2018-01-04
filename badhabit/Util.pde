class Util{

  int findWords(char factor){
    for(int i=0; i< words.length;i++){
      if(words[i] == factor){
        return i;
      }
    }
    return -1;
  }
  
  
  void showName(int where){
    if(where==1){
      for(int i=0;i<name.length;i++){
        if(name[i]!=' '){
          image(nameWords[findWords(name[i])], 430+ i*30, 165);
        }
      }
    }else if(where==2){
      for(int i=0;i<name.length;i++){
        if(name[i]!=' '){
          image(nameWords[findWords(name[i])], posX+ i*30+50, posY+200);
        }
      }
    }else if(where==3){
      for(int i=0;i<name.length;i++){
        if(name[i]!=' '){
          image(nameWordsDark[findWords(name[i])], 285+i*30, 135);
        }
      }
    }
  }  

}