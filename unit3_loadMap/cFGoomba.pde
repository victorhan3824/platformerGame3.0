
class FGoomba extends FGameObject {
  
  int direction = L;
  int speed = 50;
  int frame = 0;
  
  FGoomba(float x, float y) {
    super();
    setPosition(x,y);
    setName("goomba");
    setRotatable(false); 
  }
  
  void act() {
    animate(goomba); 
    move();
    collide();
  }
  
  void animate(PImage[] array) {
    if (frame >= array.length) { //reset frame when all frame used
      frame = 0;  
    }
    if (frameCount % 5 == 0) { //display
      if (direction == R) attachImage(array[frame]); //natural image orientation
      if (direction == L) attachImage(reverseImage(array[frame]));
      //PImage[] reverseImage(PImage img) is global funtion in ultilities tab
      frame++;
    }
  }
  
  void collide() {
    if (collideWith("wall")) {
      direction *= -1;
      setPosition(getX()+direction, getY()); //slightly shift so the collision does not repeat
    }
    if (collideWith("player")) {
      if(player.getY() < getY()-gridSize/2) {
        world.remove(this);
        enemies.remove(this);
        player.setVelocity(player.getVelocityX(), -300);
      }
      else {
        player.takeDamage();
      }
    }
  }
  
  void move() {
    float vy = getVelocityY();
    setVelocity(speed*direction, vy);
  }
  
}
