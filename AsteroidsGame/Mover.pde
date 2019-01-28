/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 All objects in this world that move must implemnt the Movable interface.
 */
interface Movable {
  /*
    Return the x location of the Movable
   */
  float getX();

  /*
    Return the y location of the Movable
   */
  float getY();

  /*
    Return the direction of the Movable in degrees.
   */
  float getDirection();

  /*
   Return the speed of the Movable.
   The speed you use is a relative value and will
   feel different for different frame rates. For example,
   if frameRate is set to 48, then a speed of 1 would move 48 pixels 
   per second.
   */
  float getSpeed();

  /*
   Return the radius of influence. If you could draw a circle
   around your object, then what would this radius be.
   */
  float getRadius();

  /*
  Return the m value (used for hit detection)
   */

  float getSize();

  /*
    Returns hypotenuse value of asteroid
   */
  float getHypotenuse();

  /*
    Returns the X velocity value
   */
  float getVelocityX();

  /*
    Returns the Y velocity value
   */
  float getVelocityY();

  /* 
   Sets the direction of the Movable
   */
  void setDirection(float newDirectionInDegrees);

  /* 
   Sets the speed of the Movable
   */
  void setSpeed(float newSpeed);

  /*
  Sets the velocity of the Movable
   */
  void setVelocity(PVector v);

  /*
  Sets the X location value
   */
  void setLocationX(float x);

  /*
  Sets the Y location value
   */
  void setLocationY(float y);

  /*
   Update the internals of the instance
   */
  void update(); 

  /*
    Display the isntance
   */
  void show();

  /*
   Return true if the instance of Movable is "colliding with" 
   the movable referred to by object.  *Note* An object should not
   be able to collide with iteself.
   */
  boolean collidingWith(Movable object);
  
  void collision();
  
}
//END OF Movable Interface




/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 Abstract base class Mover 
 */
abstract class Mover implements Movable {// implements Movable {

  protected PVector location, velocity;
  protected float direction, speed, size;
  protected int myColor;
  protected float radius;  

  //CONSTRUCTOR
  Mover(float x, float y, float speed, float direction, float size) {
    location = new PVector(x, y);
    velocity = new PVector(speed*(float)Math.cos(radians(direction)), 
      speed*(float)Math.sin(radians(direction)));
    this.direction = direction;
    this.speed = speed;
    this.size = size;
    myColor = 225;
    radius = size/2;
  }
  //
  

  //UPDATE WORK
  void update() {
    location.x += velocity.x; //update x and y
    location.y += velocity.y;
    location.x = location.x + speed*(float)Math.cos(radians(direction));
    location.y = location.y + speed*(float)Math.sin(radians(direction));
  }
  //
  
  
  //Show function overridden in each class object
  abstract void show();

  
  //HIT DETECTION WORK
  boolean collidingWith(Movable object) {
    float distance = (object.getRadius())+ (size/2);
    return(dist(location.x, location.y, object.getX(), object.getY()) < distance);
  }
  //
  
  
  //COLLISION WORK (new velocities)
  void collision(Movable object) {
    PVector finalVel;

    finalVel = new PVector( .95*((2*size*velocity.x)+(object.getVelocityX()*(object.getSize()-size)))/(object.getSize()+size) ,  
      .95*((2*size*velocity.y)+(object.getVelocityY()*(object.getSize()-size)))/(object.getSize()+size) );
      
    velocity = finalVel;
  }
  //
}
