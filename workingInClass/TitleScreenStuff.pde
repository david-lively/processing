void drawTitleScreen()
{
  drawLogo();
  drawPlayButton();
}

void drawLogo()
{
  // draw the logo
}

void drawPlayButton()
{
  color background = color(0);
  //outer rectangle
  stroke(0);
  fill(background);
  //rect(left,top,right,bottom);
  //text
  fill(255);
  textSize(110);
  text("ASTEROIDS", 230, 400);
  textSize(70);
  text("Press to Begin", 285, 500);
}
