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
    ellipse(location.x, location.y, size, size);
  }
}
