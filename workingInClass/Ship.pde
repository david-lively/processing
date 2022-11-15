
class Entity
{
  int x;
  int y;
  float randDir;
  float speed; 
  float rotation;
  float velocity;
  int size;

  void accelerate(float amount)
  {
    velocity += amount;    
  }
  
  void draw()
  {
    var fixedRotation = rotation - 90;
    x += cos(radians(fixedRotation)) * velocity;
    y += sin(radians(fixedRotation)) * velocity;
  } 
}

class Asteroid extends Entity //<>//
{
  Asteroid()
  {
    randDir = random(0, TWO_PI);
    speed = 5;    
  }
  
  void draw()
  {
    super.draw();
    
    x += cos(randDir) * speed;
    y += sin(randDir) * speed;
    noFill();
    stroke(255);
    
    pushMatrix();
    translate(x, y);
    rotate(radians(rotation));
    scale(2);
    circle(0, 0, 80);
    circle(0, 0, 80);
    popMatrix();
  } //<>//
}

class Ship extends Entity
{
  void draw()
  {
    super.draw();
    
    stroke(255);
    pushMatrix();
    translate(x, y);
    rotate(radians(rotation));
    scale(2);
    line(-5, 10, 0, -10);
    line(0, -10, 5, 10);
    popMatrix();
  }
}
