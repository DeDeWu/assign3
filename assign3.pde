//You should implement your assign3 here.

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_WIN = 2;
final int GAME_OVER = 3;
final int ONE_MOVE = 1;
final int TWO_MOVE = 2;
final int THREE_MOVE = 3;
int gameState;
int enemyMove=ONE_MOVE;

PImage start1, start2;
PImage ship, enemy, hp, treasure, bg1, bg2;
PImage end1, end2;
int treasureX,treasureY, back1X, back2X, hpX;
float spacingX = 70,spacingY = 50,spacingZ = 60;
float enemyX=-400,enemyY1= floor(random(440)),enemyY2=250,enemyY3=180;

float shipX, shipY;
float speed = 5;
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

// boolean isPlaying = false;

void setup () {
  size(640, 480);
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");

  gameState = GAME_START;
  
  shipX = 580;
  shipY = 240;
  treasureX = floor(random(600));
  treasureY = floor(random(440));
  back1X = 0;
  back2X = 640;
  hpX = 40;
  ship = loadImage("img/fighter.png");
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  enemy = loadImage("img/enemy.png");
  hp = loadImage("img/hp.png");
  treasure = loadImage("img/treasure.png");
  
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
}

void draw() {

  // rect(209,380,240,30);
  switch (gameState){
    case GAME_START:
      image(start2,0,0);
      if (mouseX >= 209 && mouseY >= 380){
        if (mouseX <= 450 && mouseY <= 410){
          image(start1,0,0);
          if (mousePressed){
            gameState = GAME_RUN;
          }
        } 
      }
      break;
    case GAME_RUN:
      // isPlaying = !isPlaying;
      if (upPressed) {
        shipY -= speed;
      }
      if (downPressed) {
        shipY += speed;
      }
      if (leftPressed) {
        shipX -= speed;
      }
      if (rightPressed) {
        shipX += speed;
      }
      if (shipX > 590){
        shipX = 590;
      }
      if (shipX < 0){
        shipX = 0;
      }
      if (shipY > 430){
        shipY = 430;
      }
      if (shipY < 0){
        shipY = 0;
      } 

      image(bg1,back1X,0);
      image(bg2,back2X,0);
      image(ship,shipX,shipY);
      image(treasure,treasureX,treasureY);
      //image(enemy,enemyX,enemyY);
      
      fill(255,0,0);
      rect(20,0,hpX,20);
      image(hp,10,0);
      
      //enemy place
      //five enemys on line
      enemyX += 3;
      enemyX %=width;
      switch(enemyMove){
      case ONE_MOVE:
        for (int i=0; i<5; i++){
          image(enemy, enemyX+i*spacingX,enemyY1);
        if(enemyX>637){          
          enemyMove=TWO_MOVE;
        }
       }
       break;
       
      case TWO_MOVE:
       for(int j=0;j<5;j++){
          image(enemy, enemyX+j*spacingY,enemyY2-j*spacingY);
       if(enemyX>636){
          enemyMove=THREE_MOVE;
         }
       }
       break;
      
       case THREE_MOVE:
        for(int k=0;k<3;k++){
          image(enemy, enemyX+k*spacingZ,enemyY3-k*spacingX);
          image(enemy, enemyX+k*spacingZ,enemyY3+k*spacingX);
          image(enemy, enemyX+(4-k)*spacingZ,enemyY3-k*spacingX);
          image(enemy, enemyX+(4-k)*spacingZ,enemyY3+k*spacingX);
        if(enemyX>588){
          enemyX += 1;
          if(enemyX >=637){
            enemyMove=ONE_MOVE;
            enemyY1= floor(random(440));
          }
         }
         }
        break;
          
      }
      
      //enemy go to ship
      /*if (shipY > enemyY){
        enemyY+=2;
      } else {
        enemyY-=2;
      }*/
      
      //background
      back1X -= 1;
      back2X -= 1;
      if(back1X == -640){
        back1X = 640;
      }
      if(back2X == -640){
        back2X = 640;
      }      
      
      //hit enemy
      /*if (enemyX <= shipX && enemyX+60 >= shipX){         
         if(enemyY <= shipY+45 && enemyY+60 >= shipY+45){
           hpX-=40;
           enemyX=0;
        }
      }
      if (enemyX <= shipX && enemyX+60 >= shipX){  
        if(enemyY <= shipY && enemyY+60 >= shipY){
          hpX-=40;
          enemyX=0;
        }
      }
      if (enemyX <= shipX+45 && enemyX+60 >= shipX+45){  
        if(enemyY <= shipY+45 && enemyY+60 >= shipY+45){
          hpX-=40;
          enemyX=0;
        }
      }
      if (enemyX <= shipX+45 && enemyX+60 >= shipX+45){ 
        if(enemyY <= shipY && enemyY+60 >= shipY){
          hpX-=40;
          enemyX=0;
        }
      }
      
      //eat treasure
      if (treasureX <= shipX && treasureX+40 >= shipX){  
         if(treasureY <= shipY+45 && treasureY+40 >= shipY+45){
          hpX += 20;
          treasureX = floor(random(600));
          treasureY = floor(random(440));
          image(treasure,treasureX,treasureY);
        }
      }
      if (treasureX <= shipX && treasureX+40 >= shipX){  
         if(treasureY <= shipY && treasureY+40 >= shipY){
          hpX += 20;
          treasureX = floor(random(600));
          treasureY = floor(random(440));
          image(treasure,treasureX,treasureY);
        }
      }
      if (treasureX <= shipX+50 && treasureX+40 >= shipX+50){  //right
        if(treasureY <= shipY+50 && treasureY+40 >= shipY+50){
          hpX += 20;
          treasureX = floor(random(600));
          treasureY = floor(random(440));
          image(treasure,treasureX,treasureY);
        }
      }
      if (treasureX <= shipX+50 && treasureX+40 >= shipX+50){  //bown
        if(treasureY <= shipY && treasureY+40 >= shipY){
          hpX += 20;
          treasureX = floor(random(600));
          treasureY = floor(random(440));
          image(treasure,treasureX,treasureY);
        }
      }*/
      if (hpX<=0){
        gameState = GAME_OVER;
      }
      if (hpX>194){
        hpX=194; 
      }
      
      break;
    // case GAME_WIN:
      // do something
      // break;
    case GAME_OVER:
      image(end2,0,0);
     // rect(209,315,215,30);
      if (mouseX >= 209 && mouseY >= 315){
        if (mouseX <= 425 && mouseY <= 345){
          image(end1,0,0);
          if (mousePressed){
            shipX = 580;
            shipY = 240;
            enemyX = 0;
            //enemyY = floor(random(440));
            treasureX = floor(random(600));
            treasureY = floor(random(440));
            hpX = 40;
            gameState = GAME_RUN;
          }
        } 
      }
      break;
    }

}
 void keyPressed(){
  /*  if (key == CODED){
    println(keyCode);
  }*/
  
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
