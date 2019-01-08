/*
  Spaceship class
 Should extend Mover class and implement show.
 You may add additional methods to this class, for example "rotate" and "accelerate" 
 might be useful.
 */
class Spaceship {
  float x, y, hitbox, speed, direction; //ship x, y, hitbox, speed, and direction
  boolean FORWARD, RLEFT, RRIGHT;
  int lives = 4;

  Spaceship(float x, float y, float hitbox, float speed, float direction, int lives) {
    this.x = x;
    this.y = y;
    this.hitbox = hitbox;
    this.speed = speed;
    this.direction = direction;
    this.lives = lives;
  }
}
