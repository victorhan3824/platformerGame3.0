class FPlayer extends FGameObject{
  int lives;
  int frame, direction;
  int shieldCounter;
  boolean shield;
  
  FPlayer() {
    //initalize location + display
    super();
    setPosition(200,0); //inital position
    setFillColor(red);
    setRotatable(false);
    setName("player");
    
    //display variables
    direction = R;
    frame =0;
    
    //stat initalize
    lives = 5;
    shieldCounter = 0;
    shield = false;
  }
  
  void act() {
    moveByControl();
    statManagement();
    collisions();
    animate();    
    death();
  }
  
  void death() {
    if (lives <= 0) { //when you die
      mode = OVER;
      win = false;
    }
  }
  void animate() {
    if (frame >= action.length) { //reset frame when all frame used
      frame = 0;  
    }
    if (frameCount % 5 == 0) { //display
      if (direction == R) attachImage(action[frame]); //natural image orientation
      if (direction == L) attachImage(reverseImage(action[frame]));
      //PImage[] reverseImage(PImage img) is global funtion in ultilities tab
      frame++;
    }
    
  }
  
  void collisions() {
    //checking collisions
    if (this.collideWith("spike") || collideWith("hammer")) {
      takeDamage();
    }
    
    //finds treasure
    if (collideWith("treasure")) {
      mode = OVER;  
      win = true;
    }
  }
  
  void takeDamage() {
    //takeDamage
    if (shieldCounter == 0 && !shield) {
      this.lives --;
      shield = true;
    }
  }
  
  void statManagement() {
    for (int i=0; i<this.lives; i++) {
      image(heart, 500+i*32,16);  
    }
    //shield display + calculation
    if (shield) {
      shieldCounter++;
      if (shieldCounter >= 20) {
        shieldCounter = 0;
        shield = false;
      }
    }
    
    if (shieldCounter < 20 && shield) {
      float rad = radians(map(shieldCounter, 0, 20, 0, 360));
      fill(Lblue, 200);
      arc(500-32, 30, 32, 32 , 0, 2*PI - rad);
    }
  }
  
  void moveByControl() {
    float vx = this.getVelocityX();
    float vy = this.getVelocityY();
    ArrayList<FContact> contacts = this.getContacts();
    if (abs(vy) < 0.1) action = idle; 
    if (aKey) { 
      setVelocity(-300, vy);
      action = run; //run is global PImage[]
      direction = L;
    }
    if (dKey) { 
      setVelocity(300,  vy);
      action = run; //run is global PImage[]
      direction = R;
    }
    if (wKey && contacts.size() > 0) {
      setVelocity(vx, -300);
    }
    if (sKey) setVelocity(vx, 300);
    
    if(abs(vy) > 0.1) action = jump; //jump is global PImage[]
  }
}
