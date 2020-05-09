int gseq = -1;
int virus_num = 100;
int virusD = 20;
int virusStepXs[] = new int[virus_num];
int virusStepYs[] = new int[virus_num];
int virus[] = new int[virus_num];
int virusXs[] = new int[virus_num];
int virusYs[] = new int[virus_num];
int virusCols[] = new int[virus_num];
int time = 0;

int selectBtnW = 200;
int selectBtnH = 100;
int selectBtnY = 350;
int[] selectBtnXs = {75, 400, 725};
int[] selectBtnCol = {color(255), color(255), color(255)};
int[] population = {20, 50, 100};
int startBtnX = 350;
int startBtnY = 550;
int startBtnW = 300;
int startBtnH = 150;
boolean select = false;
boolean selectText= false;
int[] populationCol = {color(0), color(0), color(0)};

void setup() {
  size(1000, 800);
  noStroke();
  frameRate(60);
  gameInit();
}

void draw() {
  background(0);
  if (gseq==-1) {
    startDisp();
  } else if (gseq==0) {
    gamePlay();
  } else if (gseq==1) {
    gameOver();
  } else if (gseq==2) {
    gameComplete();
  } else if (gseq==3) {
    selectLevel();
  }
}

void gameInit() {
  for (int i = 0; i < virus_num; i++) {
    boolean flag = false;
    while (flag==false) {
      flag = true;
      virusXs[i]=int(random(virusD/2+1, width-virusD/2));
      virusYs[i]=int(random(virusD/2+1, height-virusD/2));
      for (int j = 0; j < i; j++) {
        if (abs(virusXs[i]-virusXs[j]) <= virusD+10 && abs(virusYs[i]-virusYs[j]) <= virusD+10) {
          flag = false;
        }
      }
    }

    virusStepXs[i] = 1;
    virusStepYs[i] = 1;
    if (i%4==1) {
      virusStepXs[i] *= -1;
    } else if (i%4==2) {
      virusStepYs[i] *= -1;
    } else if (i%4==3) {
      virusStepXs[i] *= -1;
      virusStepYs[i] *= -1;
    }
    virusCols[i] = color(0, 0, 255);
  }
  virusCols[0] = color(255, 0, 0);
}

void startDisp() {
  background(0, 0, 0);
  textSize(70);
  fill(255, 0, 0);
  text("prevent spread of virus !!", 100, height/2-100);
  time++;
  if (time%60 < 40) {
    fill(255);
    textSize(50);
    text("click to start", 350, 500);
  }
}

void selectLevel() {
  time++;
  background(0);
  fill(255);
  textSize(70);
  if (time%60 < 40) {
    text("select population!", 200, 200);
  }


  fill(selectBtnCol[0]);
  rect(selectBtnXs[0], selectBtnY, selectBtnW, selectBtnH);
  textSize(60);
  fill(populationCol[0]);
  text("20", selectBtnXs[0]+60, 425);
  fill(selectBtnCol[1]);
  rect(selectBtnXs[1], selectBtnY, selectBtnW, selectBtnH);
  fill(populationCol[0]);
  text("50", selectBtnXs[1]+60, 425);
  fill(selectBtnCol[2]);
  rect(selectBtnXs[2], selectBtnY, selectBtnW, selectBtnH);
  fill(populationCol[2]);
  text("100", selectBtnXs[2]+50, 425);

  fill(255, 255, 0);
  rect(startBtnX, startBtnY, startBtnW, startBtnH);
  textSize(80);
  fill(0);
  text("Start", startBtnX+60, startBtnY+100);
  if (time%60 < 40 && selectText) {
    fill(255, 0, 0);
    textSize(50);
    text("select Level", 370, 530);
  }
}


void gamePlay() {
  background(180, 250, 250);
  virusMove();
  gameJudge();
}

void gameOver() {
  background(0);
  fill(10, 230, 20);
  textSize(80);
  text("GAME OVER", 300, 400);
  time++;
  if (time%60 < 40) {
    fill(250, 250, 0);
    textSize(50);
    text("click to retry", 350, 500);
  }
}


