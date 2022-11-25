function setup() {
  createCanvas(1280,720);
}

function drawAxes()
{
  push();
  stroke(255, 0, 0);
  line(-100, 0, 100, 0);
  stroke(0, 255, 0);
  line(0, -100, 0, 100);

  pop();
}

function draw()
{
  push();

  background(0);
  translate(width / 2, height / 2);
  drawAxes();
  textSize(32);
  stroke(255);
  fill(255);
  textAlign(CENTER, CENTER);
  text("Hello world",0,0);

  pop();
}

