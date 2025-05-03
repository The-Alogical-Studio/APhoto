Slider smooth;
Slider dia;
Slider col;
Slider iter;
float dl = 0.1;

float softX, softY, iW, iH;
int tmr = 0;

MainMenu menu;
PImage start_image;
boolean flg = false;

Dropdown drop;

void New() {
  setup();
}

void setup() {

  menu = new MainMenu(2);

  String[] fl = {"New", "Open", "Save"};
  //String[] ed = {"Copy", "Paste"};
  String[] hp = {"About"};
  menu.addNextMenu(0, "File", fl);
  //menu.addNextMenu(1, "Edit", ed);
  menu.addNextMenu(1, "Help", hp);

  size(1000, 500, P2D);
  windowResizable(true);
  background(0);
  noStroke();
  frameRate(60);
  textFont(createFont("Lucida Console", 16));
  smooth = new Slider(loadImage("sld1.png"), loadImage("sld2.png"), 0, 50, width / 5, height/20, 0.02, 1);
  smooth.value = 0.3;

  col = new Slider(loadImage("sld1.png"), loadImage("sld2.png"), 0, 170, width / 5, height/20, 0, 255); //sld1 - фон, sld2 - ползунок. x, y, w, h, minV, maxV
  col.value = 255;

  dia = new Slider(loadImage("sld1.png"), loadImage("sld2.png"), 0, 90, width / 5, height/20, 1, 100);
  dia.value = 30;

  iter = new Slider(loadImage("sld1.png"), loadImage("sld2.png"), 0, 240, width / 5, height/20, 1, 50);
  iter.value = 10;


  String[] str = {"Circle", "Rectangle", "Line"};
  drop = new Dropdown(str, 0, 130, 100, 20, 20);
  iW = width / 5;
  iH = 50;
}


void draw() {
  if (millis() - tmr >= 1000) {
    iW = width / 5;
    iH = height / 20;
    tmr = millis();
  }


  if (flg) {

    image(start_image, width/3.5, 0, start_image.width * 2, start_image.height * 2);
    flg = !flg;
  }

  fill(120);
  rect(0, 0, width/3.5, height);
  fill(255);

  win_tick();
  smooth.tick();
  text("Smooth", iW + 5, 65);
  dia.tick();
  text("Size", iW, 105);
  col.tick();
  text("Color", iW + 25, 185);
  drop.tick();
  iter.tick();
  text("Step", iW, 255);
  menu.tick();

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

void Open() {
  selectInput("test", "selected");
}

void selected(File file) {
  start_image = loadImage(file.toString());
  flg = true;
}

void Save() {
  draw();
  saveFrame("sample.png");
  PImage img = loadImage("sample.png");
  img.loadPixels();
  int px = img.width * img.height;

  //PImage nI = createImage(width - (int) (width / 3.5), width - (int) (width / 3.5), RGB);
  //nI.loadPixels();

  for (int i = 0; i < px; i++) {
    int x = i % img.width;
    int y = i / img.width;

    if (x > (width / 3.5)) {
      img.pixels[(int) (y * img.width + (x - (width / 3.5)) - 1)] = img.pixels[i];
    }
  }

  //img.resize(width - (int) (width / 3.5), height);
  img.updatePixels();

  img.save("sample.png");
}

void About() {
  println("APhoto - absoultely free graphics editor");
  println("Copyright Alogical Std. 2025 - present\n");
  println("This application powered by LoGUI");
  println("Copyright NThacker 2025 - present");
  println("Version alpha 1.0");
  println("C0d9d by NTh6ck9r");
}
