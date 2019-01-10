Asteroid[] asteroids = new Asteroid[10];
Star[] starField = new Star[100];
Bullet[] bullets = new Bullet[10];
Spaceship player1;
float rx, ry, rs, rsize, angle, rd, baseSpeed; //rock x, y, size, angle, direction, and base speed(increments)
float sx, sy, ssize, sspeed; //star x, y, size, and speed
int shotIndex;
boolean gameOver;

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
  //initialize your asteroid array and fill it
  //setupAsteroids();
  for (int i = 0; i<asteroids.length; i++) {
    rx = random(0, width);
    ry = random(0, height);
    rs = random(.5, 1);
    rd = random(0, 360);
    asteroids[i] = new Asteroid(rx, ry, rs, rd);
  }

  //initialize ship
  player1 = new Spaceship(width/2, height/2, 0, 180);
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
  for (int i = 0; i<asteroids.length; i++) {
    asteroids[i].show();
    asteroids[i].move();
  }


  //Update spaceship
  //TODO: Part I
  player1.update();
  player1.move();

  //Check for ship collision agaist asteroids
  //TODO: Part II or III

  //Draw spaceship & and its bullets
  //TODO: Part I, for now just render ship
  player1.show();
  for(int i = 0; i<bullets.length-1; i++){
    if(bullets[i] != null){
      bullets[i].move();
      bullets[i].show();
      if(bullets[i].dud){
        bullets[i] = null;
      }
    }
  }

  //TODO: Part IV - we will use a new feature in Java called an ArrayList, 
  //so for now we'll just leave this comment and come back to it in a bit. 

  //Update score
  //TODO: Keep track of a score and output the score at the top right
}


/* * * * * * * * * * * * * * * * * * * * * * *
 Record relevent mouse presses for our game
 */

void mousePressed() {
  //add shooting stuff here
  if (shotIndex < bullets.length-1) {
    bullets[shotIndex] = new Bullet(player1.location.x, player1.location.y, 5, player1.direction);
    shotIndex++;
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
