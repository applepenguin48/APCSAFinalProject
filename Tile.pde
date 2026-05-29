class Tile {
  private int matrixRow;
  private int matrixCol;
  private float pixelX;
  private float pixelY;
  private float size;
  private Candy currentCandy;
  private boolean isSelected = false;

  public Tile(int r, int c, float x, float y, float s) {
    this.matrixRow = r;
    this.matrixCol = c;
    this.pixelX = x;
    this.pixelY = y;
    this.size = s;
    int randomColor = int(random(5)); 
    this.currentCandy = new Candy(randomColor);
  }
  


  public int getMatrixRow() { return matrixRow; }
  public int getMatrixCol() { return matrixCol; }
  public Candy getCandy() { return currentCandy; }
  public void setCandy(Candy c) { this.currentCandy = c; }
  public void setSelected(boolean b) { this.isSelected = b; }

 public void displayTile() {
  if (isSelected) {
    stroke(255, 0, 0); 
    strokeWeight(3);
  } else {
    stroke(200);
    strokeWeight(1);
  }
  
  fill(255);
  rect(pixelX, pixelY, size, size);
  strokeWeight(1); 
  
  if (currentCandy != null) {
    currentCandy.display(pixelX + size/2, pixelY + size/2, size * 0.7);
  }
 }
}
