class Clock
{
  float dt = 1/60.0;

  private float _prevMS = 0;

  void update()
  {
    var ms = millis();
    dt = (ms - _prevMS) / 1000.0;
    _prevMS = ms;
  }
}

class Vector2
{
  float x;
  float y;
  
  Vector2() {}
  Vector2(float v)
  {
    x = v;
    y = v;
  }
  Vector2(float vx, float vy)
  {
    x = vx;
    y = vy;
  }
  
  float magnitudeSquared()
  {
    return x*x + y*y;
  }
  
  float magnitude()
  {
    return sqrt(x*x + y*y);
  }
}

class Entity
{
  String name;
  float x;
  float y;
  float size;
  color c;
  
  float heading;
  Vector2 velocity = new Vector2();

  Entity() {
    c = color(255);
  }

  Entity(float centerX, float centerY, float radius, color c)
  {
    this.x = centerX;
    this.y = centerY;
    this.size = radius;
    this.c = c;
  }

  float distanceFrom(Entity other)
  {
    var dx = this.x - other.x;
    var dy = this.y - other.y;
    return sqrt(dx*dx + dy*dy);
  }

  Boolean collidesWith(Entity other)
  {
    var d = distanceFrom(other);
    var sumOfRadii = other.size + this.size;
    return d <= sumOfRadii;
  }

  void draw()
  {
    drawBounds();
    print();
  }

  /// Draw the bounding circle for this Entity
  void drawBounds()
  {
    push();
    stroke(c);
    noFill();
    translate(x, y);
    ellipseMode(RADIUS);
    circle(0, 0, size);
    pop();
  }

  void update()
  {
    //var dx = moveDistance * cos(radians(heading));
    //var dy = moveDistance * sin(radians(heading));
    x += clock.dt * velocity.x;
    y += clock.dt * velocity.y;
  }
  
  void accelerate(float dv)
  {
    velocity.x += dv * cos(radians(heading));
    velocity.y += dv * sin(radians(heading));
  }

  void printAt(float tx, float ty)
  {    
    text("X = " + round(x, 2), tx, ty);
    text("Y = " + round(y, 2), tx, ty + 24);
    text("V = " + round(velocity.x,2) + "," + round(velocity.y,2), tx, ty + 24*2);
  }
  
  void print()
  {
    print(16);
  }

  void print(float fontSize)
  {
    push();
    
    textSize(fontSize);
    var px = x + size;
    var py = y + size;
    text(name,px, py += fontSize);
    text("X = " + round(x,2), px, py += fontSize);
    text("Y = " + round(y,2), px, py += fontSize);
    text("Size = " + round(size,2), px, py += fontSize);
    
    pop();
  }
}

class Ship extends Entity
{
  Ship(float centerX, float centerY, float radius, color c)
  {
    super(centerX, centerY, radius, c);
  }


  void draw()
  {
    super.draw();

    push();
    noFill();
    stroke(c);

    translate(x, y);
    rotate(radians(heading - 90));
    scale(size);
    strokeWeight(2.0/size);
    line(0, 1, 0.5, -1);
    line(0, 1, -0.5, -1);

    pop();
  }
}

void drawGrid(int cellSize)
{
  strokeWeight(1);
  for (float i=0; i <= height; i += cellSize)
  {
    line(0, i, width, i);
  }
  for (float i=0; i < width; i += cellSize)
  {
    line(i, 0, i, height);
  }
}

void labelLine(float x0, float y0, float x1, float y1, String label)
{
  noFill();
  line(x0, y0, x1, y1);
  var tx = (x0 + x1) / 2.0;
  var ty = (y0 + y1) / 2.0;
  text(label, tx, ty - 32);
  line(tx,ty,tx,ty-32);
}


float round(float val, int places)
{
  int scalar = (int)pow(10, 2);
  float t = val * scalar;
  t = round(t) * 1.0 / scalar;
  return t;
}
