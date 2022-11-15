PFont font;

class Button
{
  String text;
  int x;
  int y;
  int width;
  int height;
}

Ship player = new Ship();
Button playButton = new Button();
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();

Boolean onTitleScreen = true;
void setup()
{
  frameRate(60);
  size(1000, 1000);
  background(0);
  player.x = width / 2;
  player.y = height / 2;
  initializeEntities();
  font = createFont("Arial Narrow", 48);
  textFont(font);
  createAsteroids();
}

void createAsteroids()
{

  var bob = new Asteroid();
  var dave = new Asteroid();
  asteroids.add(bob);
  asteroids.add(dave);
}


void initializeEntities()
{
  playButton.text = "Click here to play";
  playButton.x = 100;
  playButton.y = 100;
  playButton.width = 500;
  playButton.height = 100;
}
void mouseClicked() {
  int left = 280;
  int top = 425;
  int right = 700;
  int bottom = 550;
  rectMode(CORNERS);
  if (pointIsInRectangle(left, top, right, bottom, mouseX, mouseY))
  {
    onTitleScreen = false;
    print("click: true\n");
  } else
    print("click: false\n");
}
void draw()
{
  background(0);
  if (onTitleScreen)
  {
    drawTitleScreen();
  } else
  {
    drawGameScreen();
  }
}


Boolean pointIsInRectangle(int left, int top, int right, int bottom, int pointX, int pointY)
{
  if (pointX >= left
    && pointX <= right
    && pointY <= bottom
    && pointY >= top
    )
    return true;
  else
    return false;
}

void wrapEntityToScreen(Entity e)
{
  if (e.x > width) 
    e.x -= width;
  else if (e.x < 0)
    e.x += width-1;
  if (e.y > height)
    e.y -= height;
  else if (e.y < 0)
    e.y += height;
}

void drawGameScreen()
{
  background(0);
  drawShip();
  wrapEntityToScreen(player);
  
  for(var asteroid : asteroids)
  {
    asteroid.draw();
    wrapEntityToScreen(asteroid);

    
  }
  // draw bullets
}

void drawShip()
{
  handleInput();
  player.draw();
}

void handleInput()
{
  if (keyPressed)
  {
    if (keyCode == LEFT)
    {
      player.rotation -= 5;
    } else if (keyCode == RIGHT)
    {
      player.rotation += 5;
    } else if (keyCode == UP)
    {
      player.accelerate(0.5);
    } else if (keyCode == DOWN)
    {
      player.accelerate(-1);
    }
  }
}
