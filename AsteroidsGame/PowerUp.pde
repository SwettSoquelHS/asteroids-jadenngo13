class PowerUp extends Mover {
  boolean dud;
  float life, oscillate, r, s;
  int type; //not used yet but will be if chosen to make diff types of power ups

  PowerUp(float x, float y, float speed, float direction, float size) {
    super(x, y, speed, direction, size);
    dud = false;
    life = 10;
    oscillate = 0;
    r = 0;
  }

  void show() {
    fill(#8D0EA7);
    ellipse(location.x, location.y, size, size);
    fill(#F4F50C);
    if (r > 100) {
      r = 0;
    } else {
      r+=1;
    }
    oscillate = (float)Math.sin(radians((r)))*25;
    ellipse(location.x, location.y, oscillate, oscillate);
  }

  void update() {
    location.x--;
    if (location.x < 0) {
      dud = true;
    }
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
      return size/2;
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

    void collision() {
    }
  }
