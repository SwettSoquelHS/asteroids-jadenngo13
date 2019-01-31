class Bullet extends Mover {
  boolean hit, dud;
  float size;

  Bullet(float x, float y, float speed, float direction, float size) {
    super(x, y, speed, direction, size);
    this.size = size;
  }

  void update() {
    if (dist(location.x, location.y, player1.location.x, player1.location.y)<300) {
      super.update();
    } else {
      dud = true;
    }
  }

  void show() {
    fill(#0DBCFF);
    ellipse(location.x, location.y, radius, radius);
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
    return size;
  }

  float getSize() {
    return size;
  }

  float getSpeed() {
    return speed;
  }

  float getHypotenuse() {
    return 0;
  }

  float getVelocityX() {
    return velocity.x;
  }

  float getVelocityY() {
    return velocity.y;
  }

  void setVelocity(PVector v) {
    velocity = v;
  }

  void setLocationX(float x) {
    location.x = x;
  }

  void setLocationY(float y) {
    location.y = y;
  }
  void setDirection(float newDirectionInDegrees) {
    direction = newDirectionInDegrees;
  }

  void setSpeed(float newSpeed) {
    speed = newSpeed;
  }
  
  void collision(){
  }
}
