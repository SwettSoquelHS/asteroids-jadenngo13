class Bullet extends Mover {
  float x, y, speed, direction, size;
  boolean hit, dud;
  PVector location, velocity;

  Bullet(float x, float y, float speed, float direction) {
    super(x, y, speed, direction);
    location = new PVector(x, y);
    velocity = new PVector(speed*(float)Math.cos(radians(direction)), 
      speed*(float)Math.sin(radians(direction)));
    this.speed = speed;
    this.direction = direction;
    size = 10;
  }

  void move() {
    System.out.println("X: " + location.x + " Y: " + location.y);
    if (dist(location.x, location.y, player1.location.x, player1.location.y)<300) {
      location.x += velocity.x; //update x and y
      location.y += velocity.y;
      velocity.x = (speed*(float)Math.cos(radians(direction))); //update direction
      velocity.y = (speed*(float)Math.sin(radians(direction)));
    } else {
      dud = true;
    }
  }

  void show() {
    fill(#0DBCFF);
    ellipse(location.x, location.y, size, size);
  }
}
