class Page
{
  String title;
  ArrayList<Entity> entities;

  Vector2 rotation = new Vector2();
  Vector2 velocity = new Vector2();

  Boolean visible = false;
  
  void initialize() {}

  void draw()
  {
    if (visible)
      drawPage();
  }

  void drawPage()
  {
    push();
    rotateX(radians(rotation.x));
    rotateY(radians(rotation.y));
    for (Entity e : entities)
    {
      e.draw();
    }
    pop();
  }

  void update()
  {
    rotatePage();
    for (Entity e : entities)
    {
      e.update();
    }
  }

  void rotatePage()
  {
    if (rotation.x != 0)
      rotation.x += velocity.x * clock.dt;
    if (velocity.y != 0)
      rotation.y += velocity.y * clock.dt;
      
    if (rotation.x >= 90 && rotation.y >= 90)
    {
      visible = false;
    }
    else
      visible = true;

    rotation.x = clamp(pageRotation.x, 0, 90);
    rotation.y = clamp(pageRotation.y, 0, 90);
  }
}
