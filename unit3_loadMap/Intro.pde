
void intro() {
  background(0);
  
  title();
  
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
