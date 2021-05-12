int squareSize = 30;
int boardX = 10;
int boardY = 20;

//line, t, left l, right l, left z, right z, square
color[] pieceColors = {#26224D, #56FAEE, #741BA5, #E38E0E, #290EE3, #E30E15, #1EE30E, #E5E51C};
boolean t = true;
boolean f = false;
boolean[][][][] shapes = {{{{f, f, f, f}, {t, t, t, t}, {f, f, f, f}, {f, f, f, f}}, {{f, t, f, f}, {f, t, f, f}, {f, t, f, f}, {f, t, f, f}}, {{f, f, f, f}, {t, t, t, t}, {f, f, f, f}, {f, f, f, f}}, {{f, t, f, f}, {f, t, f, f}, {f, t, f, f}, {f, t, f, f}}}, {{{f, f, f, f}, 
    {t, t, t, f}, {f, t, f, f}, {f, f, f, f}}, {{f, t, f, f}, {t, t, f, f}, {f, t, f, f}, {f, f, f, f}}, {{f, t, f, f}, {t, t, t, f}, {f, f, f, f}, {f, f, f, f}}, {{f, t, f, f}, {f, t, t, f}, {f, t, f, f}, 
  {f, f, f, f}}}, {{{f, f, f, f}, {t, t, t, f}, {t, f, f, f}, {f, f, f, f}}, {{t, t, f, f}, {f, t, f, f}, {f, t, f, f}, {f, f, f, f}}, {{f, f, t, f}, {t, t, t, f}, {f, f, f, f}, {f, f, f, f}}, {{f, t, f, f}, {f, t, f, f}, 
  {f, t, t, f}, {f, f, f, f}}}, {{{t, f, f, f}, {t, t, t, f}, {f, f, f, f}, {f, f, f, f}}, {{f, t, t, f}, {f, t, f, f}, {f, t, f, f}, {f, f, f, f}}, {{f, f, f, f}, {t, t, t, f}, {f, f, t, f}, {f, f, f, f}}, {
  {f, t, f, f}, {f, t, f, f}, {t, t, f, f}, {f, f, f, f}}}, {{{f, f, f, f}, {t, t, f, f}, {f, t, t, f}, {f, f, f, f}}, {{f, f, t, f}, {f, t, t, f}, {f, t, f, f}, {f, f, f, f}}, {{f, f, f, f}, {t, t, f, f}, 
  {f, t, t, f}, {f, f, f, f}}, {{f, f, t, f}, {f, t, t, f}, {f, t, f, f}, {f, f, f, f}}}, {{{f, f, f, f}, {f, t, t, f}, {t, t, f, f}, {f, f, f, f}}, {{f, t, f, f}, {f, t, t, f}, {f, f, t, f}, {f, f, f, f}}, {
  {f, f, f, f}, {f, t, t, f}, {t, t, f, f}, {f, f, f, f}}, {{f, t, f, f}, {f, t, t, f}, {f, f, t, f}, {f, f, f, f}}}, {{{f, t, t, f}, {f, t, t, f}, {f, f, f, f}, {f, f, f, f}}, {{f, t, t, f}, {f, t, t, f}, 
  {f, f, f, f}, {f, f, f, f}}, {{f, t, t, f}, {f, t, t, f}, {f, f, f, f}, {f, f, f, f}}, {{f, t, t, f}, {f, t, t, f}, {f, f, f, f}, {f, f, f, f}}}};

int[] pieceBag = {0, 1, 2, 3, 4, 5, 6};
int[] nextScramble = {0, 1, 2, 3, 4, 5, 6};
int bagPosition = 0;

int[][] landscape = new int[boardY][boardX];
int[][] blankLandscape = new int[boardY][boardX];

int currentPiece;
int currentRotation = 0;
int currentX = 3;
int currentY = -1;

int score = 0;

int fallTimer = 0;
int startTimer = 0;

int linesCleared = 0;
int level = 0;
int[] speeds = {48, 43, 38, 33, 28, 23, 18, 13, 8, 6, 5, 5, 5, 4, 4, 4, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1};

int hold = -1;
boolean alreadyHeld = false;

boolean lost = false;
int lostCount = 0;

boolean doGhost = true;

boolean pause = false;

void reset() {
  int[] pieceBag = {0, 1, 2, 3, 4, 5, 6};
int[] nextScramble = {0, 1, 2, 3, 4, 5, 6};
int bagPosition = 0;

landscape = new int[boardY][boardX];

currentPiece = 0;
currentRotation = 0;
currentX = 3;
currentY = -1;

score = 0;

fallTimer = 0;
startTimer = 0;

linesCleared = 0;
level = 0;
hold = -1;
alreadyHeld = false;

lost = false;
lostCount = 0;

  pieceBag = scramble(pieceBag);
  nextScramble = scramble(nextScramble);
  currentPiece = pieceBag[0];
}

void setup() {
  size(499, 600);
  pieceBag = scramble(pieceBag);
  nextScramble = scramble(nextScramble);
  currentPiece = pieceBag[0];
}

void draw() {
  if(!pause){
  //print(bagPosition);
  //printArray(pieceBag);
  background(lighten(#26224D, -10));
  fill(0);
  //llipse(100, 100, 10, 10);
  if (!lost) {
    fallTimer++;
    startTimer++;
    if (fallTimer >= speeds[level]) {
      fallTimer = 0;
      if (positionOkay(currentX, currentY + 1, currentPiece, currentRotation)) {
        currentY++;
      } else {
        addLandscape(currentX, currentY, currentPiece, currentRotation);
        bagPosition++;
        if (bagPosition == 7) {
          arrayCopy(nextScramble, pieceBag);
          nextScramble = scramble(nextScramble);
          bagPosition = 0;
        }
        currentPiece = pieceBag[bagPosition];
        currentRotation = 0;
        currentX = 3;
        currentY = -1;
        startTimer = 0;
        checkClears();
        alreadyHeld = false;
        if (!positionOkay(currentX, currentY, currentPiece, currentRotation)) {
          lose();
        }
      }
    }
  }
  drawLandscape();
  if (doGhost) {
    drawGhost(currentX, currentY, currentPiece, currentRotation);
  }
  drawPiece(currentX * squareSize, currentY * squareSize, currentPiece, currentRotation, false);
  info();

  if (lost) {
    fill(#26224D, lostCount);
    lostCount += 2;
    rect(0, 0, width, height);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(40);
    text("You Lost", width / 2, height / 2);
    textSize(20);
    text("Score: " + score, width / 2, height / 2 +
      30);
  }
}}

void keyPressed() {
  if(key == 'r'){
    reset();
     }
  if(key == 'p'){
    pause = !pause;
    if(pause){
      fill(255);
      textSize(10);
      textAlign(CENTER, CENTER);
      text("paused", width - 100, height - 15);
       }
     }
  if(key == 'g'){
    doGhost = !doGhost;
     }
  if (!lost && !pause) {
    if (key == 'z') {
      if (positionOkay(currentX, currentY, currentPiece, doRotate(currentRotation, -1))) {
        currentRotation = doRotate(currentRotation, -1);
        fallTimer--;
      }
    }
    if (keyCode == UP) {
      if (positionOkay(currentX, currentY, currentPiece, doRotate(currentRotation, 1))) {
        currentRotation = doRotate(currentRotation, 1);
      }
    }
    if (keyCode == LEFT) {
      if (positionOkay(currentX - 1, currentY, currentPiece, currentRotation)) {
        currentX--;
      }
    }
    if (keyCode == RIGHT) {
      if (positionOkay(currentX + 1, currentY, currentPiece, currentRotation)) {
        currentX++;
      }
    }
    if (keyCode == DOWN && startTimer > 45) {
      if (positionOkay(currentX, currentY + 1, currentPiece, currentRotation)) {
        score++;
        currentY++;
      } else {
        addLandscape(currentX, currentY, currentPiece, currentRotation);
        bagPosition++;
        if (bagPosition == 7) {
          arrayCopy(nextScramble, pieceBag);
          nextScramble = scramble(nextScramble);
          bagPosition = 0;
        }
        currentPiece = pieceBag[bagPosition];
        currentRotation = 0;
        currentX = 3;
        currentY = -1;
        startTimer = 0;
        checkClears();
        alreadyHeld = false;
        if (!positionOkay(currentX, currentY, currentPiece, currentRotation)) {
          lose();
        }
      }
    }
    if (key == 'x' ) {
      while (true) {
        //println("up: " + currentPiece);
        if (positionOkay(currentX, currentY + 1, currentPiece, currentRotation)) {
          score += 2;
          currentY++;
        } else {
          addLandscape(currentX, currentY, currentPiece, currentRotation);
          bagPosition++;
          if (bagPosition == 7) {
            arrayCopy(nextScramble, pieceBag);
            nextScramble = scramble(nextScramble);
            bagPosition = 0;
          }
          //println(pieceBag[bagPosition]);
          currentPiece = pieceBag[bagPosition];
          currentRotation = 0;
          currentX = 3;
          currentY = -1;
          startTimer = 0;
          checkClears();
          alreadyHeld = false;
          if (!positionOkay(currentX, currentY, currentPiece, currentRotation)) {
            lose();
          }
          break;
        }
      }
    }
    if (key == 'c' && !alreadyHeld) {
      int holder = hold;
      hold = currentPiece;
      if (holder == -1) {
        bagPosition++;
        if (bagPosition == 7) {
          arrayCopy(nextScramble, pieceBag);
          nextScramble = scramble(nextScramble);
          pieceBag = scramble(pieceBag);
          bagPosition = 0;
        }
        currentPiece = pieceBag[bagPosition];
      } else {
        currentPiece = holder;
      }
      currentRotation = 0;
      currentX = 3;
      currentY = -1;
      startTimer = 0;
      if (!positionOkay(currentX, currentY, currentPiece, currentRotation)) {
        lose();
      }
      alreadyHeld = true;
    }
  }
}
void drawLandscape() {
  for (int i = 0; i < landscape.length; i++) {
    for (int j = 0; j < landscape[i].length; j++) {
      drawSquare((squareSize) * j, (squareSize) * i, landscape[i][j], false);
    }
  }
}

void drawPiece(int x, int y, int piece, int rotation, boolean ghost) {
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      //System.out.println(shapes[piece][rotation][i][j]);
      if (shapes[piece][rotation][i][j]) {
        //System.out.println(i);
        drawSquare((x) + (squareSize) * j, (y) + (squareSize) * i, piece + 1, ghost);
      }
    }
  }
}

void drawGhost(int x, int y, int piece, int rotation) {
  int newY = y;
  while (true) {
    if (positionOkay(x, newY + 1, piece, rotation)) {
      //println(y);
      newY++;
    } else {
      break;
    }
  }
  drawPiece(x * squareSize, newY * squareSize, piece, rotation, true);
}

void drawSquare(int x, int y, int piece, boolean ghost) {
  int push = 4;

  if (ghost) {
    push = 2;
  }

  color main = pieceColors[piece];
  color left = lighten(main, -30);
  color right = lighten(main, 30);

  if (ghost) {
    main = color(pieceColors[piece], 100);
    left = color(lighten(main, -30), 100);
    right = color(lighten(main, 30), 100);
  }

  fill(main);
  rect(x, y, squareSize, squareSize);

  noStroke();

  fill(left);
  beginShape();
  vertex(x, y);
  vertex(x + squareSize, y);
  vertex(x + squareSize - push, y + push);
  vertex(x + push, y + push);
  vertex(x + push, y + squareSize - push);
  vertex(x, y + squareSize);
  endShape();

  fill(right);
  beginShape();
  vertex(x + squareSize, y + squareSize);
  vertex(x + squareSize, y);
  vertex(x + squareSize - push, y + push);
  vertex(x + squareSize - push, y + squareSize - push);
  vertex(x + push, y + squareSize - push);
  vertex(x, y + squareSize);
  endShape();
}

color lighten(color funcIn, int amount) {
  return(color(red(funcIn) + amount, green(funcIn) + amount, blue(funcIn) + amount));
}

void spacer(int x, int y) {
  fill(#8B8B8B);
  noStroke();
  rect(x, y, squareSize, squareSize);
  fill(#4B4B48);
  rect(x + 4, y + 4, squareSize - 8, squareSize - 8, 4);
}

void drawBox(int x, int y, int sizeX, int sizeY) {
  int push = 6;

  color main = pieceColors[0];
  color left = lighten(main, -30);
  color right = lighten(main, 30);

  fill(main);
  rect(x, y, sizeX, sizeY);
  noStroke();

  fill(left);
  beginShape();
  vertex(x, y);
  vertex(x + sizeX, y);
  vertex(x + sizeX - push, y + push);
  vertex(x + push, y + push);
  vertex(x + push, y + sizeY - push);
  vertex(x, y +sizeY);
  endShape();

  fill(right);
  beginShape();
  vertex(x + sizeX, y + sizeY);
  vertex(x + sizeX, y);
  vertex(x + sizeX - push, y + push);
  vertex(x + sizeX - push, y + sizeY - push);
  vertex(x + push, y + sizeY - push);
  vertex(x, y + sizeY);
  endShape();
}

void info() {
  fill(0);
  rect(boardX * squareSize, 0, 5, height);

  drawBox(boardX * squareSize + 25, 25, 150, 160);
  textAlign(CENTER, TOP);
  textSize(16);
  fill(255);
  text("Score:", boardX * squareSize + 100, 35);
  text(score, boardX * squareSize + 100, 56);
  text("Lines Cleared:", boardX * squareSize + 100, 85);
  text(linesCleared, boardX * squareSize + 100, 106);
  text("Level:", boardX * squareSize + 100, 135);
  text(level, boardX * squareSize + 100, 156);

  textSize(20);
  drawBox(boardX * squareSize + 25, 210, 150, 170);
  fill(255);
  text("Next:", boardX * squareSize + 100, 225);
  if (nextPiece() == 0 || nextPiece() == 6) {
    if (nextPiece() == 0) {
      drawPiece(boardX * squareSize + 40, 250, nextPiece(), 0, false);
    } else {
      drawPiece(boardX * squareSize + 40, 250 + squareSize, nextPiece(), 0, false);
    }
  } else {
    if (nextPiece() != 1 && nextPiece() != 5 && nextPiece() != 4 && nextPiece() != 2) {
      drawPiece(boardX * squareSize + 55, 250 + squareSize, nextPiece(), 0, false);
    } else {
      drawPiece(boardX * squareSize + 55, 250, nextPiece(), 0, false);
    }
  }


  drawBox(boardX * squareSize + 25, 405, 150, 170);
  fill(255);
  text("Hold: ", boardX * squareSize + 100, 420);
  if (hold != -1) {
    if (hold == 0 || hold == 6) {
      if (hold == 0) {
        drawPiece(boardX * squareSize + 40, 445, hold, 0, false);
      } else {
        drawPiece(boardX * squareSize + 40, 445 + squareSize, hold, 0, false);
      }
    } else {
      if (hold != 1 && hold != 5 && hold != 4 && hold != 2) {
        drawPiece(boardX * squareSize + 55, 445 + squareSize, hold, 0, false);
      } else {
        drawPiece(boardX * squareSize + 55, 445, hold, 0, false);
      }
    }
  }
}

//false = left, true = right
int sideMost(boolean side, boolean[][] piece) {
  if (side) {
    int farthest = 0;
    for (int i = 0; i < 4; i++) {
      if (piece[0][i] || piece[1][i] || piece[2][i] || piece[3][i]) {
        farthest = i;
      }
    }
    return(farthest);
  } else {
    int farthest = 0;
    for (int i = 3; i >= 0; i--) {
      if (piece[0][i] || piece[1][i] || piece[2][i] || piece[3][i]) {
        farthest = i;
      }
    }
    return(farthest);
  }
}

boolean positionOkay(int x, int y, int piece, int rotation) {
  boolean ret = true;

  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      //println(piece + " , " + rotation);
      if ((x + i < 0 || x + i >= boardX || y + j >= boardY || y + j < 0) && shapes[piece][rotation][j][i]) {
      //System.out.println(x + " ' " + i + " , " + shapes[piece][rotation][i][j]);
        drawSquare((x + i) * squareSize, (y + j) * squareSize, piece, false);
        if(y + j >= 0){
        ret = false;
        }
      } else if (shapes[piece][rotation][j][i]) {
        if (landscape[y + j][x + i] > 0) {
          //println("in");
          ret = false;
        }
      }
    }
  }

  return(ret);
}

void addLandscape(int x, int y, int piece, int rotation) {
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      if (x + i >= 0 && y + j < boardY) {
        if (shapes[piece][rotation][j][i]) {
          //System.out.println("here: " + (x + i));
          if(y + j >= 0){
          landscape[y + j][x + i] = piece + 1;
          } else {
            lose();
          }
        }
      }
    }
  }
}

