class Tile {
  private int r;               
  private int c;               
  private float x;            
  private float y;            
  private Candy candy;   
  private boolean isSelected;  
  private float size;

  Tile(int r, int c, float x, float y, float size) {
    this.r = r;
    this.c = c;
    this.x = x;
    this.y = y;
    this.size = size;
    this.candy = null;
    this.isSelected = false;
  }

    public void display() {
     if (isSelected) {
      stroke(255, 255, 0); 
      strokeWeight(3);     
     } else {
      stroke(255, 50);     
      strokeWeight(1);
    }
    
    fill(45, 45, 55); 
    rect(x, y, size, size, 8); 
  }

  public int getMatrixRow() { return this.r; }
  public int getMatrixCol() { return this.c; }
  public Candy getCandy()   { return this.candy; }
  
  public void setCandy(Candy c){ 
    this.candy = c; 
  }
  public void setSelected(boolean b){ 
    this.isSelected = b; 
  }
}
