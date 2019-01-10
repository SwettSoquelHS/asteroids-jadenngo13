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

  Asteroid(float x, float y, float speed, float direction, float size) {
    super(x, y, speed, direction, size);
    rotation = 360/8;
    this.hypotenuse = size*((float)Math.random()+1);
    for (int i = 0; i<offSet.length; i++) {
      offSet[i] = random(-5, 5);
    }
    for (int i = 0; i<coordinates.length; i++) {
      coordinates[i] = new PVector((this.hypotenuse*(float)Math.cos(radians(rotation)))+offSet[i], (this.hypotenuse*(float)Math.sin(radians(rotation)))+offSet[i]);
      rotation += random(40, 50);
    }
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
    super.update();
    if(location.x + (size/2) > width){
      velocity.x *= -1;
    }
  }
}