void lose(){
  //println("lost");
  lost = true;
}

int doRotate(int input, int rotation){
  if((input == 0 && rotation == -1) || (input == 3 && rotation == 1)){
    if(input == 0){
      return(3);
    } else {
      return(0);
    }
  } else {
    return(input += rotation);
  }
}

void checkClears(){
  int totalClears = 0;
  for(int i = 0; i < landscape.length; i++){
    if(allLine(landscape[i])){
      clearLine(i);
      totalClears++;
      linesCleared++;
      if(linesCleared % 10 == 0){
        level++;
      }
    }
  }
  switch(totalClears){
    case 0:
    break;
    case 1:
    score += 40 * (level + 1);
    break;
    case 2:
    score += 100 * (level + 1);
    break;
    case 3:
    score += 300 * (level + 1);
    break;
    case 4:
    score += 1200 * (level + 1);
    break;
  }
}

void clearLine(int line){
  int[] clear = new int[boardX];
  for(int i = line; i > 0; i--){
    landscape[i] = clear;
    landscape[i] = landscape[i - 1];
  }
  landscape[0] = clear;
}

boolean allLine(int[] input){
  for(int i : input){
    if(i == 0){
      return(false);
    }
  }
  return(true);
}

int[] scramble(int[] input1){
  int[] input = input1;
  for(int i = 0; i < input.length; i++){
    int randomNum = int(random(i, input.length));
    int holder = input[i];
    input[i] = input[randomNum];
    input[randomNum] = holder;
  }
  return(input);
}

int nextPiece(){
  if(bagPosition == 6){
    return(nextScramble[0]);
  } else {
    return(pieceBag[bagPosition+1]);
  }
}
