class Pink_ghost{
  int k;
  float x;
  float y;
  int t,i=0;
  int square_x;
  int square_y;
  int colore [] = new int [3];
  int ghost_direction,old_ghost_direction=sinistra;
  int target_x;
  int target_y;
  int mode,oldmode;
  float speed;
  boolean tunnel, gohome, escihome,check=true, eaten;
  Pink_ghost(){
    x=300;
    y=330;
    k=20;
    t=0;
    colore [0] = 255;
    colore [1] = 192;
    colore [2] = 203;
    escihome=false;
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
  void target(){
    if(mode==chase){
      if(pac.direction==su){
        if((pac.square_x-4)>0) target_x=(pac.square_x-4);
        else target_x=0;
        if((pac.square_y-4)>0) target_y=(pac.square_y-4);
        else target_y=0;
      }
      else if(pac.direction==giu){
        target_x=pac.square_x;
        if((pac.square_y+4)<30) target_y=pac.square_y+4;
        else target_y=30;
      }
      else if(pac.direction==sinistra){
        target_y=pac.square_y;
        if((pac.square_x-4)>0) target_x=pac.square_x-4;
        else target_x=0;
      }
      else{
        target_y=pac.square_y;
        if((pac.square_x+4)<29) target_x=pac.square_x+4;
        else target_x=29;
      }
    }
    else{
      target_x=3;
      target_y=0;
    }
  }
  void square(){
    square_x=(int)x/20;
    square_y=(int)(y-40)/20;
  }
  void home(){
    if(((t<0 && contapallinilocali) || (((contatorepallini-contatorepallinicasa)<7) && !contapallinilocali)) && ((time-timertrapallini)< 400) && !escihome){
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
      if (k>=80){
        k=0;
        t++;
      }
    }
    else{
      timertrapallini=millis()/10;
      escihome=true;
      if(y!=270){
        ghost_direction=su;
        stampa(x,y);
        y=y-1;
        t++;
      }
      else{
        if(generalmode==frightened && eaten==false){
          mode=generalmode;
        }
        else{
          mode=chase;
          choosemode(rosa);
        }
        ghost_direction=sinistra;
        t=0;
        k=20;
        escihome=false;
        timertrapallini=millis()/10;
      }
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
      if(k<60){
        y++;
        stampa(x,y);
      }
      else{
        k=19;
        gohome=false;
        mode=home;
      }
      k++;
    }
    else{
      if(((Math.round(x/10)*10)%10==0 && (Math.round(x/10)*10)%20!=0 && (Math.round(y/10)*10)%10==0 && (Math.round(y/10)*10)%20!=0) && ( (old_ghost_direction==sinistra && (Math.round(x/10)*10)>=(x-speed)) || (old_ghost_direction==destra && (Math.round(x/10)*10)<=(x+speed)) || (old_ghost_direction==su && (Math.round(y/10)*10)>=(y-speed)) || (old_ghost_direction==giu && (Math.round(y/10)*10)<=(y+speed)) )){
        if(matrice_fantasmi[square_y][square_x]=='i'  || matrice_fantasmi[square_y][square_x]=='z'){
          if(mode==frightened){
            if(check)
            ghost_direction=(dir_ghost(target_x,target_y,old_ghost_direction,square_x,square_y,mode));
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
}
