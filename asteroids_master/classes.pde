int entityCount = 0;
class Entity
{
  Entity parent;
  ArrayList<Entity> children = new ArrayList<Entity>();
  String name;

  Entity()
  {
    name = "Entity " + entityCount++;
    initialize();
  }

  void update() {
    for (var child : children)
    {
      child.update();
    }
  }
  void render() {
    for (var child : children)
    {
      child.render();
    }
  }
  void initialize() {
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
      position.x += width;
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

  void render()
  {
    //println("Rendering `" + name + "`");
    push();
    translate(position.x, position.y);
    rotate(radians(orientation));
    scale(radius);

    stroke(c);
    strokeWeight(2.0/radius);

    for (var i=0; i < vertices.length; i += 4)
    {
      line(vertices[i],
        vertices[i+1],
        vertices[i+2],
        vertices[i+3]);
    }
    for (var entity : children)
    {
      entity.render();
    }

    pop();
    //circle(0, 0, 400);
  }
}

class Ship extends Drawable
{
  Drawable thruster;
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
  }

  void accelerate(float dv)
  {
    super.accelerate(dv);
    thruster.accelerate(dv);
  }
}

class Thruster extends Drawable
{
  float lifetime = 0;

  void initialize()
  {
    name = "Thruster";
    println("Initializing `" + name + "`");
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
  }

  void render()
  {
    super.render();
    push();

    translate(position.x, position.y);
    rotate(orientation);

    stroke(64);

    for (var i=-radius; i <= radius; i += 32)
    {
      line(-radius, i, radius, i);
      line(i, -radius, i, radius);
    }

    pop();
  }
}
