ArrayList<Entity> allEntities;
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
  
  drawAxes(600);


  pop();
}

void handleInput()
{
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
