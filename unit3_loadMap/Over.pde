
void over() {
  background(11);
  
  overAesthetics();
  
  reset.show();
  if (reset.buttonClicked()) {
    mode = INTRO;  
    world = new FWorld();
    player = new FPlayer();
    
    loadWorld(map2);
    loadPlayer();
  }
}

void overAesthetics() {
  fill(white);
  textSize(72);
  if (win) text("YOU WON!!!", width/2, 300);
  else text("SUP LOSER", width/2, 300);
}
