class Bubble {
  private int diameter = 75, t;
  PVector position;
  Bubble() {position = new PVector(random(width), -diameter); t = 0;}
  void applyForce(PVector force) {position.add(force);}
  private int startX() {return int(position.x - diameter / 2);}
  private int startY() {return int(position.y - diameter / 2);}
  private int wobbleX() {return int(sin(t) * 5);}
  private int wobbleY() {return int(cos(t) * 5);}
  void draw() {
    t += 1;
    pushStyle();
      noStroke();
      fill(10, 200, 200, 150);
      ellipse(
        position.x, position.y,
        diameter + wobbleX(), diameter + wobbleY());
      fill(255, 100);
      pushMatrix();
        translate(startX() + 15 + wobbleX() / 2, startY() + 15 + wobbleY() / 2);
        rotate(radians(45));
        rect(0, 0, 10, 10);
      popMatrix();
    popStyle();
  }
  boolean collidesWith(PImage changes) {
    changes.loadPixels();
    for(int y = startY(); y < startY() + diameter - 1; y++)
    for(int x = startX(); x < startX() + diameter - 1; x++)
      if(y < changes.height && y > 0 && x < changes.width && x > 0)
        if(changes.pixels[x + y * changes.width] == color(255)) return true;
    return false;
  }
  boolean inFrame() {return position.y <= (height + diameter);}
}
