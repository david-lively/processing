int entityCount = 0;
class Entity
{
  Entity parent;
  ArrayList<Entity> children = new ArrayList<Entity>();
  String name;

  Entity()
  {
    name = "Entity " + entityCount++;
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
  int livesRemaining=1;
  Boolean wrapToScreen = true;
  float spin;

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

  Boolean IsOffScreen()
  {
    return abs(position.x) > width/2 || abs(position.y) > height/2;
    //return position.x < 0 || position.x >= width
    //  || position.y < 0 ||position.y >= height;
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
    var move = velocity.copy().mult(dt);
    //moveBy = moveBy * velocity * clock.dt;
    position.add(move);
    orientation += spin * dt;

    if (wrapToScreen)
    {
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
    push();
    translate(position.x, position.y);
    rotate(radians(orientation));
    scale(radius);

    stroke(c);
    strokeWeight(2.0/radius);
  }

  void render()
  {
    prerender();
    drawAxes();

    if (null != vertices)
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

    postrender();
  }

  void postrender()
  {
    pop();
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
    livesRemaining = 1;
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
      triangle(0.5, 0.3, 0.5, -0.3, -0.5, 0);
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
    drawAxes();
  }
}

class Asteroid extends Drawable
{

  void explode()
  {
    radius *= 0.5;
    --livesRemaining;
  }



  void initialize()
  {
    super.initialize();
    spin=45;
    livesRemaining = 3;
    var numVerts = 20;
    var r = 1;

    var points = new float[numVerts * 2 + 2];

    {
      for (var i=0; i < numVerts; ++i)
      {
        var theta = i * 2.0 *PI / numVerts;

        /// offset each vertex by a random amount
        var noiseR = r + (random(20)-10)/40.0;
        //var noiseR = 1;;
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
  }
}

class Missile extends Drawable
{
  void initialize()
  {
    super.initialize();
    wrapToScreen = false;
    livesRemaining = 1;

    vertices = new float[4];

    //radius = 100;
    vertices[0] = -0.5;
    vertices[1] = 0;
    vertices[2] = 0.5;
    vertices[3] = 0;

    this.c = color(255);
  }

  void update()
  {
    super.update();
    if (IsOffScreen())
      --livesRemaining;
  }
  /*
  void prerender()
   {
   super.prerender();
   println("Prerender " + name);
   push();
   drawAxes(10);
   pop();
   }
   
   void render()
   {
   super.render();
   //println("Rendering " + name);
   push();
   translate(100,100);
   stroke(255);
   triangle(-0.5,0.25,0.5,0,-0.5,-0.25);
   pop();
   }
   */
}
