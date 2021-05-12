int begin; 
int duration = 3000;
int time = 3000;

String tempo;


PFont font;


void setup() {
  size(1000, 600); 
  background(251,176,59);
  font = loadFont("DINAlternate-Bold-382.vlw");
  textAlign(CENTER);
  textFont(font);
  textSize(382);
  begin = millis();   
}

void draw() {
  background(251,176,59); 

    time = duration - (millis() - begin)/1000;
     int minutos = time/60;
    int segundos = time%60;
    tempo = minutos + ":" + segundos;
    fill(247,147,30);
    text(tempo, width/2, height/2+132);
   
    fill(237,28,36);
    text(tempo, width/2-15, height/2+132);

}

void mouseClicked(){
  begin = millis(); 
}
