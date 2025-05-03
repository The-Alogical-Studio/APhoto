Slider smooth;
Slider dia;
Slider col;
Slider iter;
float dl = 0.1;

Dropdown drop;


void setup() {
  size(1000, 500, P2D);
  windowResizable(true);
  background(0);
  noStroke();
  frameRate(60);
  textFont(createFont("Lucida Console", 16));
  smooth = new Slider(loadImage("sld1.png"), loadImage("sld2.png"), 0, 10, width / 5, height/20, 0.02, 1);
  smooth.value = 0.3;

  col = new Slider(loadImage("sld1.png"), loadImage("sld2.png"), 0, 130, width / 5, height/20, 0, 255); //sld1 - фон, sld2 - ползунок. x, y, w, h, minV, maxV
  col.value = 255;

  dia = new Slider(loadImage("sld1.png"), loadImage("sld2.png"), 0, 50, width / 5, height/20, 1, 100);
  dia.value = 30;

  iter = new Slider(loadImage("sld1.png"), loadImage("sld2.png"), 0, 200, width / 5, height/20, 1, 50);
  iter.value = 10;


  String[] str = {"Circle", "Rectangle", "Line"};
  drop = new Dropdown(str, 0, 90, 100, 20, 20);
  iW = width / 5;
  iH = height / 20;
}

float softX, softY, iW, iH;
int tmr = 0;

void draw() {
  if(millis() - tmr >= 1000){
    iW = width / 5;
    iH = height / 20;
    tmr = millis();
  }
  
  fill(120);
  rect(0, 0, width/3.5, height);
  fill(255);

  win_tick();
  smooth.tick();
  text("Smooth", iW + 5, iH);
  dia.tick();
  text("Size", iW , 40 + iH);
  col.tick();
  text("Color", iW, 120 + iH);
  drop.tick();
  iter.tick();
  text("Step", iW, 190 + iH);

  softX += (mouseX - softX) * smooth.value;
  softY += (mouseY - softY) * smooth.value;


  if (mousePressed && !(abs(iW - mouseX) <= (width/7))) {

    float clr = mouseButton == 37 ? ((int) col.value) : 0;
    fill(clr);

    switch(drop.value) {
    case 0:
      for (int i = 0; i <= iter.value; i++) {
        softX += (mouseX - softX) * dl;
        softY += (mouseY - softY) * dl;
        circle(softX, softY, dia.value);
      }
      break;
    case 1:
      for (int i = 0; i <= iter.value; i++) {
        softX += (mouseX - softX) * dl;
        softY += (mouseY - softY) * dl;
        rect(softX, softY, dia.value, dia.value);
      }
      break;
    case 2:
      stroke(clr);
      for (int i = 0; i <= iter.value; i++) {
        softX += (mouseX - softX) * dl;
        softY += (mouseY - softY) * dl;
        line(softX, softY, softX + dia.value, softY + dia.value);
      }
      noStroke();
      break;
    }
  }
}
