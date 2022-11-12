void drawAxes(float extent)
{
  var halfSize = extent / 2.0;
  color xAxisColor = color(128, 0, 0);
  color yAxisColor = color(0, 128, 0);

  stroke(xAxisColor);
  line(-halfSize, 0, halfSize, 0);

  stroke(yAxisColor);
  line(0, -halfSize, 0, halfSize);
}
