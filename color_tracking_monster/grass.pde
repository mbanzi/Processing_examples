
float MAXBEND = 0.3;

float windSpeed = 0.3;
float windVary = 0.01;
float grassAgility = 0.1;
float grassMaxBend = 0.5;
float spawnRate = 10;

class Grass
{
  int size;
  float defaultdegree;
  float degree;
  float xpos;
  float ypos;
  float pos;
  float widthscale;
  color col;
  float length;
  float targetDegree;
  float hardness;
  float offset;

  Grass(int output_width, int output_height)
  {
    hardness = 0.1 + random(1);
    defaultdegree = random(0.5)-.25;
    widthscale=random(0.6)+0.2;
    xpos = random(output_width);
    ypos = output_height+15;
    pos = 0;
    offset = random(0.1)-0.05;
    targetDegree = 0;
    degree = targetDegree;
    colorMode(HSB);
    col = color(51+random(5),200+random(55),90+random(165));
    //col = color(0);
    colorMode(RGB);


    size = 4+(int)random(4);
    length = random(1.5)+2;
  }

  void render()
  {
    float currentx, currenty;
    float nextx, nexty;
    currentx = xpos;
    currenty = ypos;
    float currentdegree = PI/2;

    int spawn = 0;


    pos = xpos - mouseX  ;
    targetDegree = constrain(5/pos,-MAXBEND,MAXBEND)  + offset + (noise(xpos*0.01,frameCount*0.01)-0.5)*0.4;
    degree += (targetDegree - degree)*0.3;
    spawn = (int)(abs(targetDegree - degree)*spawnRate);
    noStroke();

    fill(col);
    for(int i=size;i>0;i--)
    {
      nextx = currentx - cos(currentdegree)*size*length;
      nexty = currenty - sin(currentdegree)*size*length;
      currentdegree+=degree*hardness;
      beginShape();

      vertex(currentx-i*widthscale, currenty+0.7);

      vertex(currentx+i*widthscale, currenty+0.7);

      vertex(nextx+(i-1)*widthscale, nexty);

      vertex(nextx-(i-1)*widthscale, nexty);

      endShape();
      currentx = nextx;
      currenty = nexty;
    }
  }
}


