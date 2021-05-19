class Blue_ghost{
  int k;
  float x;
  float y;
  int i=0,a=0;
  int square_x;
  int square_y;
  int ghost_direction,old_ghost_direction=sinistra;
  int intermedia_x=0,intermedia_y=0;
  int target_x;
  int colore [] = new int [3];
  int target_y;
  int mode,oldmode;
  float speed;
  int t, tlimit;
  boolean tunnel, gohome, escihome, check= true, eaten;
  Blue_ghost(){
    escihome=false;
    t=0;
    if(stage<3) tlimit=30;
    else tlimit=0;
    x=270;
    y=310;
    k=0;
    colore [0] = 25;
    colore [1] = 198;
    colore [2] = 255;
    tunnel=false;
    gohome=false;
    ghost_direction=sinistra;
    mode=home;
    oldmode=home;
    eaten=false;
  }
  void coord(){
    if(ghost_direction==su) y=y-speed;
    else if(ghost_direction==giu) y=y+speed;
    else if(ghost_direction==sinistra) x=x-speed;
    else if(ghost_direction==destra) x=x+speed;
}
  void stampa(float x,float y){
    imageMode(CENTER);
    if((generalmode==frightened && !eaten) || mode==frightened){
      if(!lampeggiofrightened){
        if(i<15) image(frightened_image1,x,y);
        else image(frightened_image2,x,y);
        i++;
        if(i>30) i=0;
      }
      else{
        if(j<15){
          if(i<15) image(frightened_white1,x,y);
          else image(frightened_white2,x,y);
          i++;
          if(i>30) i=0;
        }
        else{
          if(i<15) image(frightened_image1,x,y);
          else image(frightened_image2,x,y);
          i++;
          if(i>30) i=0;
        }
      }
    }
    else{
      if (mode!=dead){
        tint(colore[0],colore[1],colore[2]);
        if(i<15) image(ghost1,x,y);
        else image(ghost2,x,y);
        i++;
        if(i>30) i=0;
        noTint();
      }
      if(ghost_direction==su) image(occhisu,x,y);
      else if(ghost_direction==sinistra) image(occhisinistra,x,y);
      else if(ghost_direction==giu) image(occhigiu,x,y);
      else if(ghost_direction==destra) image(occhidestra,x,y);
    }
  }
  void square(){
    square_x=(int)x/20;
    square_y=(int)(y-40)/20;
  }
  void target(){
    if(mode==chase){
      if(pac.direction==destra){
        intermedia_y=pac.square_y;
        intermedia_x=pac.square_x+2;
      }
      else if(pac.direction==sinistra){
        intermedia_y=pac.square_y;
        intermedia_x=pac.square_x-2;
      }
      else if(pac.direction==giu){
        intermedia_y=pac.square_y+2;
        intermedia_x=pac.square_x;
      }
      else if(pac.direction==su){
        intermedia_y=pac.square_y-2;
        intermedia_x=pac.square_x-2;
      }
      if(red.square_x>intermedia_x) target_x=red.square_x-((red.square_x-intermedia_x)*2);
      else target_x=red.square_x+((intermedia_x-red.square_x)*2);
      if(red.square_y>intermedia_y) target_y=red.square_y-((red.square_y-intermedia_y)*2);
      else target_y=red.square_y+((intermedia_y-red.square_y)*2);
      if(target_x<0) target_x=0;
      if(target_x>29) target_x=29;
      if(target_y<0) target_y=0;
      if(target_y>30) target_y=30;
    }
    else{
      target_x=29;
      target_y=30;
    }
  }
  void movimento(){
    if (x>=600) x=10;
    if (x<=0) x=590;
    square();
    if(mode==dead && x==300 && y==270) gohome=true; 
    if(mode==home){
      home();
    }
    else if(gohome){
      if(k<40){
        y++;
        stampa(x,y);
      }
      else if(k>=40 && k<70){
        x--;
        stampa(x,y);
      }
      else{
        k=-1;
        gohome=false;
        mode=home;
      }
      k++;
    }
    else{
      if(((Math.round(x/10)*10)%10==0 && (Math.round(x/10)*10)%20!=0 && (Math.round(y/10)*10)%10==0 && (Math.round(y/10)*10)%20!=0) && ( (old_ghost_direction==sinistra && (Math.round(x/10)*10)>=(x-speed)) || (old_ghost_direction==destra && (Math.round(x/10)*10)<=(x+speed)) || (old_ghost_direction==su && (Math.round(y/10)*10)>=(y-speed)) || (old_ghost_direction==giu && (Math.round(y/10)*10)<=(y+speed)) )){
        if(matrice_fantasmi[square_y][square_x]=='i' || matrice_fantasmi[square_y][square_x]=='z'){
          if(mode==frightened){
            if(check)
            ghost_direction=(dir_ghost(target_x,target_y,ghost_direction,square_x,square_y,mode));
            check=false;
          }
          else if(mode==dead){
            ghost_direction=(dir_ghost(14,11,old_ghost_direction,square_x,square_y,mode));
          }
          else{
            target();
            ghost_direction=(dir_ghost(target_x,target_y,old_ghost_direction,square_x,square_y,mode));
          }
        }
        else{
          if(old_ghost_direction!=ghost_direction){
            x=(Math.round(x/10)*10);
            y=(Math.round(y/10)*10);
          }
          check=true;
          old_ghost_direction= ghost_direction;
        }
      }
      else{
        check=true;
        if(mode!=oldmode){
          if(oldmode!=frightened && oldmode!=home){
            ghost_direction=3-ghost_direction;
            old_ghost_direction=3-old_ghost_direction;
          }
          oldmode=mode;
        }
      }
      coord();
      stampa(x,y);
    }
  }
  void home(){
    if(((t<tlimit && contapallinilocali) || (((contatorepallini-contatorepallinicasa)<17) && !contapallinilocali)) && ((time-timertrapallini)<400) && !escihome || a<30){
      if(k<40){
        ghost_direction=giu;
        stampa(x,y);
        y=y+1;
      }
      else{
        ghost_direction=su;
        stampa(x,y);
        y=y-1;
      }
      k++;
      if (k>=80) k=0;
      a++;
    }
    else{
      timertrapallini=millis()/10;
      escihome=true;
      if(x!=300){
        ghost_direction=destra;
        stampa(x,y);
        x=x+1;
      }
      else if (y!=270){
        ghost_direction=su;
        stampa(x,y);
        y=y-1;
      }
      else{
        if(generalmode==frightened && eaten==false){
          mode=generalmode;
        }
        else{
          mode=chase;
          choosemode(azzurro);
        }
        ghost_direction=sinistra;
        t=0;
        a=0;
        k=0;
        escihome=false;
        timertrapallini=millis()/10;
      }  
    }
  }
}
        
    
    
