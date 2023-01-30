import fisica.*;
FWorld world;

//mode framework
int mode;
final int GAME  = 0;
final int INTRO = 1;
final int OVER  = 2;

color white = #FFFFFF;
//colors used to load in map; pixilart.com; common pallette
color black = #000000;
color red   = #ed1c24;
color brown = #9c5a3c; 
color orange= #ff7e00;
color lime  = #a8e61d;
color Lblue = #99d9ea;
color Dblue = #4d6df3; 
color purple= #6f3198;
color grey  = #b5a5d5;
color crimson=#990030;
color yellow= #fff200;
color pink  = #ffa3b1;
color Lbrown= #e5aa7a;
color green = #22b14c;
color rice  = #f5e49c;

//Images used in game;
PImage ice, brick, spike, trampoline, bridge, crate, heal, treasure;
PImage trunk, intersect, center, west, east; //tree images
PImage[] lava; //lava images

//action images arrays
PImage[] idle, jump, run, action;

//other files
PImage map2; //map Files
PImage heart;
int gridSize = 32; //size of every pixel
float zoom = 1.5; //scale factor

boolean wKey, aKey, sKey, dKey, upKey, downKey, leftKey, rightKey;
FPlayer player;

ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;

//enemies' images/arrays
PImage[] goomba, thwomp, hammerbro;
PImage hammer;

//buttons
Button start, reset;

//other weird stuff
PFont font;
PImage introBackGrd;
boolean win = false;

//=============================================================================
void setup() {
  size(700,700);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  mode = INTRO;
  loadFisicaStuff();
  loadOtherStuff();
}

void loadOtherStuff() {
  font = createFont("font.TTF", 21);
  textFont(font);
  
  introBackGrd = loadImage("introImg.jpg");
  introBackGrd.resize(width, height);
  start = new Button(0, width/2, 500, 150, 50, 3, 3, white, black, Dblue, "PLAY");    
  reset = new Button(0, width/2, 500, 150, 50, 3, 3, white, black, Dblue, "BACK");    
}

void loadFisicaStuff() {
  Fisica.init(this);
  map2 = loadImage("map2.png");
  terrain = new ArrayList<FGameObject>();
  loadImageFiles();
  loadEnemies();
  loadWorld(map2);
  loadPlayer();  
}

void loadImageFiles() {
  //loadImage
  brick = loadImage("img/brick.png");
  ice = loadImage("img/blueBlock.png");
  spike = loadImage("img/spike.png");
  trunk = loadImage("img/tree_trunk.png");
  intersect = loadImage("img/tree_intersect.png");
  center = loadImage("img/treetop_center.png");
  east = loadImage("img/treetop_e.png");
  west = loadImage("img/treetop_w.png");
  trampoline = loadImage("img/trampoline.png");
  bridge = loadImage("img/bridge.png");
  crate = loadImage("img/crate.png");
  heal = loadImage("img/healblk.png");
  treasure = loadImage("img/treasure.png");
  
  heart = loadImage("heart.png");
  loadResizeLavaImages();
  
  //resize image
  PImage[] P = {brick, ice, spike, trunk, intersect,
    center, east, west, heart, trampoline, bridge, crate, heal, treasure};
  for (int i=0; i<P.length; i++) {
    P[i].resize(gridSize, gridSize);  
  }
}

void loadResizeLavaImages() {
  lava = new PImage[6];
  for (int i=0; i<6; i++) {
    lava[i] = loadImage("lava/lava"+i+".png");  
    lava[i].resize(gridSize, gridSize);
  }
}

void loadPlayer() {
  //loadPlayerActionImages
  idle = new PImage[30];
  for (int i=0; i<29; i++) idle[i] = loadImage("img/idle0.png");
  idle[29] = loadImage("img/idle1.png");
  
  jump = new PImage[1];
  jump[0] = loadImage("img/jump0.png");
  
  run = new PImage[3];
  run[0] = loadImage("img/run0.png");
  run[1] = loadImage("img/run1.png");
  run[2] = loadImage("img/run2.png");
  
  action = idle;
  //adding in the player
  player = new FPlayer(); 
  world.add(player);
}

