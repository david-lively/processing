ArrayList<Entity> allEntities;
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
Clock clock;
Grid grid;
TitleScreen titleScreen;
GameScreen gameScreen;

ArrayList<Screen> screens = new ArrayList<Screen>();

void setup()
{
  size(1280, 720);

  allEntities = new ArrayList<Entity>();

  clock = new Clock();
  //titleScreen = new TitleScreen();
  //screens.add(titleScreen);
  //allEntities.add(titleScreen);
  
  gameScreen = new GameScreen();
  gameScreen.enabled = false;
  screens.add(gameScreen);

  allEntities.add(clock);

  //grid = new Grid();
  ////allEntities.add(grid);


  for (var entity : allEntities)
  {
    entity.initialize();
  }
}


void draw()
{
  background(0);
  for(var screen : screens)
  {
    screen.update();
  }
  for(var screen : screens)
  {
    screen.render();
  }

}
/*
void drawGameScreen()
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
 */
