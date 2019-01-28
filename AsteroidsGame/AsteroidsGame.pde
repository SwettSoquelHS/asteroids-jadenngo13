ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
Star[] starField = new Star[100];
ArrayList<Asteroid> removeAst = new ArrayList<Asteroid>(); //used to prevent ConcurrentModificationException
ArrayList<Asteroid> addAst = new ArrayList<Asteroid>(); //
ArrayList<Bullet> removeBullet = new ArrayList<Bullet>(); //

Spaceship player1;
float rx, ry, rs, rsize, angle, rd, baseSpeed; //rock x, y, size, angle, direction, and base speed(increments)
float brokenDirection; //direction for broken asteroids
float sx, sy, ssize, sspeed; //star x, y, size, and speed
Asteroid tempAsteroid;
int shotIndex, brokenIndex, level, randomAssignment; //shotIndex, brokenAsteroid index, level
boolean gameOver, nextLevel;
float score, shotCount, killCount;
String stats, gameOverScreen, gameOverInstruct;
int timer;

/*
  Track User keyboard input
 */
boolean ROTATE_LEFT;  //User is pressing a
boolean ROTATE_RIGHT; //User is pressing d
boolean MOVE_FORWARD; //User is pressing w arrow
boolean HYPERSPACE; //user is pressing q


/* * * * * * * * * * * * * * * * * * * * * * *
 Initialize all of your variables and game state here
 */
public void setup() {
  size(800, 600);

  //Initialize game
  gameOver = false;
  level = 1;

  //String initialization
  gameOverScreen = "Game Over";
  gameOverInstruct = "Press 'r' to restart";

  //setup asteroids
  //setupAsteroids(); //(on line 258)
  Asteroid a = new Asteroid(width/2, 0, .8, 90, 40);
  Asteroid b = new Asteroid(width, height/2, 1, 180, 40);
  asteroids.add(a);
  asteroids.add(b);

  //initialize ship
  player1 = new Spaceship(width/2, 500, 0, 180, 30); //x, y, speed, direction, size

  shotIndex = 0;

  //initialize starfield
  for (int i = 0; i<starField.length; i++) {
    sx = random(0, width);
    sy = random(0, height);
    ssize = random(1, 5);
    sspeed = random(.5, .8);
    starField[i] = new Star(sx, sy, ssize, sspeed);
  }
}


/* * * * * * * * * * * * * * * * * * * * * * *
 Drawing work here
 */
