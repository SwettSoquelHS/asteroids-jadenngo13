class Star {
  float x, y, size, speed;

  Star(float x, float y, float size, float speed) {
    this.x = x;
    this.y = y;
    this.size = size;
    if (size < 3)
      speed /= 2;
    this.speed = speed;
  }

  void show() {
    fill(250);
    ellipse(x, y, size, size);
  }

  void move() {
    if (x < 0 || y > height) {
      x = width;
      y = random(0, height);
    } 
    x -= speed;
  }
}
