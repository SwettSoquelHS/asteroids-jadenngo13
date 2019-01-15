/*
  Asteroid class
 Should extend Mover class and implement show.
 
 Initially, your asteroid may just be a simple circle or square
 but the final program should use "beginShape(), vertex(), and endShape()"
 to render the asteroid.
 */
class Asteroid extends Mover {   
  float hypotenuse, rotation;
  float[] offSet = new float[8];
  PVector[] coordinates = new PVector[8];
  boolean hit;

  Asteroid(float x, float y, float speed, float direction, float size) {
    super(x, y, speed, direction, size);
    rotation = 360/8;
    //this.hypotenuse = size*((float)Math.random()+1);
    this.hypotenuse = random(size-1, size+1);
    for (int i = 0; i<offSet.length; i++) {
      offSet[i] = random(-5, 5);
    }
    for (int i = 0; i<coordinates.length; i++) {
      coordinates[i] = new PVector((this.hypotenuse*(float)Math.cos(radians(rotation)))+offSet[i], (this.hypotenuse*(float)Math.sin(radians(rotation)))+offSet[i]);
      rotation += random(40, 50);
    }
    this.size = dist(coordinates[0].x, coordinates[0].y, coordinates[3].x, coordinates[3].y);
  }

  void show() {
    stroke(255);
    pushMatrix();
    translate(location.x, location.y);
    beginShape();
    stroke(250);
    fill(#2E1708);
    for (int i = 0; i<coordinates.length; i++) {
      vertex(coordinates[i].x, coordinates[i].y);
    }
    endShape(CLOSE);
    popMatrix();
  }

  void update() {
   // System.out.println("Velocity x: " + velocity.x + " Vecloity y: " + velocity.y + " Direction: " + direction);
    //System.out.println("Location x: " + location.x + " Location y: " + location.y);
    
    //testing out of bounds
    if(location.x > width+size){
      location.x = -size;
    } else if(location.x < -size){
      location.x = width+size;
    } else if(location.y > height+size){
      location.y = -size;
    } else if(location.y < -size){
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
    return size/2;
  }

  float getSpeed() {
    return speed;
  }
  
  float getHypotenuse(){
    return hypotenuse;
  }
  
  void setDirection(float newDirectionInDegrees) {
    direction = newDirectionInDegrees;
  }

  void setSpeed(float newSpeed) {
    speed = newSpeed;
  }
}
