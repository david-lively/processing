class Page
{
  String title;
  ArrayList<Entity> entities = new ArrayList<Entity>();

  private Vector2 rotation = new Vector2();
  private Vector2 velocity = new Vector2();

  Boolean visible = true;

  void initialize() {
  }
  
  void render()
  {
    if (!visible)
      return;

    push();
    //translate(width/2, height/2);
    //rotateX(radians(rotation.x));
    //rotateY(radians(rotation.y));
    //rotate(radians(rotation.x));
    //translate(-width/2, -height/2);

    drawPage();

    pop();
    //String s = "Visible: " + visible + "\nRotation "+rotation.x + " " + rotation.y + "\nVelocity " + velocity.x + " " + velocity.y;
    //text(s, 0, height-64);
  }

  void drawPage()
  {
    for (Entity e : entities)
    {
      e.draw();
    }
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
    rotation.x += velocity.x * clock.dt;
    rotation.y += velocity.y * clock.dt;

    if (rotation.x < 90 && rotation.y < 90)
      visible = true;
    else
      visible = false;

    if (rotation.x < 0)
    {
      velocity.x = 0;
      rotation.x = 0;
    }
    if (rotation.x > 90)
    {
      velocity.x = 0;
      rotation.x = 90;
    }

    if (rotation.y < 0)
    {
      rotation.y = 0;
      velocity.y = 0;
    }
    if (rotation.y > 90)
    {
      rotation.y = 90;
      velocity.y = 0;
    }

    //if (rotation.x > 90 && rotation.y > 90)
    //{
    //  this.visible = false;
    //  velocity.x = 0;
    //  velocity.y = 0;
    //  println("Visible: ", visible);
    //} else if (rotation.x < 0 && rota
    //{
    //  this.visible = true;
    //  println("Visible: ", visible);
    //}

    //rotation.x = clamp(this.rotation.x, 0, 90);
    //rotation.y = clamp(this.rotation.y, 0, 90);
  }

  void keyPressed() {
    switch(key)
    {
    case ENTER:
      if ( visible)
      {
        velocity.x = 80;
        velocity.y = 80;
      } else
      {
        velocity.x = -80;
        velocity.y = -80;
      }
      break;
    }
  }
}
