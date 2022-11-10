
void drawGrid(int cellSize)
{
  strokeWeight(1);
  for (float i=0; i <= height; i += cellSize)
  {
    line(0, i, width, i);
  }
  for (float i=0; i < width; i += cellSize)
  {
    line(i, 0, i, height);
  }
}

void labelLine(float x0, float y0, float x1, float y1, String label)
{
  noFill();
  line(x0, y0, x1, y1);
  var tx = (x0 + x1) / 2.0;
  var ty = (y0 + y1) / 2.0;
  text(label, tx, ty - 32);
  line(tx,ty,tx,ty-32);
}


float round(float val, int places)
{
  int scalar = (int)pow(10, 2);
  float t = val * scalar;
  t = round(t) * 1.0 / scalar;
  return t;
}

Boolean collided(Entity foo, Entity bar)
{
  var dx = foo.x - bar.x;
  var dy = foo.y - bar.y;

  var distance = sqrt(dx*dx + dy*dy);

  var sumRadii = foo.size + bar.size;

  return sumRadii <= distance;
}

void wrapPositionToScreen(Entity e)
{
  if (e.x > width/2)
    e.x -= width;
  else if (e.x < -width/2)
    e.x += width;
  if (e.y > height/ 2)
    e.y -= height;
  else if (e.y < -height/2)
    e.y += height;  
}
