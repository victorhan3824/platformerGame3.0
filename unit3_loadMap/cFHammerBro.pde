
class FHammerBro extends FGoomba{
  
  FHammerBro(float x, float y) {
    super(x, y);
    /*
    inherit variables: speed, direction, frame
    */
    setName("HammerBro");
  }
  
  void act() {
    animate(hammerbro); //animate the hammerbro; function inherited from cFGoomba
    move(); //inherited from goomba
    turn();
    throwHammer();
  }
  
  void turn() {
    if (collideWith("wall")) {
      direction *= -1;
      setPosition(getX()+direction*2, getY()); //slightly shift so the collision does not repeat
    }
  }
  
  void throwHammer() {
    if (frameCount % 300 == 0) {
      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(getX(), getY());
      b.setName("hammer");
      b.setSensor(true);
      b.setVelocity(0,-500);
      b.setAngularVelocity(20);
      b.attachImage(hammer);
      world.add(b);  
    }
  }
  
}
