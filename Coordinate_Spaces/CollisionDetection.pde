/*
//Entity first = new Entity();
//Entity second = new Entity();
Clock clock = new Clock();

ArrayList<Page> allPages = new ArrayList<Page>();


void setup()
{
  size(1280, 720, P3D);
  allPages.add(new GamePage());
  //allPages.add(new HomeScreen());

  for (Page page : allPages)
  {
    page.initialize();
  }
}

void draw()
{
  background(0);
  clock.update();
  for (Page page : allPages)
    page.update();
  for (Page page : allPages)
    page.render();
}

void keyPressed()
{
  for (var p : allPages)
  {
    p.keyPressed();
  }
}
*/
