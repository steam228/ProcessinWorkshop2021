
float posX, posY;
float tamanho; //variável global do tipo inteiro

void setup(){
size (800,600);
background(0);

posX = 50;
posY = 400;
tamanho = (width/6)-30;

}


void draw(){
background(0);


for (int i = 0; i < 6; i=i+1) {

  posX = ((width/6)*i+1)+tamanho/2+30/2;
  posY = 300;
  
  stroke(274,25,255);
  strokeWeight(10);
  noFill();
  circle(posX,posY,tamanho);
  noStroke();
  fill(274,25,255);
  triangle(posX, posY+tamanho/2, posX+tamanho/2, posY+tamanho, 
 posX-tamanho/2, posY+tamanho);

}

}