void gameComplete() {
  background(0);
  fill(250, 250, 0);
  textSize(90);
  text("GAME CLEAR!", 230, 350);
  time++;
  if (time%60 < 40) {
    fill(250);
    textSize(50);
    text("click to retry", 350, 500);
  }
}


void virusMove() {
  for (int i = 0; i < virus_num; i++) {
    fill(virusCols[i]);
    ellipse(virusXs[i], virusYs[i], virusD, virusD);
  }

  for (int i= 0; i < virus_num; i++) {    
    if (virusXs[i] <= virusD/2 || virusXs[i] >= width-virusD/2) {
      virusStepXs[i] *= -1;
    }
    if (virusYs[i] <= virusD/2 || virusYs[i] >= height-virusD/2) {
      virusStepYs[i] *= -1;
    }

    for (int j = 0; j < i; j++) {
      if (abs(virusXs[i]-virusXs[j]) <= virusD && abs(virusYs[i]-virusYs[j]) <= virusD) {
        /*
        if (i%4==1) {
         virusStepXs[i] *= -1;
         } else if (i%4==2) {
         virusStepYs[i] *= -1;
         } else if (i%4==3) {
         virusStepXs[i] *= -1;
         virusStepYs[i] *= -1;
         }*/
        if (virusCols[j] == color(255, 0, 0)) {
          virusCols[i] = color(255, 0, 0);
        }
      }
    }
    for (int j = i+1; j < virus_num; j++) {
      if (abs(virusXs[i]-virusXs[j]) <= virusD && abs(virusYs[i]-virusYs[j]) <= virusD) {
        /*if (i%4==1) {
         virusStepXs[i] *= -1;
         } else if (i%4==2) {
         virusStepYs[i] *= -1;
         } else if (i%4==3) {
         virusStepXs[i] *= -1;
         virusStepYs[i] *= -1;
         }*/
        if (virusCols[j] == color(255, 0, 0)) {
          virusCols[i] = color(255, 0, 0);
        }
      }
    }
    virusXs[i] += virusStepXs[i];
    virusYs[i] += virusStepYs[i];
  }
}

void gameJudge() {
  boolean lose = false;
  boolean win = false;
  for (int i = 0; i<virus_num; i++) {
    if (virusCols[i]==color(0, 0, 255)) {
      lose = true;
    }
    if (virusCols[i]==color(255, 0, 0)) {
      win = true;
    }
  }
  if (lose==false) {
    gseq=1;
  }
  if (win==false) {
    gseq=2;
  }
}



void mousePressed() {
  if (gseq==-1) {
    gseq=3;
  }

  if (gseq==3) {
    //select button
    for (int i = 0; i < 3; i++) {
      if (selectBtnXs[i] <= mouseX && mouseX < selectBtnXs[i]+selectBtnW && selectBtnY <= mouseY && mouseY < selectBtnY+selectBtnH) {
        virus_num = population[i];
        populationCol[i] = color(255);
        selectBtnCol[i] = color(0, 0, 255);
        populationCol[i] = color(0);
        for (int j = 0; j < i; j++) {
          selectBtnCol[j] = color(255);
          select = true;
          selectText = false;
        }
        for (int j = i+1; j < 3; j++) {
          selectBtnCol[j] = color(255);
          populationCol[i] = color(0);
          select = true;
          selectText = false;
        }
      }
    }
    //push start
    if (startBtnX <= mouseX && mouseX <= startBtnX+startBtnW && startBtnY <= mouseY && mouseY <= startBtnY+startBtnH) {
      if (select) {
        gseq=0;
      } else {
        selectText=true;
      }
    }
  }

  if (gseq==0) {
    for (int i = 0; i< virus_num; i++) {
      if (abs(virusXs[i]-mouseX) <virusD/2 && abs(virusYs[i]-mouseY) < virusD/2) {
        virusCols[i] = color(0, 0, 255);
      }
    }
  }

  if (gseq==1 || gseq==2) {
    gseq=3;
    gameInit();
  }
}
