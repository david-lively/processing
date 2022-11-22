ArrayList<Entity> allEntities;
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<Missile> missiles = new ArrayList<Missile>();
Boolean[] keyState = new Boolean[255*2];
Boolean turnRight = false;
Boolean turnLeft = false;
UserInterface ui;
Ship ship;
Clock clock;
Grid grid;

void setup()
{
  size(1280, 720);

  allEntities = new ArrayList<Entity>();

  clock = new Clock();
  allEntities.add(clock);

  grid = new Grid();
  //allEntities.add(grid);

  ship = new Ship();
  ship.radius = 30;
  allEntities.add(ship);

  createAsteroids();

  ui = new UserInterface();
  ui.score = 0;
  ui.ship = ship;
  allEntities.add(ui);

  for (var entity : allEntities)
  {
    entity.initialize();
  }

  for (var i=0; i < keyState.length; ++i)
  {
    keyState[i] = false;
  }
}

/*
*/
void createAsteroids()
{
  int numAsteroids = 6;

  var spread = 300;
  for (var i=0; i < numAsteroids; ++i)
  {
    var a = new Asteroid();
    a.radius = 60;
    a.position = new PVector(0, 0);

    var angle = i * 360.0 / numAsteroids;
    a.position.x = cos(radians(angle)) * spread;
    a.position.y = sin(radians(angle)) * spread;

    var speed = 20;
    a.velocity = new PVector(random(speed), random(speed));

    asteroids.add(a);
    allEntities.add(a);
  }
}

void draw()
{
  push();

  handleInput();
  background(0);
  // move the origin to the center of the screen
  translate(width/2, height/2);
  grid.render();

  for (var entity : allEntities)
  {
    entity.update();
  }

  for (var entity : allEntities)
  {
    entity.render();
  }

  for (var i=asteroids.size()-1; i >= 0; --i)
  {
    var a = asteroids.get(i);
    if (a.livesRemaining <= 0)
    {
      allEntities.remove(a);
      asteroids.remove(a);
    }
  }

  for (var i=missiles.size()-1; i >= 0; --i)
  {
    var m = missiles.get(i);
    if (m.livesRemaining <= 0 || m.IsOffScreen())
    {
      allEntities.remove(m);
      missiles.remove(m);
    }
  }

  checkCollisions();

  pop();
}

void keyReleased()
{
  if (CODED == key)
  {
    keyState[256 + keyCode] = false;
  } else
  {
    keyState[key] = false;
    if (key == ' ')
      fireMissile();
  }
}


void keyPressed()
{
  if (CODED == key)
  {
    keyState[256 + keyCode] = true;
  } else
  {
    keyState[key] = true;
  }
}

Boolean codedState(int v)
{
  return keyState[256 + v];
}

void handleInput()
{
  if (codedState(RIGHT))
    ship.orientation += 5;
  if (codedState(LEFT))
    ship.orientation -= 5;
  if (codedState(UP))
    ship.accelerate(4);
}

void fireMissile()
{
  float missileSpeed = 400;

  var m = new Missile();

  m.initialize();
  m.orientation = ship.orientation;
  m.position = ship.position.copy();

  var v = PVector.fromAngle(radians(ship.orientation)).mult(missileSpeed);
  m.velocity = v;

  m.radius = 10;
  missiles.add(m);
  allEntities.add(m);
}

void checkCollisions()
{
  /// check each missile against each asteroid
  for (var i=asteroids.size()-1; i >= 0; --i)
  {
    var a = asteroids.get(i);

    for (var j=missiles.size()-1; j >= 0; --j)
    {
      var m = missiles.get(j);

      if (collidesWith(a, m))
      {
        --m.livesRemaining;
        a.explode();
        ++ui.score;
        if (a.livesRemaining > 0)
        {
          /*
           split the asteroid in two, and send the pieces flying
           in opposite directions, both at right angles to the missile direction.
           */
          var speed = a.velocity.mag() * 3;

          a.velocity = PVector.fromAngle(radians(m.orientation + 90));

          var b = new Asteroid();

          b.initialize();
          b.radius = a.radius;
          b.livesRemaining = a.livesRemaining;
          b.velocity = a.velocity.copy().mult(-1);
          b.position = a.position.copy();
          b.spin = -1 * a.spin;

          /// push the pieces apart along their heading by their radius / 2
          a.position = PVector.add(a.position, PVector.mult(a.velocity, a.radius/2.0));
          b.position = PVector.add(b.position, PVector.mult(b.velocity, b.radius/2.0));

          a.velocity = PVector.mult(a.velocity, speed);
          b.velocity = PVector.mult(b.velocity, speed);

          allEntities.add(b);
          asteroids.add(b);
        }

        break;
      }
    }
  }
}
