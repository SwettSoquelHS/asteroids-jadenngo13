Asteroid[] asteroids = new Asteroid[10];
Asteroid[] brokenAsteroids = new Asteroid[20];
Star[] starField = new Star[100];
Bullet[] bullets = new Bullet[10];
Spaceship player1;
float rx, ry, rs, rsize, angle, rd, baseSpeed; //rock x, y, size, angle, direction, and base speed(increments)
float brokenDirection; //direction for broken asteroids
float sx, sy, ssize, sspeed; //star x, y, size, and speed
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

  //initialize asteroids
  //setupAsteroids();
  /*  for (int i = 0; i<asteroids.length; i++) {
   rx = random(0, width);
   ry = random(0, height);
   rs = random(.2, .6);
   rd = random(0, 360);
   rsize = random(30, 60);
   asteroids[i] = new Asteroid(rx, ry, rs, rd, rsize);
   } */

  //setup asteroids
  setupAsteroids(); //(on line 258)
  for (int i = 0; i<brokenAsteroids.length; i++) {
    brokenAsteroids[i] = null;
  }

  //initialize ship
  player1 = new Spaceship(width/2, height/2, 0, 180, 30); //x, y, speed, direction, size
  for (int i = 0; i<bullets.length; i++) {
    bullets[i] = null;
  }
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

  //game mechanics
  timer = millis() / 1000;

  //Starfield
  for (int i = 0; i<starField.length; i++) {
    starField[i].show();
    if (!gameOver)
      starField[i].move();
  }

  //Check for asteroid collisions against other asteroids and alter course
  //TODO: Part III, for now keep this comment in place

  //Bullet Collision
  for (int i = 0; i<bullets.length; i++) {
    if (bullets[i] != null) {
      for (int j = 0; j<asteroids.length; j++) { //collision with asteroids
        if (asteroids[j] != null && bullets[i].collidingWith(asteroids[j])) {
          killCount++;
          bullets[i].hit = true;
          asteroids[j].hit = true;
        }
      }
      for (int k = 0; k<brokenAsteroids.length; k++) {
        if (brokenAsteroids[k] != null) {
          if (bullets[i].collidingWith(brokenAsteroids[k])) {
            bullets[i].hit = true;
            brokenAsteroids[k].hit = true;
          }
        }
      }
    }
  }

  //Draw Asteroids
  for (int i = 0; i<asteroids.length; i++) {
    if (asteroids[i] != null) {
      asteroids[i].show();
      asteroids[i].update();
      checkOnAsteroids();
      if (asteroids[i].hit) {
        for (int k = brokenIndex; k<brokenIndex+2; k++) { //make two new broken asteroids
          brokenDirection = random(0, 360);
          brokenAsteroids[k] = new Asteroid(asteroids[i].location.x, asteroids[i].location.y, 
            asteroids[i].speed/2, brokenDirection, asteroids[i].getHypotenuse()/2);
        }
        brokenIndex += 2;
        asteroids[i] = null;
      }
    }
  }

  //Draw brokenAsteroids (if any)
  for (int i = 0; i<brokenAsteroids.length; i++) {
    if (brokenAsteroids[i] != null) {
      brokenAsteroids[i].show();
      brokenAsteroids[i].update();
      if (brokenAsteroids[i].hit)
        brokenAsteroids[i] = null;
    }
  }

  //Spaceship
  player1.show();
  player1.update();
  for (int i = 0; i<asteroids.length; i++) { //asteroid collision
    if (asteroids[i] != null) {
      if (player1.collidingWith(asteroids[i])) {
        asteroids[i] = null;
        player1.lives--;
      }
    }
  }
  for (int i = 0; i<brokenAsteroids.length; i++) { //broken asteroid collision
    if (brokenAsteroids[i] != null) {
      if (player1.collidingWith(brokenAsteroids[i])) {
        brokenAsteroids[i] = null;
        player1.lives--;
      }
    }
  }
  if (HYPERSPACE) {
    player1.hyperArea += 4;
    player1.hyperSpace();
  }

  System.out.println(player1.test.x + " " + player1.test.y);

  //Bullets
  for (int i = 0; i<bullets.length-1; i++) {
    if (bullets[i] != null) {
      bullets[i].update();
      bullets[i].show();
      if (bullets[i].dud || bullets[i].hit) {
        bullets[i] = null;
      }
    }
  }

  //TODO: Part IV - we will use a new feature in Java called an ArrayList, 
  //so for now we'll just leave this comment and come back to it in a bit. 

  //Stats
  stats = "Total Score: " + score +
    "\n Total Lives: " + player1.lives + 
    "\n Level: " + level;
  score = round((100*(killCount/shotCount) + 100*(killCount)));
  fill(#FF520D);
  textSize(12);
  text(stats, 30, 30);

  //Game status
  gameUpdate();
  if (nextLevel) {
    level++;
    setupAsteroids();
    brokenIndex = 0;
    if (level % 3 == 0) {
      if (player1.lives < 4)
        player1.lives++;
    }
  }
  if (gameOver) {
    fill(#FA1703);
    textSize(40);
    text(gameOverScreen, (width/2)-100, height/2);
    textSize(20);
    text(gameOverInstruct, (width/2)-75, (height/2)+50);
  }
}


/* * * * * * * * * * * * * * * * * * * * * * *
 Record relevent mouse presses for our game
 */

void mousePressed() {
  //add shooting stuff here
  if (shotIndex < bullets.length-1) {
    bullets[shotIndex] = new Bullet(player1.location.x, player1.location.y, 2, player1.direction, 10);
    shotIndex++;
    shotCount++;
  } else {
    shotIndex = 0;
  }
}

/* * * * * * * * * * * * * * * * * * * * * * *
 Record relevent key presses for our game
 */
void keyPressed() {
  if (key == 'a') {
    ROTATE_LEFT = true;
  } else if ( key == 'd' ) {
    ROTATE_RIGHT = true;
  } else if (key == 'w') {
    MOVE_FORWARD = true;
  }
  if (key == CODED) {
    if (keyCode == SHIFT) {
      HYPERSPACE = true;
    }
  }
}



/* * * * * * * * * * * * * * * * * * * * * * *
 Record relevant key releases for our game.
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


void checkOnAsteroids() {
  for (int i = 0; i<asteroids.length; i++) {
    if (asteroids[i] != null) {
      Asteroid a1 = asteroids[i];
      for (int j = 0; j<asteroids.length; j++) {
        if (asteroids[j] != null) {
          Asteroid a2 = asteroids[j];
          if (a1 != a2 && a1.collidingWith(a2)) {
            //enter work
          }
        }
      }
    }
  }
}

void gameUpdate() {
  nextLevel = true;
  for (int i = 0; i<asteroids.length; i++) {
    if (asteroids[i] != null) {
      nextLevel = false;
    }
  }
  for (int i = 0; i<brokenAsteroids.length; i++) {
    if (brokenAsteroids[i] != null) {
      nextLevel = false;
    }
  }
  if (player1.lives == 0) {
    gameOver = true;
  }
}

//setup for asteroids
void setupAsteroids() {
  int randomAssignment;
  for (int i = 0; i<asteroids.length; i++) {
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
    asteroids[i] = new Asteroid(rx, ry, rs, rd, rsize); //x, y, speed, direction, hypotenuse
  }
}
