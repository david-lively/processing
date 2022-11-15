class GamePage extends Page
{
  Entity moon;
  Entity asteroid;
  Entity earth;
  color cyan = color(0, 255, 255);

  void initialize()
  {
    super.initialize();

    color red = color(255, 0, 0);
    color green = color(0, 255, 0);

    moon = new Entity(-200, 0, 10, red);
    moon.name = "Moon";
    moon.heading = 45;
    //ship.velocity = new Vector2(50 * sqrt(2), 50 * sqrt(2));
    moon.size = 40;
    entities.add(moon);

    asteroid = new Entity(-100, 0, 30, green);
    asteroid.heading = 135;
    //asteroid.velocity = new Vector2(40,20);
    entities.add(asteroid);
    asteroid.name = "Asteroid";

    moon.parent = asteroid;

    earth = new Entity(0, 0, 100, green);
    earth.heading = 135;
    //asteroid.velocity = new Vector2(40,20);
    entities.add(earth);
    earth.name = "Earth";
    entities.add(earth);

    asteroid.parent = earth;
  }

  void update()
  {
    super.update();
    handleInput();

    asteroid.heading += clock.dt * 1;
    earth.heading += clock.dt *  0.5;


    for (var e : entities)
    {
      if (e.x > width/2)
        e.x -= width;
      else if (e.x < -width/2)
        e.x += width;

      if (e.y > height/2)
        e.y -= height;
      else if (e.y < -height/2)
        e.y += height;
    }
  }

  void handleInput()
  {
    if (keyPressed)
    {
      switch(keyCode)
      {
      case UP :
        asteroid.accelerate(2);
        break;
      case DOWN:
        asteroid.accelerate(-2);
        break;
      case LEFT :
        asteroid.heading--;
        break;
      case RIGHT :
        asteroid.heading++;
        break;
      }
    }
  }

  void drawPage()
  {
    //super.drawPage();

    push();

    background(0);
    stroke(32);
    drawGrid(32);

    translate(width/2, height / 2);

    var e0 = entities.get(0);
    var e1 = entities.get(1);

    color c;
    if (e0.collidesWith(e1))
    {
      c = color(255, 0, 0);
    } else
    {
      c = color(0, 255, 0);
    }

    for (Entity entity : entities)
    {
      entity.c = c;
      entity.draw();
    }

    //stroke(128);
    //drawCollisionTriangle(e0, e1);
    pop();

    //drawHelpers();
  }

  void keyPressed()
  {
    super.keyPressed();

    switch(key)
    {
    case ' ':
      moon.velocity.x = 0;
      moon.velocity.y = 0;
      break;
    }
  }
}
