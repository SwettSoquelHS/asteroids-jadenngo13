Asteroid[] asteroids;
Star[] starField = new Star[100];
//Bullet[] shot = new Bullet[10];
Spaceship player1;
boolean nextLevel, gameOver; //next level boolean, game over boolean
int shipLives, level;
float rx, ry, rs, rsize, angle, rd, baseSpeed; //rock x, y, size, angle, direction, and base speed(increments)
int rsides; //number of sides on each asteroid
float sx, sy, ssize, sspeed; //star x, y, size, and speed
int index = -1; //shot index
int shotCount, killCount;
int brokenIndex, randomAssignment; //used for making brokenRocks, used for setting up rocks
float randomDirection; //broken asteroid direction
int toggleEndScreen; //used for GameOverScreen
String stats, lives, gameOverScreen, gameOverInstruct;


/*
  Track User keyboard input
 */
boolean ROTATE_LEFT;  //User is pressing <-
boolean ROTATE_RIGHT; //User is pressing ->
boolean MOVE_FORWARD; //User is pressing ^ arrow
boolean SPACE_BAR;    //User is pressing space bar


/* * * * * * * * * * * * * * * * * * * * * * *
 Initialize all of your variables and game state here
 */
public void setup() {
  size(800, 600);

  //initialize your asteroid array and fill it
  //setupAsteroids();

  //initialize ship
  player1 = new Spaceship(width/2, height/2, 30, 0, 180, 4);

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
  //your code here
  background(0);

  //Draw Starfield first
  for (int i = 0; i<starField.length; i++) {
    starField[i].show();
    if (!gameOver)
      starField[i].move();
  }

  //Check bullet collisions
  //TODO: Part III or IV - for not just leave this comment

  //TODO: Part II, Update each of the Asteroids internals

  //Check for asteroid collisions against other asteroids and alter course
  //TODO: Part III, for now keep this comment in place

  //Draw asteroids
  //TODO: Part II

  //Update spaceship
  //TODO: Part I

  //Check for ship collision agaist asteroids
  //TODO: Part II or III

  //Draw spaceship & and its bullets
  //TODO: Part I, for now just render ship
  //TODO: Part IV - we will use a new feature in Java called an ArrayList, 
  //so for now we'll just leave this comment and come back to it in a bit. 

  //Update score
  //TODO: Keep track of a score and output the score at the top right
}



/* * * * * * * * * * * * * * * * * * * * * * *
 Record relevent key presses for our game
 */
void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      ROTATE_LEFT = true;
    } else if ( keyCode == RIGHT ) {
      ROTATE_RIGHT = true;
    } else if (keyCode == UP) {
      MOVE_FORWARD = true;
    }
  }

  //32 is spacebar
  if (keyCode == 32) {  
    SPACE_BAR = true;
  }
}



/* * * * * * * * * * * * * * * * * * * * * * *
 Record relevant key releases for our game.
 */
void keyReleased() {  
  if (key == CODED) { 
    if (keyCode == LEFT) {
      ROTATE_LEFT = false;
    } else if ( keyCode == RIGHT ) {
      ROTATE_RIGHT = false;
    } else if (keyCode == UP) {
      MOVE_FORWARD = false;
    }
  }
  if (keyCode == 32) {
    SPACE_BAR = false;
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
