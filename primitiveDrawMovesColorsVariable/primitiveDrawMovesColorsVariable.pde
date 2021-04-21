

float tamanho = 200; //variável global do tipo inteiro

void setup(){
  
size (800,600); //dimensão da tela
background(0);


}


void draw(){

background(0);

stroke(274,25,255);
strokeWeight(10);
noFill();
circle(mouseX,mouseY,tamanho);

noStroke();
fill(274,25,255);
triangle(mouseX, mouseY+tamanho/2, mouseX+tamanho/2, mouseY+tamanho, mouseX-tamanho/2, mouseY+tamanho);

}
