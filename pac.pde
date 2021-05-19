PImage map, sfondolobby, sfondowindows,sfondocredits, sfondogameover; //<>//
PFont ottobit;
import processing.sound.*;
SoundFile soundtrack, readysound, eat, siren, death, scaredsound, extralife, ghosteat, fruiteat, text_select_effect, text_click_effect, gameoversound1, youarealoser, sparkle;
final int destra=2, sinistra=1, su=3, giu=0;
final int chase=0, scatter=1, frightened=2, home=3, dead=4;
final int rosso=0, arancio=1, rosa=2, azzurro=3, tutti=4;
final int lobby=0, game=1, game_over=2, options=3, credits=4, topscores=5,setscore=6;
int fantasma;
int contatorepallini=0, contatorepallinicasa, contatorepuntivite=0;
int r=238, g=97, b=34, chosenr=255, choseng=220, chosenb=0;
int time,timermode=0, frightenedtime, frightenedtimelampeggio, timerready, timertrapallini=0, timerfrutta=0, timergameover, timerdead;
int generalmode=scatter,oldmode=scatter, window=lobby;
int punti=0;
int stage=1;
int z=0, i=0, j=0, u=0, t=0, y=0, v=0;
int vita_temp, temptime, tempstage=1;
int direzione[] = new int[3];
float tempx, tempy, xo=385, yo=85;
float generalspeed=3.5;
boolean gameover=false, contapallinilocali=true, ready=true, stampapunti=false, inizio=true, iniziofrightened=true, lampeggiofrightened=false,iniziastampafrutta=true,frutta=false;
boolean elroy1=false, elroy2=false, playmusic=true, ingrandisci=false, premivolume=false, eatenfruit=true, trascinavolume=false, ghostfollowspac, playsoundtrack, topscoresingame;
boolean frecciasinistracolore=false, frecciadestracolore=false, loser, link1,link2,link3;
PImage pac_image[] =new PImage[35];
PImage fruits[] =new PImage [8];
PImage frightened_image1, frightened_image2, frightened_white1,frightened_white2, ghost1,ghost2;
PImage occhisu, occhigiu, occhidestra, occhisinistra;
PImage pacmantext, gameovertext, podio;
Table punteggi = new Table();
String name = "", nome_temp, max_nome;
int tasto;
int old_score;
int max,pos, temp, posnome;
boolean check=false, pausa=false;
  int p=0;
