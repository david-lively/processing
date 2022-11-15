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

class Button extends Drawable
{
  String caption;
  PVector dimensions = new PVector(100, 100);
  float fontSize = 64;

  void update()
  {
    super.update();
  }
  void render()
  {
    super.render();
    push();
    translate(position.x, position.y);
    //translate(width/2,height/2);
    //drawAxes(200);
    stroke(255);
    noFill();
    textAlign(CENTER, CENTER);
    textSize(fontSize);
    dimensions.x = textWidth(caption);
    dimensions.y = fontSize;
    text(caption,0,0);
    //rectMode(CENTER);
    //rect(0, 0, dimensions.x, dimensions.y);
    pop();    
  }

  void handleInput()
  {
    super.handleInput();
  }
}
