class Board {
  private int rows;
  private int cols;
  private Tile[][] grid;
  private int tileSize = 60;
  private int offsetX = 60; 
  private int offsetY = 60;  
  private Tile firstSelected = null;
  private int score;

  public Board(int r, int c) {
    this.rows = r;
    this.cols = c;
    grid = new Tile[rows][cols];
    
    initializeBoard();
  }

  public int getScore(){
    return score;
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

        if (checkMatches()){
          cascadeBoard();
          while (checkMatches()){
            cascadeBoard();
          }
        }
        else {
          swapCandies(firstSelected, clickedTile);
        }
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
   boolean horizontalMatches = checkHorizontal();
   boolean verticalMatches = checkVertical();
   return horizontalMatches || verticalMatches;
 }

 private boolean checkHorizontal(){
   boolean foundMatch = false;
   for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols - 2; j++) {
      Candy candy1 = grid[i][j].getCandy();
      Candy candy2 = grid[i][j+1].getCandy();
      Candy candy3 = grid[i][j+2].getCandy();

      if (candy1 != null && candy2 != null && candy3 != null) 
       {
        if (candy1.getColorType() == candy2.getColorType() && candy1.getColorType() == candy3.getColorType()) 
         {
          candy1.setMatched(true);
          candy2.setMatched(true);
          candy3.setMatched(true);
          foundMatch = true;
         }
       }
      }
     }
    return foundMatch;
 }

 private boolean checkVertical(){
   boolean foundMatch = false;
   for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows - 2; j++) {
      Candy candy1 = grid[j][i].getCandy();
      Candy candy2 = grid[j][i+1].getCandy();
      Candy candy3 = grid[j][i+2].getCandy();

      if (candy1 != null && candy2 != null && candy3 != null) 
       {
        if (candy1.getColorType() == candy2.getColorType() && candy1.getColorType() == candy3.getColorType()) 
         {
          candy1.setMatched(true);
          candy2.setMatched(true);
          candy3.setMatched(true);
          foundMatch = true;
         }
       }
      }
     }
    return foundMatch;
 }
 
   public void cascadeBoard(){
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
       for (int j = rows - 1; j >= 0; j--){
        if (grid[j][i].getCandy() == null)
        {
          for (int up = j - 1; up >= 0; up--) {
          if (grid[up][i].getCandy() != null) {
            grid[j][i].setCandy(grid[up][i].getCandy());
            grid[up][i].setCandy(null);
            break;
          }
        }
        }
      }
     }
   }

   private void refillCandies(){
     for (int i = 0; i < cols; i++){
      for (int j = 0; j < rows; j++){
        if (grid[j][i].getCandy() == null)
         {
	    	grid[j][i].setCandy(new Candy(int(random(5))));
		 }
      }
     }
   }