
float tamanho = 200; //variável global do tipo inteiro
color c1;

void setup(){

size (800,600); //dimensão da tela
background(0);

}


void draw(){

background(0);

//escolhe cor c1 consoante localização do rato em X no ecrã
if (mouseX >= width/2) {
  c1 = color(204, 153, 0);
}
else {
  c1 = color(0, 153, 204);
}

stroke(c1);
strokeWeight(10);
noFill();
circle(mouseX,mouseY,tamanho);

noStroke();
fill(c1);
triangle(mouseX, mouseY+tamanho/2, mouseX+tamanho/2, mouseY+tamanho, mouseX-tamanho/2, mouseY+tamanho);

}
