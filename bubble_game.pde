import processing.video.*;
Capture cap;
PImage last, current, changes;
ArrayList bubbles;
int score;
void setup() {
  size(320, 240);
  smooth();
  cap = new Capture(this, width, height, 120);
  last = createImage(width, height, RGB);
  current = createImage(width, height, RGB);
  changes = createImage(width, height, RGB);
  bubbles = new ArrayList();
  score = 0;
}
void draw() {
  if(cap.available()) {
    cap.read();
    current = flipHorizontal(cap);
    changes.copy(last, 0, 0, width, height, 0, 0, width, height);
    changes.blend(current, 0, 0, width, height, 0, 0, width, height, DIFFERENCE);
    changes.filter(GRAY);
    changes.filter(BLUR);
    changes.filter(THRESHOLD, 0.07);
    last.copy(current, 0, 0, width, height, 0, 0, width, height);
  }
  image(current, 0, 0);
  Iterator it = bubbles.iterator();
  while(it.hasNext()) {
    Bubble bubble = (Bubble) it.next();
    bubble.applyForce(new PVector(0, height / 100));
    bubble.draw();
    if(bubble.collidesWith(changes)) {
      score += 1;
      it.remove();
    }
    if(!bubble.inFrame()) it.remove();
  }
  if(random(100) > 75) {
    bubbles.add(new Bubble());
  }
  text("Move around to pop the bubbles!", 10, 15);
  text("Bubbles popped: " + score, 10, 35);
}
PImage flipHorizontal(PImage src) {
  PImage dst = createImage(width, height, RGB);
  src.loadPixels();
  dst.loadPixels();
  for(int i = 0; i < width; i++)
  for(int j = 0; j < height; j++)
    dst.pixels[j * width + i] = src.pixels[(width - i - 1) + j * width];
  dst.updatePixels();
  return dst;
}
