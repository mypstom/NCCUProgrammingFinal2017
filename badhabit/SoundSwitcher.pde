int currentSoundState = GAME_START;
class SoundSwitcher{

  SoundSwitcher(){
  
  }
  
  void gameResult(int result){
    if(result==0){
      sound_win.play();
    }else{
      sound_lose.play();
    }
  
  }
  
  void click(){
    sound_click.play(0);
  }
  
  void switchSound(int state){
    switch(state){
      case GAME_START:
        if(currentSoundState!=GAME_START){
          currentSoundState = GAME_START;
        }
        break;
      case GAME_NAME:
        if(currentSoundState!=GAME_NAME){
          sound_start.pause();
          sound_name.loop();
          currentSoundState = state;
        }
        break;
      case GAME_MAP:
        if(currentSoundState!=GAME_MAP){
          sound_map.loop();
          sound_name.pause();
          sound_pharmacy.pause();
          sound_little.pause();
          currentSoundState = GAME_MAP;
        }
        break;
      case GAME_KIT:
        if(currentSoundState!=GAME_KIT){
          currentSoundState = GAME_KIT;
        }
        break;
      case GAME_DIALOG:
        if(currentSoundState!=GAME_DIALOG){
          currentSoundState = GAME_DIALOG;
        }
        break;
      case GAME_PHARMACY:
        if(currentSoundState!=GAME_PHARMACY){
          sound_pharmacy.loop();
          sound_map.pause();
          currentSoundState = GAME_PHARMACY;
        }

        break;
      case GAME_INGAME:
        if(currentSoundState!=GAME_INGAME){
          currentSoundState = GAME_INGAME;
        }
        break;
      case GAME_PLAYING:
        if(currentSoundState!=GAME_PLAYING){
          sound_map.pause();
          currentSoundState = GAME_PLAYING;
        }
        break;
      case GAME_RESULT:
        if(currentSoundState!=GAME_RESULT){
          currentSoundState = GAME_RESULT;
        }
        break;
      case GAME_END:
        if(currentSoundState!=GAME_END){
          sound_map.pause();
          currentSoundState = GAME_END;
        }
        break;   
      case GAME_LITTLE:
        if(currentSoundState!=GAME_LITTLE){
          sound_map.pause();
          sound_little.loop();
          currentSoundState = GAME_LITTLE;
        }
        break;
    }
  }
}