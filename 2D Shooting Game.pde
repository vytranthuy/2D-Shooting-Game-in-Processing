float xEnemy = width/80;
float yEnemy = height/10;

float[][] enemyPos = new float[5][2];
float[] enemyMove = new float[5];

float[][][] bullet = new float[100][5][2];
boolean shooting = false;
int press = 0;
int diaBullet = 10;
boolean[] enemyAppear = new boolean[5];

float xChar = 400;

float yBullet = 200/1.15;


void setup() {
  size(800, 200);

  //enemy
  for (int i = 0; i < 5; i++) {
    enemyPos[i][0] = width/80;  //xPos
    enemyPos[i][1] = height/20; //yPos
    enemyAppear[i] = true;
    enemyMove[i] = random (1, 6);
  }
}


void draw() {
  background(0);

  character();
  drawEnemy();

  displayBullet();

  for (int i = 0; i < 5; i++) {
    if (enemyPos [i][0] < 0) {

      //display text "Game Over"
      background(#F27A58);
      fill(#1F0606);
      textSize(60);
      textAlign(CENTER);
      text("Oh no! You lose :(", width/2, height/2);
    }

    //display text "Game Won"
    if (enemyAppear[0] == false && enemyAppear[1] == false && enemyAppear[2] == false && enemyAppear[3] == false && enemyAppear[4] == false) {
      background(#FFF381);
      fill(#1F1506);
      textSize(60);
      textAlign(CENTER);
      text("Congrats! You did it!", width/2, height/2);
    }
  }
}

// character design
void character() {
  fill(255, 0, 0);
  ellipse(xChar, height, width/10, width/10);
  noStroke();
  fill(255);
  circle(xChar-9, 180, width/40);
  circle(xChar+9, 180, width/40);
  fill(0);
  circle(xChar-9, 179, width/60);
  circle(xChar+9, 179, width/60);
  rect(xChar-4, 192, width/100, height/60);
}

void keyPressed() {
  if (keyCode == RIGHT) {
    if (xChar+width/20 < width) {
      xChar += 20;
    } else {
      xChar += 0;
    }
  }
  if (keyCode == LEFT) {
    if (xChar-width/20 >0 ) {
      xChar -= 20;
    } else {
      xChar += 0;
    }
  }
}


void mousePressed() {

  //bullet position
  for (int k = 0; k < bullet[press].length; k++) {
    bullet[press][k][0] = xChar - 15 + k*8;
    bullet[press][k][1] = yBullet;
  }
  press++;

  stroke(255, 0, 0);
  noFill();
  circle(mouseX, mouseY, 50);
}

//enemy
void drawEnemy() {
  boolean enemyWay = true;
  for (int i = 0; i < 5; i++) {
    if (enemyAppear[i]) {
      
      //enemyMoving
      if (enemyPos[i][0] > width) {
        enemyWay = false;
      } else if (enemyPos[i][0] < width || enemyPos[i][0] >= width/80) {
        enemyWay = true;
      }

      //enemy design
      fill(0, 255, 0);
      ellipse(enemyPos[i][0], enemyPos[i][1], width/40, height/10);
      noStroke();
      fill(255);
      circle(enemyPos[i][0]-3, height/25, width/80);
      circle(enemyPos[i][0]+3, height/25, width/80);
      fill(0, 40, 40);

      //eyes
      fill(0);
      circle(enemyPos[i][0]-3, height/25-1, width/110);
      circle(enemyPos[i][0]+3, height/25-1, width/110);

      //nose
      triangle(enemyPos[i][0], enemyPos[i][1], enemyPos[i][0]-3, enemyPos[i][1]+3, enemyPos[i][0]+3, enemyPos[i][1]+3);


      if (enemyWay == true) {
        enemyPos[i][0] += enemyMove[i];
      } else {
        enemyMove[i] *= -1;
        enemyPos[i][0] +=  enemyMove[i];
      }
    }

    //enemy with bullet
    collision();
  }
}


void displayBullet() {
  for (int k = 0; k < bullet.length; k++) {
    for (int i = 0; i < bullet[k].length; i++) {
      fill(255);
      ellipse(bullet[k][i][0], bullet[k][i][1], diaBullet, diaBullet);
      bullet[k][i][1] -= 2;
      bullet[k][0][0] -= 0.15;
      bullet[k][1][0] -= 0.075;
      bullet[k][3][0] += 0.075;
      bullet[k][4][0] += 0.15;
    }
  }
}

//check collision
void collision() {
  for (int i = 0; i < 5; i++) {
    for (int k = 0; k < press; k++) {
      for (int j = 0; j < bullet[k].length; j++) {
        float d = dist(enemyPos[i][0], enemyPos[i][1], bullet[k][j][0], bullet[k][j][1]);
        if (d <= 15) {
          enemyAppear[i] = false;
        }
      }
    }
  }
}
