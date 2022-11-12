ArrayList<Entity> allEntities;
Ship ship;
Clock clock;

void setup()
{
  size(1280, 720);

  allEntities = new ArrayList<Entity>();

  clock = new Clock();
  allEntities.add(clock);

  ship = new Ship();
  ship.radius = 30;
  //ship.orientation = -90;
  allEntities.add(ship);
}

void drawAxes()
{
  var size = 600.0;
  var halfSize = size / 2.0;
  color xAxisColor = color(128, 0, 0);
  color yAxisColor = color(0, 128, 0);

  //translate(width/2,height/2);

  stroke(xAxisColor);
  line(-halfSize, 0, halfSize, 0);

  stroke(yAxisColor);
  line(0, -halfSize, 0, halfSize);
}

void draw()
{
  handleInput();
  background(0);
  push();
  translate(width/2, height/2);

  // move the origin to the center of the screen
  drawAxes();

  for (var entity : allEntities)
  {
    entity.update();
  }

  for (var entity : allEntities)
  {
    entity.render();
  }
  


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
