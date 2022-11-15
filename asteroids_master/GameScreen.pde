class GameScreen extends Screen
{
  Ship ship;

  void initialize()
  {
    ship = new Ship();
    ship.radius = 30;
    allEntities.add(ship);

    createAsteroids();
  }

  void handleInput()
  {
    super.handleInput();
    if (keyPressed)
    {
      switch(key)
      {
      case ' ':
        ship.reset();
        break;
      }
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
  
  void preRender()
  {
    background(0);
  }
  
  void createAsteroids()
  {
    var a = new Asteroid();
    a.radius = 60;
    a.position = new PVector(0, 0);
    asteroids.add(a);
    allEntities.add(a);
  }
  
  void render()
  {
    super.render();
  }
}
