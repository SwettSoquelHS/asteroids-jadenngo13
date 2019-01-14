Asteroid[] asteroids = new Asteroid[10];
Asteroid[] brokenAsteroids = new Asteroid[20];
Star[] starField = new Star[100];
Bullet[] bullets = new Bullet[10];
Spaceship player1;
float rx, ry, rs, rsize, angle, rd, baseSpeed; //rock x, y, size, angle, direction, and base speed(increments)
float sx, sy, ssize, sspeed; //star x, y, size, and speed
int shotIndex, brokenIndex; //shotIndex, brokenAsteroid index
boolean gameOver;
float score, shotCount, killCount;
String stats;

/*
  Track User keyboard input
 */
boolean ROTATE_LEFT;  //User is pressing <-
boolean ROTATE_RIGHT; //User is pressing ->
boolean MOVE_FORWARD; //User is pressing ^ arrow


/* * * * * * * * * * * * * * * * * * * * * * *
 Initialize all of your variables and game state here
 */
public void setup() {
  size(800, 600);

  //initialize asteroids
  //setupAsteroids();
  for (int i = 0; i<asteroids.length; i++) {
    rx = random(0, width);
    ry = random(0, height);
    rs = random(.2, .6);
    rd = random(0, 360);
    rsize = random(20, 50);
    asteroids[i] = new Asteroid(rx, ry, rs, rd, rsize);
  }

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

  //Starfield
  for (int i = 0; i<starField.length; i++) {
    starField[i].show();
    if (!gameOver)
      starField[i].move();
  }

  //Bullet Collision
  for (int i = 0; i<bullets.length; i++) {
    if (bullets[i] != null) {
      for (int j = 0; j<asteroids.length; j++) {
        if (asteroids[j] != null) {
          if (bullets[i].collidingWith(asteroids[j])) {
            brokenIndex++;
            killCount++;
            bullets[i].hit = true;
            asteroids[j] = null;
            brokenAsteroids[brokenIndex]
          }
        }
      }
    }
  }

  //Check for asteroid collisions against other asteroids and alter course
  //TODO: Part III, for now keep this comment in place

  //Draw Asteroids
  for (int i = 0; i<asteroids.length; i++) {
    if (asteroids[i] != null) {
      asteroids[i].show();
      asteroids[i].update();
      for (int j = 0; j<asteroids.length; j++) {
        if (asteroids[i] != asteroids[j] && asteroids[j] != null) {
          if (asteroids[i].collidingWith(asteroids[j]))
            System.out.println("");
        }
      }
    }
  }

  //Draw brokenAsteroids (if any)
  for (int i = 0; i<brokenAsteroids.length; i++) {
    if (brokenAsteroids[i] != null) {
      brokenAsteroids[i].show();
      brokenAsteroids[i].update();
    }
  }

  //Spaceship
  player1.show();
  player1.update();
  for (int i = 0; i<asteroids.length; i++) {
    if (asteroids[i] != null) {
      if (player1.collidingWith(asteroids[i])) {
        asteroids[i] = null;
        player1.lives--;
      }
    }
  }

  //System.out.println(dist(player1.location.x, player1.location.y, 
  //    asteroids[0].getX(), asteroids[0].getY()));

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
    "\n Level: ";
  score = round((100*(killCount/shotCount) + 100*(killCount)));
  fill(#FF520D);
  textSize(12);
  text(stats, 30, 30);
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
}


//setup for asteroids
/*void setupAsteroids() {
 for (int i = 0; i<asteroids.length; i++) {
 randomAssignment = (int)random(0, 3);
 if (randomAssignment == 0) {
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
 rsides = 8;
 rs = random(baseSpeed + .1, baseSpeed + .4);
 rsize = random(30, 50);
 asteroids[i] = new Asteroid(rx, ry, rs, rsize, rd, rsides, 1); //x, y, speed, direction, sides, hypotenuse
 }
 } */
