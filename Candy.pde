class Candy {
  private int colored;
  private boolean isMatched = false;
  private int specialCandy;
  private float x;
  private float y;
  private float targetX; 
  private float targetY;
  private float scale = 1.0;
  private int pendingSpecial = 0; 
  public boolean activated = false; 

  public void setPendingSpecial(int s){
    pendingSpecial = s; 
  }
  public int getPendingSpecial(){ 
   return pendingSpecial; 
  }
  public void setSpecial(int s){ 
    specialCandy = s; 
  }

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

  public void display(float size) {
    if (scale <= 0) return;

    pushMatrix();
    translate(x, y);  
    scale(scale); 

    noStroke();
    if (colored == 0) fill(255, 50, 50);    // Red
    else if (colored == 1) fill(50, 100, 255); // Blue
    else if (colored == 2) fill(50, 200, 50);  // Green
    else if (colored == 3) fill(255, 215, 0);  // Yellow
    else if (colored == 4) fill(150, 50, 200); // Purple
    ellipse(0, 0, size, size);

    if (specialCandy == 1) { 
      stroke(255);
      strokeWeight(4);
      line(-size/2, 0, size/2, 0);
    } 
    else if (specialCandy == 2) {
      stroke(255);
      strokeWeight(4);
      line(0, -size/2, 0, size/2);
    }
    else if (specialCandy == 3) {
      fill(0);
      ellipse(0, 0, size * 0.4, size * 0.4);
    }

    popMatrix();
  }
}
