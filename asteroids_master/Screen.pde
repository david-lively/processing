abstract class Screen extends Drawable
{
  void handleInput()
  {
  }
}

class TitleScreen extends Screen
{
  Button playButton;

  void initialize()
  {
    super.initialize();

    playButton = new Button();
    //playButton.position.y = 500;//2 * height / 3.0;
    playButton.name = "Play button";
    
    children.add(playButton);
    
    playButton.initialize();
    playButton.position.y = -400;
    playButton.caption = "Press Enter to Begin";
  }
  
  void update()
  {
    super.update();
  }
  
  void prerender()
  {
    //super.prerender();
    background(0);
    translate(width/2.0,height/3.0);
    push();
    textSize(128);
    textAlign(CENTER);
    text("ASTEROIDS",0,0);
    pop();
  }
  
  void handleInput()
  {
  }
}
