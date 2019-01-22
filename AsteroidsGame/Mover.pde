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

  float getM();

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
  Sets the X velocity value
   */
  void setVelocityX(float x);

  /*
  Sets the Y velocity value
   */
  void setVelocityY(float y);

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
}
//END OF Movable Interface




/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 Abstract base class Mover 
 */
abstract class Mover implements Movable {// implements Movable {

  protected PVector location, velocity;
  protected float direction, speed, size;
  protected int myColor;
  protected float radius, m;  

  /*
    Default Mover, not actually moving and directionless
   */
  /*Mover(float x, float y) {
   //The line below shows how we can 
   //link this constructor to the constructor below through "this"
   this(x, y, 0, 0);
   }*/

  /*
    Mover constructor specifying x, y position along with its speed and
   direction (in degrees)
   */
  Mover(float x, float y, float speed, float direction, float size) {
    location = new PVector(x, y);
    velocity = new PVector(speed*(float)Math.cos(radians(direction)), 
      speed*(float)Math.sin(radians(direction)));
    this.direction = direction;
    this.speed = speed;
    this.size = size;
    myColor = 225;
    radius = size/2;
    m = radius*.1;
  }

  /*
    Most of your movalbe objects should follow this pattern.
   */
  void update() {
    location.x += velocity.x; //update x and y
    location.y += velocity.y;
    location.x = location.x + speed*(float)Math.cos(radians(direction));
    location.y = location.y + speed*(float)Math.sin(radians(direction));
  }



  /*
    Save this for your subclasses to override.
   but notice how it is tagged with abstract, meaning 
   it is incomplete. (It's like an I.O.U.)
   */
  abstract void show();


  /*
    TODO: Part 4: Implement collision detection
   */
  boolean collidingWith(Movable object) {
    float distance = (object.getRadius())+ (size/2);
    return(dist(location.x, location.y, object.getX(), object.getY()) < distance);
  }

  void collision(Movable object) {

    //object PVector location
    PVector objectLocation = new PVector(object.getX(), object.getY());
    System.out.println("RIGHT BEFORE: " + object.getVelocityX() + " " + object.getVelocityY());
    System.out.println("LEFT BEFORE: " + velocity.x + " " + velocity.y);

    //distance between asteroids
    PVector distanceVect = PVector.sub(objectLocation, location);

    //Magnitude of the vector separating the balls
    float distanceVectMag = distanceVect.mag();

    // Minimum distance before they are touching
    float minDistance = (size/2) + object.getRadius();

    if (distanceVectMag < minDistance) {
      float distanceCorrection = (minDistance-distanceVectMag)/2.0;
      PVector d = distanceVect.copy();
      PVector correctionVector = d.normalize().mult(distanceCorrection);
      objectLocation.add(correctionVector);
      location.sub(correctionVector);

      // get angle of distanceVect
      float theta  = distanceVect.heading();
      // precalculate trig values
      float sine = sin(theta);
      float cosine = cos(theta);

      /* bTemp will hold rotated ball positions. You 
       just need to worry about bTemp[1] position*/
      PVector[] bTemp = {
        new PVector(), new PVector()
      };

      /* this ball's position is relative to the object
       so you can use the vector between them (bVect) as the 
       reference point in the rotation expressions.
       bTemp[0].position.x and bTemp[0].position.y will initialize
       automatically to 0.0, which is what you want
       since b[1] will rotate around b[0] */
      bTemp[1].x  = cosine * distanceVect.x + sine * distanceVect.y;
      bTemp[1].y  = cosine * distanceVect.y - sine * distanceVect.x;

      // rotate Temporary velocities
      PVector[] vTemp = {
        new PVector(), new PVector()
      };

      vTemp[0].x  = cosine * velocity.x + sine * velocity.y;
      vTemp[0].y  = cosine * velocity.y - sine * velocity.x;
      vTemp[1].x  = cosine * object.getVelocityX() + sine * object.getVelocityY();
      vTemp[1].y  = cosine * object.getVelocityY() - sine * object.getVelocityX();

      /* Now that velocities are rotated, you can use 1D
       conservation of momentum equations to calculate 
       the final velocity along the x-axis. */
      PVector[] vFinal = {  
        new PVector(), new PVector()
      };

      // final rotated velocity for b[0]
      vFinal[0].x = ((m - object.getM()) * vTemp[0].x + 2 * object.getM() * vTemp[1].x) / (m + object.getM());
      vFinal[0].y = vTemp[0].y;

      // final rotated velocity for b[0]
      vFinal[1].x = ((object.getM() - m) * vTemp[1].x + 2 * m * vTemp[0].x) / (m + object.getM());
      vFinal[1].y = vTemp[1].y;

      // hack to avoid clumping
      bTemp[0].x += vFinal[0].x;
      bTemp[1].x += vFinal[1].x;

      /* Rotate ball positions and velocities back
       Reverse signs in trig expressions to rotate 
       in the opposite direction */
      // rotate balls
      PVector[] bFinal = { 
        new PVector(), new PVector()
      };

      bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
      bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
      bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
      bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;

      // update balls to screen position
      object.setLocationX(location.x + bFinal[1].x);
      object.setLocationY(location.y + bFinal[1].y);

      location.add(bFinal[0]);

      // update velocities
      velocity.x = cosine * vFinal[0].x - sine * vFinal[0].y;
      velocity.y = cosine * vFinal[0].y + sine * vFinal[0].x;
      object.setVelocityX(cosine * vFinal[1].x - sine * vFinal[1].y);
      object.setVelocityY(cosine * vFinal[1].y + sine * vFinal[1].x);

      System.out.println("RIGHT AFTER: " + object.getVelocityX() + " " + object.getVelocityY());
      System.out.println("LEFT AFTER: " + velocity.x + " " + velocity.y);
    }
  }
}

//TODO: Part I: implement the methods of Moveable interface - delete this comment
