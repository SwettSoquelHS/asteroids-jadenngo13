/*
  Spaceship class
 Should extend Mover class and implement show.
 You may add additional methods to this class, for example "rotate" and "accelerate" 
 might be useful.
 */
class Spaceship extends Mover {
  float x, y, hitbox, speed, direction; //ship x, y, hitbox, speed, and direction
  float myColor, radius;
  boolean FORWARD, RLEFT, RRIGHT;
  int lives = 4;
  PVector location, velocity;

  Spaceship(float x, float y, float speed, float direction) {
    super(x, y, speed, direction);
    location = new PVector(x, y);
    velocity = new PVector(speed*(float)Math.cos(radians(direction)), 
      speed*(float)Math.sin(radians(direction)));
    this.speed = speed;
  }

  void show() {
    pushMatrix();
    translate(location.x, location.y);
    rotate(radians(direction));
    rotate(1.56);
    fill(#0DBCFF);
    triangle(0, -20, 10, 5, -10, 5); //ship body
    popMatrix();
  }

  void move() {
    if (ROTATE_LEFT)
      direction -= 2;
    if (ROTATE_RIGHT)
      direction += 2;

    //moving forward
    if (MOVE_FORWARD) {
      if (speed < 3) {
        speed += 0.2;
      }
    } else { //slowing down
      if (speed > 0)
        speed -= .05;
      if (speed < 0)
        speed = 0;
    }
    location.x += velocity.x; //update x and y
    location.y += velocity.y;
    velocity.x = (speed*(float)Math.cos(radians(direction))); //update direction
    velocity.y = (speed*(float)Math.sin(radians(direction)));
  }
}