Pacman pac;
Red_ghost red;
Pink_ghost pink;
Orange_ghost orange;
Blue_ghost blue;
void mouseDragged(){
  if(trascinavolume){
    xo=mouseX;
    if(mouseX>475) xo=475;
    if(mouseX<300) xo=300;
  }
}
void mouseClicked(){
  if(frecciasinistracolore || frecciadestracolore){
    text_click_effect.play();
    if(frecciasinistracolore)  y--;
    else y++;
    if(y<0) y=4;
    if(y>4) y=0;
    if(y==0){
      chosenr=255;
      choseng=220;
      chosenb=0;
    }
    else if(y==1){
      chosenr=203;
      choseng=50;
      chosenb=52;
    }
    else if(y==2){
      chosenr=80;
      choseng=101;
      chosenb=211;
    }
    else if(y==3){
      chosenr=67;
      choseng=208;
      chosenb=86;
    }
    else{
      chosenr=143;
      choseng=64;
      chosenb=207;
    }
  }
  if(link1) link("http://www.gamasutra.com/view/feature/3938/the_pacman_dossier.php?print=1");
  if(link2) link("https://dev.to/code2bits/pac-man-patterns--ghost-movement-strategy-pattern-1k1a");
  if(link3) link("http://gameinternals.com/post/2072558330/understanding-pac-man-ghost-behavior");
  if(trascinavolume){
    xo=mouseX;
    if(mouseX>475) xo=475;
    if(mouseX<300) xo=300;
    text_click_effect.play();
  }
  if(premivolume){
    xo=xo+10;
    text_click_effect.play();
    if(xo>475) xo=300;
  }
}
void audio(){
  death.amp(0.9*((xo-300)/185));
  siren.amp(0.2*((xo-300)/185));
  eat.amp(0.2*((xo-300)/185));
  scaredsound.amp(0.3*((xo-300)/185));
  soundtrack.amp(0.2*((xo-300)/185));
  readysound.amp(0.5*((xo-300)/185));
  ghosteat.amp(0.7*((xo-300)/185));
  death.amp(0.5*((xo-300)/185));
  fruiteat.amp(0.7*((xo-300)/185));
  extralife.amp(0.7*((xo-300)/185));
  text_click_effect.amp((xo-300)/185);
  text_select_effect.amp((xo-300)/185);
  youarealoser.amp(0.9*((xo-300)/185));
  sparkle.amp(0.9*((xo-300)/185));
  gameoversound1.amp(0.9*((xo-300)/185));
}
void elroy(){
  if(stage==1){
    if(contatorepallini==224) elroy1=true;
    else if(contatorepallini==234){
      elroy1=false;
      elroy2=true;
    }
  }
  else if(stage==2){
    if(contatorepallini==214) elroy1=true;
    else if(contatorepallini==229){
      elroy1=false;
      elroy2=true;
    }
  }
  else if(stage<6){
    if (contatorepallini==204) elroy1=true;
    else if(contatorepallini==224){
      elroy1=false;
      elroy2=true;
    }
  }
  else if(stage<9){
    if (contatorepallini==194) elroy1=true;
    else if(contatorepallini==219){
      elroy1=false;
      elroy2=true;
    }
  }
  else if(stage<12){
    if (contatorepallini==184) elroy1=true;
    else if(contatorepallini==214){
      elroy1=false;
      elroy2=true;
    }
  }
  else if(stage<15){
    if (contatorepallini==164) elroy1=true;
    else if(contatorepallini==204){
      elroy1=false;
      elroy2=true;
    }
  }
  else if(stage<19){
    if (contatorepallini==144) elroy1=true;
    else if(contatorepallini==194){
      elroy1=false;
      elroy2=true;
    }
  }
  else{
    if (contatorepallini==124) elroy1=true;
    else if(contatorepallini==184){
      elroy1=false;
      elroy2=true;
    }
  }
}
void fruit(){
  if(iniziastampafrutta){
    timerfrutta=millis()/10;
    iniziastampafrutta=false;
  }
  if(pac.dead || time-timerfrutta>1000){
    iniziastampafrutta=true;
    frutta=false;
  }
  else{
    if(stage==1) image(fruits[0],300,510);
    else if(stage==2) image(fruits[1],300,510);
    else if(stage<5) image(fruits[2],300,510);
    else if(stage<7) image(fruits[3],300,510);
    else if(stage<9) image(fruits[4],300,510);
    else if(stage<11) image(fruits[5],300,510);
    else if(stage<13) image(fruits[6],300,510);
    else image(fruits[7],300,510);
  }
}
void setspeed(){
  if(u<3){
    u++;
    pac.speed=0;
  }
  else if(generalmode==frightened){
    if(stage==1)pac.speed=generalspeed*0.90;
    else if(stage<5)pac.speed=generalspeed*0.95;
    else pac.speed=generalspeed;
  }
  else{
    if(stage==1)pac.speed=generalspeed*0.80;
    else if(stage<5)pac.speed=generalspeed*0.90;
    else if(stage<20) pac.speed=generalspeed;
    else pac.speed=generalspeed*0.90;
  }
  if(red.mode==frightened){
    if(stage==1)red.speed=generalspeed*0.50;
    else if(stage<5)red.speed=generalspeed*0.55;
    else red.speed=generalspeed*0.60;
  }
  else if(red.mode==dead) red.speed=5;
  else if(elroy1){
    if(stage==1)red.speed=generalspeed*0.80;
    else if(stage<5)red.speed=generalspeed*0.90;
    else red.speed=generalspeed;
    if(matrice_fantasmi[red.square_y][red.square_x]=='k' || matrice_fantasmi[red.square_y][red.square_x]=='K' || matrice_fantasmi[red.square_y][red.square_x]=='a') red.speed=red.speed/2;
  }
  else if(elroy2){
    if(stage==1)red.speed=generalspeed*0.85;
    else if(stage<5)red.speed=generalspeed*0.95;
    else red.speed=generalspeed*1.05;
    if(matrice_fantasmi[red.square_y][red.square_x]=='k' || matrice_fantasmi[red.square_y][red.square_x]=='K' || matrice_fantasmi[red.square_y][red.square_x]=='a') red.speed=red.speed/2;
  }
  else{
    if(stage==1) red.speed=generalspeed*0.75;
    else if(stage<5) red.speed=generalspeed*0.85;
    else red.speed=generalspeed*0.95;
    if(matrice_fantasmi[red.square_y][red.square_x]=='k' || matrice_fantasmi[red.square_y][red.square_x]=='K' || matrice_fantasmi[red.square_y][red.square_x]=='a') red.speed=red.speed/2;
  }
  if(pink.mode==frightened){
    if(stage==1)pink.speed=generalspeed*0.50;
    else if(stage<5)pink.speed=generalspeed*0.55;
    else pink.speed=generalspeed*0.60;
  }
  else if(pink.mode==dead) pink.speed=5;
  else{
    if(stage==1) pink.speed=generalspeed*0.75;
    else if(stage<5) pink.speed=generalspeed*0.85;
    else pink.speed=generalspeed*0.95;
    if(matrice_fantasmi[pink.square_y][pink.square_x]=='k' || matrice_fantasmi[pink.square_y][pink.square_x]=='K' || matrice_fantasmi[pink.square_y][pink.square_x]=='a') pink.speed=pink.speed/2;
  }
  if(blue.mode==frightened){
    if(stage==1)blue.speed=generalspeed*0.50;
    else if(stage<5)blue.speed=generalspeed*0.55;
    else blue.speed=generalspeed*0.60;
  }
  else if(blue.mode==dead) blue.speed=5;
  else{
    if(stage==1) blue.speed=generalspeed*0.75;
    else if(stage<5) blue.speed=generalspeed*0.85;
    else blue.speed=generalspeed*0.95;
    if(matrice_fantasmi[blue.square_y][blue.square_x]=='k' || matrice_fantasmi[blue.square_y][blue.square_x]=='K' || matrice_fantasmi[blue.square_y][blue.square_x]=='a') blue.speed=blue.speed/2;
  }
  if(orange.mode==frightened){
    if(stage==1)orange.speed=generalspeed*0.50;
    else if(stage<5)orange.speed=generalspeed*0.55;
    else orange.speed=generalspeed*0.60;
  }
  else if(orange.mode==dead) orange.speed=5;
  else{
    if(stage==1) orange.speed=generalspeed*0.75;
    else if(stage<5) orange.speed=generalspeed*0.85;
    else orange.speed=generalspeed*0.95;
    if(matrice_fantasmi[orange.square_y][orange.square_x]=='k' || matrice_fantasmi[orange.square_y][orange.square_x]=='K' || matrice_fantasmi[orange.square_y][orange.square_x]=='a') orange.speed=orange.speed/2;
  }
}
void frightenedmode(){
  j++;
  if(j>30) j=0;
  if(iniziofrightened){
    frightenedtime=millis()/10;
    iniziofrightened=false;
    lampeggiofrightened=false;
    j=0;
  }
  if(tempstage!=stage){
    choosemode(tutti);
    frightenedtime=millis()/10;
    timermode=timermode+(millis()/10-frightenedtime);
    scaredsound.stop();
    tempstage=stage;
  }
  else if(!lampeggiofrightened){
    if(stage==1){
      if(millis()/10-frightenedtime>600){
        lampeggiofrightened=true;
        frightenedtimelampeggio=millis()/10;
      }
    }
    else if(stage==2 || stage==6 || stage==10){
      if(millis()/10-frightenedtime>500){
        lampeggiofrightened=true;
        frightenedtimelampeggio=millis()/10;
      }
    }
    else if(stage==3){
      if(millis()/10-frightenedtime>400){
        lampeggiofrightened=true;
        frightenedtimelampeggio=millis()/10;
      }
    }
    else if(stage==4 || stage==14){
      if(millis()/10-frightenedtime>300){
        lampeggiofrightened=true;
        frightenedtimelampeggio=millis()/10;
      }
    }
    else if(stage==5 || stage==7 || stage==8 || stage==11){
      if(millis()/10-frightenedtime>200) {
        lampeggiofrightened=true;
        frightenedtimelampeggio=millis()/10;
      }
    }
    else if(stage==9 || stage==12 || stage==13 || stage==15 || stage==16){
      if(millis()/10-frightenedtime>100) {
        lampeggiofrightened=true;
        frightenedtimelampeggio=millis()/10;
      }
    }
    else{
      lampeggiofrightened=true;
      frightenedtimelampeggio=millis()/10;
    }
  }
  else{
    if((stage<9) || stage==10 || stage==11 || stage==14){
      if(millis()/10-frightenedtimelampeggio>500){
        choosemode(tutti);
        frightenedtime=millis()/10;
        timermode=timermode+(millis()/10-frightenedtime);
        scaredsound.stop();
        if(tempstage==stage) siren.loop();
        tempstage=stage;
      }
    }
    else if(stage==9 || stage==12 || stage==13 || stage==15 || stage==16 || stage==18){
      if(millis()/10-frightenedtimelampeggio>300){
        choosemode(tutti);
        frightenedtime=millis()/10;
        timermode=timermode+(millis()/10-frightenedtime);
        scaredsound.stop();
        if(tempstage==stage) siren.loop();
        tempstage=stage;
      }
    }
    else{
      if(millis()/10-frightenedtimelampeggio>100){
        choosemode(tutti);
        frightenedtime=millis()/10;
        timermode=timermode+(millis()/10-frightenedtime);
        scaredsound.stop();
        if(tempstage==stage) siren.loop();
        tempstage=stage;
      }
    }
  }
}
void modecheck(int a, int fantasma){
  if(fantasma==tutti) generalmode=a;
  if(red.mode!=home && red.mode!=dead && (fantasma==rosso || fantasma==tutti)) red.mode=a;
  if((elroy1 || elroy2) && red.mode==scatter && (fantasma==rosso || fantasma==tutti)) red.mode=chase;
  if(blue.mode!=home && blue.mode!=dead && (fantasma==azzurro || fantasma==tutti)) blue.mode=a;
  if(pink.mode!=home && pink.mode!=dead && (fantasma==rosa || fantasma==tutti)) pink.mode=a;
  if(orange.mode!=home && orange.mode!=dead && (fantasma==arancio || fantasma==tutti)) orange.mode=a;
}
void choosemode(int fantasma){
  if(stage==1){
    if((millis()/10-timermode)<700) modecheck(scatter,fantasma);
    else if((millis()/10-timermode)<2700) modecheck(chase,fantasma);
    else if((millis()/10-timermode)<3400) modecheck(scatter,fantasma);
    else if((millis()/10-timermode)<5400) modecheck(chase,fantasma);
    else if((millis()/10-timermode)<5900) modecheck(scatter,fantasma);
    else if((millis()/10-timermode)<7900) modecheck(chase,fantasma);
    else if((millis()/10-timermode)<8400) modecheck(scatter,fantasma);
    else modecheck(chase,fantasma);
  }
  else if(stage<5){
    if((millis()/10-timermode)<700) modecheck(scatter,fantasma);
    else if((millis()/10-timermode)<2700) modecheck(chase,fantasma);
    else if((millis()/10-timermode)<3400)modecheck(scatter,fantasma);
    else if((millis()/10-timermode)<5400) modecheck(chase,fantasma);
    else if((millis()/10-timermode)<5900) modecheck(scatter,fantasma);
    else if((millis()/10-timermode)<109200) modecheck(chase,fantasma);
    else if((millis()/10-timermode)<109202) modecheck(scatter,fantasma);
    else modecheck(chase,fantasma);
  }
  else{
    if((millis()/10-timermode)<500)modecheck(scatter,fantasma);
    else if((millis()/10-timermode)<2500) modecheck(chase,fantasma);
    else if((millis()/10-timermode)<3000) modecheck(scatter,fantasma);
    else if((millis()/10-timermode)<5000) modecheck(chase,fantasma);
    else if((millis()/10-timermode)<5500) modecheck(scatter,fantasma);
    else if((millis()/10-timermode)<109200) modecheck(chase,fantasma);
    else if((millis()/10-timermode)<109202) modecheck(scatter,fantasma);
    else modecheck(chase,fantasma);
  }
}
void colors() {
  if (r<255) r=r+13;
  else r=0;
  if (g<255) g=g+13;
  else g=0;
  if (b<255) b=b+13;
  else b=0;
}
void stampavite(){
  if(pac.lives==3){
    if(generalmode==frightened) tint(r,g,b);
    else tint(chosenr,choseng,chosenb);
    image(pac_image[16],180,680);
    image(pac_image[16],230,680);
    noTint();
  }
  else if(pac.lives==2){
    if(generalmode==frightened) tint(r,g,b);
    else tint(chosenr,choseng,chosenb);
    image(pac_image[16],180,680);
    noTint();
  }
  else if(pac.lives==4){
    if(generalmode==frightened) tint(r,g,b);     
    else tint(chosenr,choseng,chosenb);;
    image(pac_image[16],180,680);
    image(pac_image[16],280,680);
    image(pac_image[16],230,680);
    noTint();
  }
  else if(pac.lives>4){
    if(generalmode==frightened) tint(r,g,b);
    else tint(chosenr,choseng,chosenb);
    image(pac_image[16],180,680);
    textSize(15);
    fill(r,g,b);
    text("x", 210,690);
    text(pac.lives-1, 230, 690);
    noTint();
  }
}
void stampa_pallini() {
  for (int i=0; i<30; i++) {
    for (int j=0; j<31; j++) {
      if (matrice_mappa[j][i]=='c') {
        if(generalmode==frightened) fill(r,g,b);
        else fill(chosenr,choseng,chosenb);
        ellipse(20*i+10, 20*j+50, 7, 7);
        noFill();
      } else if (matrice_mappa[j][i]=='C') {
        if(generalmode==frightened) fill(r,g,b);
        else fill(chosenr,choseng,chosenb);
        ellipse(20*i+10, 20*j+50, 20, 20);
        noFill();
      }
    }
  }
}
int dir_ghost(int targetx, int targety, int dir, int quadrato_x, int quadrato_y, int mode) {
  int newdir=su;
  float distanzaminore=1000;
  if (mode==frightened) {
    t=0;
    if (matrice_fantasmi[quadrato_y][quadrato_x+1]!='w' && (destra+dir)!=3){
      direzione[t]=destra;
      t++;
    }
    if (matrice_fantasmi[quadrato_y][quadrato_x-1]!='w' && (sinistra+dir)!=3){
      direzione[t]=sinistra;
      t++;
    }
    if (matrice_fantasmi[quadrato_y+1][quadrato_x]!='w' && (giu+dir)!=3){
      direzione[t]=giu;
      t++;
    }
    if (matrice_fantasmi[quadrato_y-1][quadrato_x]!='w' && (su+dir)!=3){
      direzione[t]=su;
      t++;
    }
    return ( direzione[(int(random(t)))]);
  }
  else {
    if (dir==destra) {
      if (matrice_fantasmi[quadrato_y-1][quadrato_x]!='w' && (matrice_fantasmi[quadrato_y][quadrato_x]!='z' || mode==scatter)) { //su
        distanzaminore=sqrt((targetx-quadrato_x)*(targetx-quadrato_x)+(targety-(quadrato_y-1))*(targety-(quadrato_y-1)));
        newdir=su;
      }
      if (matrice_fantasmi[quadrato_y+1][quadrato_x]!='w') {//giu
        if ((sqrt((targetx-quadrato_x)*(targetx-quadrato_x)+(targety-(quadrato_y+1))*(targety-(quadrato_y+1))))<distanzaminore) { 
          distanzaminore=sqrt((targetx-quadrato_x)*(targetx-quadrato_x)+(targety-(quadrato_y+1))*(targety-(quadrato_y+1)));
          newdir=giu;
        }
      }
      if (matrice_fantasmi[quadrato_y][quadrato_x+1]!='w') {//destra
        if ((sqrt((targetx-(quadrato_x+1))*(targetx-(quadrato_x+1))+(targety-(quadrato_y))*(targety-(quadrato_y))))<distanzaminore) { 
          distanzaminore=sqrt((targetx-(quadrato_x+1))*(targetx-(quadrato_x+1))+(targety-(quadrato_y))*(targety-(quadrato_y)));
          newdir=destra;
        }
      }
    } else if (dir==sinistra) {
      if (matrice_fantasmi[quadrato_y-1][quadrato_x]!='w'  &&(matrice_fantasmi[quadrato_y][quadrato_x]!='z' || mode==scatter)) { //su
        distanzaminore=sqrt((targetx-quadrato_x)*(targetx-quadrato_x)+(targety-(quadrato_y-1))*(targety-(quadrato_y-1)));
        newdir=su;
      }
      if (matrice_fantasmi[quadrato_y][quadrato_x-1]!='w') {//sinistra
        if ((sqrt((targetx-(quadrato_x-1))*(targetx-(quadrato_x-1))+(targety-(quadrato_y))*(targety-(quadrato_y))))<distanzaminore) {   
          distanzaminore=sqrt((targetx-(quadrato_x-1))*(targetx-(quadrato_x-1))+(targety-(quadrato_y))*(targety-(quadrato_y)));
          newdir=sinistra;
        }
      }
      if (matrice_fantasmi[quadrato_y+1][quadrato_x]!='w') {//giu
        if ((sqrt((targetx-quadrato_x)*(targetx-quadrato_x)+(targety-(quadrato_y+1))*(targety-(quadrato_y+1))))<distanzaminore) {
          distanzaminore=sqrt((targetx-quadrato_x)*(targetx-quadrato_x)+(targety-(quadrato_y+1))*(targety-(quadrato_y+1)));
          newdir=giu;
        }
      }
    } else if (dir==giu) {
      if (matrice_fantasmi[quadrato_y][quadrato_x-1]!='w') {//sinistra
        distanzaminore=sqrt((targetx-(quadrato_x-1))*(targetx-(quadrato_x-1))+(targety-(quadrato_y))*(targety-(quadrato_y)));
        newdir=sinistra;
      }
      if (matrice_fantasmi[quadrato_y+1][quadrato_x]!='w') {//giu
        if ((sqrt((targetx-quadrato_x)*(targetx-quadrato_x)+(targety-(quadrato_y+1))*(targety-(quadrato_y+1))))<distanzaminore) { 
          distanzaminore=sqrt((targetx-quadrato_x)*(targetx-quadrato_x)+(targety-(quadrato_y+1))*(targety-(quadrato_y+1)));
          newdir=giu;
        }
      }
      if (matrice_fantasmi[quadrato_y][quadrato_x+1]!='w') {//destra
        if ((sqrt((targetx-(quadrato_x+1))*(targetx-(quadrato_x+1))+(targety-(quadrato_y))*(targety-(quadrato_y))))<distanzaminore) {
          distanzaminore=sqrt((targetx-(quadrato_x+1))*(targetx-(quadrato_x+1))+(targety-(quadrato_y))*(targety-(quadrato_y)));
          newdir=destra;
        }
      }
    } else if (dir==su) {
      if (matrice_fantasmi[quadrato_y-1][quadrato_x]!='w'  &&(matrice_fantasmi[quadrato_y][quadrato_x]!='z' || mode==scatter)) { //su
        distanzaminore=sqrt((targetx-quadrato_x)*(targetx-quadrato_x)+(targety-(quadrato_y-1))*(targety-(quadrato_y-1)));
        newdir=su;
      }
      if (matrice_fantasmi[quadrato_y][quadrato_x-1]!='w') {//sinistra
        if ((sqrt((targetx-(quadrato_x-1))*(targetx-(quadrato_x-1))+(targety-(quadrato_y))*(targety-(quadrato_y))))<distanzaminore) { 
          distanzaminore=sqrt((targetx-(quadrato_x-1))*(targetx-(quadrato_x-1))+(targety-(quadrato_y))*(targety-(quadrato_y)));
          newdir=sinistra;
        }
      }
      if (matrice_fantasmi[quadrato_y][quadrato_x+1]!='w') {//destra
        if ((sqrt((targetx-(quadrato_x+1))*(targetx-(quadrato_x+1))+(targety-(quadrato_y))*(targety-(quadrato_y))))<distanzaminore) {
          distanzaminore=sqrt((targetx-(quadrato_x+1))*(targetx-(quadrato_x+1))+(targety-(quadrato_y))*(targety-(quadrato_y)));
          newdir=destra;
        }
      }
    }
    return newdir;
  }
}
void verifica_stessa_casella() {
  if ((pac.square_x==red.square_x)&&(pac.square_y==red.square_y)) {
    if (red.mode==frightened) {
      red.mode=dead;
      ghosteat.play();
      v++;
      punti=punti+(200*v);
      if(v==4) punti=punti+12000;
      stampapunti=true;
      temptime=millis()/10;
      tempx=pac.x;
      tempy=pac.y;
      red.eaten=true;
    } 
    else if(red.mode!=frightened && red.mode!=dead) {
      if(generalmode==frightened){
        choosemode(tutti);
        frightenedtime=millis()/10;
        timermode=timermode+(millis()/10-frightenedtime);
        scaredsound.stop();
      }
      else siren.stop();
      pac.dead=true;
      red.k=0;
      fantasma=rosso;
      pac.lives--;
      i=0;
      contatorepallinicasa=contatorepallini;
      contapallinilocali=false;
    }
  }
  if ((pac.square_x==pink.square_x)&&(pac.square_y==pink.square_y)) {
    if (pink.mode==frightened) {
      pink.k=0;
      pink.t=0;
      ghosteat.play();
      pink.mode=dead;
      v++;
      punti=punti+(200*v);
      if(v==4) punti=punti+12000;
      stampapunti=true;
      temptime=millis()/10;
      tempx=pac.x;
      tempy=pac.y;
      pink.eaten=true;
    } 
    else if(pink.mode!=frightened && pink.mode!=dead){
      if(generalmode==frightened){
        choosemode(tutti);
        frightenedtime=millis()/10;
        timermode=timermode+(millis()/10-frightenedtime);
        scaredsound.stop();
      }
      else siren.stop();
      pac.dead=true;
      fantasma=rosa;
      pac.lives--;
      i=0;
      contatorepallinicasa=contatorepallini;
      contapallinilocali=false;
    }
  }
  if ((pac.square_x==orange.square_x)&&(pac.square_y==orange.square_y)) {
    if (orange.mode==frightened) {
      orange.k=0;
      orange.mode=dead;
      ghosteat.play();
      v++;
      punti=punti+(200*v);
      if(v==4) punti=punti+12000;
      stampapunti=true;
      temptime=millis()/10;
      tempx=pac.x;
      tempy=pac.y;
      orange.eaten=true;
    } 
    else if(orange.mode!=frightened && orange.mode!=dead){
      if(generalmode==frightened){
        choosemode(tutti);
        frightenedtime=millis()/10;
        timermode=timermode+(millis()/10-frightenedtime);
        scaredsound.stop();
      }
      else siren.stop();
      pac.dead=true;
      fantasma=arancio;
      pac.lives--;
      i=0;
      contatorepallinicasa=contatorepallini;
      contapallinilocali=false;
    }
  }
  if ((pac.square_x==blue.square_x)&&(pac.square_y==blue.square_y)) {
    if (blue.mode==frightened) {
      blue.k=0;
      blue.mode=dead;
      ghosteat.play();
      v++;
      punti=punti+(200*v);
      if(v==4) punti=punti+12000;
      stampapunti=true;
      temptime=millis()/10;
      tempx=pac.x;
      tempy=pac.y;
      blue.eaten=true;
    } 
    else if(blue.mode!=frightened && blue.mode!=dead){
      if(generalmode==frightened){
        choosemode(tutti);
        frightenedtime=millis()/10;
        timermode=timermode+(millis()/10-frightenedtime);
        scaredsound.stop();
      }
      else siren.stop();
      pac.dead=true;
      fantasma=azzurro;
      pac.lives--;
      i=0;
      contatorepallinicasa=contatorepallini;
      contapallinilocali=false;
    }
  }
}
void get_direction() {
  if (keyPressed) {
    if (keyCode==RIGHT) pac.direction= destra;
    else if (keyCode==LEFT) pac.direction= sinistra;
    else if (keyCode==DOWN) pac.direction= giu;
    else if (keyCode==UP) pac.direction= su;
    if (keyCode==RIGHT){
      if(pausa) pausa=false;
      else pausa=true;
    }
  }
}
char[][] matrice_mappa= new char[][]{
  {'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w'}, 
  {'w', 'w', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'w', 'w', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'w', 'w'}, 
  {'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w'}, 
  {'w', 'w', 'C', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'C', 'w', 'w'}, 
  {'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w'}, 
  {'w', 'w', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'w', 'w'}, 
  {'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w'}, 
  {'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w'}, 
  {'w', 'w', 'c', 'c', 'c', 'c', 'c', 'c', 'w', 'w', 'c', 'c', 'c', 'c', 'w', 'w', 'c', 'c', 'c', 'c', 'w', 'w', 'c', 'c', 'c', 'c', 'c', 'c', 'w', 'w'}, 
  {'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'z', 'w', 'w', 'z', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w'}, 
  {'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'z', 'w', 'w', 'z', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w'}, 
  {'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'z', 'z', 'z', 'z', 'z', 'z', 'z', 'z', 'z', 'z', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w'}, 
  {'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'z', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'z', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w'}, 
  {'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'z', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'z', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w'}, 
  {'k', 'a', 'a', 'a', 'a', 'a', 'a', 'c', 'z', 'z', 'z', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'z', 'z', 'z', 'c', 'a', 'a', 'a', 'a', 'a', 'a', 'k'}, 
  {'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'z', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'z', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w'}, 
  {'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'z', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'z', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w'}, 
  {'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'z', 'z', 'z', 'z', 'z', 'z', 'z', 'z', 'z', 'z', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w'}, 
  {'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'z', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'z', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w'}, 
  {'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'z', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'z', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w'}, 
  {'w', 'w', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'w', 'w', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'w', 'w'}, 
  {'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w'}, 
  {'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w'}, 
  {'w', 'w', 'C', 'c', 'c', 'w', 'w', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'z', 'y', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'w', 'w', 'c', 'c', 'C', 'w', 'w'}, 
  {'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w'}, 
  {'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w'}, 
  {'w', 'w', 'c', 'c', 'c', 'c', 'c', 'c', 'w', 'w', 'c', 'c', 'c', 'c', 'w', 'w', 'c', 'c', 'c', 'c', 'w', 'w', 'c', 'c', 'c', 'c', 'c', 'c', 'w', 'w'}, 
  {'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w'}, 
  {'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w'}, 
  {'w', 'w', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'w', 'w'}, 
  {'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w'}};
