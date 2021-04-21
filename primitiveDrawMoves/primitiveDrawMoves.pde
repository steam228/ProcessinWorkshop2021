








void setup(){
size (800,600);
background(0);
}


void draw(){
background(0);
circle(mouseX,mouseY,200);
triangle(mouseX, mouseY+100, mouseX+200, mouseY+100+200, mouseX-200, mouseY+100+200);

}
