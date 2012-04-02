class BlinkingEye
{
  float x,y;
  float px,py;
  int age;
  
  BlinkingEye(float _x, float _y)
  {
    x = _x;
    y = _y;
    px = x;
    py = y;
    age = 0;
  }
  
  void update(float _x, float _y)
  {
    px = x;
    py = y;
    x += (_x - x)*0.1;
    y += (_y - y)*0.1;
    
    age++;
    //draw();
  }
  
  void draw()
  {
    pushMatrix();
    translate(x,y);
    
    fill(0);
    ellipse(0,0,50,50);
    pushMatrix();
    if(age %100 > 95)
    {
      scale(1,0.2); 
    }
    fill(255);
    ellipse(0,0,25,25);
    popMatrix();
    fill(0);
    ellipse(0,0,5,5);
    popMatrix();
  }
}