char[][] matrice_fantasmi= new char[][]{
  {'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w'}, 
  {'w', 'w', 'i', 'c', 'c', 'c', 'c', 'i', 'c', 'c', 'c', 'c', 'c', 'i', 'w', 'w', 'i', 'c', 'c', 'c', 'c', 'c', 'i', 'c', 'c', 'c', 'c', 'i', 'w', 'w'}, 
  {'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w'}, 
  {'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w'}, 
  {'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w'}, 
  {'w', 'w', 'i', 'c', 'c', 'c', 'c', 'i', 'c', 'c', 'i', 'c', 'c', 'i', 'c', 'c', 'i', 'c', 'c', 'i', 'c', 'c', 'i', 'c', 'c', 'c', 'c', 'i', 'w', 'w'}, 
  {'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w'}, 
  {'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w'}, 
  {'w', 'w', 'i', 'c', 'c', 'c', 'c', 'i', 'w', 'w', 'i', 'c', 'c', 'i', 'w', 'w', 'i', 'c', 'c', 'i', 'w', 'w', 'i', 'c', 'c', 'c', 'c', 'i', 'w', 'w'}, 
  {'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w'}, 
  {'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w'}, 
  {'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'i', 'c', 'c', 'z', 'c', 'c', 'z', 'c', 'c', 'i', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w'}, 
  {'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w'}, 
  {'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w'}, 
  {'K', 'a', 'a', 'a', 'a', 'a', 'a', 'i', 'c', 'c', 'i', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'i', 'c', 'c', 'i', 'a', 'a', 'a', 'a', 'a', 'a', 'k'}, 
  {'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w'}, 
  {'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w'}, 
  {'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'i', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'i', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w'}, 
  {'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w'}, 
  {'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w'}, 
  {'w', 'w', 'i', 'c', 'c', 'c', 'c', 'i', 'c', 'c', 'i', 'c', 'c', 'i', 'w', 'w', 'i', 'c', 'c', 'i', 'c', 'c', 'i', 'c', 'c', 'c', 'c', 'i', 'w', 'w'}, 
  {'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w'}, 
  {'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'c', 'w', 'w'}, 
  {'w', 'w', 'i', 'c', 'i', 'w', 'w', 'i', 'c', 'c', 'i', 'c', 'c', 'z', 'c', 'c', 'z', 'c', 'c', 'i', 'c', 'c', 'i', 'w', 'w', 'i', 'c', 'i', 'w', 'w'}, 
  {'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w'}, 
  {'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w'}, 
  {'w', 'w', 'i', 'c', 'i', 'c', 'c', 'i', 'w', 'w', 'i', 'c', 'c', 'i', 'w', 'w', 'i', 'c', 'c', 'i', 'w', 'w', 'i', 'c', 'c', 'i', 'c', 'i', 'w', 'w'}, 
  {'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w'}, 
  {'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w', 'c', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'c', 'w', 'w'}, 
  {'w', 'w', 'i', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'i', 'c', 'c', 'i', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'c', 'i', 'w', 'w'}, 
  {'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w', 'w'}};
void setup() {
  size(600, 700);
  colorMode(RGB, 255, 255, 255);
  pac= new Pacman();
  red= new Red_ghost();
  blue= new Blue_ghost();
  pink= new Pink_ghost();
  orange = new Orange_ghost();
  ottobit = createFont("8bit.TTF", 30);
  map = loadImage("Pacman_Map.jpg");
  for (int i=0; i<6; i++)   pac_image[i]= loadImage("pacman0.png");
  for (int i=6; i<12; i++) pac_image[i]= loadImage("pacman1.png");
  for (int i=12; i<18; i++) pac_image[i]= loadImage("pacman2.png");
  for (int i=18; i<24; i++) pac_image[i]= loadImage("pacman3.png");
  for (int i=24; i<30; i++) pac_image[i]= loadImage("pacman4.png");
  fruits[0]= loadImage("cherry.png");
  fruits[1]= loadImage("strawberry.png");
  fruits[2]= loadImage("peach.png");
  fruits[3]= loadImage("apple.png");
  fruits[4]= loadImage("grapes.png");
  fruits[5]= loadImage("galaxian.png");
  fruits[6]= loadImage("bell.png");
  fruits[7]= loadImage("key.png");
  for(int i=0; i<8;i++) fruits[i].resize(29,29);
  pac_image[30]= loadImage("distruzione1.png");
  pac_image[31]= loadImage("distruzione2.png");
  pac_image[32]= loadImage("distruzione3.png");
  pac_image[33]= loadImage("distruzione4.png");
  pac_image[34]= loadImage("distruzione5.png");
  for (int i=0; i<35; i++) pac_image[i].resize(29,29);
  frightened_image1= loadImage("frightened1.png");
  frightened_white1= loadImage("frightened_white1.png");
  frightened_image2= loadImage("frightened2.png");
  frightened_white2= loadImage("frightened_white2.png");
  sfondolobby= loadImage("sfondolobby2.png");
  sfondowindows = loadImage("sfondolobby.jpg");
  sfondocredits = loadImage("sfondocredits.png");
  sfondogameover = loadImage("sfondogameover.png");
  podio = loadImage("podio1.png");
  pacmantext= loadImage("pacmantext.png");
  gameovertext= loadImage("gameovertext.png");
  occhisu = loadImage("occhisu.png");
  occhigiu = loadImage("occhigiu.png");
  occhisinistra = loadImage("occhisinistra.png");
  occhidestra = loadImage("occhidestra.png");
  ghost1 = loadImage("ghost1.png");
  ghost2 = loadImage("ghost2.png");
  soundtrack= new SoundFile(this, "soundtrack.wav");
  readysound= new SoundFile(this, "ready.wav");
  eat= new SoundFile(this, "waka.wav");
  extralife= new SoundFile(this, "extra_life.wav");
  siren= new SoundFile(this, "siren1.wav");
  death = new SoundFile(this, "death.wav");
  scaredsound = new SoundFile (this, "scaredsound1.wav");
  ghosteat = new SoundFile (this, "ghostdeath.wav");
  fruiteat= new SoundFile (this, "fruit_eat.wav");
  text_select_effect= new SoundFile (this, "text_select_effect.wav");
  text_click_effect= new SoundFile (this, "text_click_effect.wav");
  gameoversound1= new SoundFile (this, "gameoversound1.wav");
  youarealoser= new SoundFile (this, "youarealoser.wav");
  sparkle = new SoundFile (this, "sparkle.wav");
  textFont(ottobit);
  occhisu.resize(27,27);
  occhisinistra.resize(27,27);
  occhidestra.resize(27,27);
  occhigiu.resize(27,27);
  frightened_image1.resize(27,27);
  frightened_image2.resize(27,27);
  frightened_white1.resize(27,27);
  frightened_white2.resize(27,27);
  ghost1.resize(27,27);
  ghost2.resize(27,27);
  podio.resize(200,0);
  punteggi= loadTable("punti.tsv", "header");
  
}
void draw() {
  audio();
  colors();
  if(window==lobby){
    background(sfondolobby);
    if(i==0) soundtrack.loop();
    if (i<90){
      i++;
      imageMode(CENTER);
      translate(width/2, height/2-250);
      scale(0.003*i);
      translate(-width/2, -height/2+250);
      image(pacmantext, 300, 100);
    }
    else{
      fill(r,g,b);
      imageMode(CENTER);
      translate(width/2, height/2-250);
      scale(0.27);
      translate(-width/2, -height/2+250);
      image(pacmantext, 300, 100);
      translate(width/2, height/2-250);
      scale(3.703);
      translate(-width/2, -height/2+250);
      textAlign(CENTER, CENTER);
      if(mouseX>255 && mouseY>246 && mouseX<343 && mouseY<266){
        if(ingrandisci==false) text_select_effect.play();
        textSize(35);
        if(mousePressed){
          window=game;
          noCursor();
          i=0;
          timermode=millis()/10;
          text_click_effect.play();
          soundtrack.stop();
        }
      }
      else textSize(23);
      text("play", 300, 250);
      if(mouseX>225 && mouseY>336 && mouseX<372 && mouseY<355){
        if(ingrandisci==false) text_select_effect.play();
        textSize(35);
        if(mousePressed){
          window=options;
          i=0;
          text_click_effect.play();
        }
      } 
      else textSize(23);
      text("options", 300, 340); 
      if(mouseX>227 && mouseY>425 && mouseX<372 && mouseY<447){
        if(ingrandisci==false) text_select_effect.play();
        textSize(35);
        if(mousePressed){
          window=credits;
          i=0;
          text_click_effect.play();
        }
      }
      else textSize(23);
      text("credits", 300, 430);
      if(mouseX>191 && mouseY>515 && mouseX<408 && mouseY<535){
        if(ingrandisci==false) text_select_effect.play();
        textSize(35);
        if(mousePressed){
          window=topscores;
          i=1;
          text_click_effect.play();
          for (int i=0; i<35; i++) pac_image[i].resize(40,40);
          ghost1.resize(40,40);
          ghost2.resize(40,40);
          occhidestra.resize(40,40);
          pac.direction=destra;
          red.ghost_direction=destra;
          blue.ghost_direction=destra;
        }
      }
      else textSize(23);
      text("top scores", 300, 520);
      if(mouseX>260 && mouseY>605 && mouseX<339 && mouseY<627){
        if(ingrandisci==false) text_select_effect.play();
        textSize(35);
        if(mousePressed){
          text_click_effect.play();
          exit();
        }
      }
      else textSize(23);
      text("exit", 300, 610);
      if(((mouseX>255 && mouseY>246 && mouseX<343 && mouseY<266)||(mouseX>260 && mouseY>605 && mouseX<339 && mouseY<627)||(mouseX>191 && mouseY>515 && mouseX<408 && mouseY<535)||(mouseX>227 && mouseY>425 && mouseX<372 && mouseY<447)||(mouseX>225 && mouseY>336 && mouseX<372 && mouseY<355))&& window!=game){
        ingrandisci=true;
        cursor(HAND);
      }
      else if (window!=game){
        ingrandisci=false;
        cursor(ARROW);
      }
    }
  }
  else if(window==options){
    background(sfondowindows);
    fill(r,g,b);
    if(mouseX>260 && mouseY>60 && mouseX<540 && mouseY<140) trascinavolume=true;
    else trascinavolume=false;
    if(mouseX>85 && mouseY>95 && mouseX<230 && mouseY<115){
      if(ingrandisci==false) text_select_effect.play();
      textSize(35);
      premivolume=true;
    }
    else{
      textSize(23);
      premivolume=false;
    }
    text("volume", 160, 100);
    rect(300,100,180,4);
    rect(xo,yo,10,30);
    if(mouseX>102 && mouseY>196 && mouseX<215 && mouseY<216){
      if(ingrandisci==false) text_select_effect.play();
      textSize(35);
    }
    else textSize(23);
    text("Color", 160, 200);
    translate(385, 200);
    scale(1.2);
    translate(-385, -200);
    tint(chosenr,choseng,chosenb);
    image(pac_image[17], 385,200);
    noTint();
    translate(385, 200);
    scale(1/1.2);
    translate(-385, -200);
    triangle(315,200,345,215,345,185);
    triangle(425,215,425,185,455,200);
    if(mouseX>315 && mouseY>185 && mouseX<345 && mouseY<215) frecciasinistracolore=true;
    else frecciasinistracolore=false;
    if(mouseX>425 && mouseY>185 && mouseX<455 && mouseY<215) frecciadestracolore=true;
    else frecciadestracolore=false;
    if(mouseX>114 && mouseY>295 && mouseX<204 && mouseY<317){
      if(ingrandisci==false) text_select_effect.play();
        textSize(35);
        if(mousePressed){
          text_click_effect.play();
          window=lobby;
          red.mode=scatter;
          pink.mode=home;
          blue.mode=home;
          orange.mode=home;
      }
    }
    else textSize(23);
    text("back", 160, 300);
    if((mouseX>85 && mouseY>95 && mouseX<230 && mouseY<115)||(mouseX>102 && mouseY>196 && mouseX<215 && mouseY<216) || (mouseX>114 && mouseY>295 && mouseX<204 && mouseY<317)){
      ingrandisci=true;
      cursor(HAND);
    }
    else{
      ingrandisci=false;
      cursor(ARROW);
    }
    if(i<500){
      circle(480,500,20);
      pac.direction=destra;
      pac.stampa(-20+i,500);
      red.stampa(-90+i,500);
      pink.stampa(-120+i,500);
      orange.stampa(-150+i,500);
      blue.stampa(-180+i,500);
    }
    else if(i==500){
      red.mode=frightened;
      pink.mode=frightened;
      blue.mode=frightened;
      orange.mode=frightened;
    }
    else if(i<1100){
      pac.direction=sinistra;
      if(i<640)red.stampa(390-((i-500)/2),500);
      if(i<700)pink.stampa(360-((i-500)/2),500);
      if(i<760)orange.stampa(330-((i-500)/2),500);
      if(i<820)blue.stampa(300-((i-500)/2),500);
      pac.stampa(480-(i-500),500);
    }
    else{
      i=0;
      red.mode=scatter;
      pink.mode=scatter;
      blue.mode=scatter;
      orange.mode=scatter;
    }
    i++;
  }
  else if(window==credits){
    background(sfondocredits);
    fill(r,g,b);
    if(mouseX>225 && mouseY>594 && mouseX<371 && mouseY<616){
      textSize(35);
      if(ingrandisci==false){
        text_select_effect.play();
      }
      if(mousePressed){
        window=lobby;
        text_click_effect.play();
        pink.mode=home;
        red.mode=scatter;
        orange.mode=home;
        blue.mode=home;
        i=1;
      }
    }
    else{
      textSize(23);
    }
    text("go back", 300, 600);
    if(mouseX>62 && mouseY>415 && mouseX<534 && mouseY<426){
      if(ingrandisci==false){
        text_select_effect.play();
      }
      link1=true;
    }
    else{
      link1=false;
    }
    if(mouseX>56 && mouseY>458 && mouseX<546 && mouseY<470){
      if(ingrandisci==false){
        text_select_effect.play();
      }
      link2=true;
    }
    else{
      link2=false;
    }
    if(mouseX>54 && mouseY>506 && mouseX<549 && mouseY<518){
      if(ingrandisci==false){
        text_select_effect.play();
      }
      link3=true;
    }
    else{
      link3=false;
    }
    if((mouseX>225 && mouseY>594 && mouseX<371 && mouseY<616)||(mouseX>54 && mouseY>506 && mouseX<549 && mouseY<518)||(mouseX>56 && mouseY>458 && mouseX<546 && mouseY<470)||(mouseX>62 && mouseY>415 && mouseX<534 && mouseY<426)){
      cursor(HAND);
      ingrandisci=true;
    }
    else{
      cursor(ARROW);
      ingrandisci=false;
    }
    if(i<620){
      circle(520,600,20);
      if(i<180){
        pac.direction=destra;
        pac.stampa(-20+i,600);
      }
      else if(i<220){
        pac.direction=giu;
        pac.stampa(160,600+(i-180));
      }
      else if(i<500){
        pac.direction=destra;
        pac.stampa(160+(i-220),640);
      }
      else if(i<540){
        pac.stampa(440,640-(i-500));
        pac.direction=su;
      }
      else{
        pac.direction=destra;
        pac.stampa(440+(i-540),600);
      }
      if(i<250) red.stampa(-90+i,600);
      else if(i<290) red.stampa(160,600+(i-250));
      else if(i<570) red.stampa(160+(i-290),640);
      else if(i<610) red.stampa(440,640-(i-570));
      else red.stampa(440+(i-610),600);
      if(i<280) pink.stampa(-120+i,600);
      else if(i<320) pink.stampa(160,600+(i-280));
      else if(i<600) pink.stampa(160+(i-320),640);
      else if(i<640) pink.stampa(440,640-(i-600));
      else pink.stampa(440+(i-640),600);
      if(i<310) orange.stampa(-150+i,600);
      else if(i<350) orange.stampa(160,600+(i-310));
      else if(i<630) orange.stampa(160+(i-350),640);
      else if(i<670) orange.stampa(440,640-(i-630));
      else orange.stampa(440+(i-670),600);
      if(i<340) blue.stampa(-180+i,600);
      else if(i<380) blue.stampa(160,600+(i-340));
      else if(i<660) blue.stampa(160+(i-380),640);
      else if(i<700) blue.stampa(440,640-(i-660));
      else blue.stampa(440+(i-700),600);
    }
    else if(i==620){
      red.mode=frightened;
      pink.mode=frightened;
      blue.mode=frightened;
      orange.mode=frightened;
    }
    else if(i<1240){
      if(i<640) red.stampa(450-((i-620)/2),600);
      else if(i<720) red.stampa(440,600+((i-640)/2));
      else if(i<740) red.stampa(440-((i-720)/2),640);
      if(i<660) pink.stampa(440,620+((i-620)/2));
      else if(i<800) pink.stampa(440-((i-660)/2),640);
      if(i<860) orange.stampa(430-((i-620)/2),640);
      if(i<920) blue.stampa(400-((i-620)/2),640);
      if(i<700){
        pac.direction=sinistra;
        pac.stampa(520-(i-620),600);
      }
      else if(i<740){
        pac.direction=giu;
        pac.stampa(440,600+(i-700));
      }
      else if(i<1020){
        pac.direction=sinistra;
        pac.stampa(440-(i-740),640);
      }
      else if(i<1060){
        pac.stampa(160,640-(i-1020));
        pac.direction=su;
      }
      else{
        pac.direction=sinistra;
        pac.stampa(160-(i-1060),600);
      }
    }
    else{
      i=0;
      red.mode=scatter;
      pink.mode=scatter;
      blue.mode=scatter;
      orange.mode=scatter;
    }
    i++;
  }
  else if(window==topscores){
    background(sfondowindows);
    if(i==1 && topscoresingame){
      if(loser)youarealoser.play();
      else sparkle.play();
      i++;
    }
    fill(r,g,b);
    textSize(23);
    text("Names",150,60);
    text("Scores",450,60);
    for(int i=0; i<10; i++){
      if(i==posnome && topscoresingame) fill(r,g,b);
      else if(i==0 || i==4 || i==8) fill(red.colore[0],red.colore[1],red.colore[2]);
      else if(i==1 || i==5 || i==9) fill(pink.colore[0],pink.colore[1],pink.colore[2]);
      else if(i==2 || i==6) fill(blue.colore[0],blue.colore[1],blue.colore[2]);
      else if(i==3 || i==7) fill(orange.colore[0],orange.colore[1],orange.colore[2]);
      if((punteggi.getInt(i,"score"))!=0)text(punteggi.getString(i,"name"), 150, 160+i*30);
      if((punteggi.getInt(i,"score"))!=0)text(punteggi.getInt(i,"score"),450, 160+i*30);
    }
    fill(r,g,b);
    imageMode(CENTER);
    image(podio,400,600);
    pac.stampa(400,515);
    red.stampa(330,560);
    blue.stampa(470,575);
    if((mouseX>103 && mouseY>594 && mouseX<195 && mouseY<616 && !topscoresingame) ||(mouseX>103 && mouseY>583 && mouseX<195 && mouseY<604 && topscoresingame) ){
      cursor(HAND);
      textSize(35);
      if(ingrandisci==false){
        text_select_effect.play();
        ingrandisci=true;
      }
      if(mousePressed){
        if (!topscoresingame){
          window=lobby;
          i=1;
        }
        else{
          topscoresingame=false;
          window=game_over;
          i=0;
        }
        text_click_effect.play();
        for (int i=0; i<35; i++) pac_image[i].resize(29,29);
        ghost1.resize(29,29);
        ghost2.resize(29,29);
        occhidestra.resize(29,29);
        pac.direction=sinistra;
        red.ghost_direction=sinistra;
        blue.ghost_direction=sinistra;
      }  
    }
    else{
      cursor(ARROW);
      textSize(23);
      ingrandisci=false;
    }
    if(!topscoresingame) text("back",150,600);
    else{
      text("next",150,600);
      textSize(23);
      if(posnome<10) text("sei arrivato "+ (posnome+1), 300,100);
      else text("non sei nella top 10",300,100);
    }
  }
  else if(window==setscore){
    background(sfondowindows);
    fill(r,g,b);
    textAlign(CENTER);
    text(name, 300, 200);
    text("Enter your Name", 300, 100);
    if(keyCode!=ENTER){
      if(keyPressed){
        if(key==BACKSPACE){
          if(name.length()>=1)
          name = name.substring(0,name.length()-1);
            keyPressed=false;
          }
          else if(name.length()<=10){
            name+=key;
            keyPressed=false;
          }
        }
    }
    else{
      name=name.substring(0,name.length()-1);
      if(old_score>punteggi.getInt(9,"score")){
        loser=false;
        punteggi.setInt(9,"score", old_score);
        punteggi.setString(9,"name", name);
        for(int i=0;i<punteggi.getRowCount();i++){
            max=punteggi.getInt(i,"score");
            max_nome=punteggi.getString(i,"name");
            for(int j=i;j<punteggi.getRowCount();j++){
                if(max<=punteggi.getInt(j,"score")){
                    max=punteggi.getInt(j,"score");
                    max_nome=punteggi.getString(j,"name");
                    pos=j;
                    check=true;
                }
            }
            if(check==true){
              temp=punteggi.getInt(i,"score");
              punteggi.setInt(i,"score",max);
              punteggi.setInt(pos,"score",temp);
              nome_temp=punteggi.getString(i,"name");
              punteggi.setString(i,"name", max_nome);
              punteggi.setString(pos,"name",nome_temp);
              if(old_score==max) posnome=i;
            }
            check=false;
        }
      }
      else{
        loser=true;
        posnome=15;
      }
      saveTable(punteggi, "punti.tsv");
      name="";
      topscoresingame=true;
      window=topscores;
      for (int i=0; i<35; i++) pac_image[i].resize(40,40);
      ghost1.resize(40,40);
      ghost2.resize(40,40);
      occhidestra.resize(40,40);
      pac.direction=destra;
      red.ghost_direction=destra;
      blue.ghost_direction=destra;
      i=1;
    }
  }
  else if(window==game){
    background(map);
    setspeed();
    elroy();
    if((contatorepallini==70 || contatorepallini==170)){
      if(!eatenfruit) frutta=true;
      eatenfruit=true;
    }
    else eatenfruit=false;
    if(frutta) fruit();
    if(generalmode!=frightened) choosemode(tutti);
    else frightenedmode();
    stampavite();
    if(stampapunti && (time-temptime<200)){
      textSize(10);
      text(v*200, tempx-5,tempy-5);
      if(v==4) text(12000, tempx+40,tempy-5);
    }
    if(punti-contatorepuntivite>=10000){
      contatorepuntivite=punti-(punti%10000);
      pac.lives++;
      extralife.play();
    }
    textSize(35);
    textFont(ottobit);
    textAlign(LEFT, LEFT);
    text(stage, 150, 35);
    text(punti, 360, 35);
    time=millis()/10;
    stampa_pallini();
    if(ready){
      if(i==0){
        if(playmusic){
          readysound.play();
          playmusic=false;
        }
        i++;
        timerready=millis()/10;
        siren.stop();
        scaredsound.stop();
      }
      else if(time-timerready<450){
        textSize(20);
        if(z<15) fill(255, 255, 255);
        else fill(chosenr,choseng,chosenb);
        text("Get ready", 220, 397);
        textSize(35);
        z++;
        blue.stampa(blue.x, blue.y);
        pink.stampa(pink.x, pink.y);
        red.stampa(red.x, red.y);
        pac.stampa(pac.x, pac.y);
        orange.stampa(orange.x, orange.y);
        if(z>30) z=0;
      }
      else{
        ready=false;
        i=0;
        timertrapallini=millis()/10;
        timermode=timermode+(time-timerready);
        siren.loop();
      }
    }
    else if (contatorepallini==244){ //progressione livelli
      siren.stop();
      scaredsound.stop();
      if(time-timertrapallini<=100){
        blue.stampa(blue.x, blue.y);
        pink.stampa(pink.x, pink.y);
        red.stampa(red.x, red.y);
        orange.stampa(orange.x, orange.y);
      }
      else if (time-timertrapallini<=600){
        blue.stampa(blue.x, blue.y);
        pink.stampa(pink.x, pink.y);
        red.stampa(red.x, red.y);
        orange.stampa(orange.x, orange.y);
        textSize(20);
        if(z<15) fill(255, 255, 255);
        else fill(255,0,0);
        text("Good job", 225, 397);
        textSize(35);
        z++;
        if(z>30) z=0;
      }
      else{
        stage++;
        for (int i=0; i<30; i++) {
          for (int j=0; j<31; j++) {
            if (matrice_mappa[j][i]=='e') matrice_mappa[j][i]='c';
            if (matrice_mappa[j][i]=='E') matrice_mappa[j][i]='C';
          }
        }
        ready=true;
        vita_temp=pac.lives;
        timertrapallini=millis()/10;
        timermode=millis()/10;
        frutta=false;
        pac= new Pacman();
        red= new Red_ghost();
        blue= new Blue_ghost();
        pink= new Pink_ghost();
        orange = new Orange_ghost();
        contatorepallini=0;
        contapallinilocali=true;
        pac.lives=vita_temp;
        elroy1=false;
        elroy2=false;
        i=0;
        playmusic=true;
      }
    }
    else if(pac.dead) { //morte
      if(i==0){
        timerdead=millis()/10;
        siren.stop();
      }
      if (fantasma!=rosa)
        pink.stampa(pink.x, pink.y);
      if (fantasma!=azzurro)
        blue.stampa(blue.x, blue.y);
      if (fantasma!=rosso)
        red.stampa(red.x, red.y);
      if (fantasma!=arancio)
        orange.stampa(orange.x, orange.y);
      if(i==80) death.play();
      if(i<70){
        pac.stampa(pac.x,pac.y);
      }
      else if(i<151){
        if(generalmode==frightened) fill(r,g,b);
        else fill(chosenr,choseng,chosenb);
        circle(pac.x,pac.y,29);
        fill(0,0,0);
        arc(pac.x, pac.y, 29, 29, radians(270-(((i/7)-10))*15), radians(270+(((i/7)-10))*15), PIE);
      }
      else if(i<158){
        imageMode(CENTER);
        if(generalmode==frightened) tint(r,g,b);
        else tint(chosenr,choseng,chosenb);
        image(pac_image[30],pac.x,pac.y);
        noTint();
      }
      else if(i<165){
        if(generalmode==frightened) tint(r,g,b);
        else tint(chosenr,choseng,chosenb);
        imageMode(CENTER);
        image(pac_image[31],pac.x,pac.y);
        noTint();
      }
      else if(i<172){
        if(generalmode==frightened) tint(r,g,b);
        else tint(chosenr,choseng,chosenb);
        imageMode(CENTER);
        image(pac_image[32],pac.x,pac.y);
        noTint();
      }
      else if(i<179){
        if(generalmode==frightened) tint(r,g,b);
        else tint(chosenr,choseng,chosenb);
        imageMode(CENTER);
        image(pac_image[33],pac.x,pac.y);
        noTint();
      }
      else if(i<186){
        if(generalmode==frightened) tint(r,g,b);
        else tint(chosenr,choseng,chosenb);
        imageMode(CENTER);
        image(pac_image[34],pac.x,pac.y);
        noTint();
      }
      else{
        vita_temp=pac.lives;
        pac= new Pacman();
        pac.lives=vita_temp;
        red= new Red_ghost();
        blue= new Blue_ghost();
        pink= new Pink_ghost();
        orange = new Orange_ghost();
        if(pac.lives!=0){
          red.stampa(red.x, red.y);
          pink.stampa(pink.x, pink.y);
          orange.stampa(orange.x, orange.y);
          blue.stampa(blue.x, blue.y);
          pac.stampa(pac.x, pac.y);
          ready=true;
          timermode=timermode+(time-timerdead);
        }
        else{
          gameover=true;
          timergameover=millis()/10;
          pac.dead=false;
          for (int i=0; i<30; i++) {
            for (int j=0; j<31; j++) {
              if (matrice_mappa[j][i]=='e') matrice_mappa[j][i]='c';
              if (matrice_mappa[j][i]=='E') matrice_mappa[j][i]='C';
            }
          }
          contatorepallini=0;
        }
      }
      i++;
      if(i>186) i=0;
    }
    else if(gameover){
      if(time-timergameover<300){
        textSize(20);
        if(z<15) fill(255, 255, 255);
        else fill(255,0,0);
        text("Game Over", 215, 397);
        textSize(35);
        z++;
        if(z>30) z=0;
      }
      else{
        gameover=false;
        window=setscore;
        old_score=punti;
        pac.lives=3;
        stage=1;
        punti=0;
      }
    }
    else{ //movimento ordinario
    get_direction();
    pac.movimento();
    red.movimento();
    pink.movimento();
    blue.movimento();
    orange.movimento();
    verifica_stessa_casella();
    } 
  }
  else if(window==game_over){
    background(sfondogameover);
    fill(r,g,b);
    if(i==0){
      gameoversound1.play();
      textAlign(CENTER,CENTER);
      ghost1.resize(50,50);
      ghost2.resize(50,50);
      occhidestra.resize(50,50);
      occhisinistra.resize(50,50);
      playsoundtrack=true;
    }
    if(i==200 && playsoundtrack) soundtrack.play();
    if (i<90){
      imageMode(CENTER);
      translate(width/2, height/2-250);
      scale(0.012*i);
      translate(-width/2, -height/2+250);
      image(gameovertext, 300, 100);
    }
    else{
      imageMode(CENTER);
      translate(width/2, height/2-250);
      scale(0.012*90);
      translate(-width/2, -height/2+250);
      image(gameovertext, 300, 100);
      scale(1/(0.012*90));
      if(mouseX>65 && mouseY>287 && mouseX<385 && mouseY<309){
        if(ingrandisci==false) text_select_effect.play();
        textSize(30);
        if(mousePressed){
          window=lobby;
          i=1;
          text_click_effect.play();
          ready=true;
          red.ghost_direction=sinistra;
          orange.ghost_direction=sinistra;
          ghost1.resize(29,29);
          ghost2.resize(29,29);
          occhidestra.resize(29,29);
          occhisinistra.resize(29,29);
          playmusic=true;
        }
      }
      else textSize(23);
      text("return to lobby", 250, 300);
      if(mouseX>122 && mouseY>387 && mouseX<328 && mouseY<407){
        if(ingrandisci==false) text_select_effect.play();
        textSize(30);
        if(mousePressed){
          window=game;
          i=-1;
          text_click_effect.play();
          soundtrack.stop();
          ready=true;
          timermode=millis()/10;
          red.ghost_direction=sinistra;
          orange.ghost_direction=sinistra;
          noCursor();
          ghost1.resize(29,29);
          ghost2.resize(29,29);
          occhidestra.resize(29,29);
          occhisinistra.resize(29,29);
          playmusic=true;
        }
      }
      else textSize(23);
      text("play again", 250, 400);
      if(mouseX>186 && mouseY>488 && mouseX<265 && mouseY<508){
        if(ingrandisci==false) text_select_effect.play();
        textSize(30);
        if(mousePressed){
          text_click_effect.play();
          exit();
        }
      }
      else textSize(23);
      text("exit", 250, 500);
      if((mouseX>65 && mouseY>287 && mouseX<385 && mouseY<309) || (mouseX>122 && mouseY>387 && mouseX<328 && mouseY<407) || (mouseX>186 && mouseY>488 && mouseX<265 && mouseY<508)){
        ingrandisci=true;
        if(window!=game) cursor(HAND);
      }
      else{
        ingrandisci=false;
        cursor(ARROW);
      }
      if(i<230){
        pac.direction=destra;
        pac.stampa(((i-90)*5), 600);
        red.ghost_direction=destra;
        red.stampa(-70+((i-90)*5),600);
      }
      else if(i<370){
        pac.direction=sinistra;
        pac.stampa(600-((i-230)*5), 600);
        blue.ghost_direction=sinistra;
        blue.stampa(670-((i-230)*5),600);
      }
      else if(i<510){
        pac.direction=destra;
        pac.stampa(((i-370)*5), 600);
        orange.ghost_direction=destra;
        orange.stampa(-70+((i-370)*5),600);
      }
      else if(i<650){
        pac.direction=sinistra;
        pac.stampa(600-((i-510)*5), 600);
        pink.ghost_direction=sinistra;
        pink.stampa(670-((i-510)*5),600);
      }
      else{
        i=90;
        playsoundtrack=false;
      }
    }
    i++;
  }

}
