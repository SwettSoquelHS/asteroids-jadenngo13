/*
  Spaceship class
 Should extend Mover class and implement show.
 You may add additional methods to this class, for example "rotate" and "accelerate" 
 might be useful.
 */
class Spaceship extends Mover {
  float hitbox; //ship x, y, hitbox, speed, and direction
  boolean FORWARD, RLEFT, RRIGHT;
  int lives;

  Spaceship(float x, float y, float speed, float direction, float size) {
    super(x, y, speed, direction, size);
    lives = 4;
    this.size = 30;
  }

  void show() {
    pushMatrix();
    translate(location.x, location.y);
    rotate(radians(direction));
    rotate(1.56);
    fill(#0DBCFF);
    triangle(0, -20, 10, 5, -10, 5); //ship body

    beginShape(); //force field
    fill(0, 0, 0, 0);
    stroke(#FF520D);
    if (lives == 4) {
      ellipse(0, -5, 40, 40); //inner
      ellipse(0, -5, 50, 50); //middle
      ellipse(0, -5, 60, 60); //outer
      hitbox = 30;
    } else if (lives == 3) {
      ellipse(0, -5, 40, 40);
      ellipse(0, -5, 50, 50); //middle
      hitbox = 25;
    } else if (lives == 2) {
      ellipse(0, -5, 40, 40);
      hitbox = 20;
    } else {
      hitbox= 5;
    }
    this.size = hitbox*2;
    endShape(); //end force field
    noStroke();
    popMatrix();
  }

  void update() {
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

    //testing out of bounds
    if (location.x > width+size) {
      location.x = -size;
    } else if (location.x < -size) {
      location.x = width+size;
    } else if (location.y > height+size) {
      location.y = -size;
    } else if (location.y < -size) {
      location.y = height+size;
    } 

    super.update();
  }

  float getX() {
    return location.x;
  }

  float getY() {
    return location.y;
  }

  float getDirection() {
    return direction;
  }

  float getRadius() {
    return hitbox/2;
  }

  float getSpeed() {
    return speed;
  }

  float getHypotenuse() {
    return 0;
  }

  void setDirection(float newDirectionInDegrees) {
    direction = newDirectionInDegrees;
  }

  void setSpeed(float newSpeed) {
    speed = newSpeed;
  }
}
