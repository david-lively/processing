Boolean Debug_EnableAxisDisplay = false;

void drawAxes()
{
  push();
  float extent = 2.0;
  if (Debug_EnableAxisDisplay)
  {
    var halfSize = extent / 2.0;
    color xAxisColor = color(128, 0, 0);
    color yAxisColor = color(0, 128, 0);

    stroke(xAxisColor);
    line(-halfSize, 0, halfSize, 0);

    stroke(yAxisColor);
    line(0, -halfSize, 0, halfSize);
  }
  pop();
}

Boolean collidesWith(Drawable a, Drawable b)
{
  var distance = PVector.dist(a.position, b.position);

  return distance <= (a.radius + b.radius);
}
