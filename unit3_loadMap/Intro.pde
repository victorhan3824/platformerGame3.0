
void intro() {
  background(0);
  
  title();
  guide();
  
  start.show();
  if (start.buttonClicked()) mode = GAME;
}

void title() {
  image(introBackGrd, 0, 0);
  
  if (sin(0.05*frameCount) < -0.9 ) background(crimson);
  
  fill(white);
  textSize(72);
  text("In the Dark", width/2, 300);
}

void guide() {
  fill(grey);
  rect(width/2,416, 250,60);
  fill(white);
  textSize(16);
  text("Find treasure chest to win",width/2,416);
  image(treasure, 170, 400);  
}
