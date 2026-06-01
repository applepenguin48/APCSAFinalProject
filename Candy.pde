class Candy {
  private int colored;
  private boolean isMatched = false;
  private int specialCandy;

  public Candy(int typeColor) {
    this.colored = typeColor;
  }

  public Candy (int typeColor, int special){
    this.colored = typeColor;
    this.special = special;
  }

  public int getColorType() 
  { return colored; }

  public void setMatched(boolean m) 
  { this.isMatched = m; }
  
  public boolean getMatched() 
  { return isMatched; }

  public void display(float cx, float cy, float diameter) {
    if (isMatched) {
    fill(255, 255, 255, 150); 
    ellipse(cx, cy, diameter, diameter);
    return;
    }
    noStroke();
    if (colored == 0) fill(255, 50, 50);    // Red
    else if (colored == 1) fill(50, 100, 255); // Blue
    else if (colored == 2) fill(50, 200, 50);  // Green
    else if (colored == 3) fill(255, 215, 0);  // Yellow
    else if (colored == 4) fill(150, 50, 200); // Purple
    ellipse(cx, cy, diameter, diameter);
  }
}
