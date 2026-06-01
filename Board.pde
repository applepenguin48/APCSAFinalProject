class Board {
  private int rows;
  private int cols;
  private Tile[][] grid;
  private int tileSize = 60;
  private int offsetX = 60; 
  private int offsetY = 60;  
  private Tile firstSelected = null;

  public Board(int r, int c) {
    this.rows = r;
    this.cols = c;
    grid = new Tile[rows][cols];
    
    initializeBoard();
  }

  private void initializeBoard() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        float x = offsetX + j * tileSize;
        float y = offsetY + i * tileSize;
        grid[i][j] = new Tile(i, j, x, y, tileSize);
      }
    }
  }

  public void display() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        grid[i][j].displayTile();
      }
    }
  }

  public void handleMouseClick(int mx, int my) {
  int clickedCol = (mx - offsetX) / tileSize;
  int clickedRow = (my - offsetY) / tileSize;

  if (clickedRow >= 0 && clickedRow < rows && clickedCol >= 0 && clickedCol < cols) {
    Tile clickedTile = grid[clickedRow][clickedCol];

    if (firstSelected == null) {
      firstSelected = clickedTile;
      firstSelected.setSelected(true); 
    } 
    else {
      if (isAdjacent(firstSelected, clickedTile)) {
        swapCandies(firstSelected, clickedTile); 
      }
      firstSelected.setSelected(false);
      firstSelected = null;
    }
  }
}

 private boolean isAdjacent(Tile t1, Tile t2) {
  int rDiff = abs(t1.getMatrixRow() - t2.getMatrixRow());
  int cDiff = abs(t1.getMatrixCol() - t2.getMatrixCol());
  return (rDiff == 1 && cDiff == 0) || (rDiff == 0 && cDiff == 1);
 }

 private void swapCandies(Tile t1, Tile t2) {
  Candy temp = t1.getCandy();
  t1.setCandy(t2.getCandy());
  t2.setCandy(temp);
 }
 
 public boolean checkMatches() {
  boolean foundAnyMatch = false;
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols - 2; j++) {
      Candy c1 = grid[i][j].getCandy();
      Candy c2 = grid[i][j+1].getCandy();
      Candy c3 = grid[i][j+2].getCandy();

      if (c1 != null && c2 != null && c3 != null) {
        if (c1.getColorType() == c2.getColorType() && c1.getColorType() == c3.getColorType()) {
          c1.setMatched(true);
          c2.setMatched(true);
          c3.setMatched(true);
          foundAnyMatch = true;
        }
      }
    }
  }

  for (int j = 0; j < cols; j++) {
    for (int i = 0; i < rows - 2; i++) {
      Candy c1 = grid[i][j].getCandy();
      Candy c2 = grid[i+1][j].getCandy();
      Candy c3 = grid[i+2][j].getCandy();

      if (c1 != null && c2 != null && c3 != null) {
        if (c1.getColorType() == c2.getColorType() && c1.getColorType() == c3.getColorType()) {
          c1.setMatched(true);
          c2.setMatched(true);
          c3.setMatched(true);
          foundAnyMatch = true;
        }
      }
    }
  }

  return foundAnyMatch;
 }
 
   public void cascadeBoard {
     clearMatches();
     shiftCandies();
     refillCandies();
   }


   private void clearMatches(){    
     for (int i = 0; i < cols; i++){
       for (int j = 0; j < rows; j++){
        if (grid[j][i].getCandy() != null && grid[j][i].getCandy().getMatched()) 
         {
          grid[j][i].setCandy(null);
          score += 10;
         }
     }
   }
  }


   private void shiftCandies(){
     for (int i = 0; i < cols; i++){
       for (int j = 0; j < rows; j++){
        if (grid[j][i].getCandy() == null)
        {
          for (int up = j - 1; up >= 0; up--) {
          if (grid[up][k].getCandy() != null) {
            grid[j][k].setCandy(grid[up][k].getCandy());
            grid[up][k].setCandy(null);
            break;
          }
        }
        }
      }
     }
   }

   private void refillBoard(){
     for (int i = 0; i < cols; i++){
      for (int j = 0; j < rows; j++){
        if (grid[j][i].getCandy() == null)
         {
						grid[j][i].setCandy(new Candy(int(random(5))));
				 }
      }
     }
   }
 }
}
