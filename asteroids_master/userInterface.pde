class UserInterface extends Drawable
{
  int score;
  Ship ship;
  
  UserInterface()
  {
    super();
    position.x = -width/2;
    position.y = -height/2;
    radius = 1;
    
  }

  void renderSelf()
  {
    push();
    textAlign(LEFT, TOP);
    stroke(255);
    textSize(32);
    fill(255);  
    var s = "Score: " + score + " Lives: " + ship.livesRemaining + " Asteroids: " + asteroids.size();
    s += " Missiles: " + missiles.size();
    //s += "\nSpeed : " + ship.velocity.mag();
    text(s, 0, 0);
    pop();
  }
}
