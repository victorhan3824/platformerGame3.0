
class FLava extends FGameObject {
  int counter; 
  
  FLava (float x, float y, int c) {
    super();
    setPosition(x, y);  
    counter = c;
    
    attachImage(lava[counter]); 
    //put the image array at the random; lava[] is global image array
    
    setName("lava");
    setSensor(true);
    setStatic(true);
    setFriction(1);
  }
  
  void act() {
    if (frameCount % 20 ==0) counter++;  
    if (counter > 5) {
      counter = 0;      
    }
    this.attachImage(lava[counter]);
    
    if (collideWith("player")) {
      player.takeDamage();
    }
  }
}
