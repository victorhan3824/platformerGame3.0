

void game() {
  background(0);
  drawWorld();
  actWorld();    
}

void actWorld() {
  player.act();
  
  for (int i=0; i < terrain.size(); i++) {
    //acting all the terrains
    FGameObject t = terrain.get(i);
    t.act();
  }
  for (int i=0; i < enemies.size(); i++) {
    //acting all the terrains
    FGameObject e = enemies.get(i);
    e.act();
  }  
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom + width/2, -player.getY()*zoom + height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
}
