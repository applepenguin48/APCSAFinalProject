class Candy {
  private int colored;
  private boolean isMatched = false;
  private int specialCandy;
  private float x;
  private float y;
  private float targetX; 
  private float targetY;
  private float scale = 1.0;

  public Candy(int colored, float startX, float startY) {
    this.colored = colored;
    this.x = startX;
    this.y = startY;
    this.targetX = startX;
    this.targetY = startY;
  }

  public void setTarget(float tx, float ty) {
    this.targetX = tx;
    this.targetY = ty;
  }

  public boolean isMoving() {
    return dist(x, y, targetX, targetY) > 0.5; 
  }

  public boolean isShrinking() {
    return isMatched && scale > 0;
  }

  public void update() {
    if (isMatched && scale > 0) {
      scale -= 0.1; 
      if (scale < 0) scale = 0;
    }

    if (isMoving()) {
      x = lerp(x, targetX, 0.2); 
      y = lerp(y, targetY, 0.2);
    } 
    else {
      x = targetX; 
      y = targetY;
    }
  }

  public int getColorType() 
  { return colored; }

  public int getSpecialCandy() 
  {return specialCandy;}

  public void setMatched(boolean m) 
  { this.isMatched = m; }
  
  public boolean getMatched() 
  { return isMatched; }

  public void display(float cx, float cy, float diameter) {
    noStroke();
    if (colored == 0) fill(255, 50, 50);    // Red
    else if (colored == 1) fill(50, 100, 255); // Blue
    else if (colored == 2) fill(50, 200, 50);  // Green
    else if (colored == 3) fill(255, 215, 0);  // Yellow
    else if (colored == 4) fill(150, 50, 200); // Purple

    if (specialCandy == 0)
    {
      ellipse(cx, cy, diameter, diameter);
    }

    else if (specialCandy == 1)
    {
      rectMode(CENTER);
      rect(cx, cy, diameter, diameter, 10);
    }
    else if (specialCandy == 2)
    {
      pushMatrix();
      translate(cx, cy);
      rotate(QUARTER_PI);
      rectMode(CENTER);
      rect(0, 0, diameter * 0.8, diameter * 0.8);
      popMatrix;
    }
    if (isMatched) {
    fill(255, 255, 255, 150); 
    ellipse(cx, cy, diameter, diameter);
    return;
    }
  }
}
