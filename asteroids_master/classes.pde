int entityCount = 0;
class Entity
{
  Boolean enabled = true;
  Entity parent;
  ArrayList<Entity> children = new ArrayList<Entity>();
  String name;

  Entity()
  {
    name = "Entity " + entityCount++;
    //initialize();
  }

  void update() {
    if (!enabled)
      return;
    handleInput();
    for (var child : children)
    {
      child.update();
    }
  }
  void render() {
    if (!enabled)
      return;
    for (var child : children)
    {
      child.render();
    }
  }

  void initializeSelf() {
  }

  void initialize() {
    initializeSelf();
    for (var child : children)
    {
      child.initialize();
    }
  }

  void reset() {
    for (var child : children)
    {
      child.reset();
    }
  }

  void handleInput() {
  }
}

class Clock extends Entity
{
  private float _prevTime;
  float dt;

  Clock()
  {
    _prevTime = millis();
  }

  void update()
  {
    super.update();

    var ms = millis();
    dt = ms - _prevTime;
    _prevTime = ms;
  }

  float dtSecs()
  {
    return dt / 1000.0;
  }
}

class Moveable extends Entity
{
  PVector position = new PVector();
  PVector velocity = new PVector();
  float orientation;

  Moveable()
  {
    super();
  }

  Moveable(float x, float y, float orientation)
  {
    this();
    position = new PVector(x, y);
    this.orientation = orientation;
  }

  void accelerate(float dv)
  {
    velocity.x += dv * cos(radians(orientation));
    velocity.y += dv * sin(radians(orientation));
  }

  void update()
  {
    super.update();
    var dt = clock.dtSecs();
    var moveX = velocity.x * dt;
    var moveY = velocity.y * dt;
    //moveBy = moveBy * velocity * clock.dt;
    position.x += moveX;
    position.y += moveY;

    if (position.x < -width/2)
    {
      position.x += width;
    } else if (position.x >= width/2)
    {
      position.x -= width;
    }
    if (position.y < -height/2)
    {
      position.y += height;
    } else if (position.y >= height/2)
    {
      position.y -= height;
    }
  }

  void reset()
  {
    //super.reset();
    //position.x = 0;
    //position.y = 0;
    //orientation = 0;
    //velocity.x = 0;
    //velocity.y = 0;
  }
}



class Drawable extends Moveable
{
  float radius;
  color c = 255;

  float[] vertices;// = new float[0];

  Drawable() {
    super();
    //vertices = new float[0];
    this.c = color(255);
  }

  Drawable(float x, float y, float orientation, float radius)
  {
    this(x, y, radius);
    this.orientation = orientation;
  }

  Drawable(float x, float y, float radius)
  {
    this();
    position.x = x;
    position.y = y;
    this.radius = radius;
  }

  void prerender() {
    translate(position.x, position.y);
    rotate(radians(orientation));
    scale(radius);

    stroke(c);
    strokeWeight(2.0/radius);
  }

  void render()
  {
    push();
    prerender();

    if (null != vertices)
      for (var i=0; i < vertices.length; i += 4)
      {
        line(vertices[i],
          vertices[i+1],
          vertices[i+2],
          vertices[i+3]);
      }
    for (var child : children)
    {
      child.render();
    }

    postrender();
    pop();
  }

  void postrender()
  {
  }
}

class Ship extends Drawable
{
  Drawable thruster;
  Axes axes;

  Ship(float x, float y, float radius)
  {
    super(x, y, 0, radius);
  }

  Ship()
  {
    super();
    name = "Ship";
    radius = 10;
  }

  void initialize()
  {
    super.initialize();
    this.vertices = new float[] {
      -1, 0.5, 1, 0,
      -1, -0.5, 1, 0
    };

    thruster = new Thruster();
    thruster.parent = this;
    children.add(thruster);

    thruster.initialize();
    //axes = new Axes();
    //children.add(axes);
  }

  void accelerate(float dv)
  {
    super.accelerate(dv);
    thruster.accelerate(dv);
  }

  void prerender()
  {
    super.prerender();
    push();
    drawAxes(10);
    pop();
  }

  void reset()
  {
    super.reset();
    position.x = 0;
    position.y = 0;
    velocity.x = 0;
    velocity.y = 0;
    orientation = 0;
  }
}

class Thruster extends Drawable
{
  float lifetime = 0;

  void initialize()
  {
    name = "Thruster";
    vertices = new float[] {
      -1, +1, +1, +1,
      +1, +1, +1, -1,
      +1, -1, -1, -1,
      -1, -1, -1, +1
    };
    c = 255;
    position = new PVector(-1.3, 0);
  }

  void render()
  {
    if (lifetime > 0)
    {
      push();
      translate(position.x, position.y);
      rotate(orientation);
      noFill();
      triangle(0.5, 0.3, 0.5, -0.3, -1, 0);
      pop();
    }
  }

  void accelerate(float dv)
  {
    lifetime = 1;
  }

  void update()
  {
    if (lifetime > 0)
    {
      lifetime -= 0.1;
    }
  }
}

class Grid extends Drawable
{
  float cellSize = 32;

  Grid()
  {
    super(0, 0, width/2);
    vertices = new float[0];
  }

  void render()
  {
    super.render();
    push();

    translate(position.x, position.y);
    rotate(orientation);

    stroke(32);

    for (var i=-radius; i <= radius; i += 32)
    {
      line(-radius, i, radius, i);
      line(i, -radius, i, radius);
    }

    pop();
  }
}

class Axes extends Drawable
{
  void initialize()
  {
    super.initialize();
  }
  void render()
  {
    super.render();
    drawAxes(10);
  }
}

class Asteroid extends Drawable
{
  void initialize()
  {
    super.initialize();

    var numVerts = 32;
    var r = 1;

    var points = new float[numVerts * 2 + 2];

    {
      for (var i=0; i < numVerts; ++i)
      {
        var theta = i * 2.0 *PI / numVerts;

        var noiseR = r + (random(20)-10)/60.0;
        var x = cos(theta) * noiseR;
        var y = sin(theta) * noiseR;




        points[2*i] = x;
        points[2*i + 1] = y;
      }
      points[2*numVerts] = points[0];
      points[2*numVerts+1] = points[1];
    }

    var vi = 0;
    vertices = new float[points.length * 2];
    // convert to line segments
    for (var i=0; i < points.length-1; i += 2)
    {
      var x0 = points[i];
      var y0 = points[i+1];
      var x1 = points[(i+2) % points.length];
      var y1 = points[(i+3) % points.length];

      vertices[vi++] = x0;
      vertices[vi++] = y0;
      vertices[vi++] = x1;
      vertices[vi++] = y1;
    }

    println(vi + " length = " + vertices.length);
  }

  void prerender()
  {
    super.prerender();
    push();
    drawAxes(10);
    pop();
  }
}