public void draw() {
  background(0);
  
  //Reset removing arrays
  ArrayList<Bullet> removeBullet = new ArrayList<Bullet>();
  ArrayList<Asteroid> removeAst = new ArrayList<Asteroid>();
  ArrayList<Asteroid> addAst = new ArrayList<Asteroid>();
  

  //game mechanics
  timer = millis() / 1000;

  //SPACESHIP WORK
  if (!gameOver) {
    player1.update();
    if (HYPERSPACE) {
      player1.hyperArea += 4;
      player1.hyperSpace();
    }
  }
  player1.show();

  for (Asteroid a : asteroids) { //asteroid collision
    if (player1.collidingWith(a)) {
      removeAst.add(a);
      player1.lives--;
    }
  }
  //asteroids.removeAll(removeAst);
  //


  //BULLET WORK
  for (Bullet b : bullets) {
    if (!gameOver) {
      b.update();
    }
    b.show();
    if (b.dud || b.hit) {
      removeBullet.add(b);
    }
  } 
  bullets.removeAll(removeBullet);

  for (Bullet b : bullets) { //collision
    for (Asteroid a : asteroids) {
      if (b.collidingWith(a)) {
        killCount++;
        b.hit = true;
        a.hit = true;
      }
    }
  }
  //


  //STARFIELD WORK
  for (int i = 0; i<starField.length; i++) {
    starField[i].show();
    if (!gameOver)
      starField[i].move();
  }
  //


  //ASTEROID WORK
  for (Asteroid a : asteroids) {
    a.show();
    if (!gameOver) {
      a.update();
      if (a.hit) {
        if (a.getRadius() > 30) {
          for (int k = 0; k<2; k++) { //make two new broken asteroids
            brokenDirection = random(0, 360);
            Asteroid newAsteroid = new Asteroid(a.location.x, a.location.y, 
              a.speed/2, brokenDirection, a.getHypotenuse()/2);
            addAst.add(newAsteroid);
          }
        }
        brokenIndex += 2;
        removeAst.add(a);
      }
      for (Asteroid b : asteroids) { //asteroid collision
        if (a != b) {
          if (a.collidingWith(b)) {
            a.collision(b);
          }
        }
      }
    }
  }
  asteroids.addAll(addAst);
  asteroids.removeAll(removeAst);
  //


  //GAME STATE WORK
  gameUpdate();
  if (nextLevel) {
    level++;
    baseSpeed += .1;
    //setupAsteroids();
    System.out.println("NEXT LEVEL");
    if (level % 3 == 0) {
      if (player1.lives < 4)
        player1.lives++;
    }
    nextLevel = false;
  }
  if (gameOver) {
    fill(#FA1703);
    textSize(40);
    text(gameOverScreen, (width/2)-100, height/2);
    textSize(20);
    text(gameOverInstruct, (width/2)-75, (height/2)+50);
  }
  //


  //STAT WORK
  score = round((100*(killCount/shotCount) + 100*(killCount)));
  stats = "Total Score: " + score +
    "\n Total Lives: " + player1.lives + 
    "\n Level: " + level;
  fill(#FF520D);
  textSize(12);
  text(stats, 30, 30);
  //
}


/* * * * * * * * * * * * * * * * * * * * * * *
 Record relevent mouse presses for game
 */
void mousePressed() {
  //add shooting stuff here
  if (bullets.size() <= 10) {
    Bullet b = new Bullet(player1.location.x, player1.location.y, 2, player1.direction, 10);
    bullets.add(b);
    shotCount++;
  }
}
//


/* * * * * * * * * * * * * * * * * * * * * * *
 Record relevent key presses for game
 */
void keyPressed() {
  if (key == 'a') {
    ROTATE_LEFT = true;
  } else if ( key == 'd' ) {
    ROTATE_RIGHT = true;
  } else if (key == 'w') {
    MOVE_FORWARD = true;
  } else if (key == 'r') {
    if (gameOver) {
      resetGame();
    }
  }
  if (key == CODED) {
    if (keyCode == SHIFT) {
      HYPERSPACE = true;
    }
  }
}
//


/* * * * * * * * * * * * * * * * * * * * * * *
 Record relevant key releases for game.
 */
void keyReleased() {  
  if (key == 'a') {
    ROTATE_LEFT = false;
  } else if ( key == 'd' ) {
    ROTATE_RIGHT = false;
  } else if (key == 'w') {
    MOVE_FORWARD = false;
  }
  if (key == CODED) {
    if (keyCode == SHIFT) {
      HYPERSPACE = false;
      player1.location = player1.hyperLocation;
      player1.hyperArea = 0;
    }
  }
}
//


/* * * * * * * * * * * * * * * * * * * * * * 
 Some Game Utils
 */

//CHECKING ON GAME STATUS
void gameUpdate() {
  if (asteroids.size() == 0) {
    nextLevel = true;
  }
  if (player1.lives == 0) {
    gameOver = true;
  }
}
//


//SETUP FOR ASTEROIDS
void setupAsteroids() {
  int randomAssignment;
  for (int i = 0; i<asteroids.size(); i++) {
    randomAssignment = (int)random(0, 4);
    if (randomAssignment == 0) { //random assignment to evenly distribute asteroids on all sides of the screen
      rx = random(100, width-100);
      ry = random(-200, 0);
      rd = random(110, 70);
    } else if (randomAssignment == 1) {
      rx = random(0, width);
      ry = random(height, height+200);
      rd = random(-110, -70);
    } else if (randomAssignment == 2) {
      rx = random(-100, 0);
      ry = random(100, height-100);
      rd = random(-20, 20);
    } else {
      rx = random(width, width+100);
      ry = random(0, height);
      rd = random(170, 210);
    }
    rs = random(baseSpeed + .1, baseSpeed + .4);
    rsize = random(30, 50);
    Asteroid a =  new Asteroid(rx, ry, rs, rd, rsize);
    asteroids.add(a); //x, y, speed, direction, hypotenuse
  }
}
//


//RESET GAME
void resetGame() {
  level = 0;
  baseSpeed = 0;
  player1.lives = 4;
  killCount = 0;
  shotCount = 0;
  gameOver = false;
  player1 = new Spaceship(width/2, height/2, 0, 180, 30); //x, y, speed, direction, size
  setupAsteroids();
}
//
