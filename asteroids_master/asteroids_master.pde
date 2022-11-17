ArrayList<Entity> allEntities;
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<Missile> missiles = new ArrayList<Missile>();
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

  for (var entity : allEntities)
  {
    entity.initialize();
  }
}

/*
*/
void createAsteroids()
{
  int numAsteroids = 4;

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
  handleInput();
  background(0);
  push();
  translate(width/2, height/2);
  grid.render();

  // move the origin to the center of the screen

  for (var entity : allEntities)
  {
    entity.update();
  }

  for (var entity : allEntities)
  {
    entity.render();
  }


  {
    var newAsteroids = new ArrayList<Asteroid>();
    for (var a : asteroids)
    {
      if (a.livesRemaining > 0)
      {
        newAsteroids.add(a);
      } else {
        allEntities.remove(a);
      }
    }
    asteroids = newAsteroids;
  }

  {
    var newMissiles = new ArrayList<Missile>();
    for (var m : missiles)
    {
      if (m.livesRemaining <= 0 || m.IsOffScreen())
      {
        allEntities.remove(m);  
      } else
        newMissiles.add(m);
    }
    missiles = newMissiles;
  }

  //drawAxes(600);

  checkCollisions();

  pop();
}

void breakAsteroids()
{
  var newAsteroids = new ArrayList<Asteroid>();

  for (var i = asteroids.size()-1; i >= 0; --i)
  {
    var a = asteroids.get(i);
    a.explode();

    if (a.livesRemaining <= 0)
    {
      allEntities.remove(a);
      continue;
    }

    var b = new Asteroid();

    b.initialize();
    b.radius = a.radius;
    b.livesRemaining = a.livesRemaining;
    b.velocity = a.velocity.copy().mult(-1);
    b.position = a.position.copy();

    //var v = a.velocity;
    //a.velocity.y = v.x;
    //a.velocity.x = -1 * v.y;
    //b.velocity.x = -1 * a.velocity.x;
    //b.velocity.y = -1 * a.velocity.y;
    //b.position.x = a.position.x;
    //b.position.y = a.position.y;

    newAsteroids.add(b);
    newAsteroids.add(a);
    allEntities.add(b);
  }

  asteroids = newAsteroids;
}

void mouseClicked()
{
  breakAsteroids();
}


void keyReleased()
{
  if (' ' == key)
    fireMissile();
  //println("Hello world");
}
void handleInput()
{
  if (keyPressed)
  {
    //switch(key)
    //{
    //  //case 'b':
    //  //  breakAsteroids();
    //  //  break;
    //}

    switch(keyCode)
    {
    case LEFT:
      ship.orientation -= 5;
      break;

    case RIGHT:
      ship.orientation += 5;
      break;

    case UP:
      ship.accelerate(4);
      break;
    }
  }
}

void fireMissile()
{
  float missileSpeed = 400;
  println("Fire");
  var m = new Missile();
  m.initialize();
  //m.position.x = ship.position.x;
  //m.velocity.y = ship.velocity.y;
  m.orientation = ship.orientation;
  m.position =  ship.position.copy();
  m.velocity = PVector.fromAngle(radians(ship.orientation)).mult(missileSpeed);
  //m.velocity.y = sin(radians(m.orientation)) * 100;

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
        if (a.livesRemaining > 0)
        {
          var speed = a.velocity.mag();
         
          a.velocity = PVector.fromAngle(radians(m.orientation + 90)).mult(speed);

          var b = new Asteroid();          
          b.initialize();
          b.radius = a.radius;
          b.livesRemaining = a.livesRemaining;
          b.velocity = a.velocity.copy().mult(-1);
          b.position = a.position.copy();
          b.spin = -1 * a.spin;

          allEntities.add(b);
          asteroids.add(b);
        }

        break;
      }
    }
  }
}
