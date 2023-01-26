
class FThwomp extends FGameObject {
  FThwomp(int x, int y) {
    super(gridSize*2, gridSize*2);
    
    setPosition(x,y);
    setName("thwomp");
    setRotatable(false); 
    setStatic(true);
    attachImage(thwomp[0]);
  }
  
  void act() {
    fall();
    collision();
  }
  
  void fall() {
    float dist = getX()+gridSize - player.getX();
    if (abs(dist) < 1.2*gridSize) {
        setStatic(false);
        attachImage(thwomp[1]);
    }
  }
  void collision() {
    if (collideWith("player")) {
      enemies.remove(this);
      player.lives = 0;
    }
  }
}