void loadEnemies() {
  enemies = new ArrayList<FGameObject>();  
  //goomba
  goomba = new PImage[2];
  goomba[0] = loadImage("enemies/goomba0.png");
  goomba[1] = loadImage("enemies/goomba1.png");
  for (int i=0; i<goomba.length; i++) goomba[i].resize(gridSize, gridSize);
  
  //thwomp
  thwomp = new PImage[2];
  thwomp[0] = loadImage("enemies/thwomp0.png");
  thwomp[1] = loadImage("enemies/thwomp1.png");
  for (int i=0; i<thwomp.length; i++) thwomp[i].resize(gridSize*2, gridSize*2);
  
  //hammerBro
  hammerbro = new PImage[2];
  hammerbro[0] = loadImage("enemies/hammerbro0.png");
  hammerbro[1] = loadImage("enemies/hammerbro1.png");
  for (int i=0; i<hammerbro.length; i++) hammerbro[i].resize(gridSize, gridSize);  
  hammer = loadImage("enemies/hammer.png");
}

void loadWorld(PImage map) {
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 980); 
  //loading the map
  for (int x=0; x<map.width; x++) {
    for (int y=0; y<map.height; y++) {
      //map.get(x, y); gets the color at pixel at this pixel number (x,y)
      // map.width & map.height --> height/width of image (ie. 50x120)
       
      //initalize box
      FBox b = new FBox(gridSize, gridSize); //intialize FBox
      b.setPosition(x*gridSize, y*gridSize); //set position of FBox
      b.setStatic(true);
      b.setFriction(0.5);
      b.setRestitution(0.1);
      
      //retrieve color
      color c = map.get(x, y); //current color
      color d = map.get(x, y+1); //color below
      color l = map.get(x-1, y); //color to the left
      color r = map.get(x+1, y); //color to the right
      
      //add in the Fboxes based on color at the pixel
      if (c == black) { //ground
        addFbox(b, brick, "brick");
        b.setFriction(4);
      }
      if (c == Dblue) { //wall; defined for the enemies' classes
        addFbox(b, brick, "wall");
        b.setFriction(4);
      }
      if (c == Lblue) { //ice
        addFbox(b, ice, "ice");
        b.setFriction(0);
      }
      if(c == grey) { //spike
        addFbox(b, spike, "spike");
      }
      if (c == purple) {
        addFbox(b, trampoline, "trampoline");
        b.setRestitution(1.5);
      }
      if (c == brown) {
        FBridge br = new FBridge(x*gridSize, y*gridSize); 
        world.add(br);
        terrain.add(br); //add into terrain arrayList to call the act funtion of FBridge class
      }
      if (c == red) { //lava
        FLava la = new FLava(x*gridSize, y*gridSize, (int) random(0,5));
        world.add(la);
        terrain.add(la);
      }
      if(c == crimson) { //goomba 
        FGoomba gm = new FGoomba(x*gridSize, y*gridSize);
        world.add(gm);
        enemies.add(gm);
      }
      if(c == yellow) { //thwomp, takes 4 grids
         FThwomp tw = new FThwomp(x*gridSize, y*gridSize); 
         world.add(tw);
         enemies.add(tw);
      }
      if(c == pink) { //hammerbro 
        FHammerBro hb = new FHammerBro(x*gridSize, y*gridSize);
        world.add(hb);
        enemies.add(hb);
      }
      if (c == Lbrown) { //movable box/crate
        addFbox(b, crate, "crate");
        b.setRotatable(false);
        b.setStatic(false);
      }
      if (c == green) { //heal blk, buried onto ground
        FMed md = new FMed(x*gridSize, y*gridSize);
        world.add(md);
        terrain.add(md);
      }
      if (c == rice) {
        addFbox(b, treasure, "treasure");
        b.setStatic(true);
        b.setSensor(true);
      }
      
      addingTrees(c, d, l, r, b);
    }
  }    
}

void addingTrees(color c, color d, color l, color r, FBox box) {
  //only add trees
  if (c == orange) { //trunk
    addFbox(box, trunk, "trunk"); 
    box.setSensor(true);
  } 
  
  if (c == lime && d == orange) {
    addFbox(box, intersect, "intersect");  
    box.setSensor(true);
  } else if (c == lime) {
    if ((l == lime && r == lime) || (l != lime && r != lime)) {
      addFbox(box, center, "center");
      box.setSensor(true);
    } else if (l == lime) {
      addFbox(box, east, "east");
      box.setSensor(true);
    } else {
      addFbox(box, west, "west");
      box.setSensor(true);
    }
  }
}

void addFbox(FBox box, PImage img, String name) {
  box.attachImage(img);
  box.setName(name);
  world.add(box);
}

//=========================================================================

void draw() {
  if (mode == INTRO) intro();
  else if (mode == GAME) game();
  else if (mode == OVER) over();
}
