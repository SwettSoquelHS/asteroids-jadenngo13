/*
  Asteroid class
 Should extend Mover class and implement show.
 
 Initially, your asteroid may just be a simple circle or square
 but the final program should use "beginShape(), vertex(), and endShape()"
 to render the asteroid.
 */
class Asteroid extends Mover {   
  float x, y, speed, direction;
  PVector location, velocity;

  Asteroid(float x, float y, float speed, float direction) {
    super(x, y, speed, direction);
    location = new PVector(x, y);
    velocity = new PVector(speed*(float)Math.cos(radians(direction)), 
      speed*(float)Math.sin(radians(direction)));
    this.speed = speed;
    this.direction = direction;
  }

  void show() {
    fill(255);
    ellipse(location.x, location.y, 10, 10);
  }

  void move() {
    location.x += velocity.x; //update x and y
    location.y += velocity.y;
    velocity.x = (speed*(float)Math.cos(radians(direction))); //update direction
    velocity.y = (speed*(float)Math.sin(radians(direction)));
    
    //System.out.println(direction);
    if (location.x > width || location.x < 0
      || location.y > height || location.y < 0) {
        //direction -= random(160, 190);
        direction *= -1;
    }
  }
}
