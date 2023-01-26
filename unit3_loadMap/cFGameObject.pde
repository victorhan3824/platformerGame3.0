
class FGameObject extends FBox {
  final int L = -1;
  final int R = 1;
  
  FGameObject() {
    super(gridSize, gridSize);
  }
  
  FGameObject(int l, int w) {
    super(l, w);  
  }
  
  void act() {}

  boolean collideWith(String objBeingChecked) { 
    //collsion code shared
    ArrayList<FContact> contacts = this.getContacts();
    for (int i=0; i<contacts.size(); i++) { //loop through the list
      FContact fc = contacts.get(i);
      if (fc.contains(objBeingChecked)) {
        return true;
      }
    }
    return false;
  }
}

class FMed extends FGameObject {
  FMed(float x, float y) {
    super();
    setPosition(x,y);
    setName("heal");
    setSensor(true);
    setStatic(true);
    setFriction(1);
    attachImage(heal);
  }
  
  void act() {
    if (collideWith("player")) {
      player.lives = 5;
      world.remove(this);
      terrain.remove(this);
    }
  }
  
}
