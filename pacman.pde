class Pacman{
  int k;
  float x;
  float y;
  int lives=3;
  int old_direction;
  int direction;
  int square_x;
  int square_y;
  float speed;
  int tempdir;
  boolean dead;
  boolean tunnel;
  Pacman(){
    old_direction=sinistra;
    direction=sinistra;
    x=300;
    y=510;
    k=0;
    tunnel=false;
    dead=false;
  }
  void coord(int a){
      if(a==su) y=y-speed;
      else if(a==giu) y=y+speed;
      else if(a==sinistra) x=x-speed;
      else if(a==destra) x=x+speed;
}
    void stampa(float x, float y){
    imageMode(CENTER);
    if(generalmode==frightened) tint(r,g,b);
    else tint(chosenr,choseng,chosenb);
    if (direction==giu){
      translate(x,y);
      rotate(PI/2); 
      translate(-x,-y);
      if(pac.dead) image(pac_image[15],x,y);
      else image(pac_image[k],x,y);
      translate(x,y);
      rotate(-PI/2);
      translate(-x,-y);
    }
    else if (direction==sinistra){
      translate(x,y);
      rotate(PI);
      translate(-x,-y);
      if(pac.dead) image(pac_image[15],x,y);
      else image(pac_image[k],x,y);
      translate(x,y);
      rotate(-PI);
      translate(-x,-y);
    }
    else if (direction==su){
      translate(x,y);
      rotate(3*PI/2);
      translate(-x,-y);
      if(pac.dead) image(pac_image[15],x,y);
      else image(pac_image[k],x,y);
      translate(x,y);
      rotate(-3*PI/2);
      translate(-x,-y);  
    }
    else{
      if(pac.dead) image(pac_image[15],x,y);
      else image(pac_image[k],x,y);

    }  
    k++;
    if(k>29 ) k=0;
    noTint();
  }
  void movimento(){
    if (x>=600) x=10;
    if (x<=0) x=590;
    square_x=(int)(x/20); //identifico caselle in x e in y
    square_y=(int)(y-40)/20;
    if(((Math.round(x/10)*10)%10==0 && (Math.round(x/10)*10)%20!=0 && (Math.round(y/10)*10)%10==0 && (Math.round(y/10)*10)%20!=0) && ( (old_direction==sinistra && (Math.round(x/10)*10)>=(x-speed)) || (old_direction==destra && (Math.round(x/10)*10)<=(x+speed)) || (old_direction==su && (Math.round(y/10)*10)>=(y-speed)) || (old_direction==giu && (Math.round(y/10)*10)<=(y+speed)) )){ //in italiano: se il pacman è al centro della casella
      if(matrice_mappa[square_y][square_x]=='k'){
        if (direction==destra || old_direction==destra && direction!=sinistra){ 
          tunnel=true;
          direction=destra;
          coord(direction);
          stampa(x,y);
          
        }
        else{
          tunnel=false;
          direction=sinistra;
          coord(direction);
          stampa(x,y);
        }
      }
      else if(matrice_mappa[square_y][square_x]=='K'){
        if (direction==sinistra || old_direction==sinistra && direction!=destra ){
          tunnel=true;
          direction=sinistra;
          coord(direction);
          stampa(x,y);   
        }
        else{
          tunnel=false;
          direction=destra;
          coord(direction);
          stampa(x,y);

        }
      }
      else{
        if(matrice_mappa[square_y][square_x]=='c'){
          if(!eat.isPlaying()) eat.play();
          u=2;
          punti=punti+10;
          contatorepallini++;
          timertrapallini=millis()/10;
          matrice_mappa[square_y][square_x]='e';
          if(blue.mode==home && pink.mode!=home) blue.t++;
          else if(orange.mode==home && pink.mode!=home && blue.mode!=home) orange.t++;
        }
        else if(matrice_mappa[square_y][square_x]=='C'){
          punti=punti+50;
          contatorepallini++;
          v=0;
          u=0;
          tempstage=stage;
          siren.stop();
          red.eaten=false;
          blue.eaten=false;
          orange.eaten=false;
          pink.eaten=false;
          red.check=true;
          blue.check=true;
          orange.check=true;
          pink.check=true;
          if(generalmode!=frightened) scaredsound.loop();
          else timermode=timermode+(millis()/10-frightenedtime);
          iniziofrightened=true;
          if(!eat.isPlaying()) eat.play();
          timertrapallini=millis()/10;
          matrice_mappa[square_y][square_x]='E';
          if(blue.mode==home && pink.mode!=home) blue.t++;
          else if(orange.mode==home && pink.mode!=home && blue.mode!=home) orange.t++;
          if(red.mode!=home && red.mode!=4) red.mode=frightened;
          if(pink.mode!=home && pink.mode!=4)pink.mode=frightened;
          if(blue.mode!=home && blue.mode!=4)blue.mode=frightened;
          if(orange.mode!=home && orange.mode!=4)orange.mode=frightened;
          generalmode=frightened;
        }
        else if(matrice_mappa[square_y][square_x]=='y' && frutta){
          if(stage==1) punti=punti+100;
          else if(stage==2) punti=punti+300;
          else if(stage<5) punti=punti+500;
          else if(stage<7) punti=punti+700;
          else if(stage<9) punti=punti+1000;
          else if(stage<11) punti=punti+2000;
          else if(stage<13) punti=punti+3000;
          else punti=punti+5000;
          frutta=false;
          iniziastampafrutta=true;
          fruiteat.play();
        }
        if(((matrice_mappa[square_y][square_x+1]!='w') && (direction==destra))||((matrice_mappa[square_y][square_x-1]!='w') && (direction==sinistra))||
        ((matrice_mappa[square_y-1][square_x]!='w') && (direction==su))||((matrice_mappa[square_y+1][square_x]!='w') && (direction==giu)) ){  
          if(direction!=old_direction){
             x=(Math.round(x/10)*10);
             y=(Math.round(y/10)*10);
          }
          stampa(x,y);
          coord(direction);
          old_direction=direction;
        }
        else{
           if(((direction==su || direction==giu) && (old_direction==sinistra && matrice_mappa[square_y][square_x-1]!='w' || old_direction == destra && matrice_mappa[square_y][square_x+1]!='w') )
           ||((direction==destra || direction==sinistra) && (old_direction==giu && matrice_mappa[square_y+1][square_x]!='w' || old_direction==su && matrice_mappa[square_y-1][square_x]!='w'))){

             coord(old_direction);
             tempdir=direction;
             direction=old_direction;
             stampa(x,y);
             direction=tempdir;

            }
            else{
              if(direction+old_direction==3 || direction==old_direction){
                x=(Math.round(x/10)*10);
                y=(Math.round(y/10)*10);
              }
              direction = old_direction;
              stampa(x,y);
            }
        }
      }
    }
    else{
      if(matrice_mappa[square_y][square_x]=='k' && tunnel==true){
        stampa((x-600),y);
      }
      else if(matrice_mappa[square_y][square_x]=='K' && tunnel==true){
        stampa((x+600),y);
      }
      if(direction+old_direction!=3){
        coord(old_direction);
        tempdir=direction;
        direction=old_direction;
        stampa(x,y);
        direction=tempdir;
      }
      else{
        coord(direction);
        stampa(x,y);
      }
    }
  }
} 
