class GamePage extends Page
{
  Entity ship;
  Entity asteroid;
  color cyan = color(0, 255, 255);
  
  void initialize()
  {
    super.initialize();

    color red = color(255, 0, 0);
    color green = color(0, 255, 0);

    ship = new Ship(-400, -400, 10, red);
    ship.name = "Ship";
    ship.heading = 45;
    //ship.velocity = new Vector2(50 * sqrt(2), 50 * sqrt(2));
    ship.size = 20;
    entities.add(ship);

    asteroid = new Entity(0, 0, 100, green);
    entities.add(asteroid);
    asteroid.name = "Asteroid";
  }

  void update()
  {
    super.update();
    handleInput();

    // wrap ship to viewport bounds
    if (ship.x > width/2)
      ship.x -= width;
    else if (ship.x < -width/2)
      ship.x += width;
    if (ship.y > height/ 2)
      ship.y -= height;
    else if (ship.y < -height/2)
      ship.y += height;
  }

  void handleInput()
  {
    if (keyPressed)
    {
      switch(keyCode)
      {
      case UP :
        ship.accelerate(2);
        break;
      case DOWN:
        ship.accelerate(-2);
        break;
      case LEFT :
        ship.heading -= 5;
        break;
      case RIGHT :
        ship.heading += 5;
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

    stroke(128);
    drawCollisionTriangle(e0, e1);
    pop();
    
    drawHelpers();
  }

  void keyPressed()
  {
    super.keyPressed();

    switch(key)
    {
    case ' ':
      ship.velocity.x = 0;
      ship.velocity.y = 0;
      break;
    }
  }


  void drawHelpers()
  {
    var e0 = ship;
    var e1 = asteroid;
    push();
    var dx = round(abs(e0.x-e1.x), 2);
    var dy = round(abs(e0.y-e1.y), 2);

    var fontSize = 24;
    var textY = 0;
    textSize(fontSize);
    text("Center-to-center distance in X = " + dx, 0, textY += fontSize);
    text("Center-to-center distance in Y = " + dy, 0, textY += fontSize);
    var d = sqrt(dx*dx + dy*dy);
    String s ="Hypotenuse = sqrt("+dx+"^2 + "+dy+"^2) = "+round(d, 2);
    text("Center Distance = "+s, 0, textY += fontSize);
    var circleDistance = d - (ship.size + asteroid.size);
    if (circleDistance <= 0)
      fill(255, 0, 0);
    s = "CenterDistance - ship radius " + ship.size + " - asteroid radius " + asteroid.size + " = " + round(circleDistance, 2);
    fill(cyan);
    text("Circle Distance = "+s, 0, textY += fontSize);
    pop();
  }

  void drawCollisionTriangle(Entity e0, Entity e1)
  {
    drawCollisionTriangle(e0.x, e0.y, e1.x, e1.y);
  }


  void drawCollisionTriangle(float x0, float y0, float x1, float y1)
  {
    push();

    float dx = round(abs(x0-x1), 2);
    float dy = round(abs(y0-y1), 2);
    float d = round(sqrt(dx*dx + dy*dy), 2);

    /// vertical leg
    line(x0, y0, x0, y1);
    /// horizontal leg
    line(x0, y1, x1, y1);
    /// hypotenuse with label

    //  labelLine(x0, y0, x1, y1, " Distance = " + d);
    var centerDistance = d - ship.size - asteroid.size;
    labelLine(x0, y0, x1, y1, "Distance = " + round(centerDistance, 2));

    /// square "right angle" indicator
    var squareSize = 15;
    var x2 = (x1 > x0) ? x0+squareSize : x0 - squareSize;
    var y2 = (y1 > y0) ? y1-squareSize : y1 + squareSize;
    /// draw the "right angle" square indicator
    rectMode(CORNERS);
    rect(x0, y1, x2, y2);

    /// circles and lines denoting distance between circles
    var theta = atan2(x1-x0, y1-y0) - radians(90);
    var p0x = x0 + cos(theta) * ship.size;
    var p0y = y0 - sin(theta) * ship.size;
    circle(p0x, p0y, 10);
    theta += radians(180);
    var p1x = x1 + cos(theta) * asteroid.size;
    var p1y = y1 - sin(theta) * asteroid.size;
    circle(p1x, p1y, 10);
    stroke(cyan);
    strokeWeight(4);
    line(p0x, p0y, p1x, p1y);
    pop();
  }

  void drawHelpText()
  {
    push();
    var fontSize = 16;
    textSize(fontSize);
    stroke(255);
    fill(255);
    var s = "Controls:\nLeft & right arrows : turn\nUp: Accelerate\nSpace: stop.";

    translate(0, height - 10 - fontSize * 5);
    text(s, 0, 0);
    pop();
  }
}
