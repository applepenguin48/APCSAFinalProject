class Board {
  private int rows;
  private int cols;
  private Tile[][] grid;
  private float tileSize = 60;
  private float offsetX = 60, offsetY = 60;
  private Tile firstSelected = null;
  private int score = 0;
  private int gameState = 0; 

  Board(int r, int c) {
    this.rows = r;
    this.cols = c;
    grid = new Tile[rows][cols];
    initializeBoard();
  }

  public void updateAnimations() {
    boolean isAnythingShrinking = false;
    boolean isAnythingMoving = false;

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if (grid[i][j].candy != null) {
          grid[i][j].candy.update();
          if (grid[i][j].candy.isShrinking()) isAnythingShrinking = true;
          if (grid[i][j].candy.isMoving()) isAnythingMoving = true;
        }
      }
    }

    if (gameState == 1 && !isAnythingShrinking) {
      removeMatches();
      applyGravity();
      refillBoard();
      gameState = 2; 
    } 
    else if (gameState == 2 && !isAnythingMoving) {
      if (checkMatches()) {
        activateSpecials();
        gameState = 1; 
      } else {
        gameState = 0; 
      }
    }
  }

 public void display() {
    for (int i = 0; i < rows; i++) for (int j = 0; j < cols; j++) grid[i][j].display();
    
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if (grid[i][j].candy != null) grid[i][j].candy.display(tileSize * 0.75);
      }
    }
  }

  public void initializeBoard() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        float px = offsetX + j * tileSize;
        float py = offsetY + i * tileSize;
        grid[i][j] = new Tile(i, j, px, py, tileSize);
        
        int randomcolored = int(random(5));
        while (createsStartingMatch(i, j, randomcolored)) {
          randomcolored = int(random(5));
        }
        grid[i][j].candy = new Candy(randomcolored, px + tileSize/2, py + tileSize/2);
      }
    }
  }

  public boolean createsStartingMatch(int r, int c, int colored) {
    if (c >= 2 && grid[r][c-1].candy != null && grid[r][c-2].candy != null &&
        grid[r][c-1].candy.colored == colored && grid[r][c-2].candy.colored == colored) return true;
    if (r >= 2 && grid[r-1][c].candy != null && grid[r-2][c].candy != null &&
        grid[r-1][c].candy.colored == colored && grid[r-2][c].candy.colored == colored) return true;
    return false;
  }

  public void handleMouseClick(int mx, int my) {
    if (gameState != 0) return; 

    int c = int((mx - offsetX) / tileSize);
    int r = int((my - offsetY) / tileSize);

    if (r >= 0 && r < rows && c >= 0 && c < cols) {
      Tile clickedTile = grid[r][c];

      if (firstSelected == null) {
        firstSelected = clickedTile;
        firstSelected.isSelected = true;
      } else {
        if (isAdjacent(firstSelected, clickedTile)) {
          swapCandies(firstSelected, clickedTile);
          
          if (checkMatches()) {
            activateSpecials();
            gameState = 1; 
          } else {
            swapCandies(firstSelected, clickedTile); 
          }
        }
        firstSelected.isSelected = false;
        firstSelected = null;
      }
    }
  }

  public boolean isAdjacent(Tile t1, Tile t2) {
    int rDiff = abs(t1.r - t2.r);
    int cDiff = abs(t1.c - t2.c);
    return (rDiff == 1 && cDiff == 0) || (rDiff == 0 && cDiff == 1);
  }

  public void swapCandies(Tile t1, Tile t2) {
    Candy c1 = t1.getCandy();
    Candy c2 = t2.getCandy();
    t1.setCandy(c2);
    t2.setCandy(c1);


    if (c1 != null) {
      c1.x = t2.x + tileSize/2;
      c1.y = t2.y + tileSize/2;
      c1.setTarget(c1.x, c1.y);
    }
    if (c2 != null) {
      c2.x = t1.x + tileSize/2;
      c2.y = t1.y + tileSize/2;
      c2.setTarget(c2.x, c2.y);
    }
  }

   public boolean checkMatches() {
  boolean foundMatch = false;
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (grid[i][j].candy != null) {
        grid[i][j].candy.setMatched(false);
      }
    }
  }

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols - 2; j++) {
      if (grid[i][j].candy != null) {
        int colored = grid[i][j].candy.getColorType();
        
        int matchLength = 1;
        while (j + matchLength < cols && grid[i][j + matchLength].candy != null && 
               grid[i][j + matchLength].candy.getColorType() == colored) 
        {
          matchLength++;
        }

        if (matchLength >= 3) {
          foundMatch = true;
          for (int k = 0; k < matchLength; k++) {
            grid[i][j + k].candy.setMatched(true);
          }
          
          if (matchLength == 4) 
          {
            grid[i][j].candy.setPendingSpecial(2); 
          }
          if (matchLength >= 5) 
          {
            grid[i][j].candy.setPendingSpecial(3); 
          }
          
          j += matchLength - 1; 
        }
      }
    }
  }

  for (int j = 0; j < cols; j++) {
    for (int i = 0; i < rows - 2; i++) {
      if (grid[i][j].candy != null) {
        int colored = grid[i][j].candy.getColorType();
        
        int matchLength = 1;
        while (i + matchLength < rows && grid[i + matchLength][j].candy != null && grid[i + matchLength][j].candy.getColorType() == colored) {
          matchLength++;
        }

        if (matchLength >= 3) 
         {
          foundMatch = true;
          for (int k = 0; k < matchLength; k++) {
            grid[i + k][j].candy.setMatched(true);
         }
          
          if (matchLength == 4) 
          {
            grid[i][j].candy.setPendingSpecial(1); 
          }
          if (matchLength >= 5) 
          {
            grid[i][j].candy.setPendingSpecial(3); 
          }
          
          i += matchLength - 1;
        }
      }
    }
  }

  return foundMatch;
}

  public void removeMatches() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        Candy c = grid[i][j].candy;
        if (c != null && c.getMatched()) {          
          if (c.getPendingSpecial() > 0) 
          {
            Candy special = new Candy(c.getColorType(), grid[i][j].x + tileSize/2, grid[i][j].y + tileSize/2);
            special.setSpecial(c.getPendingSpecial());
            grid[i][j].candy = special; 
          } 
          else 
          {
            grid[i][j].candy = null; 
          }
          score += 10;
        }
      }
    }
  }

 public void activateSpecials() {
    boolean chainReaction = false;

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        Candy c = grid[i][j].candy;
        
        if (c != null && c.getMatched() && c.getSpecialCandy() > 0 && !c.activated) {
          c.activated = true; 
          if (c.getSpecialCandy() == 1) {
            for (int k = 0; k < cols; k++) {
               if (grid[i][k].candy != null && grid[i][k].candy.getMatched() == false) {
                 grid[i][k].candy.setMatched(true);
                 chainReaction = true;
               }
            }
          }
          else if (c.getSpecialCandy() == 2) {
            for (int k = 0; k < rows; k++) {
               if (grid[k][j].candy != null && grid[k][j].candy.getMatched() == false) {
                 grid[k][j].candy.setMatched(true);
                 chainReaction = true;
               }
            }
          }
          else if (c.getSpecialCandy() == 3) {
            for (int rOffset = -1; rOffset <= 1; rOffset++) {
              for (int cOffset = -1; cOffset <= 1; cOffset++) {
                int nr = i + rOffset;
                int nc = j + cOffset;
                if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && grid[nr][nc].candy != null) {
                   if (grid[nr][nc].candy.getMatched() == false) {
                     grid[nr][nc].candy.setMatched(true);
                     chainReaction = true;
                   }
                }
              }
            }
          }
        }
      }
    }
    if (chainReaction) {
      activateSpecials(); 
    }
  }

  public void applyGravity() {
    for (int j = 0; j < cols; j++) {
      int writeRow = rows - 1;
      for (int i = rows - 1; i >= 0; i--) {
        Candy c = grid[i][j].candy;
        if (c != null) {
          grid[writeRow][j].candy = c;
          if (writeRow != i) grid[i][j].candy = null;
          c.setTarget(grid[writeRow][j].x + tileSize/2, grid[writeRow][j].y + tileSize/2);
          writeRow--;
        }
      }
    }
  }

  void refillBoard() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if (grid[i][j].candy == null) {
          float px = grid[i][j].x + tileSize/2;
          float targetPy = grid[i][j].y + tileSize/2;
          float spawnPy = offsetY - (rows * tileSize) + (i * tileSize);
          
          Candy newCandy = new Candy(int(random(5)), px, spawnPy);
          newCandy.setTarget(px, targetPy);
          grid[i][j].candy = newCandy;
        }
      }
    }
  }
}
