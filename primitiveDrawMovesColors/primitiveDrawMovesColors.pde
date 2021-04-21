








void setup(){
size (800,600);
background(0);

stroke(255);
noFill();
}


void draw(){
background(0);

stroke(274,25,255);
strokeWeight(10);
noFill();

circle(mouseX,mouseY,200);

noStroke();
fill(274,25,255);

triangle(mouseX, mouseY+100, mouseX+100, mouseY+100+100, mouseX-100, mouseY+100+100);

}
